From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH v2 04/12] t6200-fmt-merge-msg: put expected messages into
	different files
Date: Wed, 16 Apr 2008 02:39:03 +0200
Message-ID: <1208306351-20922-5-git-send-email-szeder@ira.uka.de>
References: <7vzls7so8m.fsf@gitster.siamese.dyndns.org>
	<1208306351-20922-1-git-send-email-szeder@ira.uka.de>
	<1208306351-20922-2-git-send-email-szeder@ira.uka.de>
	<1208306351-20922-3-git-send-email-szeder@ira.uka.de>
	<1208306351-20922-4-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 06:27:39 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jlvhs-0007aE-Vx
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 02:41:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756376AbYDPAje convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Apr 2008 20:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755172AbYDPAjb
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 20:39:31 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:50573 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755339AbYDPAj3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2008 20:39:29 -0400
Received: from [127.0.1.1] (p5B13305D.dip0.t-ipconnect.de [91.19.48.93])
	by mrelayeu.kundenserver.de (node=mrelayeu7) with ESMTP (Nemesis)
	id 0ML2xA-1JlvgC0M76-0003gY; Wed, 16 Apr 2008 02:39:16 +0200
X-Mailer: git-send-email 1.5.5.76.g546c
In-Reply-To: <1208306351-20922-4-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V01U2FsdGVkX18nQCuW57PQO2QAA/fw/TVF6BDFIhUF8ae/8gm
 Y6PHU0Gsy8UT6NN/18+mp5Y1doWXTKuGfK/fA47UwofZ9yPR8B
 V5V8N9CF3i9CaFsBnRWWA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79642>

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 t/t6200-fmt-merge-msg.sh |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index 526d7d1..1af3ab2 100755
--- a/t/t6200-fmt-merge-msg.sh
+++ b/t/t6200-fmt-merge-msg.sh
@@ -69,7 +69,7 @@ test_expect_success setup '
 	git show-branch
 '
=20
-cat >expected <<\EOF
+cat >msg.left.nolog <<\EOF
 Merge branch 'left'
 EOF
=20
@@ -79,10 +79,10 @@ test_expect_success 'merge-msg test #1' '
 	git fetch . left &&
=20
 	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
-	git diff actual expected
+	git diff actual msg.left.nolog
 '
=20
-cat >expected <<\EOF
+cat >msg.left_trash <<\EOF
 Merge branch 'left' of ../trash
 EOF
=20
@@ -92,10 +92,10 @@ test_expect_success 'merge-msg test #2' '
 	git fetch ../trash left &&
=20
 	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
-	git diff actual expected
+	git diff actual msg.left_trash
 '
=20
-cat >expected <<\EOF
+cat >msg.left.log <<\EOF
 Merge branch 'left'
=20
 * left:
@@ -115,10 +115,10 @@ test_expect_success 'merge-msg test #3' '
 	git fetch . left &&
=20
 	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
-	git diff actual expected
+	git diff actual msg.left.log
 '
=20
-cat >expected <<\EOF
+cat >msg.left_right.log <<\EOF
 Merge branches 'left' and 'right'
=20
 * left:
@@ -145,7 +145,7 @@ test_expect_success 'merge-msg test #4' '
 	git fetch . left right &&
=20
 	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
-	git diff actual expected
+	git diff actual msg.left_right.log
 '
=20
 test_expect_success 'merge-msg test #5' '
@@ -157,7 +157,7 @@ test_expect_success 'merge-msg test #5' '
 	git fetch . left right &&
=20
 	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
-	git diff actual expected
+	git diff actual msg.left_right.log
 '
=20
 test_done
--=20
1.5.5.76.g546c
