From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: [PATCH 2/2] t/t91XX git-svn tests: run "git svn" not "git-svn"
Date: Mon, 08 Sep 2008 19:02:08 +0900
Message-ID: <20080908190208.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
To: "Eric Wong" <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Sep 08 12:03:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kcdb4-0001Wb-I8
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 12:03:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752035AbYIHKCq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Sep 2008 06:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752008AbYIHKCq
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 06:02:46 -0400
Received: from karen.lavabit.com ([72.249.41.33]:35239 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751504AbYIHKCo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 06:02:44 -0400
Received: from d.earth.lavabit.com (d.earth.lavabit.com [192.168.111.13])
	by karen.lavabit.com (Postfix) with ESMTP id A6DDEC88C8;
	Mon,  8 Sep 2008 05:02:34 -0500 (CDT)
Received: from 3055.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id TY3IEZITH1HD; Mon, 08 Sep 2008 05:02:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=pvhG2aBPK0lnrIrje6NgsG65BIwXIXKPfHN6VKqzVpRdincpK0zTCenl51hB9QDgk0qiC1E/K6s05lwLxBoUgBT6eUJc2UeTikjEKBiJZm8+jXbE9+pVICbXo/2GYd8Dg+Gi5tI07G0mchj89ERSs2ktOgvoh/QGR2Tvvsk9XEI=;
  h=From:To:Cc:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95233>

This replaces 'git-svn' with 'git svn' in the tests.

Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
---

 t/lib-git-svn.sh                              |    6 +-
 t/t9100-git-svn-basic.sh                      |   48 +++++++-------
 t/t9101-git-svn-props.sh                      |   36 ++++++------
 t/t9102-git-svn-deep-rmdir.sh                 |    8 +-
 t/t9103-git-svn-tracked-directory-removed.sh  |    2 +-
 t/t9104-git-svn-follow-parent.sh              |   38 ++++++------
 t/t9105-git-svn-commit-diff.sh                |   12 ++--
 t/t9106-git-svn-commit-diff-clobber.sh        |   16 +++---
 t/t9106-git-svn-dcommit-clobber-series.sh     |    2 +-
 t/t9107-git-svn-migrate.sh                    |   22 ++++----
 t/t9108-git-svn-glob.sh                       |    8 +-
 t/t9108-git-svn-multi-glob.sh                 |   10 ++--
 t/t9110-git-svn-use-svm-props.sh              |   14 ++--
 t/t9111-git-svn-use-svnsync-props.sh          |   10 ++--
 t/t9112-git-svn-md5less-file.sh               |    4 +-
 t/t9113-git-svn-dcommit-new-file.sh           |    2 +-
 t/t9114-git-svn-dcommit-merge.sh              |    2 +-
 t/t9115-git-svn-dcommit-funky-renames.sh      |    4 +-
 t/t9116-git-svn-log.sh                        |    6 +-
 t/t9117-git-svn-init-clone.sh                 |    2 +-
 t/t9118-git-svn-funky-branch-names.sh         |    2 +-
 t/t9119-git-svn-info.sh                       |   80 ++++++++++++-----=
-------
 t/t9120-git-svn-clone-with-percent-escapes.sh |    2 +-
 t/t9121-git-svn-fetch-renamed-dir.sh          |    2 +-
 t/t9123-git-svn-rebuild-with-rewriteroot.sh   |    2 +-
 t/t9124-git-svn-dcommit-auto-props.sh         |    6 +-
 t/t9125-git-svn-multi-glob-branch-names.sh    |    2 +-
 27 files changed, 174 insertions(+), 174 deletions(-)

diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
index c33dc2d..c526eed 100644
--- a/t/lib-git-svn.sh
+++ b/t/lib-git-svn.sh
@@ -7,3 +7,3 @@ if test -n "$NO_SVN_TESTS"
 then
-	test_expect_success 'skipping git-svn tests, NO_SVN_TESTS defined' :
+	test_expect_success 'skipping git svn tests, NO_SVN_TESTS defined' :
 	test_done
@@ -19,3 +19,3 @@ if test $? -ne 1
 then
-    test_expect_success 'skipping git-svn tests, svn not found' :
+    test_expect_success 'skipping git svn tests, svn not found' :
     test_done
@@ -93,3 +93,3 @@ start_httpd () {
 	cat > "$GIT_DIR/httpd.conf" <<EOF
-ServerName "git-svn test"
+ServerName "git svn test"
 ServerRoot "$GIT_DIR"
diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index 5f4cfb6..5ade88d 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -5,3 +5,3 @@
=20
-test_description=3D'git-svn basic tests'
+test_description=3D'git svn basic tests'
 GIT_SVN_LC_ALL=3D${LC_ALL:-$LANG}
@@ -19,3 +19,3 @@ esac
=20
-say 'define NO_SVN_TESTS to skip git-svn tests'
+say 'define NO_SVN_TESTS to skip git svn tests'
=20
@@ -36,3 +36,3 @@ test_expect_success \
 	rm -rf import &&
-	git-svn init "$svnrepo"'
+	git svn init "$svnrepo"'
=20
@@ -40,3 +40,3 @@ test_expect_success \
     'import an SVN revision into git' \
-    'git-svn fetch'
+    'git svn fetch'
=20
@@ -51,3 +51,3 @@ test_expect_success "$name" '
 	git commit -m "$name" &&
-	git-svn set-tree --find-copies-harder --rmdir \
+	git svn set-tree --find-copies-harder --rmdir \
 		${remotes_git_svn}..mybranch &&
@@ -65,3 +65,3 @@ test_expect_success "$name" "
 	git commit -m '$name' &&
-	test_must_fail git-svn set-tree --find-copies-harder --rmdir \
+	test_must_fail git svn set-tree --find-copies-harder --rmdir \
 		${remotes_git_svn}..mybranch" || true
@@ -79,3 +79,3 @@ test_expect_success "$name" '
 	git commit -m "$name" &&
-	test_must_fail git-svn set-tree --find-copies-harder --rmdir \
+	test_must_fail git svn set-tree --find-copies-harder --rmdir \
 		${remotes_git_svn}..mybranch2' || true
@@ -93,3 +93,3 @@ test_expect_success "$name" '
 	git commit -m "$name" &&
-	test_must_fail git-svn set-tree --find-copies-harder --rmdir \
+	test_must_fail git svn set-tree --find-copies-harder --rmdir \
 		${remotes_git_svn}..mybranch3' || true
@@ -107,3 +107,3 @@ test_expect_success "$name" '
 	git commit -m "$name" &&
-	test_must_fail git-svn set-tree --find-copies-harder --rmdir \
+	test_must_fail git svn set-tree --find-copies-harder --rmdir \
 		${remotes_git_svn}..mybranch4' || true
@@ -118,3 +118,3 @@ test_expect_success "$name" '
 	git commit -m "$name" &&
-	git-svn set-tree --find-copies-harder --rmdir \
+	git svn set-tree --find-copies-harder --rmdir \
 		${remotes_git_svn}..mybranch5 &&
@@ -129,3 +129,3 @@ test_expect_success "$name" '
 	git commit -m "$name" &&
-	git-svn set-tree --find-copies-harder --rmdir \
+	git svn set-tree --find-copies-harder --rmdir \
 		${remotes_git_svn}..mybranch5 &&
@@ -141,3 +141,3 @@ test_expect_success "$name" '
 	git commit -m "$name" &&
-	git-svn set-tree --find-copies-harder --rmdir \
+	git svn set-tree --find-copies-harder --rmdir \
 		${remotes_git_svn}..mybranch5 &&
@@ -153,3 +153,3 @@ test_expect_success "$name" '
 	git commit -m "$name" &&
-	git-svn set-tree --find-copies-harder --rmdir \
+	git svn set-tree --find-copies-harder --rmdir \
 		${remotes_git_svn}..mybranch5 &&
@@ -166,3 +166,3 @@ test_expect_success "$name" '
 	git commit -m "$name" &&
-	git-svn set-tree --find-copies-harder --rmdir \
+	git svn set-tree --find-copies-harder --rmdir \
 		${remotes_git_svn}..mybranch5 &&
@@ -182,3 +182,3 @@ then
 		git commit -m '=C3=A9=C3=AF=E2=88=8F' &&
-		git-svn set-tree HEAD"
+		git svn set-tree HEAD"
 	unset LC_ALL
@@ -192,3 +192,3 @@ export GIT_SVN_ID
 test_expect_success "$name" \
-    'git-svn init "$svnrepo" && git-svn fetch &&
+    'git svn init "$svnrepo" && git svn fetch &&
      git rev-list --pretty=3Draw ${remotes_git_svn} | grep ^tree | uni=
q > a &&
@@ -218,3 +218,3 @@ test_expect_success 'exit if remote refs are ambigi=
ous' "
                               bar:refs/${remotes_git_svn} &&
-	test_must_fail git-svn migrate
+	test_must_fail git svn migrate
 "
@@ -226,3 +226,3 @@ test_expect_success 'exit if init-ing a would clobb=
er a URL' '
                                 "^bar:refs/${remotes_git_svn}$" &&
-	test_must_fail git-svn init "${svnrepo}2/bar"
+	test_must_fail git svn init "${svnrepo}2/bar"
         '
@@ -231,3 +231,3 @@ test_expect_success \
   'init allows us to connect to another directory in the same repo' '
-        git-svn init --minimize-url -i bar "$svnrepo/bar" &&
+        git svn init --minimize-url -i bar "$svnrepo/bar" &&
         git config --get svn-remote.svn.fetch \
@@ -239,3 +239,3 @@ test_expect_success \
 test_expect_success 'able to dcommit to a subdirectory' "
-	git-svn fetch -i bar &&
+	git svn fetch -i bar &&
 	git checkout -b my-bar refs/remotes/bar &&
@@ -244,3 +244,3 @@ test_expect_success 'able to dcommit to a subdirect=
ory' "
 	git commit -m '/bar/d should be in the log' &&
-	git-svn dcommit -i bar &&
+	git svn dcommit -i bar &&
 	test -z \"\`git diff refs/heads/my-bar refs/remotes/bar\`\" &&
@@ -250,3 +250,3 @@ test_expect_success 'able to dcommit to a subdirect=
ory' "
 	git commit -m 'add a new directory' &&
-	git-svn dcommit -i bar &&
+	git svn dcommit -i bar &&
 	test -z \"\`git diff refs/heads/my-bar refs/remotes/bar\`\" &&
@@ -255,3 +255,3 @@ test_expect_success 'able to dcommit to a subdirect=
ory' "
 	git commit -m 'modify a file in new directory' &&
-	git-svn dcommit -i bar &&
+	git svn dcommit -i bar &&
 	test -z \"\`git diff refs/heads/my-bar refs/remotes/bar\`\"
@@ -263,3 +263,3 @@ test_expect_success 'able to set-tree to a subdirec=
tory' "
 	git commit -m 'update /bar/d' &&
-	git-svn set-tree -i bar HEAD &&
+	git svn set-tree -i bar HEAD &&
 	test -z \"\`git diff refs/heads/my-bar refs/remotes/bar\`\"
diff --git a/t/t9101-git-svn-props.sh b/t/t9101-git-svn-props.sh
index 02eccc9..0d48b26 100755
--- a/t/t9101-git-svn-props.sh
+++ b/t/t9101-git-svn-props.sh
@@ -5,3 +5,3 @@
=20
-test_description=3D'git-svn property tests'
+test_description=3D'git svn property tests'
 . ./lib-git-svn.sh
@@ -68,4 +68,4 @@ test_expect_success 'setup some commits to svn' \
=20
-test_expect_success 'initialize git-svn' 'git-svn init "$svnrepo"'
-test_expect_success 'fetch revisions from svn' 'git-svn fetch'
+test_expect_success 'initialize git-svn' 'git svn init "$svnrepo"'
+test_expect_success 'fetch revisions from svn' 'git svn fetch'
=20
@@ -76,3 +76,3 @@ test_expect_success "$name" \
 	git commit -a -m "test keywords ignoring" &&
-	git-svn set-tree ${remotes_git_svn}..mybranch &&
+	git svn set-tree ${remotes_git_svn}..mybranch &&
 	git pull . ${remotes_git_svn}'
@@ -92,3 +92,3 @@ test_expect_success "propset CR on crlf files" \
 test_expect_success 'fetch and pull latest from svn and checkout a new=
 wc' \
-	'git-svn fetch &&
+	'git svn fetch &&
 	 git pull . ${remotes_git_svn} &&
@@ -115,3 +115,3 @@ cd ..
 test_expect_success 'fetch and pull latest from svn' \
-	'git-svn fetch && git pull . ${remotes_git_svn}'
+	'git svn fetch && git pull . ${remotes_git_svn}'
=20
@@ -147,3 +147,3 @@ test_expect_success 'test show-ignore' "
 	cd .. &&
-	git-svn show-ignore > show-ignore.got &&
+	git svn show-ignore > show-ignore.got &&
 	cmp show-ignore.expect show-ignore.got
@@ -163,4 +163,4 @@ EOF
 test_expect_success 'test create-ignore' "
-	git-svn fetch && git pull . ${remotes_git_svn} &&
-	git-svn create-ignore &&
+	git svn fetch && git pull . ${remotes_git_svn} &&
+	git svn create-ignore &&
 	cmp ./.gitignore create-ignore.expect &&
@@ -184,11 +184,11 @@ EOF
 test_expect_success 'test propget' "
-	git-svn propget svn:ignore . | cmp - prop.expect &&
+	git svn propget svn:ignore . | cmp - prop.expect &&
 	cd deeply &&
-	git-svn propget svn:ignore . | cmp - ../prop.expect &&
-	git-svn propget svn:entry:committed-rev nested/directory/.keep \
+	git svn propget svn:ignore . | cmp - ../prop.expect &&
+	git svn propget svn:entry:committed-rev nested/directory/.keep \
 	  | cmp - ../prop2.expect &&
-	git-svn propget svn:ignore .. | cmp - ../prop.expect &&
-	git-svn propget svn:ignore nested/ | cmp - ../prop.expect &&
-	git-svn propget svn:ignore ./nested | cmp - ../prop.expect &&
-	git-svn propget svn:ignore .././deeply/nested | cmp - ../prop.expect
+	git svn propget svn:ignore .. | cmp - ../prop.expect &&
+	git svn propget svn:ignore nested/ | cmp - ../prop.expect &&
+	git svn propget svn:ignore ./nested | cmp - ../prop.expect &&
+	git svn propget svn:ignore .././deeply/nested | cmp - ../prop.expect
 	"
@@ -212,4 +212,4 @@ EOF
 test_expect_success 'test proplist' "
-	git-svn proplist . | cmp - prop.expect &&
-	git-svn proplist nested/directory/.keep | cmp - prop2.expect
+	git svn proplist . | cmp - prop.expect &&
+	git svn proplist nested/directory/.keep | cmp - prop2.expect
 	"
diff --git a/t/t9102-git-svn-deep-rmdir.sh b/t/t9102-git-svn-deep-rmdir=
=2Esh
index 0ad6e24..ea5a385 100755
--- a/t/t9102-git-svn-deep-rmdir.sh
+++ b/t/t9102-git-svn-deep-rmdir.sh
@@ -1,3 +1,3 @@
 #!/bin/sh
-test_description=3D'git-svn rmdir'
+test_description=3D'git svn rmdir'
 . ./lib-git-svn.sh
@@ -16,4 +16,4 @@ test_expect_success 'initialize repo' '
 test_expect_success 'mirror via git-svn' '
-	git-svn init "$svnrepo" &&
-	git-svn fetch &&
+	git svn init "$svnrepo" &&
+	git svn fetch &&
 	git checkout -f -b test-rmdir ${remotes_git_svn}
@@ -24,3 +24,3 @@ test_expect_success 'Try a commit on rmdir' '
 	git commit -a -m "remove another" &&
-	git-svn set-tree --rmdir HEAD &&
+	git svn set-tree --rmdir HEAD &&
 	svn ls -R "$svnrepo" | grep ^deeply/nested/directory/number/1
diff --git a/t/t9103-git-svn-tracked-directory-removed.sh b/t/t9103-git=
-svn-tracked-directory-removed.sh
index 9ffd845..963dd95 100755
--- a/t/t9103-git-svn-tracked-directory-removed.sh
+++ b/t/t9103-git-svn-tracked-directory-removed.sh
@@ -5,3 +5,3 @@
=20
-test_description=3D'git-svn tracking removed top-level path'
+test_description=3D'git svn tracking removed top-level path'
 . ./lib-git-svn.sh
diff --git a/t/t9104-git-svn-follow-parent.sh b/t/t9104-git-svn-follow-=
parent.sh
index 4d964e2..0a091e0 100755
--- a/t/t9104-git-svn-follow-parent.sh
+++ b/t/t9104-git-svn-follow-parent.sh
@@ -5,3 +5,3 @@
=20
-test_description=3D'git-svn fetching'
+test_description=3D'git svn fetching'
 . ./lib-git-svn.sh
@@ -29,4 +29,4 @@ test_expect_success 'initialize repo' '
 test_expect_success 'init and fetch a moved directory' '
-	git-svn init --minimize-url -i thunk "$svnrepo"/thunk &&
-	git-svn fetch -i thunk &&
+	git svn init --minimize-url -i thunk "$svnrepo"/thunk &&
+	git svn fetch -i thunk &&
 	test "`git rev-parse --verify refs/remotes/thunk@2`" \
@@ -45,3 +45,3 @@ test_expect_success 'init and fetch from one svn-remo=
te' '
           thunk:refs/remotes/svn/thunk &&
-        git-svn fetch -i svn/thunk &&
+        git svn fetch -i svn/thunk &&
 	test "`git rev-parse --verify refs/remotes/svn/trunk`" \
@@ -59,4 +59,4 @@ test_expect_success 'follow deleted parent' '
           junk:refs/remotes/svn/junk &&
-        git-svn fetch -i svn/thunk &&
-        git-svn fetch -i svn/junk &&
+        git svn fetch -i svn/thunk &&
+        git svn fetch -i svn/junk &&
         test -z "`git diff svn/junk svn/trunk`" &&
@@ -71,5 +71,5 @@ test_expect_success 'follow larger parent' '
         svn cp -m "hi" "$svnrepo"/larger-parent "$svnrepo"/another-lar=
ger &&
-        git-svn init --minimize-url -i larger \
+        git svn init --minimize-url -i larger \
           "$svnrepo"/another-larger/trunk/thunk/bump/thud &&
-        git-svn fetch -i larger &&
+        git svn fetch -i larger &&
         git rev-parse --verify refs/remotes/larger &&
@@ -94,4 +94,4 @@ test_expect_success 'follow higher-level parent' '
         svn mv -m "move blob down a level" "$svnrepo"/blob "$svnrepo"/=
glob/blob &&
-        git-svn init --minimize-url -i blob "$svnrepo"/glob/blob &&
-        git-svn fetch -i blob
+        git svn init --minimize-url -i blob "$svnrepo"/glob/blob &&
+        git svn fetch -i blob
         '
@@ -101,4 +101,4 @@ test_expect_success 'follow deleted directory' '
 	svn rm -m "remove glob" "$svnrepo"/glob &&
-	git-svn init --minimize-url -i glob "$svnrepo"/glob &&
-	git-svn fetch -i glob &&
+	git svn init --minimize-url -i glob "$svnrepo"/glob &&
+	git svn fetch -i glob &&
 	test "`git cat-file blob refs/remotes/glob:blob/bye`" =3D hi &&
@@ -131,5 +131,5 @@ test_expect_success 'follow-parent avoids deleting =
relevant info' '
 	cd .. &&
-	git-svn init --minimize-url -i r9270-t \
+	git svn init --minimize-url -i r9270-t \
 	  "$svnrepo"/r9270/trunk/subversion/bindings/swig/perl/native/t &&
-	git-svn fetch -i r9270-t &&
+	git svn fetch -i r9270-t &&
 	test `git rev-list r9270-t | wc -l` -eq 2 &&
@@ -141,5 +141,5 @@ test_expect_success "track initial change if it was=
 only made to parent" '
 	svn cp -m "wheee!" "$svnrepo"/r9270/trunk "$svnrepo"/r9270/drunk &&
-	git-svn init --minimize-url -i r9270-d \
+	git svn init --minimize-url -i r9270-d \
 	  "$svnrepo"/r9270/drunk/subversion/bindings/swig/perl/native/t &&
-	git-svn fetch -i r9270-d &&
+	git svn fetch -i r9270-d &&
 	test `git rev-list r9270-d | wc -l` -eq 3 &&
@@ -153,3 +153,3 @@ test_expect_success "track multi-parent paths" '
 	svn cp -m "resurrect /glob" "$svnrepo"/r9270 "$svnrepo"/glob &&
-	git-svn multi-fetch &&
+	git svn multi-fetch &&
 	test `git cat-file commit refs/remotes/glob | \
@@ -159,3 +159,3 @@ test_expect_success "track multi-parent paths" '
 test_expect_success "multi-fetch continues to work" "
-	git-svn multi-fetch
+	git svn multi-fetch
 	"
@@ -165,3 +165,3 @@ test_expect_success "multi-fetch works off a 'clean=
' repository" '
 	mkdir "$GIT_DIR/svn" &&
-	git-svn multi-fetch
+	git svn multi-fetch
 	'
diff --git a/t/t9105-git-svn-commit-diff.sh b/t/t9105-git-svn-commit-di=
ff.sh
index 6323036..ba99abb 100755
--- a/t/t9105-git-svn-commit-diff.sh
+++ b/t/t9105-git-svn-commit-diff.sh
@@ -3,3 +3,3 @@
 # Copyright (c) 2006 Eric Wong
-test_description=3D'git-svn commit-diff'
+test_description=3D'git svn commit-diff'
 . ./lib-git-svn.sh
@@ -28,3 +28,3 @@ test_expect_success 'test the commit-diff command' '
 	test -n "$prev" && test -n "$head" &&
-	git-svn commit-diff -r1 "$prev" "$head" "$svnrepo" &&
+	git svn commit-diff -r1 "$prev" "$head" "$svnrepo" &&
 	svn co "$svnrepo" wc &&
@@ -33,7 +33,7 @@ test_expect_success 'test the commit-diff command' '
=20
-test_expect_success 'commit-diff to a sub-directory (with git-svn conf=
ig)' '
+test_expect_success 'commit-diff to a sub-directory (with git svn conf=
ig)' '
 	svn import -m "sub-directory" import "$svnrepo"/subdir &&
-	git-svn init --minimize-url "$svnrepo"/subdir &&
-	git-svn fetch &&
-	git-svn commit-diff -r3 "$prev" "$head" &&
+	git svn init --minimize-url "$svnrepo"/subdir &&
+	git svn fetch &&
+	git svn commit-diff -r3 "$prev" "$head" &&
 	svn cat "$svnrepo"/subdir/readme > readme.2 &&
diff --git a/t/t9106-git-svn-commit-diff-clobber.sh b/t/t9106-git-svn-c=
ommit-diff-clobber.sh
index da559f8..6eb0fd8 100755
--- a/t/t9106-git-svn-commit-diff-clobber.sh
+++ b/t/t9106-git-svn-commit-diff-clobber.sh
@@ -3,3 +3,3 @@
 # Copyright (c) 2006 Eric Wong
-test_description=3D'git-svn commit-diff clobber'
+test_description=3D'git svn commit-diff clobber'
 . ./lib-git-svn.sh
@@ -29,3 +29,3 @@ test_expect_success 'commit conflicting change from g=
it' '
 	git commit -a -m "second line from git" &&
-	test_must_fail git-svn commit-diff -r1 HEAD~1 HEAD "$svnrepo"
+	test_must_fail git svn commit-diff -r1 HEAD~1 HEAD "$svnrepo"
 '
@@ -38,3 +38,3 @@ test_expect_success 'commit complementing change from=
 git' '
 	git commit -a -m "third line from git" &&
-	git-svn commit-diff -r2 HEAD~1 HEAD "$svnrepo"
+	git svn commit-diff -r2 HEAD~1 HEAD "$svnrepo"
 	'
@@ -42,4 +42,4 @@ test_expect_success 'commit complementing change from=
 git' '
 test_expect_success 'dcommit fails to commit because of conflict' '
-	git-svn init "$svnrepo" &&
-	git-svn fetch &&
+	git svn init "$svnrepo" &&
+	git svn fetch &&
 	git reset --hard refs/${remotes_git_svn} &&
@@ -54,3 +54,3 @@ test_expect_success 'dcommit fails to commit because =
of conflict' '
 	git commit -a -m "fourth line from git" &&
-	test_must_fail git-svn dcommit
+	test_must_fail git svn dcommit
 	'
@@ -65,3 +65,3 @@ test_expect_success 'dcommit does the svn equivalent =
of an index merge' "
 	git commit -a -m 'more changes' &&
-	git-svn dcommit
+	git svn dcommit
 	"
@@ -78,3 +78,3 @@ test_expect_success 'commit another change from svn s=
ide' '
=20
-test_expect_success 'multiple dcommit from git-svn will not clobber sv=
n' "
+test_expect_success 'multiple dcommit from git svn will not clobber sv=
n' "
 	git reset --hard refs/${remotes_git_svn} &&
diff --git a/t/t9106-git-svn-dcommit-clobber-series.sh b/t/t9106-git-sv=
n-dcommit-clobber-series.sh
index bc37db9..fd18501 100755
--- a/t/t9106-git-svn-dcommit-clobber-series.sh
+++ b/t/t9106-git-svn-dcommit-clobber-series.sh
@@ -3,3 +3,3 @@
 # Copyright (c) 2007 Eric Wong
-test_description=3D'git-svn dcommit clobber series'
+test_description=3D'git svn dcommit clobber series'
 . ./lib-git-svn.sh
diff --git a/t/t9107-git-svn-migrate.sh b/t/t9107-git-svn-migrate.sh
index f3c75fc..acad16a 100755
--- a/t/t9107-git-svn-migrate.sh
+++ b/t/t9107-git-svn-migrate.sh
@@ -2,3 +2,3 @@
 # Copyright (c) 2006 Eric Wong
-test_description=3D'git-svn metadata migrations from previous versions=
'
+test_description=3D'git svn metadata migrations from previous versions=
'
 . ./lib-git-svn.sh
@@ -16,4 +16,4 @@ test_expect_success 'setup old-looking metadata' '
 		cd .. &&
-	git-svn init "$svnrepo" &&
-	git-svn fetch &&
+	git svn init "$svnrepo" &&
+	git svn fetch &&
 	mv "$GIT_DIR"/svn/* "$GIT_DIR"/ &&
@@ -29,3 +29,3 @@ test_expect_success 'git-svn-HEAD is a real HEAD' "te=
st -n '$head'"
=20
-test_expect_success 'initialize old-style (v0) git-svn layout' '
+test_expect_success 'initialize old-style (v0) git svn layout' '
 	mkdir -p "$GIT_DIR"/git-svn/info "$GIT_DIR"/svn/info &&
@@ -33,4 +33,4 @@ test_expect_success 'initialize old-style (v0) git-sv=
n layout' '
 	echo "$svnrepo" > "$GIT_DIR"/svn/info/url &&
-	git-svn migrate &&
-	! test -d "$GIT_DIR"/git-svn &&
+	git svn migrate &&
+	! test -d "$GIT_DIR"/git svn &&
 	git rev-parse --verify refs/${remotes_git_svn}^0 &&
@@ -43,3 +43,3 @@ test_expect_success 'initialize old-style (v0) git-sv=
n layout' '
 test_expect_success 'initialize a multi-repository repo' '
-	git-svn init "$svnrepo" -T trunk -t tags -b branches &&
+	git svn init "$svnrepo" -T trunk -t tags -b branches &&
 	git config --get-all svn-remote.svn.fetch > fetch.out &&
@@ -63,3 +63,3 @@ test_expect_success 'initialize a multi-repository re=
po' '
 test_expect_success 'multi-fetch works on partial urls + paths' "
-	git-svn multi-fetch &&
+	git svn multi-fetch &&
 	for i in trunk a b tags/0.1 tags/0.2 tags/0.3; do
@@ -87,3 +87,3 @@ test_expect_success 'migrate --minimize on old inited=
 layout' '
 	done &&
-	git-svn migrate --minimize &&
+	git svn migrate --minimize &&
 	test -z "`git config -l |grep -v "^svn-remote\.git-svn\."`" &&
@@ -100,3 +100,3 @@ test_expect_success 'migrate --minimize on old init=
ed layout' '
 test_expect_success  ".rev_db auto-converted to .rev_map.UUID" '
-	git-svn fetch -i trunk &&
+	git svn fetch -i trunk &&
 	test -z "$(ls "$GIT_DIR"/svn/trunk/.rev_db.* 2>/dev/null)" &&
@@ -108,3 +108,3 @@ test_expect_success  ".rev_db auto-converted to .re=
v_map.UUID" '
 	test -f "$rev_db" &&
-	git-svn fetch -i trunk &&
+	git svn fetch -i trunk &&
 	test -z "$(ls "$GIT_DIR"/svn/trunk/.rev_db.* 2>/dev/null)" &&
diff --git a/t/t9108-git-svn-glob.sh b/t/t9108-git-svn-glob.sh
index 8b792a1..d8582b1 100755
--- a/t/t9108-git-svn-glob.sh
+++ b/t/t9108-git-svn-glob.sh
@@ -2,3 +2,3 @@
 # Copyright (c) 2007 Eric Wong
-test_description=3D'git-svn globbing refspecs'
+test_description=3D'git svn globbing refspecs'
 . ./lib-git-svn.sh
@@ -48,3 +48,3 @@ test_expect_success 'test refspec globbing' '
 	                 "tags/*/src/a:refs/remotes/tags/*" &&
-	git-svn multi-fetch &&
+	git svn multi-fetch &&
 	git log --pretty=3Doneline refs/remotes/tags/end | \
@@ -76,3 +76,3 @@ test_expect_success 'test left-hand-side only globbin=
g' '
 	) &&
-	git-svn fetch two &&
+	git svn fetch two &&
 	test `git rev-list refs/remotes/two/tags/end | wc -l` -eq 6 &&
@@ -106,3 +106,3 @@ test_expect_success 'test disallow multi-globs' '
 	) &&
-	test_must_fail git-svn fetch three 2> stderr.three &&
+	test_must_fail git svn fetch three 2> stderr.three &&
 	test_cmp expect.three stderr.three
diff --git a/t/t9108-git-svn-multi-glob.sh b/t/t9108-git-svn-multi-glob=
=2Esh
index 3583721..8f79c3f 100755
--- a/t/t9108-git-svn-multi-glob.sh
+++ b/t/t9108-git-svn-multi-glob.sh
@@ -2,3 +2,3 @@
 # Copyright (c) 2007 Eric Wong
-test_description=3D'git-svn globbing refspecs'
+test_description=3D'git svn globbing refspecs'
 . ./lib-git-svn.sh
@@ -48,3 +48,3 @@ test_expect_success 'test refspec globbing' '
 	                 "tags/*/src/a:refs/remotes/tags/*" &&
-	git-svn multi-fetch &&
+	git svn multi-fetch &&
 	git log --pretty=3Doneline refs/remotes/tags/end | \
@@ -76,3 +76,3 @@ test_expect_success 'test left-hand-side only globbin=
g' '
 	) &&
-	git-svn fetch two &&
+	git svn fetch two &&
 	test `git rev-list refs/remotes/two/tags/end | wc -l` -eq 6 &&
@@ -125,3 +125,3 @@ test_expect_success 'test another branch' '
 	                 "tags/*:refs/remotes/four/tags/*" &&
-	git-svn fetch four &&
+	git svn fetch four &&
 	test `git rev-list refs/remotes/four/tags/next | wc -l` -eq 5 &&
@@ -155,3 +155,3 @@ test_expect_success 'test disallow multiple globs' =
'
 	) &&
-	test_must_fail git-svn fetch three 2> stderr.three &&
+	test_must_fail git svn fetch three 2> stderr.three &&
 	test_cmp expect.three stderr.three
diff --git a/t/t9110-git-svn-use-svm-props.sh b/t/t9110-git-svn-use-svm=
-props.sh
index 211baf4..a06e4c5 100755
--- a/t/t9110-git-svn-use-svm-props.sh
+++ b/t/t9110-git-svn-use-svm-props.sh
@@ -5,3 +5,3 @@
=20
-test_description=3D'git-svn useSvmProps test'
+test_description=3D'git svn useSvmProps test'
=20
@@ -11,8 +11,8 @@ test_expect_success 'load svm repo' '
 	svnadmin load -q "$rawsvnrepo" < "$TEST_DIRECTORY"/t9110/svm.dump &&
-	git-svn init --minimize-url -R arr -i bar "$svnrepo"/mirror/arr &&
-	git-svn init --minimize-url -R argh -i dir "$svnrepo"/mirror/argh &&
-	git-svn init --minimize-url -R argh -i e \
+	git svn init --minimize-url -R arr -i bar "$svnrepo"/mirror/arr &&
+	git svn init --minimize-url -R argh -i dir "$svnrepo"/mirror/argh &&
+	git svn init --minimize-url -R argh -i e \
 	  "$svnrepo"/mirror/argh/a/b/c/d/e &&
 	git config svn.useSvmProps true &&
-	git-svn fetch --all
+	git svn fetch --all
 	'
@@ -52,3 +52,3 @@ test_expect_success 'verify metadata for /dir' "
 test_expect_success 'find commit based on SVN revision number' "
-        git-svn find-rev r12 |
+        git svn find-rev r12 |
 	    grep `git rev-parse HEAD`
@@ -57,3 +57,3 @@ test_expect_success 'find commit based on SVN revisio=
n number' "
 test_expect_success 'empty rebase' "
-	git-svn rebase
+	git svn rebase
 	"
diff --git a/t/t9111-git-svn-use-svnsync-props.sh b/t/t9111-git-svn-use=
-svnsync-props.sh
index aab109c..bd081c2 100755
--- a/t/t9111-git-svn-use-svnsync-props.sh
+++ b/t/t9111-git-svn-use-svnsync-props.sh
@@ -5,3 +5,3 @@
=20
-test_description=3D'git-svn useSvnsyncProps test'
+test_description=3D'git svn useSvnsyncProps test'
=20
@@ -11,7 +11,7 @@ test_expect_success 'load svnsync repo' '
 	svnadmin load -q "$rawsvnrepo" < "$TEST_DIRECTORY"/t9111/svnsync.dump=
 &&
-	git-svn init --minimize-url -R arr -i bar "$svnrepo"/bar &&
-	git-svn init --minimize-url -R argh -i dir "$svnrepo"/dir &&
-	git-svn init --minimize-url -R argh -i e "$svnrepo"/dir/a/b/c/d/e &&
+	git svn init --minimize-url -R arr -i bar "$svnrepo"/bar &&
+	git svn init --minimize-url -R argh -i dir "$svnrepo"/dir &&
+	git svn init --minimize-url -R argh -i e "$svnrepo"/dir/a/b/c/d/e &&
 	git config svn.useSvnsyncProps true &&
-	git-svn fetch --all
+	git svn fetch --all
 	'
diff --git a/t/t9112-git-svn-md5less-file.sh b/t/t9112-git-svn-md5less-=
file.sh
index d470a92..91b88cf 100755
--- a/t/t9112-git-svn-md5less-file.sh
+++ b/t/t9112-git-svn-md5less-file.sh
@@ -44,4 +44,4 @@ test_expect_success 'load svn dumpfile' 'svnadmin loa=
d "$rawsvnrepo" < dumpfile.
=20
-test_expect_success 'initialize git-svn' 'git-svn init "$svnrepo"'
-test_expect_success 'fetch revisions from svn' 'git-svn fetch'
+test_expect_success 'initialize git-svn' 'git svn init "$svnrepo"'
+test_expect_success 'fetch revisions from svn' 'git svn fetch'
 test_done
diff --git a/t/t9113-git-svn-dcommit-new-file.sh b/t/t9113-git-svn-dcom=
mit-new-file.sh
index ae78e33..250c530 100755
--- a/t/t9113-git-svn-dcommit-new-file.sh
+++ b/t/t9113-git-svn-dcommit-new-file.sh
@@ -10,3 +10,3 @@
=20
-test_description=3D'git-svn dcommit new files over svn:// test'
+test_description=3D'git svn dcommit new files over svn:// test'
=20
diff --git a/t/t9114-git-svn-dcommit-merge.sh b/t/t9114-git-svn-dcommit=
-merge.sh
index 61d7781..17b2855 100755
--- a/t/t9114-git-svn-dcommit-merge.sh
+++ b/t/t9114-git-svn-dcommit-merge.sh
@@ -5,3 +5,3 @@
=20
-test_description=3D'git-svn dcommit handles merges'
+test_description=3D'git svn dcommit handles merges'
=20
diff --git a/t/t9115-git-svn-dcommit-funky-renames.sh b/t/t9115-git-svn=
-dcommit-funky-renames.sh
index b0ba1f0..9be7aef 100755
--- a/t/t9115-git-svn-dcommit-funky-renames.sh
+++ b/t/t9115-git-svn-dcommit-funky-renames.sh
@@ -5,3 +5,3 @@
=20
-test_description=3D'git-svn dcommit can commit renames of files with u=
gly names'
+test_description=3D'git svn dcommit can commit renames of files with u=
gly names'
=20
@@ -77,3 +77,3 @@ test_expect_success 'make a commit to test rebase' '
=20
-test_expect_success 'git-svn rebase works inside a fresh-cloned reposi=
tory' '
+test_expect_success 'git svn rebase works inside a fresh-cloned reposi=
tory' '
 	cd test-rebase &&
diff --git a/t/t9116-git-svn-log.sh b/t/t9116-git-svn-log.sh
index 4b2cc87..fd6d1d2 100755
--- a/t/t9116-git-svn-log.sh
+++ b/t/t9116-git-svn-log.sh
@@ -5,3 +5,3 @@
=20
-test_description=3D'git-svn log tests'
+test_description=3D'git svn log tests'
 . ./lib-git-svn.sh
@@ -18,4 +18,4 @@ test_expect_success 'setup repository and import' '
 		cd .. &&
-	git-svn init "$svnrepo" -T trunk -b branches -t tags &&
-	git-svn fetch &&
+	git svn init "$svnrepo" -T trunk -b branches -t tags &&
+	git svn fetch &&
 	git reset --hard trunk &&
diff --git a/t/t9117-git-svn-init-clone.sh b/t/t9117-git-svn-init-clone=
=2Esh
index 7a689bb..dde46cd 100755
--- a/t/t9117-git-svn-init-clone.sh
+++ b/t/t9117-git-svn-init-clone.sh
@@ -5,3 +5,3 @@
=20
-test_description=3D'git-svn init/clone tests'
+test_description=3D'git svn init/clone tests'
=20
diff --git a/t/t9118-git-svn-funky-branch-names.sh b/t/t9118-git-svn-fu=
nky-branch-names.sh
index 3281cbd..421d545 100755
--- a/t/t9118-git-svn-funky-branch-names.sh
+++ b/t/t9118-git-svn-funky-branch-names.sh
@@ -5,3 +5,3 @@
=20
-test_description=3D'git-svn funky branch names'
+test_description=3D'git svn funky branch names'
 . ./lib-git-svn.sh
diff --git a/t/t9119-git-svn-info.sh b/t/t9119-git-svn-info.sh
index 3e48459..27dd7c2 100755
--- a/t/t9119-git-svn-info.sh
+++ b/t/t9119-git-svn-info.sh
@@ -4,3 +4,3 @@
=20
-test_description=3D'git-svn info'
+test_description=3D'git svn info'
=20
@@ -58,4 +58,4 @@ test_expect_success 'setup repository and import' '
 	cd gitwc &&
-		git-svn init "$svnrepo" &&
-		git-svn fetch &&
+		git svn init "$svnrepo" &&
+		git svn fetch &&
 	cd .. &&
@@ -69,3 +69,3 @@ test_expect_success 'info' "
 	(cd svnwc; svn info) > expected.info &&
-	(cd gitwc; git-svn info) > actual.info &&
+	(cd gitwc; git svn info) > actual.info &&
 	test_cmp expected.info actual.info
@@ -74,3 +74,3 @@ test_expect_success 'info' "
 test_expect_success 'info --url' '
-	test "$(cd gitwc; git-svn info --url)" =3D "$quoted_svnrepo"
+	test "$(cd gitwc; git svn info --url)" =3D "$quoted_svnrepo"
 	'
@@ -79,3 +79,3 @@ test_expect_success 'info .' "
 	(cd svnwc; svn info .) > expected.info-dot &&
-	(cd gitwc; git-svn info .) > actual.info-dot &&
+	(cd gitwc; git svn info .) > actual.info-dot &&
 	test_cmp expected.info-dot actual.info-dot
@@ -84,3 +84,3 @@ test_expect_success 'info .' "
 test_expect_success 'info --url .' '
-	test "$(cd gitwc; git-svn info --url .)" =3D "$quoted_svnrepo"
+	test "$(cd gitwc; git svn info --url .)" =3D "$quoted_svnrepo"
 	'
@@ -89,3 +89,3 @@ test_expect_success 'info file' "
 	(cd svnwc; svn info file) > expected.info-file &&
-	(cd gitwc; git-svn info file) > actual.info-file &&
+	(cd gitwc; git svn info file) > actual.info-file &&
 	test_cmp expected.info-file actual.info-file
@@ -94,3 +94,3 @@ test_expect_success 'info file' "
 test_expect_success 'info --url file' '
-	test "$(cd gitwc; git-svn info --url file)" =3D "$quoted_svnrepo/file=
"
+	test "$(cd gitwc; git svn info --url file)" =3D "$quoted_svnrepo/file=
"
 	'
@@ -99,3 +99,3 @@ test_expect_success 'info directory' "
 	(cd svnwc; svn info directory) > expected.info-directory &&
-	(cd gitwc; git-svn info directory) > actual.info-directory &&
+	(cd gitwc; git svn info directory) > actual.info-directory &&
 	test_cmp expected.info-directory actual.info-directory
@@ -105,3 +105,3 @@ test_expect_success 'info inside directory' "
 	(cd svnwc/directory; svn info) > expected.info-inside-directory &&
-	(cd gitwc/directory; git-svn info) > actual.info-inside-directory &&
+	(cd gitwc/directory; git svn info) > actual.info-inside-directory &&
 	test_cmp expected.info-inside-directory actual.info-inside-directory
@@ -110,3 +110,3 @@ test_expect_success 'info inside directory' "
 test_expect_success 'info --url directory' '
-	test "$(cd gitwc; git-svn info --url directory)" =3D "$quoted_svnrepo=
/directory"
+	test "$(cd gitwc; git svn info --url directory)" =3D "$quoted_svnrepo=
/directory"
 	'
@@ -115,3 +115,3 @@ test_expect_success 'info symlink-file' "
 	(cd svnwc; svn info symlink-file) > expected.info-symlink-file &&
-	(cd gitwc; git-svn info symlink-file) > actual.info-symlink-file &&
+	(cd gitwc; git svn info symlink-file) > actual.info-symlink-file &&
 	test_cmp expected.info-symlink-file actual.info-symlink-file
@@ -120,3 +120,3 @@ test_expect_success 'info symlink-file' "
 test_expect_success 'info --url symlink-file' '
-	test "$(cd gitwc; git-svn info --url symlink-file)" \
+	test "$(cd gitwc; git svn info --url symlink-file)" \
 	     =3D "$quoted_svnrepo/symlink-file"
@@ -127,3 +127,3 @@ test_expect_success 'info symlink-directory' "
 		> expected.info-symlink-directory &&
-	(cd gitwc; git-svn info symlink-directory) \
+	(cd gitwc; git svn info symlink-directory) \
 		> actual.info-symlink-directory &&
@@ -133,3 +133,3 @@ test_expect_success 'info symlink-directory' "
 test_expect_success 'info --url symlink-directory' '
-	test "$(cd gitwc; git-svn info --url symlink-directory)" \
+	test "$(cd gitwc; git svn info --url symlink-directory)" \
 	     =3D "$quoted_svnrepo/symlink-directory"
@@ -148,3 +148,3 @@ test_expect_success 'info added-file' "
 	(cd svnwc; svn info added-file) > expected.info-added-file &&
-	(cd gitwc; git-svn info added-file) > actual.info-added-file &&
+	(cd gitwc; git svn info added-file) > actual.info-added-file &&
 	test_cmp expected.info-added-file actual.info-added-file
@@ -153,3 +153,3 @@ test_expect_success 'info added-file' "
 test_expect_success 'info --url added-file' '
-	test "$(cd gitwc; git-svn info --url added-file)" \
+	test "$(cd gitwc; git svn info --url added-file)" \
 	     =3D "$quoted_svnrepo/added-file"
@@ -169,3 +169,3 @@ test_expect_success 'info added-directory' "
 		> expected.info-added-directory &&
-	(cd gitwc; git-svn info added-directory) \
+	(cd gitwc; git svn info added-directory) \
 		> actual.info-added-directory &&
@@ -175,3 +175,3 @@ test_expect_success 'info added-directory' "
 test_expect_success 'info --url added-directory' '
-	test "$(cd gitwc; git-svn info --url added-directory)" \
+	test "$(cd gitwc; git svn info --url added-directory)" \
 	     =3D "$quoted_svnrepo/added-directory"
@@ -191,3 +191,3 @@ test_expect_success 'info added-symlink-file' "
 		> expected.info-added-symlink-file &&
-	(cd gitwc; git-svn info added-symlink-file) \
+	(cd gitwc; git svn info added-symlink-file) \
 		> actual.info-added-symlink-file &&
@@ -198,3 +198,3 @@ test_expect_success 'info added-symlink-file' "
 test_expect_success 'info --url added-symlink-file' '
-	test "$(cd gitwc; git-svn info --url added-symlink-file)" \
+	test "$(cd gitwc; git svn info --url added-symlink-file)" \
 	     =3D "$quoted_svnrepo/added-symlink-file"
@@ -214,3 +214,3 @@ test_expect_success 'info added-symlink-directory' =
"
 		> expected.info-added-symlink-directory &&
-	(cd gitwc; git-svn info added-symlink-directory) \
+	(cd gitwc; git svn info added-symlink-directory) \
 		> actual.info-added-symlink-directory &&
@@ -221,3 +221,3 @@ test_expect_success 'info added-symlink-directory' =
"
 test_expect_success 'info --url added-symlink-directory' '
-	test "$(cd gitwc; git-svn info --url added-symlink-directory)" \
+	test "$(cd gitwc; git svn info --url added-symlink-directory)" \
 	     =3D "$quoted_svnrepo/added-symlink-directory"
@@ -240,3 +240,3 @@ test_expect_success 'info deleted-file' "
 		> expected.info-deleted-file &&
-	(cd gitwc; git-svn info file) |
+	(cd gitwc; git svn info file) |
 	sed -e 's/^\(Text Last Updated:\).*/\1 TEXT-LAST-UPDATED-STRING/' \
@@ -247,3 +247,3 @@ test_expect_success 'info deleted-file' "
 test_expect_success 'info --url file (deleted)' '
-	test "$(cd gitwc; git-svn info --url file)" \
+	test "$(cd gitwc; git svn info --url file)" \
 	     =3D "$quoted_svnrepo/file"
@@ -261,3 +261,3 @@ test_expect_success 'info deleted-directory' "
 		> expected.info-deleted-directory &&
-	(cd gitwc; git-svn info directory) |
+	(cd gitwc; git svn info directory) |
 	sed -e 's/^\(Text Last Updated:\).*/\1 TEXT-LAST-UPDATED-STRING/' \
@@ -268,3 +268,3 @@ test_expect_success 'info deleted-directory' "
 test_expect_success 'info --url directory (deleted)' '
-	test "$(cd gitwc; git-svn info --url directory)" \
+	test "$(cd gitwc; git svn info --url directory)" \
 	     =3D "$quoted_svnrepo/directory"
@@ -282,3 +282,3 @@ test_expect_success 'info deleted-symlink-file' "
 		> expected.info-deleted-symlink-file &&
-	(cd gitwc; git-svn info symlink-file) |
+	(cd gitwc; git svn info symlink-file) |
 	sed -e 's/^\(Text Last Updated:\).*/\1 TEXT-LAST-UPDATED-STRING/' \
@@ -290,3 +290,3 @@ test_expect_success 'info deleted-symlink-file' "
 test_expect_success 'info --url symlink-file (deleted)' '
-	test "$(cd gitwc; git-svn info --url symlink-file)" \
+	test "$(cd gitwc; git svn info --url symlink-file)" \
 	     =3D "$quoted_svnrepo/symlink-file"
@@ -304,3 +304,3 @@ test_expect_success 'info deleted-symlink-directory=
' "
 		 > expected.info-deleted-symlink-directory &&
-	(cd gitwc; git-svn info symlink-directory) |
+	(cd gitwc; git svn info symlink-directory) |
 	sed -e 's/^\(Text Last Updated:\).*/\1 TEXT-LAST-UPDATED-STRING/' \
@@ -312,3 +312,3 @@ test_expect_success 'info deleted-symlink-directory=
' "
 test_expect_success 'info --url symlink-directory (deleted)' '
-	test "$(cd gitwc; git-svn info --url symlink-directory)" \
+	test "$(cd gitwc; git svn info --url symlink-directory)" \
 	     =3D "$quoted_svnrepo/symlink-directory"
@@ -321,3 +321,3 @@ test_expect_success 'info unknown-file' "
 	echo two > gitwc/unknown-file &&
-	(cd gitwc; test_must_fail git-svn info unknown-file) \
+	(cd gitwc; test_must_fail git svn info unknown-file) \
 		 2> actual.info-unknown-file &&
@@ -328,3 +328,3 @@ test_expect_success 'info --url unknown-file' '
 	echo two > gitwc/unknown-file &&
-	(cd gitwc; test_must_fail git-svn info --url unknown-file) \
+	(cd gitwc; test_must_fail git svn info --url unknown-file) \
 		 2> actual.info-url-unknown-file &&
@@ -335,3 +335,3 @@ test_expect_success 'info unknown-directory' "
 	mkdir gitwc/unknown-directory svnwc/unknown-directory &&
-	(cd gitwc; test_must_fail git-svn info unknown-directory) \
+	(cd gitwc; test_must_fail git svn info unknown-directory) \
 		 2> actual.info-unknown-directory &&
@@ -341,3 +341,3 @@ test_expect_success 'info unknown-directory' "
 test_expect_success 'info --url unknown-directory' '
-	(cd gitwc; test_must_fail git-svn info --url unknown-directory) \
+	(cd gitwc; test_must_fail git svn info --url unknown-directory) \
 		 2> actual.info-url-unknown-directory &&
@@ -350,3 +350,3 @@ test_expect_success 'info unknown-symlink-file' "
 	cd .. &&
-	(cd gitwc; test_must_fail git-svn info unknown-symlink-file) \
+	(cd gitwc; test_must_fail git svn info unknown-symlink-file) \
 		 2> actual.info-unknown-symlink-file &&
@@ -356,3 +356,3 @@ test_expect_success 'info unknown-symlink-file' "
 test_expect_success 'info --url unknown-symlink-file' '
-	(cd gitwc; test_must_fail git-svn info --url unknown-symlink-file) \
+	(cd gitwc; test_must_fail git svn info --url unknown-symlink-file) \
 		 2> actual.info-url-unknown-symlink-file &&
@@ -365,3 +365,3 @@ test_expect_success 'info unknown-symlink-directory=
' "
 	cd .. &&
-	(cd gitwc; test_must_fail git-svn info unknown-symlink-directory) \
+	(cd gitwc; test_must_fail git svn info unknown-symlink-directory) \
 		 2> actual.info-unknown-symlink-directory &&
@@ -371,3 +371,3 @@ test_expect_success 'info unknown-symlink-directory=
' "
 test_expect_success 'info --url unknown-symlink-directory' '
-	(cd gitwc; test_must_fail git-svn info --url unknown-symlink-director=
y) \
+	(cd gitwc; test_must_fail git svn info --url unknown-symlink-director=
y) \
 		 2> actual.info-url-unknown-symlink-directory &&
diff --git a/t/t9120-git-svn-clone-with-percent-escapes.sh b/t/t9120-gi=
t-svn-clone-with-percent-escapes.sh
index e5de229..ef2c052 100755
--- a/t/t9120-git-svn-clone-with-percent-escapes.sh
+++ b/t/t9120-git-svn-clone-with-percent-escapes.sh
@@ -5,3 +5,3 @@
=20
-test_description=3D'git-svn clone with percent escapes'
+test_description=3D'git svn clone with percent escapes'
 . ./lib-git-svn.sh
diff --git a/t/t9121-git-svn-fetch-renamed-dir.sh b/t/t9121-git-svn-fet=
ch-renamed-dir.sh
index 92e69a2..000cad3 100755
--- a/t/t9121-git-svn-fetch-renamed-dir.sh
+++ b/t/t9121-git-svn-fetch-renamed-dir.sh
@@ -5,3 +5,3 @@
=20
-test_description=3D'git-svn can fetch renamed directories'
+test_description=3D'git svn can fetch renamed directories'
=20
diff --git a/t/t9123-git-svn-rebuild-with-rewriteroot.sh b/t/t9123-git-=
svn-rebuild-with-rewriteroot.sh
index 363c1db..ddb1a48 100755
--- a/t/t9123-git-svn-rebuild-with-rewriteroot.sh
+++ b/t/t9123-git-svn-rebuild-with-rewriteroot.sh
@@ -5,3 +5,3 @@
=20
-test_description=3D'git-svn respects rewriteRoot during rebuild'
+test_description=3D'git svn respects rewriteRoot during rebuild'
=20
diff --git a/t/t9124-git-svn-dcommit-auto-props.sh b/t/t9124-git-svn-dc=
ommit-auto-props.sh
index 31193a3..0d7e7b2 100755
--- a/t/t9124-git-svn-dcommit-auto-props.sh
+++ b/t/t9124-git-svn-dcommit-auto-props.sh
@@ -4,3 +4,3 @@
=20
-test_description=3D'git-svn dcommit honors auto-props'
+test_description=3D'git svn dcommit honors auto-props'
=20
@@ -26,4 +26,4 @@ test_expect_success 'initialize git-svn' '
 	rm -rf import &&
-	git-svn init "$svnrepo"
-	git-svn fetch
+	git svn init "$svnrepo"
+	git svn fetch
 '
diff --git a/t/t9125-git-svn-multi-glob-branch-names.sh b/t/t9125-git-s=
vn-multi-glob-branch-names.sh
index 6b62b52..475c751 100755
--- a/t/t9125-git-svn-multi-glob-branch-names.sh
+++ b/t/t9125-git-svn-multi-glob-branch-names.sh
@@ -3,3 +3,3 @@
=20
-test_description=3D'git-svn multi-glob branch names'
+test_description=3D'git svn multi-glob branch names'
 . ./lib-git-svn.sh
--=20
1.6.0.1
