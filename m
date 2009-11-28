From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: [PATCH 2/4] t3409 t4107 t7406: use dashless commands
Date: Sat, 28 Nov 2009 11:38:55 -0700
Message-ID: <1259433537-3963-3-git-send-email-mmogilvi_git@miniinfo.net>
References: <1259433537-3963-1-git-send-email-mmogilvi_git@miniinfo.net>
 <1259433537-3963-2-git-send-email-mmogilvi_git@miniinfo.net>
Cc: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Nov 28 19:44:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NESH8-0005ra-1s
	for gcvg-git-2@lo.gmane.org; Sat, 28 Nov 2009 19:44:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753265AbZK1Snj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Nov 2009 13:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753149AbZK1Snh
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Nov 2009 13:43:37 -0500
Received: from qmta09.emeryville.ca.mail.comcast.net ([76.96.30.96]:54425 "EHLO
	QMTA09.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752756AbZK1Sne (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Nov 2009 13:43:34 -0500
Received: from OMTA08.emeryville.ca.mail.comcast.net ([76.96.30.12])
	by QMTA09.emeryville.ca.mail.comcast.net with comcast
	id Ai9P1d0030FhH24A9ijiiw; Sat, 28 Nov 2009 18:43:42 +0000
Received: from mmogilvi.homeip.net ([24.8.125.243])
	by OMTA08.emeryville.ca.mail.comcast.net with comcast
	id Aijh1d0035FCJCg8UijhXW; Sat, 28 Nov 2009 18:43:42 +0000
Received: from localhost.localdomain (bean [192.168.30.96])
	by mmogilvi.homeip.net (Postfix) with ESMTP id EE3FC89114;
	Sat, 28 Nov 2009 11:43:39 -0700 (MST)
X-Mailer: git-send-email 1.6.4.GIT
In-Reply-To: <1259433537-3963-2-git-send-email-mmogilvi_git@miniinfo.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133966>

This is needed to allow test suite to run against a standard
install bin directory instead of GIT_EXEC_PATH.

Signed-off-by: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
---
 t/t3409-rebase-preserve-merges.sh  |    6 +++---
 t/t4107-apply-ignore-whitespace.sh |   20 ++++++++++----------
 t/t7406-submodule-update.sh        |    4 ++--
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/t/t3409-rebase-preserve-merges.sh b/t/t3409-rebase-preserve-merges.sh
index 297d165..8f785e7 100755
--- a/t/t3409-rebase-preserve-merges.sh
+++ b/t/t3409-rebase-preserve-merges.sh
@@ -32,14 +32,14 @@ export GIT_AUTHOR_EMAIL
 test_expect_success 'setup for merge-preserving rebase' \
 	'echo First > A &&
 	git add A &&
-	git-commit -m "Add A1" &&
+	git commit -m "Add A1" &&
 	git checkout -b topic &&
 	echo Second > B &&
 	git add B &&
-	git-commit -m "Add B1" &&
+	git commit -m "Add B1" &&
 	git checkout -f master &&
 	echo Third >> A &&
-	git-commit -a -m "Modify A2" &&
+	git commit -a -m "Modify A2" &&
 
 	git clone ./. clone1 &&
 	cd clone1 &&
diff --git a/t/t4107-apply-ignore-whitespace.sh b/t/t4107-apply-ignore-whitespace.sh
index 484654d..b04fc8f 100755
--- a/t/t4107-apply-ignore-whitespace.sh
+++ b/t/t4107-apply-ignore-whitespace.sh
@@ -136,37 +136,37 @@ void print_int(int num) {
 EOF
 
 test_expect_success 'file creation' '
-	git-apply patch1.patch
+	git apply patch1.patch
 '
 
 test_expect_success 'patch2 fails (retab)' '
-	test_must_fail git-apply patch2.patch
+	test_must_fail git apply patch2.patch
 '
 
 test_expect_success 'patch2 applies with --ignore-whitespace' '
-	git-apply --ignore-whitespace patch2.patch
+	git apply --ignore-whitespace patch2.patch
 '
 
 test_expect_success 'patch2 reverse applies with --ignore-space-change' '
-	git-apply -R --ignore-space-change patch2.patch
+	git apply -R --ignore-space-change patch2.patch
 '
 
 git config apply.ignorewhitespace change
 
 test_expect_success 'patch2 applies (apply.ignorewhitespace = change)' '
-	git-apply patch2.patch
+	git apply patch2.patch
 '
 
 test_expect_success 'patch3 fails (missing string at EOL)' '
-	test_must_fail git-apply patch3.patch
+	test_must_fail git apply patch3.patch
 '
 
 test_expect_success 'patch4 fails (missing EOL at EOF)' '
-	test_must_fail git-apply patch4.patch
+	test_must_fail git apply patch4.patch
 '
 
 test_expect_success 'patch5 applies (leading whitespace)' '
-	git-apply patch5.patch
+	git apply patch5.patch
 '
 
 test_expect_success 'patches do not mangle whitespace' '
@@ -175,11 +175,11 @@ test_expect_success 'patches do not mangle whitespace' '
 
 test_expect_success 're-create file (with --ignore-whitespace)' '
 	rm -f main.c &&
-	git-apply patch1.patch
+	git apply patch1.patch
 '
 
 test_expect_success 'patch5 fails (--no-ignore-whitespace)' '
-	test_must_fail git-apply --no-ignore-whitespace patch5.patch
+	test_must_fail git apply --no-ignore-whitespace patch5.patch
 '
 
 test_done
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 2d33d9e..8e2449d 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -14,8 +14,8 @@ submodule and "git submodule update --rebase/--merge" does not detach the HEAD.
 
 compare_head()
 {
-    sha_master=`git-rev-list --max-count=1 master`
-    sha_head=`git-rev-list --max-count=1 HEAD`
+    sha_master=`git rev-list --max-count=1 master`
+    sha_head=`git rev-list --max-count=1 HEAD`
 
     test "$sha_master" = "$sha_head"
 }
-- 
1.6.4.GIT
