From: Alexander Strasser <eclipse7@gmx.net>
Subject: [PATCH 1/6] t4012: Use different style for quoting
Date: Thu, 12 Jul 2012 00:12:03 +0200
Message-ID: <20120711221203.GA21316@akuma>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 12 00:12:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sp58t-0003Ue-TN
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jul 2012 00:12:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933350Ab2GKWMM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jul 2012 18:12:12 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:44392 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932203Ab2GKWMK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2012 18:12:10 -0400
Received: (qmail invoked by alias); 11 Jul 2012 22:12:07 -0000
Received: from p5B06F836.dip.t-dialin.net (EHLO gmx.net) [91.6.248.54]
  by mail.gmx.net (mp034) with SMTP; 12 Jul 2012 00:12:07 +0200
X-Authenticated: #8251126
X-Provags-ID: V01U2FsdGVkX18xaqFuwnQxZs5zr/4BeL312i10lj5wCOp+pIX/Xf
	vnsfBEvZb5P/l5
Received: by gmx.net (sSMTP sendmail emulation); Thu, 12 Jul 2012 00:12:03 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201335>

This quoting style is used by all newly added test code.

Signed-off-by: Alexander Strasser <eclipse7@gmx.net>
---
 t/t4012-diff-binary.sh | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/t/t4012-diff-binary.sh b/t/t4012-diff-binary.sh
index 6cebb39..2a8b68e 100755
--- a/t/t4012-diff-binary.sh
+++ b/t/t4012-diff-binary.sh
@@ -15,13 +15,14 @@ cat >expect.binary-numstat <<\EOF
 -	-	d
 EOF
 
-test_expect_success 'prepare repository' \
-	'echo AIT >a && echo BIT >b && echo CIT >c && echo DIT >d &&
+test_expect_success 'prepare repository' '
+	 echo AIT >a && echo BIT >b && echo CIT >c && echo DIT >d &&
 	 git update-index --add a b c d &&
 	 echo git >a &&
 	 cat "$TEST_DIRECTORY"/test-binary-1.png >b &&
 	 echo git >c &&
-	 cat b b >d'
+	 cat b b >d
+'
 
 cat > expected <<\EOF
  a |    2 +-
@@ -62,8 +63,8 @@ test_expect_success 'apply --numstat understands diff --binary format' '
 
 # apply needs to be able to skip the binary material correctly
 # in order to report the line number of a corrupt patch.
-test_expect_success 'apply detecting corrupt patch correctly' \
-	'git diff | sed -e 's/-CIT/xCIT/' >broken &&
+test_expect_success 'apply detecting corrupt patch correctly' '
+	 git diff | sed -e 's/-CIT/xCIT/' >broken &&
 	 if git apply --stat --summary broken 2>detected
 	 then
 		echo unhappy - should have detected an error
@@ -74,10 +75,11 @@ test_expect_success 'apply detecting corrupt patch correctly' \
 	 detected=`cat detected` &&
 	 detected=`expr "$detected" : "fatal.*at line \\([0-9]*\\)\$"` &&
 	 detected=`sed -ne "${detected}p" broken` &&
-	 test "$detected" = xCIT'
+	 test "$detected" = xCIT
+'
 
-test_expect_success 'apply detecting corrupt patch correctly' \
-	'git diff --binary | sed -e 's/-CIT/xCIT/' >broken &&
+test_expect_success 'apply detecting corrupt patch correctly' '
+	 git diff --binary | sed -e 's/-CIT/xCIT/' >broken &&
 	 if git apply --stat --summary broken 2>detected
 	 then
 		echo unhappy - should have detected an error
@@ -88,23 +90,26 @@ test_expect_success 'apply detecting corrupt patch correctly' \
 	 detected=`cat detected` &&
 	 detected=`expr "$detected" : "fatal.*at line \\([0-9]*\\)\$"` &&
 	 detected=`sed -ne "${detected}p" broken` &&
-	 test "$detected" = xCIT'
+	 test "$detected" = xCIT
+'
 
 test_expect_success 'initial commit' 'git commit -a -m initial'
 
 # Try removal (b), modification (d), and creation (e).
-test_expect_success 'diff-index with --binary' \
-	'echo AIT >a && mv b e && echo CIT >c && cat e >d &&
+test_expect_success 'diff-index with --binary' '
+	 echo AIT >a && mv b e && echo CIT >c && cat e >d &&
 	 git update-index --add --remove a b c d e &&
 	 tree0=`git write-tree` &&
 	 git diff --cached --binary >current &&
-	 git apply --stat --summary current'
+	 git apply --stat --summary current
+'
 
-test_expect_success 'apply binary patch' \
-	'git reset --hard &&
+test_expect_success 'apply binary patch' '
+	 git reset --hard &&
 	 git apply --binary --index <current &&
 	 tree1=`git write-tree` &&
-	 test "$tree1" = "$tree0"'
+	 test "$tree1" = "$tree0"
+'
 
 test_expect_success 'diff --no-index with binary creation' '
 	echo Q | q_to_nul >binary &&
-- 
1.7.10.2.552.gaa3bb87
