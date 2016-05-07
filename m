From: tboegi@web.de
Subject: [PATCH v9 5/6] t6038; use crlf on all platforms
Date: Sat,  7 May 2016 08:11:05 +0200
Message-ID: <1462601465-23690-1-git-send-email-tboegi@web.de>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 07 08:06:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayvNj-0003c4-Go
	for gcvg-git-2@plane.gmane.org; Sat, 07 May 2016 08:06:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbcEGGGP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 May 2016 02:06:15 -0400
Received: from mout.web.de ([212.227.17.11]:55751 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751780AbcEGGGL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2016 02:06:11 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0M8i11-1buLPn3SEN-00wELr; Sat, 07 May 2016 08:06:08
 +0200
X-Mailer: git-send-email 2.0.0.rc1.6318.g0c2c796
In-Reply-To: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:s+0cz+r8pFOC2Pefkwx2CCKdl3ZW1dxedPBUJBnclEGln2Z19sc
 5u+D4Zltnxb01p0Uv8YgtBaSIYYBzFjMANsDpg087ncD310utxp1bEeL2RzIjI/tYZiTCc9
 s9ZY+4UTXdp5wrIehknVdaOGzRp6mP7Vh+O8V2qbUrxhD9OXxza5m//5sB3GAUqxTs7ldy8
 KwxucW/0Kj9k5dF3HvsrQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yYyQz6Svx/Y=:9gZ3nlk8XeztMA8bd2Dp4J
 WQfULeYNHyJ4pTNaTTptHrdo/2VwjWc3SGc5oaigEZkEUMrGRGHwrV7lQLG9s6/FoL58IRv3Q
 FrzI9V+K3xh/nlZC5siKgW6hZEDT8IJpM/HamQY+1u/7hR5U9U9Il4poWlqmMFQgZvxIi+Tdb
 8o0as4UsZq6TnzpJz6ZyG6EIRz9HfB42GUGNeyi5TEYXua8GszAJTY5UUNsjC1Q9rpeAbQYx4
 4ywEq4N1g2SDdjqTFMNHfJY/ZmWjywRx/RcQNRP/4BpcFiAMwD9Rpm87F2XVdxA1/Lvroj0PZ
 2Pu2ATIxmf2IKPFQmNdSy1VxX9WnIsanbPzWNzfzAwD61fPfHJdTh8DMIFb7gOer5NLfntKfW
 r+yRvfmQ9+bRrs3ZFzFFNHMzpP7MTmPsEYU8Ur+CmyurMmNiHCOuyOsFQhVxTTZI1ddklPQa7
 7a78K0CbmWd0HTegXz0ACx/KUgmEd6A150XIHfMbIAxk4YC5r2AH/oQ2ciALsY9Mf0LGscy5e
 ozWrn2DCreYZemJaFsXBtJs63JUQmqY3AhXqxQkcXXfDPmsoZY7p2McRvfB1cZ8am0slaVIvA
 XNkGdlRxVfePTNzOCWz69emc/zigVMiwosBlO+QkCIyzq86fFhgGziOqmxo6UC8d9MtaTdKm/
 w7srzcrjLA9Rbx12QJI0skDA0PyFSKDeKHTMIdsbw0avwr7DoDgcoD+nL+ccd0Zds7QozbpVr
 nHRyHs5mye690y5vx+sFFGw5uvnfmKRu8L+0OkRA16hlmmTimChit8KFkD4DZ7mmi5eh+QIc 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293879>

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
2.0.0.rc1.6318.g0c2c796
