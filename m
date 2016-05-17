From: tboegi@web.de
Subject: [PATCH v1 1/1] t6038; use crlf on all platforms
Date: Tue, 17 May 2016 18:09:58 +0200
Message-ID: <1463501398-8608-1-git-send-email-tboegi@web.de>
References: <573A993F.8020205@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 17 18:06:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2hVw-0005QU-Jl
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 18:06:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755332AbcEQQG2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 May 2016 12:06:28 -0400
Received: from mout.web.de ([212.227.15.4]:52242 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754848AbcEQQG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2016 12:06:27 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0Lfzwp-1bLsE00GlP-00pbPh; Tue, 17 May 2016 18:06:23
 +0200
X-Mailer: git-send-email 2.0.0.rc1.6318.g0c2c796
In-Reply-To: <573A993F.8020205@web.de>
X-Provags-ID: V03:K0:aj5c8sYfmlRrnxMJ6P9ADe0vxgIuoIhuWvcZeooEOCTkMk+USgO
 Sz37Fj1fsRyEiuVQRNLBBdOxQFPKIn9xk39zZCJPkXoQscJnoO+ZCR6GQEqml9+1LJIzYu5
 9c5/lGV8rDDqqiu+ZNnyHu/ib4WfYeJCT6BY/7dUAk8c8HykWRWsb+9F4bde4SLDtpyQ+1i
 CWE9E/H+1PlQDn8ZuTIYw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NYhzhIU4vLE=:u6WrAe/Rzv6ifXVhw1HsOz
 tfd0duI6foRd+uM+Mwqy+ynnld0SXBVXeW0mjeGmC7v6IYl8bap/l1zUjTgiq6Qqb2OsBoKUo
 JMWq3hDZEQ2+roaKTTFfTMuKXs/lpUPeuWWg0SyiVnFD67yYivdGmD46aOVdkUHt6ybB1UgBi
 pSXF1R4lpJd1cER0j3cTecqHag8EAiuj9fKURThT9wtd2gj4Qj6bQRaSq6hDlt23/vyB1RjqX
 YgoL1ERZo8LgJm6xB8ALxsSUx9x1tvg8Ky5GrKrmS3quCKgX47kxkaJZelWOkGpZX6wLQcmPI
 cBryV2DxPqugFyu0SbTzcIY2UAJIWANFT1UuTMxMSyxBOf9qUbqvs9cQ8OrwV+mpabm/H14nZ
 boACd0zGDhdYGZD8Wr1WAeHifVaPO7jdlTOQdkmPe+sp1MHtmnUSLjpcHIKM5Nn+DZrkjQjNj
 HAFltllH6aZ/IqKzjYJUWdwVURl3Ir+PKrC+khmx5BeJT74TV2tYu7BanMmVfzsHqlHz/Im6R
 nSPsXB0Op10dQgW90NKLaaJS+ElsgpuItgvadUPqzdS1CS8tobwuBcMapferILWC75GCmtRdz
 be6MBEJ8BQz/uePR/v4rsqOtVVZU7AtqjoF6HJPpw81mhxqOWEKxw7AvieQPVe8thZ7w465JS
 MZ8YbtBa+zXDvA1SbqsEAZfPEjcXA0zbEOT2QvMBrHWkGtWSma94srCEGQuXv+modcs4fXH0r
 8Et2m2p4gDX72wGPW5g2z9uqmiRXlDkV0YdHxLU6193F0aarOK50RKz8qn5oPip0WgdEZRCs 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294868>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

t6038 uses different code, depending if NATIVE_CRLF is set ot not.
When the native line endings are LF, merge.renormalize is not tested ve=
ry well.
Change the test to always use CRLF by setting core.eol=3Dcrlf.
---
Broke the 10/10 series into smaller pieces, this is the update of t6038
 t/t6038-merge-text-auto.sh | 37 +++++++++++--------------------------
 1 file changed, 11 insertions(+), 26 deletions(-)

diff --git a/t/t6038-merge-text-auto.sh b/t/t6038-merge-text-auto.sh
index 85c10b0..4dc8c1a 100755
--- a/t/t6038-merge-text-auto.sh
+++ b/t/t6038-merge-text-auto.sh
@@ -18,6 +18,7 @@ test_have_prereq SED_STRIPS_CR && SED_OPTIONS=3D-b
=20
 test_expect_success setup '
 	git config core.autocrlf false &&
+	git config core.eol crlf &&
=20
 	echo first line | append_cr >file &&
 	echo first line >control_file &&
@@ -72,10 +73,8 @@ test_expect_success 'Merge after setting text=3Dauto=
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
@@ -90,10 +89,8 @@ test_expect_success 'Merge addition of text=3Dauto' =
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
@@ -104,15 +101,9 @@ test_expect_success 'Merge addition of text=3Dauto=
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
@@ -128,15 +119,9 @@ test_expect_success 'Detect LF/CRLF conflict from =
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
