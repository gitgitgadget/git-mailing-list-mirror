From: tboegi@web.de
Subject: [PATCH v8 09/10] t6038; use crlf on all platforms
Date: Fri, 29 Apr 2016 17:02:05 +0200
Message-ID: <1461942125-16257-1-git-send-email-tboegi@web.de>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 17:02:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aw9vg-00018L-2A
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 17:02:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753936AbcD2O5i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Apr 2016 10:57:38 -0400
Received: from mout.web.de ([212.227.15.4]:57644 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753925AbcD2O5e (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 10:57:34 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0MKek3-1awQZf41fr-001whj; Fri, 29 Apr 2016 16:57:33
 +0200
X-Mailer: git-send-email 2.0.0.rc1.6318.g0c2c796
In-Reply-To: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:T8AWyp1RfSq3RTVWdYylf8KWROJ/6CBNecDoB8vmEvz6+w1HcsY
 tCuOc0ys3nZM8jSsu0Y6HWVy5gqbRcwfLzv4HS3VaXafDCR+qX6DvaR/fFh4pzYo2zaWnVR
 W2N5IcBO2dYzE13TdGCxNhldrp9qLPSMA+8OqhNJt4PjO/bXWqmIcVsnS4/l+3tXUY3yMKp
 lUHXcAC8Dc+xHO2LHCbXA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QiscHzzIA3U=:cDcmnhR9VtmTN7J6jMmpHd
 3z1btfALIBOkmiDF/F9x04hDNMlPjWvZmya328+5hT83OKmcXzI1lr6evxEhjr8OxRt20Ok5U
 nhu9pmCu/eCJvqmJaXS8X1UBKQd0KuQPfAddna/mP1m+YFQAfpf/Cn+D9fdA5h2G16u+BxF6T
 Dpl142IYvjFwyMVeNH2LDOx8DSBMJLrIiJs78KpYbT/K9vdKbT1Qvuw3yDJzYFFwWN8YKp6Zb
 2LEHabxgx4RngHWYmms0qW3eCTtPz1u7WtQ7LvI2Dyd/lO2YYWieWBXuG1WVccJxP54l36kUR
 tmUX/+uD0JEZLmvWWKtzl2766zThWIGeHukazaTDNXjt6NqBVbeFP2AeimYO0RWS2RKi/8nHg
 AZnS7086R8nvajblYy6rqF+vkZ8vanmNxgh4bzSyML20de7z4ARzUii48LJrPw93sc8DmFu0A
 l4c8CYlwZkEDR+8Nt7uFtWVLhONCrDbhtOqF6WNmsWMegccqjzLba3MKd/Vkfqvx0dOiiOe3o
 KWuNxmClwojX4oxgQwGFHf4Yi5Fe3X/DuIdgaDYlhrq1Tbo7/x7/HUgym1bdrOZ4wtXr3zWkf
 zKaKu/5SnBF5Js9C2Q+fG+9lBd4HJe5pY83gnG6aj6O3hu2NALNFJYLLwzN3tDuTzRZybYKy5
 TSdarTwlfb/3R2afWBS2mO5j6zpvQ048NobZKV+TIWHRyp8XS8tz956bgofXgQnJvRVtD8hyK
 3EDeAcRH7xeupKGNYk8eSML7pwlHokf3M0K+gGW299gHxQDQd+8esPm7ZyCjv03CleTpf7wR 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293016>

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
2.7.0.992.g0c2c796
