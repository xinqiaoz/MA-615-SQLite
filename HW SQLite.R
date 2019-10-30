library(tidyverse)
library(DBI)
library(RSQLite)
library(readxl)


donors_total<- read_excel("~/Desktop/BU/MA615/HW/Top MA Donors 2016-2020.xlsx",sheet = 2)
JFC<- read_excel("~/Desktop/BU/MA615/HW/Top MA Donors 2016-2020.xlsx",sheet = 3)


contributors<- donors_total %>% select(contribid, fam, contrib, City, State, Zip, Fecoccemp, orgname, lastname) %>% distinct() %>% na.omit()
contributions<- donors_total %>% select(cycle, contribid, fam, date, amount, recipid, type, fectransid, cmteid) %>% distinct() %>% na.omit()
recipients<- donors_total %>% select(recipid,recipient,party,recipcode) %>% distinct() %>% na.omit()
orgnizations<- donors_total %>% select(orgname,ultorg) %>% distinct() %>% na.omit()

donors_db<- dbConnect(SQLite(),"Xinqiao_Zhang.sqlite")
dbWriteTable(donors_db, "contributors", contributors, overwrite=TRUE)
dbWriteTable(donors_db, "contributions", contributions, overwrite=TRUE)
dbWriteTable(donors_db, "recipients", recipients, overwrite=TRUE)
dbWriteTable(donors_db, "orgnizations", orgnizations, overwrite=TRUE)



