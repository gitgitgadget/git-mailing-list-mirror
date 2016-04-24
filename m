From: tboegi@web.de
Subject: [PATCH v6b 09/10] t6038; use crlf on all platforms
Date: Sun, 24 Apr 2016 17:11:30 +0200
Message-ID: <1461510690-21200-1-git-send-email-tboegi@web.de>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 17:07:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auLdR-0006D7-Ux
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 17:07:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752808AbcDXPHi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Apr 2016 11:07:38 -0400
Received: from mout.web.de ([212.227.15.4]:60006 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752737AbcDXPHR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 11:07:17 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb002) with
 ESMTPSA (Nemesis) id 0MY6lc-1bGGDy3K52-00Uu7W; Sun, 24 Apr 2016 17:07:14
 +0200
X-Mailer: git-send-email 2.0.0.rc1.6318.g0c2c796
In-Reply-To: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:W+tyq8+toS1P1Kz8R1C8vy9ILDl8XESxZV0m3Cm0at7/fQrCEDA
 w3x1svuirMcAP3lHtHdEWO+KXPGYS/qYPDKHm1Hf9CTUkWAyUt0YgrIlgG8n/x1QhN8+g8S
 /JZ5QYAHxXFf/orrHRE522VO+XfH0CsKlpdbQymZL0Wvx5nJw7Oc8hMO62oa3IIqu9ateZz
 AR7jus5F8ClJvtNMlqF2g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MsLIDMbxO4c=:gLmbCvq4tnsaghdLkffaWI
 BjP8z9FfmcT9vf+usWc77Rd1Qx3aGyJFVOkJr+HxdHDIJkzqbhkd2uWA/clmGlV+1hb3wxY0o
 hMCcflLMRhJVzo+7eiewQ0LcVgBLHFgaFE3Tj9X4F3bVIcgkECGbCMOz/b9tT5nm9jxGDyJbZ
 Pl7VvcSxJXQY5GH+Fwl6m3R0eOJwLgQfeOXCg0O3W/ovf8xYzjyGGXE2XXh23HLm5xB0TXO/+
 8d2DV4BJul5cN3tkbo83z0SdTf3kLU4Ccwy5hTwR2qHdRoi8QLHffCcC6lH0Zttc7xCMWO8eP
 e/KUwuITcXhgwnONNF4Y2x3qCUlaNM836voqX+o1YCDw5MplEDR97wdYzmUSGpmC4fcLEZ404
 As7gproA5e02NHkSlGJWwKvHkftIF5ZgwBa3ayvFDrRtuu5uiHWKvvdeK3OumA2LvN1qjRwrm
 uqmz2F35Q/vgkVf/fM2qDUl9cpTSi21Dfui9SHqIxhQxockRdGN561x/gReBweORVXlxmOsJG
 MyUhS4aopp2E3yMZXy8K5ziUoUv+vClWQb+whekd2iDAEWiorSOOUBZ0AvkyNBanvsmO9yjK4
 sJj48wpHZo7xgP7BInzcgYbHdZ7+RDCdNFVrfi8HVCHABm6E04H94maeAs2PMg4CLslQdqV1y
 UzzzTBQ5ttnuz3oJzvzte0LDJohdzYzSGzE5Fe4luQfdwbbKU3HIKu1hzt48toIF4RNn0QTif
 2ExXlM2o4vgVvVYFnl76663x0Q/o0HMkC0lhHlaZYNpawmR16OXh3ZZzyi96vntcoRXeN3gw 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292414>

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
2.8.0.rc2.2.g1a4d45a.dirty
