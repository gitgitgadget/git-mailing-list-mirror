From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Replace the word 'update-cache' by 'update-index' everywhere
Date: Fri, 30 Nov 2007 11:35:23 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711301135050.27959@racer.site>
References: <200711292232.03352.christoph.duelli@gmx.de> <474FC2C5.8060400@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: christoph.duelli@gmx.de, git@vger.kernel.org, gitster@pobox.com
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri Nov 30 12:36:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iy4A7-0005J8-RJ
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 12:36:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761477AbXK3Lfm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2007 06:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760472AbXK3Lfm
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 06:35:42 -0500
Received: from mail.gmx.net ([213.165.64.20]:44004 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757485AbXK3Lfl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2007 06:35:41 -0500
Received: (qmail invoked by alias); 30 Nov 2007 11:35:38 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp003) with SMTP; 30 Nov 2007 12:35:38 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Aw3pJcRpAr+gbeW2Q3CgJ4mtUsO9X+EMtnHnBRE
	zp5Fr1H7wu9A3S
X-X-Sender: gene099@racer.site
In-Reply-To: <474FC2C5.8060400@op5.se>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66630>


Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/user-manual.txt |    2 +-
 Makefile                      |    2 +-
 configure.ac                  |    2 +-
 t/t4000-diff-format.sh        |    2 +-
 t/t4001-diff-rename.sh        |    2 +-
 t/t4100/t-apply-1.patch       |    2 +-
 t/t4100/t-apply-2.patch       |    2 +-
 t/t4100/t-apply-5.patch       |    2 +-
 t/t4100/t-apply-6.patch       |    2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 0aaed10..93a47b4 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -3707,7 +3707,7 @@ should use the `--remove` and `--add` flags respectively.
 NOTE! A `--remove` flag does 'not' mean that subsequent filenames will
 necessarily be removed: if the files still exist in your directory
 structure, the index will be updated with their new status, not
-removed. The only thing `--remove` means is that update-cache will be
+removed. The only thing `--remove` means is that update-index will be
 considering a removed file to be a valid thing, and if the file really
 does not exist any more, it will update the index accordingly.
 
diff --git a/Makefile b/Makefile
index 4454116..f000a5e 100644
--- a/Makefile
+++ b/Makefile
@@ -111,7 +111,7 @@ all::
 # times (my ext3 doesn't).
 #
 # Define USE_STDEV below if you want git to care about the underlying device
-# change being considered an inode change from the update-cache perspective.
+# change being considered an inode change from the update-index perspective.
 #
 # Define ASCIIDOC8 if you want to format documentation with AsciiDoc 8
 #
diff --git a/configure.ac b/configure.ac
index 7bcf1a4..5f8a15b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -415,7 +415,7 @@ GIT_PARSE_WITH(iconv))
 # times (my ext3 doesn't).
 #
 # Define USE_STDEV below if you want git to care about the underlying device
-# change being considered an inode change from the update-cache perspective.
+# change being considered an inode change from the update-index perspective.
 
 
 ## Output files
diff --git a/t/t4000-diff-format.sh b/t/t4000-diff-format.sh
index 7d92ae3..c44b27a 100755
--- a/t/t4000-diff-format.sh
+++ b/t/t4000-diff-format.sh
@@ -16,7 +16,7 @@ cat path0 >path1
 chmod +x path1
 
 test_expect_success \
-    'update-cache --add two files with and without +x.' \
+    'update-index --add two files with and without +x.' \
     'git update-index --add path0 path1'
 
 mv path0 path0-
diff --git a/t/t4001-diff-rename.sh b/t/t4001-diff-rename.sh
index 877c1ea..a326924 100755
--- a/t/t4001-diff-rename.sh
+++ b/t/t4001-diff-rename.sh
@@ -27,7 +27,7 @@ Line 15
 '
 
 test_expect_success \
-    'update-cache --add a file.' \
+    'update-index --add a file.' \
     'git update-index --add path0'
 
 test_expect_success \
diff --git a/t/t4100/t-apply-1.patch b/t/t4100/t-apply-1.patch
index de58751..f98baa8 100644
--- a/t/t4100/t-apply-1.patch
+++ b/t/t4100/t-apply-1.patch
@@ -90,7 +90,7 @@ diff --git a/Documentation/git.txt b/Documentation/git.txt
 diff --git a/Makefile b/Makefile
 --- a/Makefile
 +++ b/Makefile
-@@ -30,7 +30,7 @@ PROG=   git-update-cache git-diff-files 
+@@ -30,7 +30,7 @@ PROG=   git-update-index git-diff-files 
  	git-checkout-cache git-diff-tree git-rev-tree git-ls-files \
  	git-check-files git-ls-tree git-merge-base git-merge-cache \
  	git-unpack-file git-export git-diff-cache git-convert-cache \
diff --git a/t/t4100/t-apply-2.patch b/t/t4100/t-apply-2.patch
index cfdc808..f5c7d60 100644
--- a/t/t4100/t-apply-2.patch
+++ b/t/t4100/t-apply-2.patch
@@ -9,7 +9,7 @@ diff --git a/Makefile b/Makefile
 -	git-deltafy-script
 +	git-deltafy-script git-fetch-script
  
- PROG=   git-update-cache git-diff-files git-init-db git-write-tree \
+ PROG=   git-update-index git-diff-files git-init-db git-write-tree \
  	git-read-tree git-commit-tree git-cat-file git-fsck-cache \
 diff --git a/git-pull-script b/git-fetch-script
 similarity index 87%
diff --git a/t/t4100/t-apply-5.patch b/t/t4100/t-apply-5.patch
index de11623..ad45c51 100644
--- a/t/t4100/t-apply-5.patch
+++ b/t/t4100/t-apply-5.patch
@@ -200,7 +200,7 @@ diff a/Documentation/git.txt b/Documentation/git.txt
 diff a/Makefile b/Makefile
 --- a/Makefile
 +++ b/Makefile
-@@ -30,7 +30,7 @@ PROG=   git-update-cache git-diff-files 
+@@ -30,7 +30,7 @@ PROG=   git-update-index git-diff-files 
  	git-checkout-cache git-diff-tree git-rev-tree git-ls-files \
  	git-check-files git-ls-tree git-merge-base git-merge-cache \
  	git-unpack-file git-export git-diff-cache git-convert-cache \
diff --git a/t/t4100/t-apply-6.patch b/t/t4100/t-apply-6.patch
index d975363..a72729a 100644
--- a/t/t4100/t-apply-6.patch
+++ b/t/t4100/t-apply-6.patch
@@ -8,7 +8,7 @@ diff a/Makefile b/Makefile
 -	git-deltafy-script
 +	git-deltafy-script git-fetch-script
  
- PROG=   git-update-cache git-diff-files git-init-db git-write-tree \
+ PROG=   git-update-index git-diff-files git-init-db git-write-tree \
  	git-read-tree git-commit-tree git-cat-file git-fsck-cache \
 diff a/git-fetch-script b/git-fetch-script
 --- /dev/null
-- 
1.5.3.6.2088.g8c260
