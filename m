From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH] t9902: Be more specific when completing git-checkout
Date: Thu, 20 Dec 2012 18:31:03 +0100
Message-ID: <201212201831.03590.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 20 18:31:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tljxw-0000MS-Sn
	for gcvg-git-2@plane.gmane.org; Thu, 20 Dec 2012 18:31:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751575Ab2LTRbM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Dec 2012 12:31:12 -0500
Received: from mout.web.de ([212.227.17.11]:49602 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751228Ab2LTRbK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Dec 2012 12:31:10 -0500
Received: from debian-macce.localnet ([93.222.63.50]) by smtp.web.de
 (mrweb002) with ESMTPA (Nemesis) id 0MYefK-1TXyIx1miI-00Unbo; Thu, 20 Dec
 2012 18:31:09 +0100
X-Provags-ID: V02:K0:ui4A6IPPFcgPmiizaBdtKHGswZGnQVqZh7QZVydRrHx
 bwQKRmVzOdZGoj00IlTX7mLWEP8lzO5H5vejupP80Fl23IeMDq
 /BeGtd29eLM3Cv33u1W5xjxwmnEmsbYG1KZEnRw2AeTU9VNmsP
 6n/ejDAemfe84G9tYB5bEgLOnVxCpDHWmxc3xSe5mp2up1K8T0
 xZJU1J2lWzOs+iVbgsviw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211907>

t9902 is trying to complete e.g.
"git --version check" into "git --version checkout"

If there are other binaries like
"git-check-email" or "git-check-ignore" in the PATH
one test case failes

By using "checkou" instead of "check" the test becomes
more future proof.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 t/t9902-completion.sh | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 3cd53f8..0e0e2d1 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -192,19 +192,19 @@ test_expect_success 'general options' '
 '
=20
 test_expect_success 'general options plus command' '
-	test_completion "git --version check" "checkout " &&
-	test_completion "git --paginate check" "checkout " &&
-	test_completion "git --git-dir=3Dfoo check" "checkout " &&
-	test_completion "git --bare check" "checkout " &&
+	test_completion "git --version checkou" "checkout " &&
+	test_completion "git --paginate checkou" "checkout " &&
+	test_completion "git --git-dir=3Dfoo checkou" "checkout " &&
+	test_completion "git --bare checkou" "checkout " &&
 	test_completion "git --help des" "describe " &&
-	test_completion "git --exec-path=3Dfoo check" "checkout " &&
-	test_completion "git --html-path check" "checkout " &&
-	test_completion "git --no-pager check" "checkout " &&
-	test_completion "git --work-tree=3Dfoo check" "checkout " &&
-	test_completion "git --namespace=3Dfoo check" "checkout " &&
-	test_completion "git --paginate check" "checkout " &&
-	test_completion "git --info-path check" "checkout " &&
-	test_completion "git --no-replace-objects check" "checkout "
+	test_completion "git --exec-path=3Dfoo checkou" "checkout " &&
+	test_completion "git --html-path checkou" "checkout " &&
+	test_completion "git --no-pager checkou" "checkout " &&
+	test_completion "git --work-tree=3Dfoo checkou" "checkout " &&
+	test_completion "git --namespace=3Dfoo checkou" "checkout " &&
+	test_completion "git --paginate checkou" "checkout " &&
+	test_completion "git --info-path checkou" "checkout " &&
+	test_completion "git --no-replace-objects checkou" "checkout "
 '
=20
 test_expect_success 'setup for ref completion' '
--=20
1.8.0
