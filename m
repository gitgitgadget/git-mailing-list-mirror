From: Teemu Likonen <tlikonen@iki.fi>
Subject: [PATCH] Use "git <command>" instead of dashed form in sample hooks
Date: Sun, 15 Feb 2009 19:02:28 +0200
Message-ID: <1234717348-20228-1-git-send-email-tlikonen@iki.fi>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Feb 15 18:04:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYkPv-0001A0-NM
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 18:04:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754811AbZBORCj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 12:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753195AbZBORCi
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 12:02:38 -0500
Received: from mta-out.inet.fi ([195.156.147.13]:58258 "EHLO jenni1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754178AbZBORCh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 12:02:37 -0500
Received: from mithlond.arda.local (80.220.180.181) by jenni1.inet.fi (8.5.014)
        id 48FC59C7051869FD; Sun, 15 Feb 2009 19:02:34 +0200
Received: from dtw by mithlond.arda.local with local (Exim 4.69)
	(envelope-from <tlikonen@iki.fi>)
	id 1LYkNw-0005Gj-EO; Sun, 15 Feb 2009 19:02:28 +0200
X-Mailer: git-send-email 1.6.2.rc0.91.g9947
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110022>

Sample hook files used deprecated dashed form "git-<command>" which are
not installed in PATH anymore. This fixes them to use "git <command>"
form instead.

Signed-off-by: Teemu Likonen <tlikonen@iki.fi>
---
 contrib/hooks/pre-auto-gc-battery          |    2 +-
 contrib/hooks/update-paranoid              |    6 +++---
 templates/hooks--commit-msg.sample         |    2 +-
 templates/hooks--post-update.sample        |    2 +-
 templates/hooks--pre-commit.sample         |    4 ++--
 templates/hooks--pre-rebase.sample         |   18 +++++++++---------
 templates/hooks--prepare-commit-msg.sample |    2 +-
 templates/hooks--update.sample             |    4 ++--
 templates/info--exclude                    |    2 +-
 9 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/contrib/hooks/pre-auto-gc-battery b/contrib/hooks/pre-auto-gc-battery
index 1f914c9..e28530a 100644
--- a/contrib/hooks/pre-auto-gc-battery
+++ b/contrib/hooks/pre-auto-gc-battery
@@ -1,7 +1,7 @@
 #!/bin/sh
 #
 # An example hook script to verify if you are on battery, in case you
-# are running Linux or OS X. Called by git-gc --auto with no arguments.
+# are running Linux or OS X. Called by "git gc --auto" with no arguments.
 # The hook should exit with non-zero status after issuing an appropriate
 # message if it wants to stop the auto repacking.
 #
diff --git a/contrib/hooks/update-paranoid b/contrib/hooks/update-paranoid
index d18b317..412be9b 100644
--- a/contrib/hooks/update-paranoid
+++ b/contrib/hooks/update-paranoid
@@ -11,7 +11,7 @@ my $debug      = 0;
 =doc
 Invoked as: update refname old-sha1 new-sha1
 
-This script is run by git-receive-pack once for each ref that the
+This script is run by "git receive-pack" once for each ref that the
 client is trying to modify.  If we exit with a non-zero exit value
 then the update for that particular ref is denied, but updates for
 other refs in the same run of receive-pack may still be allowed.
@@ -23,9 +23,9 @@ look for "new" commits and tags (the new objects won't show up in
 
 This script loads and parses the content of the config file
 "users/$this_user.acl" from the $acl_branch commit of $acl_git ODB.
-The acl file is a git-config style file, but uses a slightly more
+The acl file is a "git config" style file, but uses a slightly more
 restricted syntax as the Perl parser contained within this script
-is not nearly as permissive as git-config.
+is not nearly as permissive as "git config".
 
 Example:
 
diff --git a/templates/hooks--commit-msg.sample b/templates/hooks--commit-msg.sample
index 6ef1d29..b58d118 100755
--- a/templates/hooks--commit-msg.sample
+++ b/templates/hooks--commit-msg.sample
@@ -1,7 +1,7 @@
 #!/bin/sh
 #
 # An example hook script to check the commit log message.
-# Called by git-commit with one argument, the name of the file
+# Called by "git commit" with one argument, the name of the file
 # that has the commit message.  The hook should exit with non-zero
 # status after issuing an appropriate message if it wants to stop the
 # commit.  The hook is allowed to edit the commit message file.
diff --git a/templates/hooks--post-update.sample b/templates/hooks--post-update.sample
index 5323b56..ec17ec1 100755
--- a/templates/hooks--post-update.sample
+++ b/templates/hooks--post-update.sample
@@ -5,4 +5,4 @@
 #
 # To enable this hook, rename this file to "post-update".
 
-exec git-update-server-info
+exec git update-server-info
diff --git a/templates/hooks--pre-commit.sample b/templates/hooks--pre-commit.sample
index 0e49279..95e154c 100755
--- a/templates/hooks--pre-commit.sample
+++ b/templates/hooks--pre-commit.sample
@@ -1,13 +1,13 @@
 #!/bin/sh
 #
 # An example hook script to verify what is about to be committed.
-# Called by git-commit with no arguments.  The hook should
+# Called by "git commit" with no arguments.  The hook should
 # exit with non-zero status after issuing an appropriate message if
 # it wants to stop the commit.
 #
 # To enable this hook, rename this file to "pre-commit".
 
-if git-rev-parse --verify HEAD 2>/dev/null
+if git rev-parse --verify HEAD 2>/dev/null
 then
 	against=HEAD
 else
diff --git a/templates/hooks--pre-rebase.sample b/templates/hooks--pre-rebase.sample
index be1b06e..226301f 100755
--- a/templates/hooks--pre-rebase.sample
+++ b/templates/hooks--pre-rebase.sample
@@ -2,7 +2,7 @@
 #
 # Copyright (c) 2006, 2008 Junio C Hamano
 #
-# The "pre-rebase" hook is run just before "git-rebase" starts doing
+# The "pre-rebase" hook is run just before "git rebase" starts doing
 # its job, and can prevent the command from running by exiting with
 # non-zero status.
 #
@@ -43,7 +43,7 @@ git show-ref -q "$topic" || {
 }
 
 # Is topic fully merged to master?
-not_in_master=`git-rev-list --pretty=oneline ^master "$topic"`
+not_in_master=`git rev-list --pretty=oneline ^master "$topic"`
 if test -z "$not_in_master"
 then
 	echo >&2 "$topic is fully merged to master; better remove it."
@@ -51,11 +51,11 @@ then
 fi
 
 # Is topic ever merged to next?  If so you should not be rebasing it.
-only_next_1=`git-rev-list ^master "^$topic" ${publish} | sort`
-only_next_2=`git-rev-list ^master           ${publish} | sort`
+only_next_1=`git rev-list ^master "^$topic" ${publish} | sort`
+only_next_2=`git rev-list ^master           ${publish} | sort`
 if test "$only_next_1" = "$only_next_2"
 then
-	not_in_topic=`git-rev-list "^$topic" master`
+	not_in_topic=`git rev-list "^$topic" master`
 	if test -z "$not_in_topic"
 	then
 		echo >&2 "$topic is already up-to-date with master"
@@ -64,7 +64,7 @@ then
 		exit 0
 	fi
 else
-	not_in_next=`git-rev-list --pretty=oneline ^${publish} "$topic"`
+	not_in_next=`git rev-list --pretty=oneline ^${publish} "$topic"`
 	perl -e '
 		my $topic = $ARGV[0];
 		my $msg = "* $topic has commits already merged to public branch:\n";
@@ -157,13 +157,13 @@ B to be deleted.
 
 To compute (1):
 
-	git-rev-list ^master ^topic next
-	git-rev-list ^master        next
+	git rev-list ^master ^topic next
+	git rev-list ^master        next
 
 	if these match, topic has not merged in next at all.
 
 To compute (2):
 
-	git-rev-list master..topic
+	git rev-list master..topic
 
 	if this is empty, it is fully merged to "master".
diff --git a/templates/hooks--prepare-commit-msg.sample b/templates/hooks--prepare-commit-msg.sample
index 3652424..0bcfea4 100755
--- a/templates/hooks--prepare-commit-msg.sample
+++ b/templates/hooks--prepare-commit-msg.sample
@@ -1,7 +1,7 @@
 #!/bin/sh
 #
 # An example hook script to prepare the commit log message.
-# Called by git-commit with the name of the file that has the
+# Called by "git commit" with the name of the file that has the
 # commit message, followed by the description of the commit
 # message's source.  The hook's purpose is to edit the commit
 # message file.  If the hook fails with a non-zero status,
diff --git a/templates/hooks--update.sample b/templates/hooks--update.sample
index 93c6055..a75649d 100755
--- a/templates/hooks--update.sample
+++ b/templates/hooks--update.sample
@@ -1,7 +1,7 @@
 #!/bin/sh
 #
 # An example hook script to blocks unannotated tags from entering.
-# Called by git-receive-pack with arguments: refname sha1-old sha1-new
+# Called by "git receive-pack" with arguments: refname sha1-old sha1-new
 #
 # To enable this hook, rename this file to "update".
 #
@@ -53,7 +53,7 @@ fi
 if [ "$newrev" = "0000000000000000000000000000000000000000" ]; then
 	newrev_type=delete
 else
-	newrev_type=$(git-cat-file -t $newrev)
+	newrev_type=$(git cat-file -t $newrev)
 fi
 
 case "$refname","$newrev_type" in
diff --git a/templates/info--exclude b/templates/info--exclude
index 2c87b72..a5196d1 100644
--- a/templates/info--exclude
+++ b/templates/info--exclude
@@ -1,4 +1,4 @@
-# git-ls-files --others --exclude-from=.git/info/exclude
+# git ls-files --others --exclude-from=.git/info/exclude
 # Lines that start with '#' are comments.
 # For a project mostly in C, the following would be a good set of
 # exclude patterns (uncomment them if you want to use them):
-- 
1.6.2.rc0.91.g9947
