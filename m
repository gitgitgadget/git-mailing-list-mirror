From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 00/19] Let Git's tests pass on Windows
Date: Tue, 26 Jan 2016 15:34:07 +0100 (CET)
Message-ID: <cover.1453818789.git.johannes.schindelin@gmx.de>
References: <cover.1453650173.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1673539101-1453818849=:2964"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 15:34:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aO4hb-0004La-3U
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 15:34:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966155AbcAZOeb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 09:34:31 -0500
Received: from mout.gmx.net ([212.227.17.21]:56600 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966257AbcAZOe0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 09:34:26 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MTO3f-1aV3Ly15Hz-00SMS7; Tue, 26 Jan 2016 15:34:09
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1453650173.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:FPjC+acYf5fX9QcuNUQlpn3Tu47hKJFZto7xcGyohy2rmmZSule
 QBh1N5Z8gbKUbsdL3V2+vs86CJQkVXNJQsjl+4Z1GDIDUeq+QF+DmeMMJYCj8cfPJrnLCSg
 cT2K3A1BzRhejedo9soIL6OeCdXQo/5UvT5ELC+e8L86wICX9vZW9lepKD4S7Y65pzAYJ+2
 mTwvWmKB0I63Iy+RMJR1Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Q8YXFOTZncE=:NvKK2iB7Ff+uTeBcxGBlZq
 fNIYs4L0BUYp/0V8/AoYfezSahZ7Dar9Gp2UKQBmBhScwEinnEgdGoqUzcDT5xPFFsrdNk97G
 rAv0K4kYF/LF4Mtdq0CJLkUAuiDtzKuruSd9WV56wJe0eojvLgEAoFHwFJxB0A+6gipX0pFGy
 yP+24qJls9cKtYN8OpHu5kpxCwFDgx4Mlt/t37wIxO4DrXhpOTzbbWCOqv/2MtNYQ690fVlNb
 JuIYl+oXmWtr8hpyDqYL49LofS0rt3BuVY0iK3QE+/zvTw1y/X/ioYS29wavy037DdZ+DJSxv
 5xW27p27WidTr2Z+umlABWTha0amwtPUMOjNb9XeM86HdlRISqgFHMvzfnAnA3EGMAyVjgdtA
 0UBGuNq6y1ymulKSpRYSD7pPDKgI/Dn9+rGrewdL+F15IXB1LLRULuL/pkKpeNOGNemcyrEFE
 0sco1s05aPGZjQaNqoRtB7MQlva/KnWKVKzJgcbJRGZGPBN1RWaYpM8CSKUovqxWlkPtJPIbm
 de3sfwtni9ZVxEmMuDNjMlleZEbzMmapiSkjnYxV2PT/tl821EH1BDRuUf9g08+2ISJEmqFRc
 qnZf4M473Qx6akYHRfaY4bKweLh3g9tbwb0nr96AjRyEjkujwnno2QfHZwL8PsAYH4vcN2R1e
 gNsn4rT++X2nKyUU+e1z7RljtTlBn2UhphW2pT/Y5Ky6Cf5uxyTzd1qVuzV2KqQpYDuTza66l
 RetGsUYcFo9afDTsMoR2d/DBlsqkYfs/H/Qc1D2ab9lB8sAWl/jkCs+89pq63Uov88e2mfdc 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284815>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1673539101-1453818849=:2964
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

This is a big milestone. With these modifications, Git's source code
does not only build without warnings in Git for Windows' SDK, but
passes the entire regression test suite.

The patch series contains three different types of patches. First,
there are a couple of real fixes that were triggered by failures in
the regression tests. Then there are a couple of fixes to the
regression tests themselves. And finally, we have to disable a couple
of tests because we simply cannot make them work on Windows.


Johannes Schindelin (16):
  mingw: let's use gettext with MSYS2
  mingw: do not trust MSYS2's MinGW gettext.sh
  Git.pm: stop assuming that absolute paths start with a slash
  mingw: prepare the TMPDIR environment variable for shell scripts
  mingw: let lstat() fail with errno =3D=3D ENOTDIR when appropriate
  mingw: fix t5601-clone.sh
  mingw: accomodate t0060-path-utils for MSYS2
  mingw: disable mkfifo-based tests
  tests: turn off git-daemon tests if FIFOs are not available
  mingw: skip test in t1508 that fails due to path conversion
  mingw: fix t9700's assumption about directory separators
  mingw: work around pwd issues in the tests
  mingw: mark t9100's test cases with appropriate prereqs
  mingw: avoid illegal filename in t9118
  mingw: handle the missing POSIXPERM prereq in t9124
  mingw: do not bother to test funny file names

Karsten Blees (1):
  mingw: factor out Windows specific environment setup

Pat Thoyts (1):
  Avoid absolute path in t0008

=EB=A7=88=EB=88=84=EC=97=98 (1):
  mingw: try to delete target directory before renaming

 Makefile                              |  1 +
 compat/mingw.c                        | 91 +++++++++++++++++++++++++++++--=
----
 config.mak.uname                      |  3 +-
 perl/Git.pm                           |  3 +-
 t/lib-git-daemon.sh                   |  5 ++
 t/t0008-ignores.sh                    |  2 +-
 t/t0060-path-utils.sh                 |  9 ++++
 t/t1508-at-combinations.sh            |  6 ++-
 t/t3300-funny-names.sh                |  1 +
 t/t3600-rm.sh                         |  3 +-
 t/t3703-add-magic-pathspec.sh         |  2 +-
 t/t3902-quoted.sh                     |  1 +
 t/t4016-diff-quote.sh                 |  1 +
 t/t4135-apply-weird-filenames.sh      |  3 +-
 t/t5601-clone.sh                      | 18 +++----
 t/t7800-difftool.sh                   | 14 +++---
 t/t9100-git-svn-basic.sh              | 18 +++----
 t/t9118-git-svn-funky-branch-names.sh | 12 +++--
 t/t9124-git-svn-dcommit-auto-props.sh | 16 +++---
 t/t9200-git-cvsexportcommit.sh        |  2 +-
 t/t9400-git-cvsserver-server.sh       |  6 +--
 t/t9401-git-cvsserver-crlf.sh         |  6 +--
 t/t9402-git-cvsserver-refs.sh         |  6 +--
 t/t9700/test.pl                       |  2 +-
 t/t9903-bash-prompt.sh                |  2 +-
 t/test-lib.sh                         |  2 +-
 test-fake-ssh.c                       | 30 ++++++++++++
 27 files changed, 196 insertions(+), 69 deletions(-)
 create mode 100644 test-fake-ssh.c

Interdiff vs v1:

 diff --git a/compat/mingw.c b/compat/mingw.c
 index 9e60335..f7acb7f 100644
 --- a/compat/mingw.c
 +++ b/compat/mingw.c
 @@ -2089,7 +2089,7 @@ static void setup_windows_environment()
  =09char *tmp =3D getenv("TMPDIR");
 =20
  =09/* on Windows it is TMP and TEMP */
 -=09if (tmp) {
 +=09if (!tmp) {
  =09=09if (!(tmp =3D getenv("TMP")))
  =09=09=09tmp =3D getenv("TEMP");
  =09=09if (tmp) {
 diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
 index 68749f5..89544dd 100755
 --- a/t/t0008-ignores.sh
 +++ b/t/t0008-ignores.sh
 @@ -5,13 +5,7 @@ test_description=3Dcheck-ignore
  . ./test-lib.sh
 =20
  init_vars () {
 -=09# On Windows, avoid using "C:" in the global-excludes paths.
 -=09if test_have_prereq MINGW
 -=09then
 -=09=09global_excludes=3D"global-excludes"
 -=09else
 -=09=09global_excludes=3D"$(pwd)/global-excludes"
 -=09fi
 +=09global_excludes=3D"global-excludes"
  }
 =20
  enable_global_excludes () {
 diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
 index 89d03e7..8532a02 100755
 --- a/t/t0060-path-utils.sh
 +++ b/t/t0060-path-utils.sh
 @@ -7,13 +7,6 @@ test_description=3D'Test various path utilities'
 =20
  . ./test-lib.sh
 =20
 -# On Windows, the root directory "/" is translated into a Windows directo=
ry.
 -# As it is not well-defined whether that Windows directory should end in =
a
 -# slash or not, let's test for that and adjust our expected longest ances=
tor
 -# length accordingly.
 -root_offset=3D0
 -case "$(test-path-utils print_path /)" in ?*/) root_offset=3D-1;; esac
 -
  norm_path() {
  =09expected=3D$(test-path-utils print_path "$2")
  =09test_expect_success $3 "normalize path: $1 =3D> $2" \
 @@ -43,12 +36,21 @@ if test $rootoff =3D 2; then
  =09rootoff=3D=09# we are on Unix
  else
  =09rootoff=3D$(($rootoff-1))
 +=09# In MSYS2, the root directory "/" is translated into a Windows
 +=09# directory *with* trailing slash. Let's test for that and adjust
 +=09# our expected longest ancestor length accordingly.
 +=09case "$(test-path-utils print_path /)" in
 +=09*/) rootslash=3D1;;
 +=09*) rootslash=3D0;;
 +=09esac
  fi
 =20
  ancestor() {
  =09# We do some math with the expected ancestor length.
  =09expected=3D$3
  =09if test -n "$rootoff" && test "x$expected" !=3D x-1; then
 +=09=09expected=3D$(($expected-$rootslash))
 +=09=09test $expected -lt 0 ||
  =09=09expected=3D$(($expected+$rootoff))
  =09fi
  =09test_expect_success "longest ancestor: $1 $2 =3D> $expected" \
 @@ -119,30 +121,30 @@ norm_path /d1/.../d2 /d1/.../d2
  norm_path /d1/..././../d2 /d1/d2
 =20
  ancestor / / -1
 -ancestor /foo / $root_offset
 +ancestor /foo / 0
  ancestor /foo /fo -1
  ancestor /foo /foo -1
  ancestor /foo /bar -1
  ancestor /foo /foo/bar -1
  ancestor /foo /foo:/bar -1
 -ancestor /foo /:/foo:/bar $root_offset
 -ancestor /foo /foo:/:/bar $root_offset
 -ancestor /foo /:/bar:/foo $root_offset
 -ancestor /foo/bar / $root_offset
 +ancestor /foo /:/foo:/bar 0
 +ancestor /foo /foo:/:/bar 0
 +ancestor /foo /:/bar:/foo 0
 +ancestor /foo/bar / 0
  ancestor /foo/bar /fo -1
 -ancestor /foo/bar /foo $((4+$root_offset))
 +ancestor /foo/bar /foo 4
  ancestor /foo/bar /foo/ba -1
 -ancestor /foo/bar /:/fo $root_offset
 -ancestor /foo/bar /foo:/foo/ba $((4+$root_offset))
 +ancestor /foo/bar /:/fo 0
 +ancestor /foo/bar /foo:/foo/ba 4
  ancestor /foo/bar /bar -1
  ancestor /foo/bar /fo -1
 -ancestor /foo/bar /foo:/bar $((4+$root_offset))
 -ancestor /foo/bar /:/foo:/bar $((4+$root_offset))
 -ancestor /foo/bar /foo:/:/bar $((4+$root_offset))
 -ancestor /foo/bar /:/bar:/fo $root_offset
 -ancestor /foo/bar /:/bar $root_offset
 -ancestor /foo/bar /foo $((4+$root_offset))
 -ancestor /foo/bar /foo:/bar $((4+$root_offset))
 +ancestor /foo/bar /foo:/bar 4
 +ancestor /foo/bar /:/foo:/bar 4
 +ancestor /foo/bar /foo:/:/bar 4
 +ancestor /foo/bar /:/bar:/fo 0
 +ancestor /foo/bar /:/bar 0
 +ancestor /foo/bar /foo 4
 +ancestor /foo/bar /foo:/bar 4
  ancestor /foo/bar /bar -1
 =20
  test_expect_success 'strip_path_suffix' '
 diff --git a/t/t1508-at-combinations.sh b/t/t1508-at-combinations.sh
 index 1d9fd7b..c59d554 100755
 --- a/t/t1508-at-combinations.sh
 +++ b/t/t1508-at-combinations.sh
 @@ -29,22 +29,16 @@ fail() {
  =09"$@" failure
  }
 =20
 -if test_have_prereq MINGW
 -then
 -=09# MSYS2 interprets `@/abc` to be a file list, and wants to substitute
 -=09# the Unix-y path with a Windows one (e.g. @C:\msys64\abc)
 -=09AT_SLASH=3D@//at-test
 -else
 -=09AT_SLASH=3D@/at-test
 -fi
 -
  test_expect_success 'setup' '
  =09test_commit master-one &&
  =09test_commit master-two &&
  =09git checkout -b upstream-branch &&
  =09test_commit upstream-one &&
  =09test_commit upstream-two &&
 -=09git checkout -b $AT_SLASH &&
 +=09if ! test_have_prereq MINGW
 +=09then
 +=09=09git checkout -b @/at-slash
 +=09fi &&
  =09git checkout -b @@/at-test &&
  =09git checkout -b @at-test &&
  =09git checkout -b old-branch &&
 @@ -73,7 +67,8 @@ check "@{-1}@{u}@{1}" commit master-one
  check "@" commit new-two
  check "@@{u}" ref refs/heads/upstream-branch
  check "@@/at-test" ref refs/heads/@@/at-test
 -check "$AT_SLASH" ref refs/heads/@/at-test
 +test_have_prereq MINGW ||
 +check "@/at-test" ref refs/heads/@/at-test
  check "@at-test" ref refs/heads/@at-test
  nonsense "@{u}@{-1}"
  nonsense "@{0}@{0}"
 diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
 index 8c74ffa..5b32a3b 100755
 --- a/t/t9100-git-svn-basic.sh
 +++ b/t/t9100-git-svn-basic.sh
 @@ -25,23 +25,12 @@ test_expect_success \
  =09(
  =09=09cd import &&
  =09=09echo foo >foo &&
 -=09=09if test_have_prereq !MINGW
 -=09=09then
 -=09=09=09ln -s foo foo.link
 -=09=09else
 -=09=09=09# MSYS libsvn does not support symlinks, so always use cp, even =
if
 -=09=09=09# ln -s actually works
 -=09=09=09cp foo foo.link
 -=09=09fi
 +=09=09ln -s foo foo.link
  =09=09mkdir -p dir/a/b/c/d/e &&
  =09=09echo "deep dir" >dir/a/b/c/d/e/file &&
  =09=09mkdir bar &&
  =09=09echo "zzz" >bar/zzz &&
 -=09=09echo "#!/bin/sh" >exec.sh &&
 -=09=09{
 -=09=09=09test_have_prereq !POSIXPERM ||
 -=09=09=09chmod +x exec.sh
 -=09=09} &&
 +=09=09printf "" | write_script exec.sh &&
  =09=09svn_cmd import -m "import for git svn" . "$svnrepo" >/dev/null
  =09) &&
  =09rm -rf import &&
 @@ -127,7 +116,7 @@ test_expect_success "$name" '
 =20
 =20
  name=3D'remove executable bit from a file'
 -test_expect_success !MINGW "$name" '
 +test_expect_success POSIXPERM "$name" '
  =09rm -f "$GIT_DIR"/index &&
  =09git checkout -f -b mybranch5 ${remotes_git_svn} &&
  =09chmod -x exec.sh &&
 @@ -140,7 +129,7 @@ test_expect_success !MINGW "$name" '
 =20
 =20
  name=3D'add executable bit back file'
 -test_expect_success !MINGW "$name" '
 +test_expect_success POSIXPERM "$name" '
  =09chmod +x exec.sh &&
  =09git update-index exec.sh &&
  =09git commit -m "$name" &&
 @@ -151,7 +140,7 @@ test_expect_success !MINGW "$name" '
 =20
 =20
  name=3D'executable file becomes a symlink to file'
 -test_expect_success !MINGW "$name" '
 +test_expect_success SYMLINKS "$name" '
  =09rm exec.sh &&
  =09ln -s file exec.sh &&
  =09git update-index exec.sh &&
 @@ -163,7 +152,8 @@ test_expect_success !MINGW "$name" '
 =20
  name=3D'new symlink is added to a file that was also just made executable=
'
 =20
 -test_expect_success !MINGW "$name" '
 +test_expect_success POSIXPERM,SYMLINKS "$name" '
 +=09chmod +x file &&
  =09ln -s file exec-2.sh &&
  =09git update-index --add file exec-2.sh &&
  =09git commit -m "$name" &&
 @@ -174,7 +164,7 @@ test_expect_success !MINGW "$name" '
  =09test -h "$SVN_TREE"/exec-2.sh'
 =20
  name=3D'modify a symlink to become a file'
 -test_expect_success !MINGW "$name" '
 +test_expect_success POSIXPERM,SYMLINKS "$name" '
  =09echo git help >help &&
  =09rm exec-2.sh &&
  =09cp help exec-2.sh &&
 @@ -190,7 +180,8 @@ test_expect_success !MINGW "$name" '
  name=3D"commit with UTF-8 message: locale: $GIT_SVN_LC_ALL"
  LC_ALL=3D"$GIT_SVN_LC_ALL"
  export LC_ALL
 -test_expect_success !MINGW,UTF8 "$name" "
 +# This test relies on the previous test, hence requires POSIXPERM,SYMLINK=
S
 +test_expect_success UTF8,POSIXPERM,SYMLINKS "$name" "
  =09echo '# hello' >> exec-2.sh &&
  =09git update-index exec-2.sh &&
  =09git commit -m '=C3=A9=C3=AF=E2=88=8F' &&
 @@ -223,7 +214,7 @@ tree d667270a1f7b109f5eb3aaea21ede14b56bfdd6e
  tree 8f51f74cf0163afc9ad68a4b1537288c4558b5a4
  EOF
 =20
 -test_expect_success !MINGW "$name" "test_cmp a expected"
 +test_expect_success POSIXPERM,SYMLINKS "$name" "test_cmp a expected"
 =20
  test_expect_success 'exit if remote refs are ambigious' "
          git config --add svn-remote.svn.fetch \
 diff --git a/t/t9118-git-svn-funky-branch-names.sh b/t/t9118-git-svn-funky=
-branch-names.sh
 index 49775a5..ecb1fed 100755
 --- a/t/t9118-git-svn-funky-branch-names.sh
 +++ b/t/t9118-git-svn-funky-branch-names.sh
 @@ -23,11 +23,11 @@ test_expect_success 'setup svnrepo' '
  =09              "$svnrepo/pr ject/branches/$scary_uri" &&
  =09svn_cmd cp -m "leading dot" "$svnrepo/pr ject/trunk" \
  =09=09=09"$svnrepo/pr ject/branches/.leading_dot" &&
 -=09{
 -=09=09test_have_prereq MINGW ||
 +=09if test_have_prereq !MINGW
 +=09then
  =09=09svn_cmd cp -m "trailing dot" "$svnrepo/pr ject/trunk" \
  =09=09=09"$svnrepo/pr ject/branches/trailing_dot."
 -=09} &&
 +=09fi &&
  =09svn_cmd cp -m "trailing .lock" "$svnrepo/pr ject/trunk" \
  =09=09=09"$svnrepo/pr ject/branches/trailing_dotlock.lock" &&
  =09svn_cmd cp -m "reflog" "$svnrepo/pr ject/trunk" \
 @@ -48,10 +48,10 @@ test_expect_success 'test clone with funky branch name=
s' '
  =09=09git rev-parse "refs/remotes/origin/more%20fun%20plugin!" &&
  =09=09git rev-parse "refs/remotes/origin/$scary_ref" &&
  =09=09git rev-parse "refs/remotes/origin/%2Eleading_dot" &&
 -=09=09{
 -=09=09=09test_have_prereq MINGW ||
 +=09=09if test_have_prereq !MINGW
 +=09=09then
  =09=09=09git rev-parse "refs/remotes/origin/trailing_dot%2E"
 -=09=09} &&
 +=09=09fi &&
  =09=09git rev-parse "refs/remotes/origin/trailing_dotlock%2Elock" &&
  =09=09git rev-parse "refs/remotes/origin/$non_reflog"
  =09)
 diff --git a/t/t9124-git-svn-dcommit-auto-props.sh b/t/t9124-git-svn-dcomm=
it-auto-props.sh
 index c851121..2be0805 100755
 --- a/t/t9124-git-svn-dcommit-auto-props.sh
 +++ b/t/t9124-git-svn-dcommit-auto-props.sh
 @@ -34,11 +34,7 @@ test_expect_success 'enable auto-props config' '
  '
 =20
  test_expect_success 'add files matching auto-props' '
 -=09echo "#!$SHELL_PATH" >exec1.sh &&
 -=09{
 -=09=09test_have_prereq !POSIXPERM ||
 -=09=09chmod +x exec1.sh
 -=09} &&
 +=09printf "" | write_script exec1.sh &&
  =09echo "hello" >hello.txt &&
  =09echo bar >bar &&
  =09git add exec1.sh hello.txt bar &&
 @@ -51,11 +47,7 @@ test_expect_success 'disable auto-props config' '
  '
 =20
  test_expect_success 'add files matching disabled auto-props' '
 -=09echo "#$SHELL_PATH" >exec2.sh &&
 -=09{
 -=09=09test_have_prereq !POSIXPERM ||
 -=09=09chmod +x exec2.sh
 -=09} &&
 +=09printf "" | write_script exec2.sh &&
  =09echo "world" >world.txt &&
  =09echo zot >zot &&
  =09git add exec2.sh world.txt zot &&
 @@ -71,10 +63,10 @@ test_expect_success 'check resulting svn repository' '
  =09cd svnrepo &&
 =20
  =09# Check properties from first commit.
 -=09{
 -=09=09test_have_prereq !POSIXPERM ||
 -=09=09test "x$(svn_cmd propget svn:executable exec1.sh)" =3D "x*"
 -=09} &&
 +=09if test_have_prereq POSIXPERM
 +=09then
 +=09=09test -z "$(svn_cmd propget svn:executable exec1.sh)"
 +=09fi &&
  =09test "x$(svn_cmd propget svn:mime-type exec1.sh)" =3D \
  =09     "xapplication/x-shellscript" &&
  =09test "x$(svn_cmd propget svn:mime-type hello.txt)" =3D "xtext/plain" &=
&
 @@ -82,10 +74,10 @@ test_expect_success 'check resulting svn repository' '
  =09test "x$(svn_cmd propget svn:mime-type bar)" =3D "x" &&
 =20
  =09# Check properties from second commit.
 -=09{
 -=09=09test_have_prereq !POSIXPERM ||
 -=09=09test "x$(svn_cmd propget svn:executable exec2.sh)" =3D "x*"
 -=09} &&
 +=09if test_have_prereq POSIXPERM
 +=09then
 +=09=09test -z "$(svn_cmd propget svn:executable exec2.sh)"
 +=09fi &&
  =09test "x$(svn_cmd propget svn:mime-type exec2.sh)" =3D "x" &&
  =09test "x$(svn_cmd propget svn:mime-type world.txt)" =3D "x" &&
  =09test "x$(svn_cmd propget svn:eol-style world.txt)" =3D "x" &&
 diff --git a/t/t9130-git-svn-authors-file.sh b/t/t9130-git-svn-authors-fil=
e.sh
 index 4126481..d306b77 100755
 --- a/t/t9130-git-svn-authors-file.sh
 +++ b/t/t9130-git-svn-authors-file.sh
 @@ -91,7 +91,7 @@ test_expect_success 'fetch continues after authors-file =
is fixed' '
  =09)
  =09'
 =20
 -test_expect_success !MINGW 'fresh clone with svn.authors-file in config' =
'
 +test_expect_success 'fresh clone with svn.authors-file in config' '
  =09(
  =09=09rm -r "$GIT_DIR" &&
  =09=09test x =3D x"$(git config svn.authorsfile)" &&

--=20
2.7.0.windows.1.7.g55a05c8

--8323329-1673539101-1453818849=:2964--
