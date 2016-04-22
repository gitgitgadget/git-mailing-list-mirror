From: tboegi@web.de
Subject: [PATCH v6 09/10] t6038; use crlf on all platforms
Date: Fri, 22 Apr 2016 16:53:56 +0200
Message-ID: <1461336836-5341-1-git-send-email-tboegi@web.de>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 16:50:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atcPB-0003Or-11
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 16:50:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754287AbcDVOtt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Apr 2016 10:49:49 -0400
Received: from mout.web.de ([212.227.17.12]:61603 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754060AbcDVOts (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 10:49:48 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0Lu52Q-1btwIm0tOw-011VZi; Fri, 22 Apr 2016 16:49:46
 +0200
X-Mailer: git-send-email 2.8.0.rc2.2.g1a4d45a.dirty
In-Reply-To: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:CQsviC9mzO5O3Rd6SCWsWbgik5tBTZ5OkqhsOv1QR19zmzU6NUH
 ptJob2k+HvB/0FuTDjzmvlet30enrZGxkoz5GVSnbj6Q+4kN1QpjN1NEHFIGxwnQg4Rn6iv
 BROmrcbjkzAjSO4Mvng9r+LvrkUFZ4ObTVCMP9gdvu7TcSIad3hsAObLbHrQaImQv127OA9
 vh+DlHgdHoMc+djCBMQwg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vx3BFReLWKM=:09aZcdDuk0cOBKyZE4mwIX
 XGFWJQQ9qtRml59auj16I+soDKVCmJdb9qZ++ZCE0iNWZW77paRLfqDvDMgqEOSVqYQp76wHS
 UplQ6OD0MGxDoSJ5SxlO6lRygIws6qR6ZB1ZKFC8on3zxe8GPrlASfayuC9nZl9Z2YI8EXacy
 vfgKqei+fS/Y6gL47NlpDvIxZ5aVD80ku/vvL1cMZnjGjMrjJer8FpFjE10Br0wORyglIF4Bu
 y/ok6lfQlb3hWXQhFmwGBAGSjBLz0PZztomJo/kQmJ5Ft+a+famKCEICRJ0tZItMkPOoOp+oK
 jGQjUVo5KHuzLquTMAw/nAaNPN/uSOp14m8Xhj6zFg/lwYz5OHnWiGuazsoLLJ3SWC9fijwSM
 +kz0mNTvvRqhy//Lk4QGIVXMzqF6Ze7LJ00bxVifL2NR2tScSUU8DvXRPrB9G7SG02aN1vFZB
 AT2RcA4Jgj1tiB8oDrpRdMLcqONbloMRzJ/912xdLWaP65wh5Asx2s6pBaaoYWXBZ7h7sw16i
 SU4+nyzcSGuykaTV5/5i61ju3hqTnIwH5pzalNRNJi4nr7qvE8z7cYCclxvgzS66e1b+c3wmb
 UqVyvNFpOXgkWBKLjbjyjOq23D4+XOhmAlZtMv4M5W2GLSp7Gfq9yZBXWFUApp7ozCRyB9Vvw
 mvpUONxklNjkM4fNK1/u23N+5nMToNZ28y2DXLDKAzSmI8sp/Pz9tuhB8PsLECYuOd7LIM4+f
 2KvsC9u3qYXGRrvn20M4+HN+Kz0Ya3KWMBkrQNb9cVgDHlZUxsBbrtDUJ3iwE7WvByykBK5Q 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292217>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

t6038 uses different code, dependig if NATIVE_CRLF is set ot not.
When the native line endings are LF, merge.renormalize is not tested ve=
ry well.
Change the test to always use CRLF by setting core.eol=3Dcrlf.
After doing so, the test fails:

rm '.gitattributes'
rm 'control_file'
rm 'file'
rm 'inert_file'
HEAD is now at 0d9ffb6 add line from b
error: addinfo_cache failed for path 'file'
file: unmerged (cbd69ec7cd12dd0989e853923867d94c8519aa52)
file: unmerged (ad55e240aeb42e0d9a0e18d6d8b02dd82ee3e527)
file: unmerged (99b633103c15c20cebebf821133ab526b0ff90b2)
fatal: git write-tree failed to write a tree
Merging:
0d9ffb6 add line from b
virtual a
found 1 common ancestor:
1c56df1 Initial
Auto-merging file
not ok 4 - Merge addition of text=3Dauto

This will be addressed in the next commit.
---
 t/t6038-merge-text-auto.sh | 37 +++++++++++--------------------------
 1 file changed, 11 insertions(+), 26 deletions(-)

diff --git a/t/t6038-merge-text-auto.sh b/t/t6038-merge-text-auto.sh
index 33b77ee..0108ead 100755
--- a/t/t6038-merge-text-auto.sh
+++ b/t/t6038-merge-text-auto.sh
@@ -25,6 +25,7 @@ compare_files () {
=20
 test_expect_success setup '
 	git config core.autocrlf false &&
+	git config core.eol crlf &&
=20
 	echo first line | append_cr >file &&
 	echo first line >control_file &&
@@ -79,10 +80,8 @@ test_expect_success 'Merge after setting text=3Dauto=
' '
 	same line
 	EOF
=20
-	if test_have_prereq NATIVE_CRLF; then
-		append_cr <expected >expected.temp &&
-		mv expected.temp expected
-	fi &&
+	append_cr <expected >expected.temp &&
+	mv expected.temp expected &&
 	git config merge.renormalize true &&
 	git rm -fr . &&
 	rm -f .gitattributes &&
@@ -97,10 +96,8 @@ test_expect_success 'Merge addition of text=3Dauto' =
'
 	same line
 	EOF
=20
-	if test_have_prereq NATIVE_CRLF; then
-		append_cr <expected >expected.temp &&
-		mv expected.temp expected
-	fi &&
+	append_cr <expected >expected.temp &&
+	mv expected.temp expected &&
 	git config merge.renormalize true &&
 	git rm -fr . &&
 	rm -f .gitattributes &&
@@ -111,15 +108,9 @@ test_expect_success 'Merge addition of text=3Dauto=
' '
=20
 test_expect_success 'Detect CRLF/LF conflict after setting text=3Dauto=
' '
 	echo "<<<<<<<" >expected &&
-	if test_have_prereq NATIVE_CRLF; then
-		echo first line | append_cr >>expected &&
-		echo same line | append_cr >>expected &&
-		echo =3D=3D=3D=3D=3D=3D=3D | append_cr >>expected
-	else
-		echo first line >>expected &&
-		echo same line >>expected &&
-		echo =3D=3D=3D=3D=3D=3D=3D >>expected
-	fi &&
+	echo first line | append_cr >>expected &&
+	echo same line | append_cr >>expected &&
+	echo =3D=3D=3D=3D=3D=3D=3D | append_cr >>expected &&
 	echo first line | append_cr >>expected &&
 	echo same line | append_cr >>expected &&
 	echo ">>>>>>>" >>expected &&
@@ -135,15 +126,9 @@ test_expect_success 'Detect LF/CRLF conflict from =
addition of text=3Dauto' '
 	echo "<<<<<<<" >expected &&
 	echo first line | append_cr >>expected &&
 	echo same line | append_cr >>expected &&
-	if test_have_prereq NATIVE_CRLF; then
-		echo =3D=3D=3D=3D=3D=3D=3D | append_cr >>expected &&
-		echo first line | append_cr >>expected &&
-		echo same line | append_cr >>expected
-	else
-		echo =3D=3D=3D=3D=3D=3D=3D >>expected &&
-		echo first line >>expected &&
-		echo same line >>expected
-	fi &&
+	echo =3D=3D=3D=3D=3D=3D=3D | append_cr >>expected &&
+	echo first line | append_cr >>expected &&
+	echo same line | append_cr >>expected &&
 	echo ">>>>>>>" >>expected &&
 	git config merge.renormalize false &&
 	rm -f .gitattributes &&
--=20
2.8.0.rc2.2.g1a4d45a.dirty
