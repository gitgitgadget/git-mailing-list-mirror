From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Rename git-config-set to git-repo-config
Date: Thu, 24 Nov 2005 11:36:01 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511241127020.12985@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0511201748440.14258@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0511200935081.13959@g5.osdl.org> <200511210026.30280.Josef.Weidendorfer@gmx.de>
 <200511221831.03954.Josef.Weidendorfer@gmx.de>
 <Pine.LNX.4.63.0511221854120.27872@wbgn013.biozentrum.uni-wuerzburg.de>
 <438371E8.2030701@op5.se> <Pine.LNX.4.63.0511231553390.8191@wbgn013.biozentrum.uni-wuerzburg.de>
 <7viruj3q7z.fsf@assigned-by-dhcp.cox.net> <4384FB61.40506@op5.se>
 <Pine.LNX.4.63.0511240042350.11106@wbgn013.biozentrum.uni-wuerzburg.de>
 <43857430.7060103@op5.se> <7vsltmwiky.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 24 11:38:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfESt-0007OS-2F
	for gcvg-git@gmane.org; Thu, 24 Nov 2005 11:36:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbVKXKgG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Nov 2005 05:36:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbVKXKgF
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Nov 2005 05:36:05 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:25822 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751349AbVKXKgD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Nov 2005 05:36:03 -0500
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 6CF2013FC28; Thu, 24 Nov 2005 11:36:02 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 49F3BB5300; Thu, 24 Nov 2005 11:36:02 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 0884DB52F8; Thu, 24 Nov 2005 11:36:02 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id DBBE613FC28; Thu, 24 Nov 2005 11:36:01 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vsltmwiky.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12702>

... and adjust all references.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	On Thu, 24 Nov 2005, Junio C Hamano wrote:
	
	> Andreas Ericsson <ae@op5.se> writes:
	> 
	> > git-config-set handles configuration for a particular repo, so
	> > git-repo-config is better, IMO.
	> 
	> Ok, so git-repo-config that is.  Johannes?

	Sorry, git-mv did not work on my system. I can now confirm that
	there is *at least* one perl 5.6 version out there which does not
	like lists in open statements at all. Grmpf.

	Further grpmf: Is it intended behaviour that git-diff *detects* 
	renames, while git-format-patch *doesn't*?

 .gitignore                        |    2 +
 Documentation/git-repo-config.txt |   36 +++++++++++++-------------
 Documentation/git.txt             |    6 ++--
 Makefile                          |    2 +
 repo-config.c                     |    2 +
 t/t1300-repo-config.sh            |   52 +++++++++++++++++++------------------
 6 files changed, 50 insertions(+), 50 deletions(-)

diff --git a/.gitignore b/.gitignore
index 074ebe9..0876525 100644
--- a/.gitignore
+++ b/.gitignore
@@ -17,7 +17,6 @@ git-clone
 git-clone-pack
 git-commit
 git-commit-tree
-git-config-set
 git-convert-objects
 git-count-objects
 git-cvsexportcommit
@@ -77,6 +76,7 @@ git-receive-pack
 git-relink
 git-rename
 git-repack
+git-repo-config
 git-request-pull
 git-reset
 git-resolve
diff --git a/Documentation/git-config-set.txt b/Documentation/git-repo-config.txt
similarity index 82%
rename from Documentation/git-config-set.txt
rename to Documentation/git-repo-config.txt
index bfbd421..92b9156 100644
--- a/Documentation/git-config-set.txt
+++ b/Documentation/git-repo-config.txt
@@ -1,19 +1,19 @@
-git-config-set(1)
+git-repo-config(1)
 ===============
 
 NAME
 ----
-git-config-set - Set options in .git/config.
+git-repo-config - Get and set options in .git/config.
 
 
 SYNOPSIS
 --------
-'git-config-set' name [value [value_regex]]
-'git-config-set' --replace-all name [value [value_regex]]
-'git-config-set' --get name [value_regex]
-'git-config-set' --get-all name [value_regex]
-'git-config-set' --unset name [value_regex]
-'git-config-set' --unset-all name [value_regex]
+'git-repo-config' name [value [value_regex]]
+'git-repo-config' --replace-all name [value [value_regex]]
+'git-repo-config' --get name [value_regex]
+'git-repo-config' --get-all name [value_regex]
+'git-repo-config' --unset name [value_regex]
+'git-repo-config' --unset-all name [value_regex]
 
 DESCRIPTION
 -----------
@@ -89,7 +89,7 @@ Given a .git/config like this:
 you can set the filemode to true with
 
 ------------
-% git config-set core.filemode true
+% git repo-config core.filemode true
 ------------
 
 The hypothetic proxy command entries actually have a postfix to discern
@@ -97,7 +97,7 @@ to what URL they apply. Here is how to c
 to "ssh".
 
 ------------
-% git config-set proxy.command '"ssh" for kernel.org' 'for kernel.org$'
+% git repo-config proxy.command '"ssh" for kernel.org' 'for kernel.org$'
 ------------
 
 This makes sure that only the key/value pair for kernel.org is replaced.
@@ -105,7 +105,7 @@ This makes sure that only the key/value 
 To delete the entry for renames, do
 
 ------------
-% git config-set --unset diff.renames
+% git repo-config --unset diff.renames
 ------------
 
 If you want to delete an entry for a multivar (like proxy.command above),
@@ -114,45 +114,45 @@ you have to provide a regex matching the
 To query the value for a given key, do
 
 ------------
-% git config-set --get core.filemode
+% git repo-config --get core.filemode
 ------------
 
 or
 
 ------------
-% git config-set core.filemode
+% git repo-config core.filemode
 ------------
 
 or, to query a multivar:
 
 ------------
-% git config-set --get proxy.command "for kernel.org$"
+% git repo-config --get proxy.command "for kernel.org$"
 ------------
 
 If you want to know all the values for a multivar, do:
 
 ------------
-% git config-set --get-all proxy.command
+% git repo-config --get-all proxy.command
 ------------
 
 If you like to live dangerous, you can replace *all* proxy.commands by a
 new one with
 
 ------------
-% git config-set --replace-all proxy.command ssh
+% git repo-config --replace-all proxy.command ssh
 ------------
 
 However, if you really only want to replace the line for the default proxy,
 i.e. the one without a "for ..." postfix, do something like this:
 
 ------------
-% git config-set proxy.command ssh '! for '
+% git repo-config proxy.command ssh '! for '
 ------------
 
 To actually match only values with an exclamation mark, you have to
 
 ------------
-% git config-set section.key value '[!]'
+% git repo-config section.key value '[!]'
 ------------
 
 
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 694fee8..a518249 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -84,9 +84,6 @@ gitlink:git-checkout-index[1]::
 gitlink:git-commit-tree[1]::
 	Creates a new commit object
 
-gitlink:git-config-set[1]::
-	Set options in .git/config.
-
 gitlink:git-hash-object[1]::
 	Computes the object ID from a file.
 
@@ -111,6 +108,9 @@ gitlink:git-prune-packed[1]::
 gitlink:git-read-tree[1]::
 	Reads tree information into the directory index
 
+gitlink:git-repo-config[1]::
+	Get and set options in .git/config.
+
 gitlink:git-unpack-objects[1]::
 	Unpacks objects out of a packed archive.
 
diff --git a/Makefile b/Makefile
index 53bba2f..c47eeec 100644
--- a/Makefile
+++ b/Makefile
@@ -134,7 +134,7 @@ PROGRAMS = \
 	git-unpack-objects$X git-update-index$X git-update-server-info$X \
 	git-upload-pack$X git-verify-pack$X git-write-tree$X \
 	git-update-ref$X git-symbolic-ref$X git-check-ref-format$X \
-	git-name-rev$X git-pack-redundant$X git-config-set$X git-var$X
+	git-name-rev$X git-pack-redundant$X git-repo-config$X git-var$X
 
 # what 'all' will build and 'install' will install.
 ALL_PROGRAMS = $(PROGRAMS) $(SIMPLE_PROGRAMS) $(SCRIPTS) git$X
diff --git a/config-set.c b/repo-config.c
similarity index 98%
rename from config-set.c
rename to repo-config.c
index d938f96..b2569b7 100644
--- a/config-set.c
+++ b/repo-config.c
@@ -2,7 +2,7 @@
 #include <regex.h>
 
 static const char git_config_set_usage[] =
-"git-config-set [--get | --get-all | --replace-all | --unset | --unset-all] name [value [value_regex]]";
+"git-repo-config [--get | --get-all | --replace-all | --unset | --unset-all] name [value [value_regex]]";
 
 static char* key = NULL;
 static char* value = NULL;
diff --git a/t/t1300-config-set.sh b/t/t1300-repo-config.sh
similarity index 81%
rename from t/t1300-config-set.sh
rename to t/t1300-repo-config.sh
index 7a5849a..5e994ff 100644
--- a/t/t1300-config-set.sh
+++ b/t/t1300-repo-config.sh
@@ -3,13 +3,13 @@
 # Copyright (c) 2005 Johannes Schindelin
 #
 
-test_description='Test git-config-set in different settings'
+test_description='Test git-repo-config in different settings'
 
 . ./test-lib.sh
 
 test -f .git/config && rm .git/config
 
-git-config-set core.penguin "little blue"
+git-repo-config core.penguin "little blue"
 
 cat > expect << EOF
 #
@@ -22,7 +22,7 @@ EOF
 
 test_expect_success 'initial' 'cmp .git/config expect'
 
-git-config-set Core.Movie BadPhysics
+git-repo-config Core.Movie BadPhysics
 
 cat > expect << EOF
 #
@@ -36,7 +36,7 @@ EOF
 
 test_expect_success 'mixed case' 'cmp .git/config expect'
 
-git-config-set Cores.WhatEver Second
+git-repo-config Cores.WhatEver Second
 
 cat > expect << EOF
 #
@@ -52,7 +52,7 @@ EOF
 
 test_expect_success 'similar section' 'cmp .git/config expect'
 
-git-config-set CORE.UPPERCASE true
+git-repo-config CORE.UPPERCASE true
 
 cat > expect << EOF
 #
@@ -70,10 +70,10 @@ EOF
 test_expect_success 'similar section' 'cmp .git/config expect'
 
 test_expect_success 'replace with non-match' \
-	'git-config-set core.penguin kingpin !blue'
+	'git-repo-config core.penguin kingpin !blue'
 
 test_expect_success 'replace with non-match (actually matching)' \
-	'git-config-set core.penguin "very blue" !kingpin'
+	'git-repo-config core.penguin "very blue" !kingpin'
 
 cat > expect << EOF
 #
@@ -106,7 +106,7 @@ EOF
 cp .git/config .git/config2
 
 test_expect_success 'multiple unset' \
-	'git-config-set --unset-all beta.haha'
+	'git-repo-config --unset-all beta.haha'
 
 cat > expect << EOF
 [beta] ; silly comment # another comment
@@ -122,7 +122,7 @@ test_expect_success 'multiple unset is c
 mv .git/config2 .git/config
 
 test_expect_success '--replace-all' \
-	'git-config-set --replace-all beta.haha gamma'
+	'git-repo-config --replace-all beta.haha gamma'
 
 cat > expect << EOF
 [beta] ; silly comment # another comment
@@ -136,7 +136,7 @@ EOF
 
 test_expect_success 'all replaced' 'cmp .git/config expect'
 
-git-config-set beta.haha alpha
+git-repo-config beta.haha alpha
 
 cat > expect << EOF
 [beta] ; silly comment # another comment
@@ -150,7 +150,7 @@ EOF
 
 test_expect_success 'really mean test' 'cmp .git/config expect'
 
-git-config-set nextsection.nonewline wow
+git-repo-config nextsection.nonewline wow
 
 cat > expect << EOF
 [beta] ; silly comment # another comment
@@ -165,8 +165,8 @@ EOF
 
 test_expect_success 'really really mean test' 'cmp .git/config expect'
 
-test_expect_success 'get value' 'test alpha = $(git-config-set beta.haha)'
-git-config-set --unset beta.haha
+test_expect_success 'get value' 'test alpha = $(git-repo-config beta.haha)'
+git-repo-config --unset beta.haha
 
 cat > expect << EOF
 [beta] ; silly comment # another comment
@@ -180,7 +180,7 @@ EOF
 
 test_expect_success 'unset' 'cmp .git/config expect'
 
-git-config-set nextsection.NoNewLine "wow2 for me" "for me$"
+git-repo-config nextsection.NoNewLine "wow2 for me" "for me$"
 
 cat > expect << EOF
 [beta] ; silly comment # another comment
@@ -196,18 +196,18 @@ EOF
 test_expect_success 'multivar' 'cmp .git/config expect'
 
 test_expect_success 'non-match' \
-	'git-config-set --get nextsection.nonewline !for'
+	'git-repo-config --get nextsection.nonewline !for'
 
 test_expect_success 'non-match value' \
-	'test wow = $(git-config-set --get nextsection.nonewline !for)'
+	'test wow = $(git-repo-config --get nextsection.nonewline !for)'
 
 test_expect_failure 'ambiguous get' \
-	'git-config-set --get nextsection.nonewline'
+	'git-repo-config --get nextsection.nonewline'
 
 test_expect_success 'get multivar' \
-	'git-config-set --get-all nextsection.nonewline'
+	'git-repo-config --get-all nextsection.nonewline'
 
-git-config-set nextsection.nonewline "wow3" "wow$"
+git-repo-config nextsection.nonewline "wow3" "wow$"
 
 cat > expect << EOF
 [beta] ; silly comment # another comment
@@ -222,15 +222,15 @@ EOF
 
 test_expect_success 'multivar replace' 'cmp .git/config expect'
 
-test_expect_failure 'ambiguous value' 'git-config-set nextsection.nonewline'
+test_expect_failure 'ambiguous value' 'git-repo-config nextsection.nonewline'
 
 test_expect_failure 'ambiguous unset' \
-	'git-config-set --unset nextsection.nonewline'
+	'git-repo-config --unset nextsection.nonewline'
 
 test_expect_failure 'invalid unset' \
-	'git-config-set --unset somesection.nonewline'
+	'git-repo-config --unset somesection.nonewline'
 
-git-config-set --unset nextsection.nonewline "wow3$"
+git-repo-config --unset nextsection.nonewline "wow3$"
 
 cat > expect << EOF
 [beta] ; silly comment # another comment
@@ -244,12 +244,12 @@ EOF
 
 test_expect_success 'multivar unset' 'cmp .git/config expect'
 
-test_expect_failure 'invalid key' 'git-config-set inval.2key blabla'
+test_expect_failure 'invalid key' 'git-repo-config inval.2key blabla'
 
-test_expect_success 'correct key' 'git-config-set 123456.a123 987'
+test_expect_success 'correct key' 'git-repo-config 123456.a123 987'
 
 test_expect_success 'hierarchical section' \
-	'git-config-set 1.2.3.alpha beta'
+	'git-repo-config 1.2.3.alpha beta'
 
 cat > expect << EOF
 [beta] ; silly comment # another comment
