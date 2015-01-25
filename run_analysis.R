## Read in Dataset
test.x <- read.table("test/X_test.txt")
test.y <- read.table("test/Y_test.txt")
test.subject <- read.table("test/subject_test.txt")
train.x <- read.table("train/X_train.txt")
train.y <- read.table("train/Y_train.txt")
train.subject <- read.table("train/subject_train.txt")
train.subject <- read.table("train/subject_train.txt")
features <- read.table("features.txt")
activity.labels <- read.table("activity_labels.txt")

## Merge the training and test sets first by cbinding the trainset data and then cbinding the testset data
## and the rbinding the train, test and subject and activity labels
trainset <- cbind(train.x, train.subject, train.y)
testset <- cbind(test.x, test.subject, test.y)
mergedset <- rbind(testset, trainset)

## Load data into a dataframe table
mergedset.df <- tbl_df(mergedset)

## Add descriptive variable names from features.txt
features.label <- features[,"V2"] ## subset features vector to extract labels
features.label <- as.character(features.label) ##convert to character vector
names(mergedset.df) <- c(features.label, "subject", "activity")

## Add descriptive activity labels from activity_labels.txt to the activity column (Y_test and Y_train)
mergedset.df <- data.frame(mergedset.df) ## to get rid of duplictae column labels
mergedset.df <- tbl_df(mergedset.df) ##convert back to datatable for easy reading
actlabels <- c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING")

mergedset.df[mergedset.df$activity %in% "1", "activity"] <- "WALKING"
mergedset.df[mergedset.df$activity %in% "2", "activity"] <- "WALKING_UPSTAIRS"
mergedset.df[mergedset.df$activity %in% "3", "activity"] <- "WALKING_DOWNSTAIRS"
mergedset.df[mergedset.df$activity %in% "4", "activity"] <- "SITTING"
mergedset.df[mergedset.df$activity %in% "5", "activity"] <- "STANDING" 
mergedset.df[mergedset.df$activity %in% "6", "activity"] <- "LAYING" 


write.table(tidyAccelData, "tidyAccelData.txt", row.name=FALSE)