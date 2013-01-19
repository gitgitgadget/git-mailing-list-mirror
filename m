From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH 3/3] t0050: Use TAB for indentation
Date: Sat, 19 Jan 2013 08:19:58 +0100
Message-ID: <201301190819.59611.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 19 08:20:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwSj6-0004Fn-Vu
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jan 2013 08:20:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250Ab3ASHUG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Jan 2013 02:20:06 -0500
Received: from mout.web.de ([212.227.17.12]:57739 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750864Ab3ASHUF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Jan 2013 02:20:05 -0500
Received: from appes.localnet ([195.67.191.23]) by smtp.web.de (mrweb003) with
 ESMTPA (Nemesis) id 0M4ZVE-1T0FT60yzc-00yy4L; Sat, 19 Jan 2013 08:20:04 +0100
X-Provags-ID: V02:K0:cO/ssaepnl2InQXGukkNphsJXoSro0jofQ27eUxbtaw
 51KDSPH1nMnxahxnaD3kgfuGU4cVTclqqczSUhsA6KJhAdCL9f
 /A1zLzQv0hZMh6TAwhj+K1Xl5wiByT8yRAymgdATmm9bXbbcok
 3jRzpOszcdu84tQuM9NgkBWtnjt3gjdKgrVwlcwQlVHTd/vYVq
 JYYAa8JtOqdVCs8aQAPMw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213960>

Use one TAB for indentation and remove empty lines

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 t/t0050-filesystem.sh | 48 +++++++++++++++----------------------------=
-----
 1 file changed, 15 insertions(+), 33 deletions(-)

diff --git a/t/t0050-filesystem.sh b/t/t0050-filesystem.sh
index a6fa3c5..05d78d2 100755
--- a/t/t0050-filesystem.sh
+++ b/t/t0050-filesystem.sh
@@ -29,12 +29,10 @@ test_have_prereq SYMLINKS ||
 if test_have_prereq CASE_INSENSITIVE_FS
 then
 test_expect_success "detection of case insensitive filesystem during r=
epo init" '
-
 	test $(git config --bool core.ignorecase) =3D true
 '
 else
 test_expect_success "detection of case insensitive filesystem during r=
epo init" '
-
 	test_must_fail git config --bool core.ignorecase >/dev/null ||
 	test $(git config --bool core.ignorecase) =3D false
 '
@@ -43,20 +41,17 @@ fi
 if test_have_prereq SYMLINKS
 then
 test_expect_success "detection of filesystem w/o symlink support durin=
g repo init" '
-
 	test_must_fail git config --bool core.symlinks ||
 	test "$(git config --bool core.symlinks)" =3D true
 '
 else
 test_expect_success "detection of filesystem w/o symlink support durin=
g repo init" '
-
 	v=3D$(git config --bool core.symlinks) &&
 	test "$v" =3D false
 '
 fi
=20
 test_expect_success "setup case tests" '
-
 	git config core.ignorecase true &&
 	touch camelcase &&
 	git add camelcase &&
@@ -67,29 +62,23 @@ test_expect_success "setup case tests" '
 	git mv tmp CamelCase &&
 	git commit -m "rename" &&
 	git checkout -f master
-
 '
=20
 $test_case 'rename (case change)' '
-
 	git mv camelcase CamelCase &&
 	git commit -m "rename"
-
 '
=20
 test_expect_success 'merge (case change)' '
-
 	rm -f CamelCase &&
 	rm -f camelcase &&
 	git reset --hard initial &&
 	git merge topic
-
 '
=20
=20
=20
 test_expect_failure CASE_INSENSITIVE_FS 'add (with different case)' '
-
 	git reset --hard initial &&
 	rm camelcase &&
 	echo 1 >CamelCase &&
@@ -97,37 +86,30 @@ test_expect_failure CASE_INSENSITIVE_FS 'add (with =
different case)' '
 	camel=3D$(git ls-files | grep -i camelcase) &&
 	test $(echo "$camel" | wc -l) =3D 1 &&
 	test "z$(git cat-file blob :$camel)" =3D z1
-
 '
=20
 test_expect_success "setup unicode normalization tests" '
-
-  test_create_repo unicode &&
-  cd unicode &&
-  touch "$aumlcdiar" &&
-  git add "$aumlcdiar" &&
-  git commit -m initial &&
-  git tag initial &&
-  git checkout -b topic &&
-  git mv $aumlcdiar tmp &&
-  git mv tmp "$auml" &&
-  git commit -m rename &&
-  git checkout -f master
-
+	test_create_repo unicode &&
+	cd unicode &&
+	touch "$aumlcdiar" &&
+	git add "$aumlcdiar" &&
+	git commit -m initial &&
+	git tag initial &&
+	git checkout -b topic &&
+	git mv $aumlcdiar tmp &&
+	git mv tmp "$auml" &&
+	git commit -m rename &&
+	git checkout -f master
 '
=20
 $test_unicode 'rename (silent unicode normalization)' '
-
- git mv "$aumlcdiar" "$auml" &&
- git commit -m rename
-
+	git mv "$aumlcdiar" "$auml" &&
+	git commit -m rename
 '
=20
 $test_unicode 'merge (silent unicode normalization)' '
-
- git reset --hard initial &&
- git merge topic
-
+	git reset --hard initial &&
+	git merge topic
 '
=20
 test_done
--=20
1.8.0.197.g5a90748
