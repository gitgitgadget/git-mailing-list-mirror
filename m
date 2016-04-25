From: tboegi@web.de
Subject: [PATCH v7 09/10] t6038; use crlf on all platforms
Date: Mon, 25 Apr 2016 18:56:40 +0200
Message-ID: <1461603400-30952-1-git-send-email-tboegi@web.de>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 25 18:52:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aujkU-0000Rw-5c
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 18:52:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933169AbcDYQwb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Apr 2016 12:52:31 -0400
Received: from mout.web.de ([212.227.17.11]:63430 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933165AbcDYQw1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 12:52:27 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0MbyUk-1bAcR01gRS-00JL63; Mon, 25 Apr 2016 18:52:20
 +0200
X-Mailer: git-send-email 2.0.0.rc1.6318.g0c2c796
In-Reply-To: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:BeOEgqCIKz8TZmG6CZ9BU45a7YCtiryQBgGqogzKwfd0zxtnkgV
 5xM/yFAPDM0Co4ADjSCrsv3gMOJoMg/SqO7E8SK/KAOwZo0i35Cizi+vc3k1rQfD++wO4pJ
 nFHpHj/Pqbh3svdkjIJqHOHdbgWFcTvjpBMQkUnE6VZb9f2ydss3/utIIarxnZbGRJPwj6h
 IgOCSeY0iQvKyebNQtJCQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RJKNHzOcOdI=:5LxsK1BJbOnVodu9awO5dX
 eNzzt7dHa+meWKeqY9/d/UGYwMj+/AEBlGcGpf7rk40ciXzyZTbp4IPQUMjV614jYwAVURgTr
 LQDm3Z7SwzosSwqTuOwu/yZlwlTNaVMz1o2RSA2geqG3clR1JtxQ5orA0YkUxrF+r+wfcblFn
 QvSZEWC0NjVtC+s4BrkW/THLa2KWdiL5JoAwSbSJ2bh7e074Z7XpPB/nECDH137WICQq/AOV6
 Vs6vLtgCW3I2zn87dfuc0vfIhvum2GN9RXPopb88FR08bRdlj+A49JB6w4Tu69EjSqRyeJKbl
 kFrvzDfMO8nt3Imb1acgGYFBsWov/vb4p57xjHnW7hu5eRFYyd1zwgAesu4rWvZK47zX0PKNi
 VU4C/g5JSImSuOeVRsjuQ4jQLJ0WamNLPxKqseXMo+kBD0V583LzIg/pagwSqh27ZZqgzYN75
 OcvlHDig9De3kOVtxGfxe710xzQG0foe7EiSgCuG8nAV2t2XGZtXYVTxIQ1pxXlgjZuCXwEip
 rHt2QoeWmwjYtS6LrWnCRV1Z72ol2FyHZ/GxpB1tNpAxe3dGZkaP3dyHJq1JoRzmjhJM0EvMo
 MeaYCDReePYFYeySvhiCIfzzkIlAnGlI//OAVXYmTwvI+IpIbCeY5uvN6pCu+pWgYYc5prw6c
 WjsrxPAJkSMZ2/dtIAyIGspo4EHeMrVDJ+vW+zPHmpM9UHTqE5nJuT0gcQbha/B38M7rmrYy7
 FB8OHDKvj3R1SmbLI4IYjg6HEgjTeyHwv44eh6zF4nyNWXL+rFvvr+g2ifOFKto5qxQMe6Em 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292517>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

t6038 uses different code, dependig if NATIVE_CRLF is set ot not. When
the native line endings are LF, merge.renormalize is not tested very we=
ll.
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

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
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
2.0.0.rc1.6318.g0c2c796
