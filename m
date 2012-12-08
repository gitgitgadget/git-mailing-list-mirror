From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH 5/8] t9402: Add missing &&; Code style
Date: Sat, 8 Dec 2012 22:34:55 +0100
Message-ID: <201212082234.55979.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de, mmogilvi_git@miniinfo.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 08 22:35:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ThS3P-0001g5-9m
	for gcvg-git-2@plane.gmane.org; Sat, 08 Dec 2012 22:35:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758196Ab2LHVfD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Dec 2012 16:35:03 -0500
Received: from mout.web.de ([212.227.15.4]:56383 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758189Ab2LHVfB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Dec 2012 16:35:01 -0500
Received: from appes.localnet ([195.67.191.23]) by smtp.web.de (mrweb101) with
 ESMTPA (Nemesis) id 0MK1s1-1TiHWo3tLh-0029ZB; Sat, 08 Dec 2012 22:35:00 +0100
X-Provags-ID: V02:K0:4+WAxmpXKnGalCuJy7FxVE5RbACrNUqKYeClS90lLJ9
 QPo7jW6pzfQ9IQH0ynoSLQebWlxrtqpJWC/2uKc+itSg4Jhwdy
 TrDJZ6OiYZe0pRZW0++zhL0ohbEL7cV3xhqAyfCmHG0h3vnR+V
 N2uE2E0bXjkoN9FcUoqct53AtUM55QQ4kC/SDZFVQY8ScF9x0F
 +TZ4+uJ7VE4QhoZQqLnTA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211219>

Add missing && at 2 places
Re-formated the sub-shell parantheses (coding style)
Added missing ] in the test_expect_success header at 2 places

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 t/t9402-git-cvsserver-refs.sh | 110 ++++++++++++++++++++--------------=
--------
 1 file changed, 52 insertions(+), 58 deletions(-)

diff --git a/t/t9402-git-cvsserver-refs.sh b/t/t9402-git-cvsserver-refs=
=2Esh
index 2f63331..d525778 100755
--- a/t/t9402-git-cvsserver-refs.sh
+++ b/t/t9402-git-cvsserver-refs.sh
@@ -54,10 +54,12 @@ check_diff() {
     vNew=3D"$3"
     rm -rf diffSandbox
     git clone -q -n . diffSandbox &&
-    ( cd diffSandbox &&
+    (
+      cd diffSandbox &&
       git checkout "$vOld" &&
       git apply -p0 --index <"../$diffFile" &&
-      git diff --exit-code "$vNew" ) >check_diff_apply.out 2>&1
+      git diff --exit-code "$vNew"
+		) >check_diff_apply.out 2>&1
 }
=20
 #########
@@ -149,7 +151,8 @@ test_expect_success 'cvs co b1 [cvswork3]' '
 '
=20
 test_expect_success 'edit cvswork3 and save diff' '
-    ( cd cvswork3 &&
+    (
+      cd cvswork3 &&
       sed -e "s/line1/line1 - data/" adir/afile >adir/afileNEW &&
 			mv -f adir/afileNEW adir/afile &&
       echo "afile5" >adir/afile5 &&
@@ -180,8 +183,7 @@ test_expect_success 'setup v1.2 on b1' '
 '
=20
 test_expect_success 'cvs -f up (on b1 adir)' '
-    ( cd cvswork/adir &&
-      cvs -f up -d ) >cvs.log 2>&1 &&
+    ( cd cvswork/adir && cvs -f up -d ) >cvs.log 2>&1 &&
     check_start_tree cvswork &&
     check_file cvswork textfile.c v1 &&
     check_file cvswork t2 v1 &&
@@ -193,8 +195,7 @@ test_expect_success 'cvs -f up (on b1 adir)' '
 '
=20
 test_expect_success 'cvs up (on b1 /)' '
-    ( cd cvswork &&
-      cvs -f up -d ) >cvs.log 2>&1 &&
+    ( cd cvswork && cvs -f up -d ) >cvs.log 2>&1 &&
     check_start_tree cvswork &&
     check_file cvswork textfile.c v1.2 &&
     check_file cvswork t3 v1.2 &&
@@ -208,8 +209,7 @@ test_expect_success 'cvs up (on b1 /)' '
=20
 # Make sure "CVS/Tag" files didn't get messed up:
 test_expect_success 'cvs up (on b1 /) (again; check CVS/Tag files)' '
-    ( cd cvswork &&
-      cvs -f up -d ) >cvs.log 2>&1 &&
+    ( cd cvswork && cvs -f up -d ) >cvs.log 2>&1 &&
     check_start_tree cvswork &&
     check_file cvswork textfile.c v1.2 &&
     check_file cvswork t3 v1.2 &&
@@ -223,8 +223,7 @@ test_expect_success 'cvs up (on b1 /) (again; check=
 CVS/Tag files)' '
=20
 # update to another version:
 test_expect_success 'cvs up -r v1' '
-    ( cd cvswork &&
-      cvs -f up -r v1 ) >cvs.log 2>&1 &&
+    ( cd cvswork && cvs -f up -r v1 ) >cvs.log 2>&1 &&
     check_start_tree cvswork &&
     check_file cvswork textfile.c v1 &&
     check_file cvswork t2 v1 &&
@@ -236,8 +235,7 @@ test_expect_success 'cvs up -r v1' '
 '
=20
 test_expect_success 'cvs up' '
-    ( cd cvswork &&
-      cvs -f up ) >cvs.log 2>&1 &&
+    ( cd cvswork && cvs -f up ) >cvs.log 2>&1 &&
     check_start_tree cvswork &&
     check_file cvswork textfile.c v1 &&
     check_file cvswork t2 v1 &&
@@ -249,8 +247,7 @@ test_expect_success 'cvs up' '
 '
=20
 test_expect_success 'cvs up (again; check CVS/Tag files)' '
-    ( cd cvswork &&
-      cvs -f up -d ) >cvs.log 2>&1 &&
+    ( cd cvswork && cvs -f up -d ) >cvs.log 2>&1 &&
     check_start_tree cvswork &&
     check_file cvswork textfile.c v1 &&
     check_file cvswork t2 v1 &&
@@ -279,15 +276,16 @@ test_expect_success 'cvs co b2 [into cvswork2]' '
 '
=20
 test_expect_success 'root dir edit [cvswork2]' '
-    ( cd cvswork2 &&
-      echo "Line 2" >>textfile.c &&
+    (
+      cd cvswork2 && echo "Line 2" >>textfile.c &&
       ! cvs -f diff -u >"$WORKDIR/cvsEdit1.diff" &&
       cvs -f commit -m "edit textfile.c" textfile.c
     ) >cvsEdit1.log 2>&1
 '
=20
 test_expect_success 'root dir rm file [cvswork2]' '
-    ( cd cvswork2 &&
+    (
+      cd cvswork2 &&
       cvs -f rm -f t2 &&
       cvs -f diff -u >../cvsEdit2-empty.diff &&
       ! cvs -f diff -N -u >"$WORKDIR/cvsEdit2-N.diff" &&
@@ -295,8 +293,9 @@ test_expect_success 'root dir rm file [cvswork2]' '
     ) >cvsEdit2.log 2>&1
 '
=20
-test_expect_success 'subdir edit/add/rm files [cvswork2' '
-    ( cd cvswork2 &&
+test_expect_success 'subdir edit/add/rm files [cvswork2]' '
+    (
+      cd cvswork2 &&
       sed -e "s/line 1/line 1 (v2)/" adir/bdir/bfile >adir/bdir/bfileN=
EW &&
       mv -f adir/bdir/bfileNEW adir/bdir/bfile &&
       rm adir/bdir/b2file &&
@@ -306,9 +305,10 @@ test_expect_success 'subdir edit/add/rm files [cvs=
work2' '
       cvs -f add bdir/b4file &&
       ! cvs -f diff -N -u >"$WORKDIR/cvsEdit3.diff" &&
       git fetch gitcvs.git b2:b2 &&
-      ( cd .. &&
-	! cvs -f diff -u -N -r v1.2 >"$WORKDIR/cvsEdit3-v1.2.diff" &&
-	! cvs -f diff -u -N -r v1.2 -r v1 >"$WORKDIR/cvsEdit3-v1.2-v1.diff"
+      (
+        cd .. &&
+        ! cvs -f diff -u -N -r v1.2 >"$WORKDIR/cvsEdit3-v1.2.diff" &&
+        ! cvs -f diff -u -N -r v1.2 -r v1 >"$WORKDIR/cvsEdit3-v1.2-v1.=
diff"
       ) &&
       cvs -f commit -m "various add/rm/edit"
     ) >cvs.log 2>&1
@@ -334,12 +334,14 @@ test_expect_success 'validate basic diffs saved d=
uring above cvswork2 edits' '
     test $(grep Index: cvsEdit3.diff | wc -l) =3D 3 &&
     rm -rf diffSandbox &&
     git clone -q -n . diffSandbox &&
-    ( cd diffSandbox &&
+    (
+      cd diffSandbox &&
       git checkout v1 &&
       git apply -p0 --index <"$WORKDIR/cvsEdit1.diff" &&
       git apply -p0 --index <"$WORKDIR/cvsEdit2-N.diff" &&
       git apply -p0 --directory=3Dadir --index <"$WORKDIR/cvsEdit3.dif=
f" &&
-      git diff --exit-code v2 ) >"check_diff_apply.out" 2>&1
+      git diff --exit-code v2
+    ) >"check_diff_apply.out" 2>&1
 '
=20
 test_expect_success 'validate v1.2 diff saved during last cvswork2 edi=
t' '
@@ -353,8 +355,7 @@ test_expect_success 'validate v1.2 v1 diff saved du=
ring last cvswork2 edit' '
 '
=20
 test_expect_success 'cvs up [cvswork2]' '
-    ( cd cvswork2 &&
-      cvs -f up ) >cvs.log 2>&1 &&
+    ( cd cvswork2 && cvs -f up ) >cvs.log 2>&1 &&
     check_start_tree cvswork2 &&
     check_file cvswork2 textfile.c v2 &&
     check_file cvswork2 adir/afile v2 &&
@@ -365,8 +366,7 @@ test_expect_success 'cvs up [cvswork2]' '
 '
=20
 test_expect_success 'cvs up -r b2 [back to cvswork]' '
-    ( cd cvswork &&
-      cvs -f up -r b2 ) >cvs.log 2>&1 &&
+    ( cd cvswork && cvs -f up -r b2 ) >cvs.log 2>&1 &&
     check_start_tree cvswork &&
     check_file cvswork textfile.c v2 &&
     check_file cvswork adir/afile v2 &&
@@ -377,8 +377,7 @@ test_expect_success 'cvs up -r b2 [back to cvswork]=
' '
 '
=20
 test_expect_success 'cvs up -r b1' '
-    ( cd cvswork &&
-      cvs -f up -r b1 ) >cvs.log 2>&1 &&
+    ( cd cvswork && cvs -f up -r b1 ) >cvs.log 2>&1 &&
     check_start_tree cvswork &&
     check_file cvswork textfile.c v1.2 &&
     check_file cvswork t3 v1.2 &&
@@ -391,8 +390,7 @@ test_expect_success 'cvs up -r b1' '
 '
=20
 test_expect_success 'cvs up -A' '
-    ( cd cvswork &&
-      cvs -f up -A ) >cvs.log 2>&1 &&
+    ( cd cvswork && cvs -f up -A ) >cvs.log 2>&1 &&
     check_start_tree cvswork &&
     check_file cvswork textfile.c v1 &&
     check_file cvswork t2 v1 &&
@@ -404,8 +402,7 @@ test_expect_success 'cvs up -A' '
 '
=20
 test_expect_success 'cvs up (check CVS/Tag files)' '
-    ( cd cvswork &&
-      cvs -f up ) >cvs.log 2>&1 &&
+    ( cd cvswork && cvs -f up ) >cvs.log 2>&1 &&
     check_start_tree cvswork &&
     check_file cvswork textfile.c v1 &&
     check_file cvswork t2 v1 &&
@@ -418,8 +415,7 @@ test_expect_success 'cvs up (check CVS/Tag files)' =
'
=20
 # This is not really legal CVS, but it seems to work anyway:
 test_expect_success 'cvs up -r heads/b1' '
-    ( cd cvswork &&
-      cvs -f up -r heads/b1 ) >cvs.log 2>&1 &&
+    ( cd cvswork && cvs -f up -r heads/b1 ) >cvs.log 2>&1 &&
     check_start_tree cvswork &&
     check_file cvswork textfile.c v1.2 &&
     check_file cvswork t3 v1.2 &&
@@ -433,8 +429,7 @@ test_expect_success 'cvs up -r heads/b1' '
=20
 # But this should work even if CVS client checks -r more carefully:
 test_expect_success 'cvs up -r heads_-s-b2 (cvsserver escape mechanism=
)' '
-    ( cd cvswork &&
-      cvs -f up -r heads_-s-b2 ) >cvs.log 2>&1 &&
+    ( cd cvswork && cvs -f up -r heads_-s-b2 ) >cvs.log 2>&1 &&
     check_start_tree cvswork &&
     check_file cvswork textfile.c v2 &&
     check_file cvswork adir/afile v2 &&
@@ -447,8 +442,7 @@ test_expect_success 'cvs up -r heads_-s-b2 (cvsserv=
er escape mechanism)' '
 v1hash=3D$(git rev-parse v1)
 test_expect_success 'cvs up -r $(git rev-parse v1)' '
     test -n "$v1hash" &&
-    ( cd cvswork &&
-      cvs -f up -r "$v1hash" ) >cvs.log 2>&1 &&
+    ( cd cvswork && cvs -f up -r "$v1hash" ) >cvs.log 2>&1 &&
     check_start_tree cvswork &&
     check_file cvswork textfile.c v1 &&
     check_file cvswork t2 v1 &&
@@ -460,23 +454,20 @@ test_expect_success 'cvs up -r $(git rev-parse v1=
)' '
 '
=20
 test_expect_success 'cvs diff -r v1 -u' '
-    ( cd cvswork &&
-      cvs -f diff -r v1 -u ) >cvsDiff.out 2>cvs.log &&
+    ( cd cvswork && cvs -f diff -r v1 -u ) >cvsDiff.out 2>cvs.log &&
     test ! -s cvsDiff.out &&
     test ! -s cvs.log
 '
=20
 test_expect_success 'cvs diff -N -r v2 -u' '
-    ( cd cvswork &&
-      ! cvs -f diff -N -r v2 -u ) >cvsDiff.out 2>cvs.log &&
+    ( cd cvswork && ! cvs -f diff -N -r v2 -u ) >cvsDiff.out 2>cvs.log=
 &&
     test ! -s cvs.log &&
     test -s cvsDiff.out &&
     check_diff cvsDiff.out v2 v1 >check_diff.out 2>&1
 '
=20
 test_expect_success 'cvs diff -N -r v2 -r v1.2' '
-    ( cd cvswork &&
-      ! cvs -f diff -N -r v2 -r v1.2 -u ) >cvsDiff.out 2>cvs.log &&
+    ( cd cvswork && ! cvs -f diff -N -r v2 -r v1.2 -u ) >cvsDiff.out 2=
>cvs.log &&
     test ! -s cvs.log &&
     test -s cvsDiff.out &&
     check_diff cvsDiff.out v2 v1.2 >check_diff.out 2>&1
@@ -484,17 +475,18 @@ test_expect_success 'cvs diff -N -r v2 -r v1.2' '
=20
 test_expect_success 'apply early [cvswork3] diff to b3' '
     git clone -q . gitwork3 &&
-    ( cd gitwork3 &&
+    (
+      cd gitwork3 &&
       git checkout -b b3 v1 &&
       git apply -p0 --index <"$WORKDIR/cvswork3edit.diff" &&
-      git commit -m "cvswork3 edits applied" ) &&
+      git commit -m "cvswork3 edits applied"
+    ) &&
     git fetch gitwork3 b3:b3 &&
     git tag v3 b3
 '
=20
 test_expect_success 'check [cvswork3] diff' '
-    ( cd cvswork3 &&
-      ! cvs -f diff -N -u ) >"$WORKDIR/cvsDiff.out" 2>cvs.log &&
+    ( cd cvswork3 && ! cvs -f diff -N -u ) >"$WORKDIR/cvsDiff.out" 2>c=
vs.log &&
     test ! -s cvs.log &&
     test -s cvsDiff.out &&
     test $(grep Index: cvsDiff.out | wc -l) =3D 3 &&
@@ -503,8 +495,7 @@ test_expect_success 'check [cvswork3] diff' '
 '
=20
 test_expect_success 'merge early [cvswork3] b3 with b1' '
-    ( cd gitwork3 &&
-      git merge "message" HEAD b1 )
+    ( cd gitwork3 && git merge "message" HEAD b1 ) &&
     git fetch gitwork3 b3:b3 &&
     git tag v3merged b3 &&
     git push --tags gitcvs.git b3:b3
@@ -515,11 +506,13 @@ test_expect_success 'merge early [cvswork3] b3 wi=
th b1' '
 # TODO: Validate that the .# file was saved properly, and then
 #   delete/ignore it when checking the tree.
 test_expect_success 'cvs up dirty [cvswork3]' '
-    ( cd cvswork3 &&
+    (
+      cd cvswork3 &&
       cvs -f up &&
-      ! cvs -f diff -N -u >"$WORKDIR/cvsDiff.out" ) >cvs.log 2>&1 &&
+      ! cvs -f diff -N -u >"$WORKDIR/cvsDiff.out"
+    ) >cvs.log 2>&1 &&
     test -s cvsDiff.out &&
-    test $(grep Index: cvsDiff.out | wc -l) =3D 2
+    test $(grep Index: cvsDiff.out | wc -l) =3D 2 &&
     check_start_tree cvswork3 &&
     check_file cvswork3 textfile.c v3merged &&
     check_file cvswork3 t3 v3merged &&
@@ -534,8 +527,9 @@ test_expect_success 'cvs up dirty [cvswork3]' '
=20
 # TODO: test cvs status
=20
-test_expect_success 'cvs commit [cvswork3' '
-    ( cd cvswork3 &&
+test_expect_success 'cvs commit [cvswork3]' '
+    (
+      cd cvswork3 &&
       cvs -f commit -m "dirty sandbox after auto-merge"
     ) >cvs.log 2>&1 &&
     check_start_tree cvswork3 &&
--=20
1.8.0.197.g5a90748
