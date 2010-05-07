From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 3/6] Skip tests in a way that makes sense under TAP
Date: Fri,  7 May 2010 19:37:02 +0000
Message-ID: <1273261025-31523-3-git-send-email-avarab@gmail.com>
References: <1273261025-31523-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 07 21:40:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OATPO-0003CZ-JP
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 21:40:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116Ab0EGTkF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 May 2010 15:40:05 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:54381 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932067Ab0EGTj6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 May 2010 15:39:58 -0400
Received: by mail-fx0-f46.google.com with SMTP id 10so1043874fxm.19
        for <git@vger.kernel.org>; Fri, 07 May 2010 12:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=ES+LMmCqSUExGSV+wOOtP3jt6Jx74v0T7UajYZFkM6I=;
        b=cUZJ5d9o1Fxxb+gDL52rJV0PKW/uVR1WDttl3wmrE7woKEbk0cztE3kl7mA2tafV4z
         Uw0rX45Eiqdpqmeo4HgbIMJnrsh5E63S+ld49j0zEgWZMnGkY8dxLdPzm1ttPhq5/Dpl
         5eeQfSAmdYSBXB8t4Cvhsbl3zSb/mHJ9uT390=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=DbKu2fso9Azi+krOmzxMNDjR7V2LWK8dqGOczzoxthtUJNv4kDmiqgYu2kWTUnpMX4
         0NT43v8y76IIaxFdYblkyzZ7tOrFQ0O9duHx60Ctqcal3rSmYhfsFGLV8rRxfvtwKQ0I
         NSzOj69j8kaML+P0Xhj9rJpZ7dwYYwWdxK2l0=
Received: by 10.223.21.215 with SMTP id k23mr543300fab.54.1273261197834;
        Fri, 07 May 2010 12:39:57 -0700 (PDT)
Received: from aoeu (dslb-188-098-088-194.pools.arcor-ip.net [188.98.88.194])
        by mx.google.com with ESMTPS id y12sm8000128faj.5.2010.05.07.12.39.55
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 07 May 2010 12:39:56 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.dirty
In-Reply-To: <1273261025-31523-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146569>

SKIP messages are now part of the TAP plan. A TAP harness now knows
why a particular test was skipped and can report that information.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/lib-git-svn.sh                       |    4 ++--
 t/lib-httpd.sh                         |    3 +--
 t/t1304-default-acl.sh                 |    9 ++++++---
 t/t1509-root-worktree.sh               |    6 +++---
 t/t2007-checkout-symlink.sh            |    2 +-
 t/t3300-funny-names.sh                 |    2 +-
 t/t3302-notes-index-expensive.sh       |    2 +-
 t/t3600-rm.sh                          |    2 +-
 t/t3701-add-interactive.sh             |    4 ++--
 t/t3902-quoted.sh                      |    2 +-
 t/t4004-diff-rename-symlink.sh         |    2 +-
 t/t4011-diff-symlink.sh                |    2 +-
 t/t4016-diff-quote.sh                  |    2 +-
 t/t4023-diff-rename-typechange.sh      |    2 +-
 t/t4114-apply-typechange.sh            |    2 +-
 t/t4115-apply-symlink.sh               |    2 +-
 t/t4122-apply-symlink-inside.sh        |    2 +-
 t/t5302-pack-index.sh                  |    2 +-
 t/t5503-tagfollow.sh                   |    2 +-
 t/t5522-pull-symlink.sh                |    2 +-
 t/t5540-http-push.sh                   |    2 +-
 t/t5541-http-push.sh                   |    2 +-
 t/t5550-http-fetch.sh                  |    2 +-
 t/t5551-http-fetch.sh                  |    2 +-
 t/t5561-http-backend.sh                |    2 +-
 t/t5705-clone-2gb.sh                   |    2 +-
 t/t6035-merge-dir-to-symlink.sh        |    2 +-
 t/t7004-tag.sh                         |    2 +-
 t/t7006-pager.sh                       |    2 +-
 t/t7800-difftool.sh                    |    2 +-
 t/t9001-send-email.sh                  |    4 ++--
 t/t9100-git-svn-basic.sh               |    2 +-
 t/t9119-git-svn-info.sh                |    2 +-
 t/t9129-git-svn-i18n-commitencoding.sh |    2 +-
 t/t9143-git-svn-gc.sh                  |    2 +-
 t/t9200-git-cvsexportcommit.sh         |    4 ++--
 t/t9400-git-cvsserver-server.sh        |    6 +++---
 t/t9401-git-cvsserver-crlf.sh          |    6 +++---
 t/t9600-cvsimport.sh                   |    2 +-
 t/t9700-perl-git.sh                    |    4 ++--
 40 files changed, 56 insertions(+), 54 deletions(-)

diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
index 0f7f35c..344785d 100644
--- a/t/lib-git-svn.sh
+++ b/t/lib-git-svn.sh
@@ -5,11 +5,11 @@ git_svn_id=3Dgit""-svn-id
=20
 if test -n "$NO_SVN_TESTS"
 then
-	say 'skipping git svn tests, NO_SVN_TESTS defined'
+	skip_all=3D'skipping git svn tests, NO_SVN_TESTS defined'
 	test_done
 fi
 if ! test_have_prereq PERL; then
-	say 'skipping git svn tests, perl not available'
+	skip_all=3D'skipping git svn tests, perl not available'
 	test_done
 fi
=20
diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index da4b8d5..a0944d6 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -5,8 +5,7 @@
=20
 if test -z "$GIT_TEST_HTTPD"
 then
-	say "skipping test, network testing disabled by default"
-	say "(define GIT_TEST_HTTPD to enable)"
+	skip_all=3D"Network testing disabled (define GIT_TEST_HTTPD to enable=
)"
 	test_done
 fi
=20
diff --git a/t/t1304-default-acl.sh b/t/t1304-default-acl.sh
index 055ad00..97ab02a 100755
--- a/t/t1304-default-acl.sh
+++ b/t/t1304-default-acl.sh
@@ -15,9 +15,12 @@ umask 077
 # is a good candidate: exists on all unices, and it has permission
 # anyway, so we don't create a security hole running the testsuite.
=20
-if ! setfacl -m u:root:rwx .; then
-    say "Skipping ACL tests: unable to use setfacl"
-    test_done
+setfacl_out=3D"$(setfacl -m u:root:rwx . 2>&1)"
+setfacl_ret=3D$?
+
+if [ $setfacl_ret !=3D 0 ]; then
+	skip_all=3D"Skipping ACL tests: unable to use setfacl (output: '$setf=
acl_out'; return code: '$setfacl_ret')"
+	test_done
 fi
=20
 check_perms_and_acl () {
diff --git a/t/t1509-root-worktree.sh b/t/t1509-root-worktree.sh
index 5322a3b..7f60fd0 100755
--- a/t/t1509-root-worktree.sh
+++ b/t/t1509-root-worktree.sh
@@ -99,17 +99,17 @@ test_foobar_foobar() {
 }
=20
 if ! test_have_prereq POSIXPERM || ! [ -w / ]; then
-	say "Dangerous test skipped. Read this test if you want to execute it=
"
+	skip_all=3D"Dangerous test skipped. Read this test if you want to exe=
cute it"
 	test_done
 fi
=20
 if [ "$IKNOWWHATIAMDOING" !=3D "YES" ]; then
-	say "You must set env var IKNOWWHATIAMDOING=3DYES in order to run thi=
s test"
+	skip_all=3D"You must set env var IKNOWWHATIAMDOING=3DYES in order to =
run this test"
 	test_done
 fi
=20
 if [ "$UID" =3D 0 ]; then
-	say "No you can't run this with root"
+	skip_all=3D"No you can't run this with root"
 	test_done
 fi
=20
diff --git a/t/t2007-checkout-symlink.sh b/t/t2007-checkout-symlink.sh
index 20f3343..616ca2a 100755
--- a/t/t2007-checkout-symlink.sh
+++ b/t/t2007-checkout-symlink.sh
@@ -8,7 +8,7 @@ test_description=3D'git checkout to switch between bran=
ches with symlink<->dir'
=20
 if ! test_have_prereq SYMLINKS
 then
-	say "symbolic links not supported - skipping tests"
+	skip_all=3D"symbolic links not supported - skipping tests"
 	test_done
 fi
=20
diff --git a/t/t3300-funny-names.sh b/t/t3300-funny-names.sh
index db46d53..a99e4d8 100755
--- a/t/t3300-funny-names.sh
+++ b/t/t3300-funny-names.sh
@@ -26,7 +26,7 @@ echo 'Foo Bar Baz' >"$p2"
=20
 test -f "$p1" && cmp "$p0" "$p1" || {
 	# since FAT/NTFS does not allow tabs in filenames, skip this test
-	say 'Your filesystem does not allow tabs in filenames, test skipped.'
+	skip_all=3D'Your filesystem does not allow tabs in filenames, test sk=
ipped.'
 	test_done
 }
=20
diff --git a/t/t3302-notes-index-expensive.sh b/t/t3302-notes-index-exp=
ensive.sh
index ee84fc4..361a10a 100755
--- a/t/t3302-notes-index-expensive.sh
+++ b/t/t3302-notes-index-expensive.sh
@@ -8,7 +8,7 @@ test_description=3D'Test commit notes index (expensive!=
)'
 . ./test-lib.sh
=20
 test -z "$GIT_NOTES_TIMING_TESTS" && {
-	say Skipping timing tests
+	skip_all=3D"Skipping timing tests"
 	test_done
 	exit
 }
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 0aaf0ad..b514cbb 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -39,7 +39,7 @@ if test -f test-file
 then
 	test_set_prereq RO_DIR
 else
-	say 'skipping removal failure test (perhaps running as root?)'
+	skip_all=3D'skipping removal failure test (perhaps running as root?)'
 fi
 chmod 775 .
 rm -f test-file
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index b6eba6a..7ad8465 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -4,7 +4,7 @@ test_description=3D'add -i basic tests'
 . ./test-lib.sh
=20
 if ! test_have_prereq PERL; then
-	say 'skipping git add -i tests, perl not available'
+	skip_all=3D'skipping git add -i tests, perl not available'
 	test_done
 fi
=20
@@ -154,7 +154,7 @@ rm -f .gitignore
=20
 if test "$(git config --bool core.filemode)" =3D false
 then
-	say 'skipping filemode tests (filesystem does not properly support mo=
des)'
+	say '# skipping filemode tests (filesystem does not properly support =
modes)'
 else
 	test_set_prereq FILEMODE
 fi
diff --git a/t/t3902-quoted.sh b/t/t3902-quoted.sh
index 29103f6..147e634 100755
--- a/t/t3902-quoted.sh
+++ b/t/t3902-quoted.sh
@@ -17,7 +17,7 @@ DQ=3D'"'
 echo foo 2>/dev/null > "Name and an${HT}HT"
 test -f "Name and an${HT}HT" || {
 	# since FAT/NTFS does not allow tabs in filenames, skip this test
-	say 'Your filesystem does not allow tabs in filenames, test skipped.'
+	skip_all=3D'Your filesystem does not allow tabs in filenames, test sk=
ipped.'
 	test_done
 }
=20
diff --git a/t/t4004-diff-rename-symlink.sh b/t/t4004-diff-rename-symli=
nk.sh
index a4da119..1a09e8d 100755
--- a/t/t4004-diff-rename-symlink.sh
+++ b/t/t4004-diff-rename-symlink.sh
@@ -14,7 +14,7 @@ by an edit for them.
=20
 if ! test_have_prereq SYMLINKS
 then
-	say 'Symbolic links not supported, skipping tests.'
+	skip_all=3D'Symbolic links not supported, skipping tests.'
 	test_done
 fi
=20
diff --git a/t/t4011-diff-symlink.sh b/t/t4011-diff-symlink.sh
index d7e327c..2b9a22d 100755
--- a/t/t4011-diff-symlink.sh
+++ b/t/t4011-diff-symlink.sh
@@ -11,7 +11,7 @@ test_description=3D'Test diff of symlinks.
=20
 if ! test_have_prereq SYMLINKS
 then
-	say 'Symbolic links not supported, skipping tests.'
+	skip_all=3D'Symbolic links not supported, skipping tests.'
 	test_done
 fi
=20
diff --git a/t/t4016-diff-quote.sh b/t/t4016-diff-quote.sh
index 55eb5f8..34e5144 100755
--- a/t/t4016-diff-quote.sh
+++ b/t/t4016-diff-quote.sh
@@ -14,7 +14,7 @@ P2=3D'pathname with SP'
 P3=3D'pathname
 with LF'
 : 2>/dev/null >"$P1" && test -f "$P1" && rm -f "$P1" || {
-	say 'Your filesystem does not allow tabs in filenames, test skipped.'
+	skip_all=3D'Your filesystem does not allow tabs in filenames, test sk=
ipped.'
 	test_done
 }
=20
diff --git a/t/t4023-diff-rename-typechange.sh b/t/t4023-diff-rename-ty=
pechange.sh
index 9bdf659..40a95a1 100755
--- a/t/t4023-diff-rename-typechange.sh
+++ b/t/t4023-diff-rename-typechange.sh
@@ -6,7 +6,7 @@ test_description=3D'typechange rename detection'
=20
 if ! test_have_prereq SYMLINKS
 then
-	say 'Symbolic links not supported, skipping tests.'
+	skip_all=3D'Symbolic links not supported, skipping tests.'
 	test_done
 fi
=20
diff --git a/t/t4114-apply-typechange.sh b/t/t4114-apply-typechange.sh
index 99ec13d..164d58c 100755
--- a/t/t4114-apply-typechange.sh
+++ b/t/t4114-apply-typechange.sh
@@ -11,7 +11,7 @@ test_description=3D'git apply should not get confused=
 with type changes.
=20
 if ! test_have_prereq SYMLINKS
 then
-	say 'Symbolic links not supported, skipping tests.'
+	skip_all=3D'Symbolic links not supported, skipping tests.'
 	test_done
 fi
=20
diff --git a/t/t4115-apply-symlink.sh b/t/t4115-apply-symlink.sh
index b852e58..aff4348 100755
--- a/t/t4115-apply-symlink.sh
+++ b/t/t4115-apply-symlink.sh
@@ -11,7 +11,7 @@ test_description=3D'git apply symlinks and partial fi=
les
=20
 if ! test_have_prereq SYMLINKS
 then
-	say 'Symbolic links not supported, skipping tests.'
+	skip_all=3D'Symbolic links not supported, skipping tests.'
 	test_done
 fi
=20
diff --git a/t/t4122-apply-symlink-inside.sh b/t/t4122-apply-symlink-in=
side.sh
index 0d3c1d5..923fcab 100755
--- a/t/t4122-apply-symlink-inside.sh
+++ b/t/t4122-apply-symlink-inside.sh
@@ -5,7 +5,7 @@ test_description=3D'apply to deeper directory without g=
etting fooled with symlink'
=20
 if ! test_have_prereq SYMLINKS
 then
-	say 'Symbolic links not supported, skipping tests.'
+	skip_all=3D'Symbolic links not supported, skipping tests.'
 	test_done
 fi
=20
diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
index 4360e77..fb3a270 100755
--- a/t/t5302-pack-index.sh
+++ b/t/t5302-pack-index.sh
@@ -74,7 +74,7 @@ if msg=3D$(git verify-pack -v "test-3-${pack3}.pack" =
2>&1) ||
 then
 	test_set_prereq OFF64_T
 else
-	say "skipping tests concerning 64-bit offsets"
+	say "# skipping tests concerning 64-bit offsets"
 fi
=20
 test_expect_success OFF64_T \
diff --git a/t/t5503-tagfollow.sh b/t/t5503-tagfollow.sh
index d5db75d..bab1a53 100755
--- a/t/t5503-tagfollow.sh
+++ b/t/t5503-tagfollow.sh
@@ -6,7 +6,7 @@ test_description=3D'test automatic tag following'
=20
 case $(uname -s) in
 *MINGW*)
-	say "GIT_DEBUG_SEND_PACK not supported - skipping tests"
+	skip_all=3D"GIT_DEBUG_SEND_PACK not supported - skipping tests"
 	test_done
 esac
=20
diff --git a/t/t5522-pull-symlink.sh b/t/t5522-pull-symlink.sh
index 7206817..298200f 100755
--- a/t/t5522-pull-symlink.sh
+++ b/t/t5522-pull-symlink.sh
@@ -6,7 +6,7 @@ test_description=3D'pulling from symlinked subdir'
=20
 if ! test_have_prereq SYMLINKS
 then
-	say 'Symbolic links not supported, skipping tests.'
+	skip_all=3D'Symbolic links not supported, skipping tests.'
 	test_done
 fi
=20
diff --git a/t/t5540-http-push.sh b/t/t5540-http-push.sh
index 37fe875..a266ca5 100755
--- a/t/t5540-http-push.sh
+++ b/t/t5540-http-push.sh
@@ -11,7 +11,7 @@ This test runs various sanity checks on http-push.'
=20
 if git http-push > /dev/null 2>&1 || [ $? -eq 128 ]
 then
-	say "skipping test, USE_CURL_MULTI is not defined"
+	skip_all=3D"skipping test, USE_CURL_MULTI is not defined"
 	test_done
 fi
=20
diff --git a/t/t5541-http-push.sh b/t/t5541-http-push.sh
index 795dc2b..a5e9be6 100755
--- a/t/t5541-http-push.sh
+++ b/t/t5541-http-push.sh
@@ -7,7 +7,7 @@ test_description=3D'test smart pushing over http via ht=
tp-backend'
 . ./test-lib.sh
=20
 if test -n "$NO_CURL"; then
-	say 'skipping test, git built without http support'
+	skip_all=3D'skipping test, git built without http support'
 	test_done
 fi
=20
diff --git a/t/t5550-http-fetch.sh b/t/t5550-http-fetch.sh
index 8cfce96..10681fb 100755
--- a/t/t5550-http-fetch.sh
+++ b/t/t5550-http-fetch.sh
@@ -4,7 +4,7 @@ test_description=3D'test dumb fetching over http via st=
atic file'
 . ./test-lib.sh
=20
 if test -n "$NO_CURL"; then
-	say 'skipping test, git built without http support'
+	skip_all=3D'skipping test, git built without http support'
 	test_done
 fi
=20
diff --git a/t/t5551-http-fetch.sh b/t/t5551-http-fetch.sh
index 7faa31a..fd19121 100755
--- a/t/t5551-http-fetch.sh
+++ b/t/t5551-http-fetch.sh
@@ -4,7 +4,7 @@ test_description=3D'test smart fetching over http via h=
ttp-backend'
 . ./test-lib.sh
=20
 if test -n "$NO_CURL"; then
-	say 'skipping test, git built without http support'
+	skip_all=3D'skipping test, git built without http support'
 	test_done
 fi
=20
diff --git a/t/t5561-http-backend.sh b/t/t5561-http-backend.sh
index 8c6d0b2..b5d7fbc 100755
--- a/t/t5561-http-backend.sh
+++ b/t/t5561-http-backend.sh
@@ -4,7 +4,7 @@ test_description=3D'test git-http-backend'
 . ./test-lib.sh
=20
 if test -n "$NO_CURL"; then
-	say 'skipping test, git built without http support'
+	skip_all=3D'skipping test, git built without http support'
 	test_done
 fi
=20
diff --git a/t/t5705-clone-2gb.sh b/t/t5705-clone-2gb.sh
index adfaae8..23fe8fa 100755
--- a/t/t5705-clone-2gb.sh
+++ b/t/t5705-clone-2gb.sh
@@ -4,7 +4,7 @@ test_description=3D'Test cloning a repository larger th=
an 2 gigabyte'
 . ./test-lib.sh
=20
 test -z "$GIT_TEST_CLONE_2GB" &&
-say "Skipping expensive 2GB clone test; enable it with GIT_TEST_CLONE_=
2GB=3Dt" &&
+skip_all=3D"Skipping expensive 2GB clone test; enable it with GIT_TEST=
_CLONE_2GB=3Dt" &&
 test_done &&
 exit
=20
diff --git a/t/t6035-merge-dir-to-symlink.sh b/t/t6035-merge-dir-to-sym=
link.sh
index 3202e1d..cd3190c 100755
--- a/t/t6035-merge-dir-to-symlink.sh
+++ b/t/t6035-merge-dir-to-symlink.sh
@@ -5,7 +5,7 @@ test_description=3D'merging when a directory was replac=
ed with a symlink'
=20
 if ! test_have_prereq SYMLINKS
 then
-	say 'Symbolic links not supported, skipping tests.'
+	skip_all=3D'Symbolic links not supported, skipping tests.'
 	test_done
 fi
=20
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 73dbc43..ac943f5 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -583,7 +583,7 @@ test_expect_success \
 # subsequent tests require gpg; check if it is available
 gpg --version >/dev/null 2>/dev/null
 if [ $? -eq 127 ]; then
-	say "gpg not found - skipping tag signing and verification tests"
+	say "# gpg not found - skipping tag signing and verification tests"
 else
 	# As said here: http://www.gnupg.org/documentation/faqs.html#q6.19
 	# the gpg version 1.0.6 didn't parse trust packets correctly, so for
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index d9202d5..e2a44a5 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -29,7 +29,7 @@ then
 	}
 	test_set_prereq TTY
 else
-	say no usable terminal, so skipping some tests
+	say "# no usable terminal, so skipping some tests"
 fi
=20
 unset GIT_PAGER GIT_PAGER_IN_USE
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 1de83ef..196827e 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -11,7 +11,7 @@ Testing basic diff tool invocation
 . ./test-lib.sh
=20
 if ! test_have_prereq PERL; then
-	say 'skipping difftool tests, perl not available'
+	skip_all=3D'skipping difftool tests, perl not available'
 	test_done
 fi
=20
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 640b3d2..ddc3d8d 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -4,7 +4,7 @@ test_description=3D'git send-email'
 . ./test-lib.sh
=20
 if ! test_have_prereq PERL; then
-	say 'skipping git send-email tests, perl not available'
+	skip_all=3D'skipping git send-email tests, perl not available'
 	test_done
 fi
=20
@@ -58,7 +58,7 @@ test_no_confirm () {
 # Exit immediately to prevent hang if a no-confirm test fails
 check_no_confirm () {
 	test -f no_confirm_okay || {
-		say 'No confirm test failed; skipping remaining tests to prevent han=
ging'
+		skip_all=3D'confirm test failed; skipping remaining tests to prevent=
 hanging'
 		test_done
 	}
 }
diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index 570e035..13766ab 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -15,7 +15,7 @@ case "$GIT_SVN_LC_ALL" in
 	test_set_prereq UTF8
 	;;
 *)
-	say "UTF-8 locale not set, some tests skipped ($GIT_SVN_LC_ALL)"
+	say "# UTF-8 locale not set, some tests skipped ($GIT_SVN_LC_ALL)"
 	;;
 esac
=20
diff --git a/t/t9119-git-svn-info.sh b/t/t9119-git-svn-info.sh
index a9a558d..5fb94fb 100755
--- a/t/t9119-git-svn-info.sh
+++ b/t/t9119-git-svn-info.sh
@@ -13,7 +13,7 @@ case $v in
 1.[456].*)
 	;;
 *)
-	say "skipping svn-info test (SVN version: $v not supported)"
+	skip_all=3D"skipping svn-info test (SVN version: $v not supported)"
 	test_done
 	;;
 esac
diff --git a/t/t9129-git-svn-i18n-commitencoding.sh b/t/t9129-git-svn-i=
18n-commitencoding.sh
index b9224bd..6831fcc 100755
--- a/t/t9129-git-svn-i18n-commitencoding.sh
+++ b/t/t9129-git-svn-i18n-commitencoding.sh
@@ -72,7 +72,7 @@ done
 if locale -a |grep -q en_US.utf8; then
 	test_set_prereq UTF8
 else
-	say "UTF-8 locale not available, test skipped"
+	say "# UTF-8 locale not available, test skipped"
 fi
=20
 test_expect_success UTF8 'ISO-8859-1 should match UTF-8 in svn' '
diff --git a/t/t9143-git-svn-gc.sh b/t/t9143-git-svn-gc.sh
index 99f69c6..337ea59 100755
--- a/t/t9143-git-svn-gc.sh
+++ b/t/t9143-git-svn-gc.sh
@@ -43,7 +43,7 @@ then
 		 gunzip .git/svn/refs/remotes/git-svn/unhandled.log.gz
 		'
 else
-	say "Perl Compress::Zlib unavailable, skipping gunzip test"
+	say "# Perl Compress::Zlib unavailable, skipping gunzip test"
 fi
=20
 test_expect_success 'git svn gc does not change unhandled.log files' '
diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcomm=
it.sh
index fc3795d..fd268b7 100755
--- a/t/t9200-git-cvsexportcommit.sh
+++ b/t/t9200-git-cvsexportcommit.sh
@@ -7,14 +7,14 @@ test_description=3D'Test export of commits to CVS'
 . ./test-lib.sh
=20
 if ! test_have_prereq PERL; then
-	say 'skipping git cvsexportcommit tests, perl not available'
+	skip_all=3D'skipping git cvsexportcommit tests, perl not available'
 	test_done
 fi
=20
 cvs >/dev/null 2>&1
 if test $? -ne 1
 then
-    say 'skipping git cvsexportcommit tests, cvs not found'
+    skip_all=3D'skipping git cvsexportcommit tests, cvs not found'
     test_done
 fi
=20
diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-se=
rver.sh
index daef2d6..dda3e4c 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -11,17 +11,17 @@ cvs CLI client via git-cvsserver server'
 . ./test-lib.sh
=20
 if ! test_have_prereq PERL; then
-	say 'skipping git cvsserver tests, perl not available'
+	skip_all=3D'skipping git cvsserver tests, perl not available'
 	test_done
 fi
 cvs >/dev/null 2>&1
 if test $? -ne 1
 then
-    say 'skipping git-cvsserver tests, cvs not found'
+    skip_all=3D'skipping git-cvsserver tests, cvs not found'
     test_done
 fi
 "$PERL_PATH" -e 'use DBI; use DBD::SQLite' >/dev/null 2>&1 || {
-    say 'skipping git-cvsserver tests, Perl SQLite interface unavailab=
le'
+    skip_all=3D'skipping git-cvsserver tests, Perl SQLite interface un=
available'
     test_done
 }
=20
diff --git a/t/t9401-git-cvsserver-crlf.sh b/t/t9401-git-cvsserver-crlf=
=2Esh
index ed7b513..925bd0f 100755
--- a/t/t9401-git-cvsserver-crlf.sh
+++ b/t/t9401-git-cvsserver-crlf.sh
@@ -41,16 +41,16 @@ not_present() {
 cvs >/dev/null 2>&1
 if test $? -ne 1
 then
-    say 'skipping git-cvsserver tests, cvs not found'
+    skip_all=3D'skipping git-cvsserver tests, cvs not found'
     test_done
 fi
 if ! test_have_prereq PERL
 then
-    say 'skipping git-cvsserver tests, perl not available'
+    skip_all=3D'skipping git-cvsserver tests, perl not available'
     test_done
 fi
 "$PERL_PATH" -e 'use DBI; use DBD::SQLite' >/dev/null 2>&1 || {
-    say 'skipping git-cvsserver tests, Perl SQLite interface unavailab=
le'
+    skip_all=3D'skipping git-cvsserver tests, Perl SQLite interface un=
available'
     test_done
 }
=20
diff --git a/t/t9600-cvsimport.sh b/t/t9600-cvsimport.sh
index b572ce3..2eff9cd 100755
--- a/t/t9600-cvsimport.sh
+++ b/t/t9600-cvsimport.sh
@@ -4,7 +4,7 @@ test_description=3D'git cvsimport basic tests'
 . ./lib-cvs.sh
=20
 if ! test_have_prereq PERL; then
-	say 'skipping git cvsimport tests, perl not available'
+	skip_all=3D'skipping git cvsimport tests, perl not available'
 	test_done
 fi
=20
diff --git a/t/t9700-perl-git.sh b/t/t9700-perl-git.sh
index 8686086..3999bf7 100755
--- a/t/t9700-perl-git.sh
+++ b/t/t9700-perl-git.sh
@@ -7,12 +7,12 @@ test_description=3D'perl interface (Git.pm)'
 . ./test-lib.sh
=20
 if ! test_have_prereq PERL; then
-	say 'skipping perl interface tests, perl not available'
+	skip_all=3D'skipping perl interface tests, perl not available'
 	test_done
 fi
=20
 "$PERL_PATH" -MTest::More -e 0 2>/dev/null || {
-	say "Perl Test::More unavailable, skipping test"
+	skip_all=3D"Perl Test::More unavailable, skipping test"
 	test_done
 }
=20
--=20
1.7.1.dirty
