From: tboegi@web.de
Subject: [PATCH v1 1/3] t6038; use crlf on all platforms
Date: Sun, 15 May 2016 08:38:00 +0200
Message-ID: <1463294280-20176-1-git-send-email-tboegi@web.de>
References: <20160513134953.GE2345@dinwoodie.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 15 08:33:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1pc0-0006Pf-3V
	for gcvg-git-2@plane.gmane.org; Sun, 15 May 2016 08:33:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752600AbcEOGdA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 May 2016 02:33:00 -0400
Received: from mout.web.de ([212.227.15.14]:57161 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752373AbcEOGdA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2016 02:33:00 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0MNtP9-1aw2BC15bP-007R0Y; Sun, 15 May 2016 08:32:53
 +0200
X-Mailer: git-send-email 2.0.0.rc1.6318.g0c2c796
In-Reply-To: <20160513134953.GE2345@dinwoodie.org>
X-Provags-ID: V03:K0:JDwu3HDYM68i+nbXB1ptqdmnwF1Bx+63emy0yIpA+iVbr1m80tw
 /1kYjaVULTXpXA3QLO8qd/OwTzkAgixxGc0dYqWHPEwgxr7sezOJNTcCF5AoOfBXti/M4ZJ
 OO6lxtmgcD6PNQ3EeqPuxyprrgo1muwQpNoR9synb2fkPtvYuHeoeE8UioUJBi1OeWEfbwK
 SWd8oaqpoFrFN4aAmth6A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:N6BlYLGlDt0=:PgNKvkFduaXOhlnzuEs0+E
 flaO31lwfvBmQIL1zSbVNLJx4iugcTuj+ITPxAcqiZxrlnRNN7TOOYtFBVQBh+xP2By0jsnKK
 ciO0acBfXQmFjeKemb63fHBdPXWOSfCsW3Xsn2wvXI3r7lX3gGgY/v7x3pc2KwFxX/Zh0Q5Oh
 VFWqPd2EtSMXkeE3/vxRYjfZ+8v4QGltPiF0AFRvNH2DrIpAyx2BzmMDLWRs5wkIp6X6CGVPo
 nEzZIeAC/qOeW1USRmgz34KQ7dVPCc2Ds8GNA/Mq/DFD6jMm3Na+LuLTEeb67iTRPS61+L/TG
 HKW9haY+fZ+eHeWjj1urEP+SnfesSRqsiAl2fJHHJFR+aBnaXTcawYW/3KZPGyp8IANvmztEQ
 bCCiMQGN8mchpB9RZ9GIDCNnVxSu0HqQNgoxv+E6Txk1AWhIpjYZ9Erhkz/OvI764Mzv18iUW
 gMpzj2UgOZ+g2iRTExoY+uue4UOhGjb+hg6UHsyOZvjDVDdS57r3HT27UKLTDuyRAhwRk80Ui
 tgJonPfqWq+n8j1B4HHJ9sk+wYjrjBMn0NExKXfZ8qTCmRniMfh2eWZ6hZ9gRid1Wx3x1Wajp
 u4Z3GBD0Ga1/T2bnZqhD3r973Si4PTA5kKNSOUfHwc7E8zwMLOWcXTAgtmUTmShi7CXjA54/K
 l33KTzDuUra+dkPBEbDkZ3mDDu+hnjSf8/HJnJ+9ESEtAX1itXrlWhmIFljC8pqm+p8N7A/ms
 rPnIlyotLMrjB1J/AhiSyXhrD5GobmPjFQPO24GuFb8KBqPw1edup3rlpE0+bKgYxJkx7LaB 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294640>

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
