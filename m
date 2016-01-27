From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 00/20] Let Git's tests pass on Windows
Date: Wed, 27 Jan 2016 17:19:02 +0100 (CET)
Message-ID: <cover.1453911367.git.johannes.schindelin@gmx.de>
References: <cover.1453818789.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-465891087-1453911543=:2964"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 17:19:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOSoO-0001mL-4G
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 17:19:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933377AbcA0QTL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 11:19:11 -0500
Received: from mout.gmx.net ([212.227.17.20]:62627 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932256AbcA0QTJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 11:19:09 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0Me5Q2-1ajqjx3bKA-00PvyP; Wed, 27 Jan 2016 17:19:03
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1453818789.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:L0iyXlA94ygDPUqYfXCIllI4L5MFB7pv2aymjnP9lwh3Z6sG+hz
 MeEAGa5yI2y5Nk5XU2KJeqzDuAcVhFRL4cTikxPAhiIgL5lyjBvi5BMeTIvqMFUQ2YNh6Fi
 0w2aLudJRcn8ptjGGQPxGgslZWSox95mrk7RtfOW1s0Zgobmqmu4xXoPe0OOM1QIsnpFoTt
 Mg8oZo0WmfY4E4KQcxgxw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Mt7fQLDLhs4=:3IyxNWgcSvl5rI8R7T0i4J
 13BU9KHoBzx0gOiV/TExb4jGeQlCLm5OH5guREp57xRX5kKV/yRULypYOEQ0BBSxbKTC1Mx1q
 Gspd015xG2aFCHkyW23qcVUWp+c61exGlBO1FYKqMsxrnkY15bACL03w05m3FEcW99nKEXEL5
 0IegH8pJA7TOxQRL5q+g8WeqY5i9IsxTnD9oPSPIob9xGpORGMzapKDShJH7+YCBC+JP7UiGq
 cDnwxgAFRVtJT4r+Njofpx7XNk46rLJp0xh4UIoGQjWL4NWVSKFS881yYLBGJjCVRj1TnhS1j
 qLAH76/aitUCHg4+W9wbs5XjNh2SPi2Nf4LA7ZbRxDDQPRoLaOROBMcN+2bYDLbcxHKh8jwVm
 UHFCK2vWJOwjiZeGbhjRK6JidawaPjT1cylnzECfVLVMGbgZg4Q1Ysp5j9nBHVjKreEZThcNa
 xDrKH0kHinh5/fPm5pNLzPrwDeOJWRESVbLu8lazJ9hhn2maVxkB+OQqcVAoGl2OPyS/8Yi7a
 i9KagaWyQPA+kTozyh8qPWuRaSqbW1sXManKK9g6s4z+CwKJSvmfQbyU5eg/ofnIs7AZmMQ2D
 JVC7EunKiKFPDX/hWE2tSfNdkYnoBw9Fmv+CC+JEtsEDUhyyNPH+e+/dt/hnA1HkKfgWPfVDQ
 TSAZcKD6UbFcCHZpWEDWFVGSTRx8ZAVUQeH2Uu5ngj4Sr106bcDx6GlWYxbAiReaJLjWacdx+
 C1Ma4wABMUzgOi9Li6KXfFIFmpDNYWHfnrnLSEve11El67UJ/vfEAlWksScwMlo6uQ9iG3A5 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284920>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-465891087-1453911543=:2964
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

Relative to v2, this fixes stupid typos that made the tests fail on
Linux, a stupid copy-paste error pointed out by Eric Sunshine,
unnecessary 'printf ""' calls pointed out by Junio Hamano, and I now
use `test_have_prereq !MINGW` consistently, as pointed out by both Eric
and Junio. This time, I also send the patch series with the character
set set (sic!) to UTF-8. Oh, and this time, I also made sure that the
regression tests pass on Windows & Linux alike. Oh, and I also managed not
to forget the fix for t9130 this time.


Johannes Schindelin (17):
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
  mingw: skip a test in t9130 that cannot pass on Windows
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
 t/t3600-rm.sh                         |  2 +-
 t/t3703-add-magic-pathspec.sh         |  2 +-
 t/t3902-quoted.sh                     |  1 +
 t/t4016-diff-quote.sh                 |  1 +
 t/t4135-apply-weird-filenames.sh      |  3 +-
 t/t5601-clone.sh                      | 18 +++----
 t/t7800-difftool.sh                   | 14 +++---
 t/t9100-git-svn-basic.sh              | 18 +++----
 t/t9118-git-svn-funky-branch-names.sh | 12 +++--
 t/t9124-git-svn-dcommit-auto-props.sh | 16 +++---
 t/t9130-git-svn-authors-file.sh       |  2 +-
 t/t9200-git-cvsexportcommit.sh        |  2 +-
 t/t9400-git-cvsserver-server.sh       |  6 +--
 t/t9401-git-cvsserver-crlf.sh         |  6 +--
 t/t9402-git-cvsserver-refs.sh         |  6 +--
 t/t9700/test.pl                       |  2 +-
 t/t9903-bash-prompt.sh                |  2 +-
 t/test-lib.sh                         |  2 +-
 test-fake-ssh.c                       | 30 ++++++++++++
 28 files changed, 196 insertions(+), 70 deletions(-)
 create mode 100644 test-fake-ssh.c

Interdiff vs v2:

 diff --git a/t/t1508-at-combinations.sh b/t/t1508-at-combinations.sh
 index c59d554..4a9964e 100755
 --- a/t/t1508-at-combinations.sh
 +++ b/t/t1508-at-combinations.sh
 @@ -35,9 +35,9 @@ test_expect_success 'setup' '
  =09git checkout -b upstream-branch &&
  =09test_commit upstream-one &&
  =09test_commit upstream-two &&
 -=09if ! test_have_prereq MINGW
 +=09if test_have_prereq !MINGW
  =09then
 -=09=09git checkout -b @/at-slash
 +=09=09git checkout -b @/at-test
  =09fi &&
  =09git checkout -b @@/at-test &&
  =09git checkout -b @at-test &&
 diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
 index 5232ee9..d046d98 100755
 --- a/t/t3600-rm.sh
 +++ b/t/t3600-rm.sh
 @@ -14,8 +14,7 @@ test_expect_success \
       git add -- foo bar baz 'space embedded' -q &&
       git commit -m 'add normal files'"
 =20
 -
 -if ! test_have_prereq MINGW && touch -- 'tab=09embedded' 'newline
 +if test_have_prereq !MINGW && touch -- 'tab=09embedded' 'newline
  embedded' 2>/dev/null
  then
  =09test_set_prereq FUNNYNAMES
 diff --git a/t/t3703-add-magic-pathspec.sh b/t/t3703-add-magic-pathspec.sh
 index aaff784..3ef525a 100755
 --- a/t/t3703-add-magic-pathspec.sh
 +++ b/t/t3703-add-magic-pathspec.sh
 @@ -38,7 +38,7 @@ cat >expected <<EOF
  add 'sub/foo'
  EOF
 =20
 -if ! test_have_prereq MINGW && mkdir ":" 2>/dev/null
 +if test_have_prereq !MINGW && mkdir ":" 2>/dev/null
  then
  =09test_set_prereq COLON_DIR
  fi
 diff --git a/t/t4135-apply-weird-filenames.sh b/t/t4135-apply-weird-filena=
mes.sh
 index 6d6b96d..27cb000 100755
 --- a/t/t4135-apply-weird-filenames.sh
 +++ b/t/t4135-apply-weird-filenames.sh
 @@ -19,7 +19,7 @@ test_expect_success 'setup' '
 =20
  =09test_when_finished "rm -f \"tab=09embedded.txt\"" &&
  =09test_when_finished "rm -f '\''\"quoteembedded\".txt'\''" &&
 -=09if ! test_have_prereq MINGW &&
 +=09if test_have_prereq !MINGW &&
  =09=09touch -- "tab=09embedded.txt" '\''"quoteembedded".txt'\''
  =09then
  =09=09test_set_prereq FUNNYNAMES
 diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
 index 2f4272a..c1efb8e 100755
 --- a/t/t5601-clone.sh
 +++ b/t/t5601-clone.sh
 @@ -5,7 +5,7 @@ test_description=3Dclone
  . ./test-lib.sh
 =20
  X=3D
 -! test_have_prereq MINGW || X=3D.exe
 +test_have_prereq !MINGW || X=3D.exe
 =20
  test_expect_success setup '
 =20
 diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
 index 5b32a3b..56acc1e 100755
 --- a/t/t9100-git-svn-basic.sh
 +++ b/t/t9100-git-svn-basic.sh
 @@ -30,7 +30,7 @@ test_expect_success \
  =09=09echo "deep dir" >dir/a/b/c/d/e/file &&
  =09=09mkdir bar &&
  =09=09echo "zzz" >bar/zzz &&
 -=09=09printf "" | write_script exec.sh &&
 +=09=09write_script exec.sh </dev/null &&
  =09=09svn_cmd import -m "import for git svn" . "$svnrepo" >/dev/null
  =09) &&
  =09rm -rf import &&
 diff --git a/t/t9124-git-svn-dcommit-auto-props.sh b/t/t9124-git-svn-dcomm=
it-auto-props.sh
 index 2be0805..9f7231d 100755
 --- a/t/t9124-git-svn-dcommit-auto-props.sh
 +++ b/t/t9124-git-svn-dcommit-auto-props.sh
 @@ -34,7 +34,7 @@ test_expect_success 'enable auto-props config' '
  '
 =20
  test_expect_success 'add files matching auto-props' '
 -=09printf "" | write_script exec1.sh &&
 +=09write_script exec1.sh </dev/null &&
  =09echo "hello" >hello.txt &&
  =09echo bar >bar &&
  =09git add exec1.sh hello.txt bar &&
 @@ -47,7 +47,7 @@ test_expect_success 'disable auto-props config' '
  '
 =20
  test_expect_success 'add files matching disabled auto-props' '
 -=09printf "" | write_script exec2.sh &&
 +=09write_script exec2.sh </dev/null &&
  =09echo "world" >world.txt &&
  =09echo zot >zot &&
  =09git add exec2.sh world.txt zot &&
 @@ -65,7 +65,7 @@ test_expect_success 'check resulting svn repository' '
  =09# Check properties from first commit.
  =09if test_have_prereq POSIXPERM
  =09then
 -=09=09test -z "$(svn_cmd propget svn:executable exec1.sh)"
 +=09=09test "x$(svn_cmd propget svn:executable exec1.sh)" =3D "x*"
  =09fi &&
  =09test "x$(svn_cmd propget svn:mime-type exec1.sh)" =3D \
  =09     "xapplication/x-shellscript" &&
 @@ -76,7 +76,7 @@ test_expect_success 'check resulting svn repository' '
  =09# Check properties from second commit.
  =09if test_have_prereq POSIXPERM
  =09then
 -=09=09test -z "$(svn_cmd propget svn:executable exec2.sh)"
 +=09=09test "x$(svn_cmd propget svn:executable exec2.sh)" =3D "x*"
  =09fi &&
  =09test "x$(svn_cmd propget svn:mime-type exec2.sh)" =3D "x" &&
  =09test "x$(svn_cmd propget svn:mime-type world.txt)" =3D "x" &&
 diff --git a/t/t9130-git-svn-authors-file.sh b/t/t9130-git-svn-authors-fil=
e.sh
 index d306b77..4126481 100755
 --- a/t/t9130-git-svn-authors-file.sh
 +++ b/t/t9130-git-svn-authors-file.sh
 @@ -91,7 +91,7 @@ test_expect_success 'fetch continues after authors-file =
is fixed' '
  =09)
  =09'
 =20
 -test_expect_success 'fresh clone with svn.authors-file in config' '
 +test_expect_success !MINGW 'fresh clone with svn.authors-file in config' =
'
  =09(
  =09=09rm -r "$GIT_DIR" &&
  =09=09test x =3D x"$(git config svn.authorsfile)" &&
 diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
 index 2ee6564..ffbfa0e 100755
 --- a/t/t9903-bash-prompt.sh
 +++ b/t/t9903-bash-prompt.sh
 @@ -67,7 +67,7 @@ repo_with_newline=3D'repo
  with
  newline'
 =20
 -if ! test_have_prereq MINGW && mkdir "$repo_with_newline" 2>/dev/null
 +if test_have_prereq !MINGW && mkdir "$repo_with_newline" 2>/dev/null
  then
  =09test_set_prereq FUNNYNAMES
  else

--=20
2.7.0.windows.1.7.g55a05c8

--8323329-465891087-1453911543=:2964--
