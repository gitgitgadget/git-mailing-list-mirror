From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH 4/8] t9402: No space after IO-redirection
Date: Sat, 8 Dec 2012 22:34:38 +0100
Message-ID: <201212082234.39648.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de, mmogilvi_git@miniinfo.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 08 22:35:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ThS34-0001MV-8c
	for gcvg-git-2@plane.gmane.org; Sat, 08 Dec 2012 22:35:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758192Ab2LHVeq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Dec 2012 16:34:46 -0500
Received: from mout.web.de ([212.227.17.11]:55098 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758189Ab2LHVep convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Dec 2012 16:34:45 -0500
Received: from appes.localnet ([195.67.191.23]) by smtp.web.de (mrweb103) with
 ESMTPA (Nemesis) id 0M1o86-1SsF6U0xis-00tjUQ; Sat, 08 Dec 2012 22:34:44 +0100
X-Provags-ID: V02:K0:dxQ7CV0iqqQ4rrZNX3xTZH/fX+nHOYI+lhxIBvPZb8I
 dGLiJhDwsgM0xDa8/m9G0sKP8cgU2qVenkhvTSIxLxd8Q0nWu+
 VvpajLnD2men+RuWlJ5R+ZBgkZTruK7z9nrgWrL+k7Xx0K75bi
 CWnpPBBydU/g1bKbKjF6wUuWIOE4mmxq+P6CZQU+A0Yj5hYkDU
 MDFqCrVp9/Hyg6xxLq8+A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211218>

Redirection should not have SP before the filename
(i.e. ">out", not "> out").

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 t/t9402-git-cvsserver-refs.sh | 60 +++++++++++++++++++++--------------=
--------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/t/t9402-git-cvsserver-refs.sh b/t/t9402-git-cvsserver-refs=
=2Esh
index 21000ec..2f63331 100755
--- a/t/t9402-git-cvsserver-refs.sh
+++ b/t/t9402-git-cvsserver-refs.sh
@@ -11,7 +11,7 @@ tags, branches and other git refspecs'
=20
 check_start_tree() {
     rm -f "$WORKDIR/check.list"
-    echo "start $1" >> "${WORKDIR}/check.log"
+    echo "start $1" >>"${WORKDIR}/check.log"
 }
=20
 check_file() {
@@ -19,11 +19,11 @@ check_file() {
     file=3D"$2"
     ver=3D"$3"
     GIT_DIR=3D$SERVERDIR git show "${ver}:${file}" \
-	> "$WORKDIR/check.got" 2> "$WORKDIR/check.stderr"
+	>"$WORKDIR/check.got" 2>"$WORKDIR/check.stderr"
     test_cmp "$WORKDIR/check.got" "$sandbox/$file"
     stat=3D$?
-    echo "check_file $sandbox $file $ver : $stat" >> "$WORKDIR/check.l=
og"
-    echo "$file" >> "$WORKDIR/check.list"
+    echo "check_file $sandbox $file $ver : $stat" >>"$WORKDIR/check.lo=
g"
+    echo "$file" >>"$WORKDIR/check.list"
     return $stat
 }
=20
@@ -57,7 +57,7 @@ check_diff() {
     ( cd diffSandbox &&
       git checkout "$vOld" &&
       git apply -p0 --index <"../$diffFile" &&
-      git diff --exit-code "$vNew" ) > check_diff_apply.out 2>&1
+      git diff --exit-code "$vNew" ) >check_diff_apply.out 2>&1
 }
=20
 #########
@@ -89,18 +89,18 @@ export CVSROOT CVS_SERVER
=20
 rm -rf "$CVSWORK" "$SERVERDIR"
 test_expect_success 'setup v1, b1' '
-    echo "Simple text file" > textfile.c &&
-    echo "t2" > t2 &&
+    echo "Simple text file" >textfile.c &&
+    echo "t2" >t2 &&
     mkdir adir &&
-    echo "adir/afile line1" > adir/afile &&
-    echo "adir/afile line2" >> adir/afile &&
-    echo "adir/afile line3" >> adir/afile &&
-    echo "adir/afile line4" >> adir/afile &&
-    echo "adir/a2file" >> adir/a2file &&
+    echo "adir/afile line1" >adir/afile &&
+    echo "adir/afile line2" >>adir/afile &&
+    echo "adir/afile line3" >>adir/afile &&
+    echo "adir/afile line4" >>adir/afile &&
+    echo "adir/a2file" >>adir/a2file &&
     mkdir adir/bdir &&
-    echo "adir/bdir/bfile line 1" > adir/bdir/bfile &&
-    echo "adir/bdir/bfile line 2" >> adir/bdir/bfile &&
-    echo "adir/bdir/b2file" > adir/bdir/b2file &&
+    echo "adir/bdir/bfile line 1" >adir/bdir/bfile &&
+    echo "adir/bdir/bfile line 2" >>adir/bdir/bfile &&
+    echo "adir/bdir/b2file" >adir/bdir/b2file &&
     git add textfile.c t2 adir &&
     git commit -q -m "First Commit (v1)" &&
     git tag v1 &&
@@ -152,7 +152,7 @@ test_expect_success 'edit cvswork3 and save diff' '
     ( cd cvswork3 &&
       sed -e "s/line1/line1 - data/" adir/afile >adir/afileNEW &&
 			mv -f adir/afileNEW adir/afile &&
-      echo "afile5" > adir/afile5 &&
+      echo "afile5" >adir/afile5 &&
       rm t2 &&
       cvs -f add adir/afile5 &&
       cvs -f rm t2 &&
@@ -162,17 +162,17 @@ test_expect_success 'edit cvswork3 and save diff'=
 '
=20
 test_expect_success 'setup v1.2 on b1' '
     git checkout b1 &&
-    echo "new v1.2" > t3 &&
+    echo "new v1.2" >t3 &&
     rm t2 &&
     sed -e "s/line3/line3 - more data/" adir/afile >adir/afileNEW &&
 		mv -f adir/afileNEW adir/afile &&
     rm adir/a2file &&
-    echo "a3file" >> adir/a3file &&
-    echo "bfile line 3" >> adir/bdir/bfile &&
+    echo "a3file" >>adir/a3file &&
+    echo "bfile line 3" >>adir/bdir/bfile &&
     rm adir/bdir/b2file &&
-    echo "b3file" > adir/bdir/b3file &&
+    echo "b3file" >adir/bdir/b3file &&
     mkdir cdir &&
-    echo "cdir/cfile" > cdir/cfile &&
+    echo "cdir/cfile" >cdir/cfile &&
     git add -A cdir adir t3 t2 &&
     git commit -q -m 'v1.2' &&
     git tag v1.2 &&
@@ -280,7 +280,7 @@ test_expect_success 'cvs co b2 [into cvswork2]' '
=20
 test_expect_success 'root dir edit [cvswork2]' '
     ( cd cvswork2 &&
-      echo "Line 2" >> textfile.c &&
+      echo "Line 2" >>textfile.c &&
       ! cvs -f diff -u >"$WORKDIR/cvsEdit1.diff" &&
       cvs -f commit -m "edit textfile.c" textfile.c
     ) >cvsEdit1.log 2>&1
@@ -289,10 +289,10 @@ test_expect_success 'root dir edit [cvswork2]' '
 test_expect_success 'root dir rm file [cvswork2]' '
     ( cd cvswork2 &&
       cvs -f rm -f t2 &&
-      cvs -f diff -u > ../cvsEdit2-empty.diff &&
+      cvs -f diff -u >../cvsEdit2-empty.diff &&
       ! cvs -f diff -N -u >"$WORKDIR/cvsEdit2-N.diff" &&
       cvs -f commit -m "rm t2"
-    ) > cvsEdit2.log 2>&1
+    ) >cvsEdit2.log 2>&1
 '
=20
 test_expect_success 'subdir edit/add/rm files [cvswork2' '
@@ -302,7 +302,7 @@ test_expect_success 'subdir edit/add/rm files [cvsw=
ork2' '
       rm adir/bdir/b2file &&
       cd adir &&
       cvs -f rm bdir/b2file &&
-      echo "4th file" > bdir/b4file &&
+      echo "4th file" >bdir/b4file &&
       cvs -f add bdir/b4file &&
       ! cvs -f diff -N -u >"$WORKDIR/cvsEdit3.diff" &&
       git fetch gitcvs.git b2:b2 &&
@@ -471,7 +471,7 @@ test_expect_success 'cvs diff -N -r v2 -u' '
       ! cvs -f diff -N -r v2 -u ) >cvsDiff.out 2>cvs.log &&
     test ! -s cvs.log &&
     test -s cvsDiff.out &&
-    check_diff cvsDiff.out v2 v1 > check_diff.out 2>&1
+    check_diff cvsDiff.out v2 v1 >check_diff.out 2>&1
 '
=20
 test_expect_success 'cvs diff -N -r v2 -r v1.2' '
@@ -479,7 +479,7 @@ test_expect_success 'cvs diff -N -r v2 -r v1.2' '
       ! cvs -f diff -N -r v2 -r v1.2 -u ) >cvsDiff.out 2>cvs.log &&
     test ! -s cvs.log &&
     test -s cvsDiff.out &&
-    check_diff cvsDiff.out v2 v1.2 > check_diff.out 2>&1
+    check_diff cvsDiff.out v2 v1.2 >check_diff.out 2>&1
 '
=20
 test_expect_success 'apply early [cvswork3] diff to b3' '
@@ -499,7 +499,7 @@ test_expect_success 'check [cvswork3] diff' '
     test -s cvsDiff.out &&
     test $(grep Index: cvsDiff.out | wc -l) =3D 3 &&
     test_cmp cvsDiff.out cvswork3edit.diff &&
-    check_diff cvsDiff.out v1 v3 > check_diff.out 2>&1
+    check_diff cvsDiff.out v1 v3 >check_diff.out 2>&1
 '
=20
 test_expect_success 'merge early [cvswork3] b3 with b1' '
@@ -537,7 +537,7 @@ test_expect_success 'cvs up dirty [cvswork3]' '
 test_expect_success 'cvs commit [cvswork3' '
     ( cd cvswork3 &&
       cvs -f commit -m "dirty sandbox after auto-merge"
-    ) > cvs.log 2>&1 &&
+    ) >cvs.log 2>&1 &&
     check_start_tree cvswork3 &&
     check_file cvswork3 textfile.c v3merged &&
     check_file cvswork3 t3 v3merged &&
@@ -550,7 +550,7 @@ test_expect_success 'cvs commit [cvswork3' '
     check_end_full_tree cvswork3 v3merged &&
     git fetch gitcvs.git b3:b4 &&
     git tag v4.1 b4 &&
-    git diff --exit-code v4.1 v3merged > check_diff_apply.out 2>&1
+    git diff --exit-code v4.1 v3merged >check_diff_apply.out 2>&1
 '
=20
 test_done
--=20
1.8.0.197.g5a90748
