From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH 1/4] test: modernize style of t4006
Date: Tue,  1 May 2012 19:10:12 +0200
Message-ID: <1335892215-21331-2-git-send-email-zbyszek@in.waw.pl>
References: <1335892215-21331-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: mj@ucw.cz,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue May 01 19:10:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPGb7-0003F1-LQ
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 19:10:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756215Ab2EARKk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 May 2012 13:10:40 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:35790 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755877Ab2EARKk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 13:10:40 -0400
Received: from ip-37-209-134-178.free.aero2.net.pl ([37.209.134.178] helo=localhost.localdomain)
	by kawka.in.waw.pl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SPGb0-0003uH-LY; Tue, 01 May 2012 19:10:39 +0200
X-Mailer: git-send-email 1.7.10.539.g288dd
In-Reply-To: <1335892215-21331-1-git-send-email-zbyszek@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196699>

Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
---
 t/t4006-diff-mode.sh |   32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/t/t4006-diff-mode.sh b/t/t4006-diff-mode.sh
index ff8c2f7..c8f5180 100755
--- a/t/t4006-diff-mode.sh
+++ b/t/t4006-diff-mode.sh
@@ -8,23 +8,21 @@ test_description=3D'Test mode change diffs.
 '
 . ./test-lib.sh
=20
-test_expect_success \
-    'setup' \
-    'echo frotz >rezrov &&
-     git update-index --add rezrov &&
-     tree=3D`git write-tree` &&
-     echo $tree'
-
-test_expect_success \
-    'chmod' \
-    'test_chmod +x rezrov &&
-     git diff-index $tree >current'
-
-sed -e 's/\(:100644 100755\) \('"$_x40"'\) \2 /\1 X X /' <current >che=
ck
-echo ":100644 100755 X X M	rezrov" >expected
+test_expect_success 'setup' '
+	echo frotz >rezrov &&
+	git update-index --add rezrov &&
+	tree=3D`git write-tree` &&
+	echo $tree
+'
=20
-test_expect_success \
-    'verify' \
-    'test_cmp expected check'
+# $_x40 is defined in test-lib.sh
+sed_script=3D's/\(:100644 100755\) \('"$_x40"'\) \2 /\1 X X /'
+test_expect_success 'chmod' '
+	test_chmod +x rezrov &&
+	git diff-index $tree >current &&
+	sed -e "$sed_script" <current >check &&
+	echo ":100644 100755 X X M	rezrov" >expected &&
+	test_cmp expected check
+'
=20
 test_done
--=20
1.7.10.539.g288dd
