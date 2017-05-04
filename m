Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C77CB207B3
	for <e@80x24.org>; Thu,  4 May 2017 09:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752064AbdEDJt3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 05:49:29 -0400
Received: from mout.gmx.net ([212.227.17.20]:51651 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751407AbdEDJt0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 05:49:26 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lomql-1dhAxT2tqt-00grud; Thu, 04
 May 2017 11:49:18 +0200
Date:   Thu, 4 May 2017 11:49:15 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v2 0/7] Abide by our own rules regarding line endings
In-Reply-To: <cover.1493728172.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1493891336.git.johannes.schindelin@gmx.de>
References: <cover.1493728172.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:lSGplLFWBg9rtXr+roLLjM6U71Knf42qRkXjLGjhj0OsGuvZgIC
 Totvg+MC1VWZ6bIK9aOyLwqzbxF3RpWgZcc4QWdJnZYVoZ79z6eFaHZMl+QKj5Y1pFnNumD
 BZ2YzabSvvnTr7kd8SblTIVpO8EB8Un3zlU/6MAr82GhzxrYt7VcEGc1Q7DtiCk5bwTRnMw
 3EBPNPrttkeeskDToyIyw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WGV6gTVAOHI=:zfPsvXpJeawMH/4ScxL8/5
 JURD3hRugSDb7ccZj+eYx8anzJwrkd5dQT9ZMU9JicoNuO9YuS+nN5SQ0vTpmPvY56NhC80Lh
 3zMmZGrPOjqWbHxSFaZ5UnVY+CFSohCGAfYNXVm1G0HqR6/eLQBtn/JQNxYYq5Y4U6ORPPZI1
 5bs9882GEZh1OdkLWt+zfabDPyNEVYglfTJew5p6HGGJ2mNadDwN/2LvubdI2C9PZw/LxG0Dt
 FkdgpSieHo0yBVUBbCopIYjn7qwbFynbD4STSMDm8EXQS2Zvu13caqg8femUP5rV5ECNRr9xQ
 ki35OEigm3xQp+IsZxR32HHYYHCTbN0ia4zk2gjE2SCHE0JFlhg45y4flp8xKzE6cSal0BtZ1
 ZkKnfcRjim68WUzI696uBzlS2E/G6C4oK2lG3BnfhveVyP9nR2oDFwrZPxMcYMVRY9Obs6XxI
 sG2wGgV8ALizwHgVzpyj2Fkl5WRta/irpKJa28yeR11gJWpospAU6/rhj0cq0dwG1qtcT3n6G
 vZZKobVySHem/CGzKDZrQfXxOP1JHZbWhTstxbqehrzS9Kj8oWu/GXzwhPJ80CrxLqPKC+8mz
 Fes8b9zzAeGLDGb2nAuZklnpceMYg5rOCuBH3NiSFSU7ksc+hmrL78obU4JGs9G/Z8/+eUmId
 tQtPvFGagzIotg6J9cr2jxgXA7nKv98FkPCw0b5nCPfMDFhs7iTfnUZrlmO+I0S6DDbMyPch9
 iV2P5/1GPv1JYCjqbg6ecEmr6huUr4PEE2mIKJ0l400SF14uByiTBaAWLxDUqHjnphADC+V7J
 JsY3Jkx
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[Cc:ing Jonathan Nieder, who reviewed the first iteration of this patch
series, and Jeff Hostetler who is guilty of prodding me into finishing
this patch series in the first place.]

Over the past decade, there have been a couple of attempts to remedy the
situation regarding line endings (Windows/DOS line endings are
traditionally CR/LF even if many current applications can handle LF,
too, Linux/MacOSX/*BSD/Unix uses LF-only line handlings, and old MacOS
software used to use CR-only line endings).

The current idea seems to be that the default line endings differ
depending on the platform, and for files that should be exempt from that
default, we strongly recommend using .gitattributes to define what the
source code requires.

It is time to heed our own recommendation and mark the files that
require LF-only line endings in our very own .gitattributes.

For starters, those files include shell scripts: the most prevalent
shell interpreter in use (and certainly used in Git for Windows) is
Bash, and Bash does not handle CR/LF line endings gracefully.

There are even two shell scripts that are used in the test suite even if
they are not technically supposed to be part of core Git, as indicated
by their habitat inside contrib/: git-new-workdir and
git-completion.bash.

Related to shell scripts: when generating common-cmds.h, we use tools
that generally operate on the assumption that input and output
deliminate their lines using LF-only line endings. Consequently, they
would happily copy the CR byte verbatim into the strings in
common-cmds.h, which in turn makes the C preprocessor barf (that
interprets them as MacOS-style line endings).

Further, the most obvious required fixes concern tests' support files
committed verbatim, to be compared to Git's output, which is always
LF-only.

There are a few SVN dump files, too, supporting the Subversion-related
tests, requiring LF-only line endings.

Finally, the test suite makes use of text files that are not obviously
supporting tests, such as t/README, comparing them to LF-only versions
(and consequently failing if the files have been checked out with CR/LF
line endings). Therefore we convert those to LF-only versions when
the test hard-codes that expectation.

Without these fixes, Git will fail to build and pass the test suite, as
can be verified even on Linux using this cadence:

	git config core.autocrlf true
	rm .git/index && git stash
	make DEVELOPER=1 -j15 test

Note: I separated out the change marking t/t4051/* as LF-only into an
individual commit for one reason: it would appear that the test passes
if checked out using core.autocrlf=true on Linux, but on Windows the
test fails. In that respect, this test is special, as the other changes
can be easily validated even without using Windows.

Changes since v1:

- the t/t3901-*.txt files have been moved into t/t3901/, in line with
  the de facto convention all other tests follow.

- instead of marking files outside of t/t[0-9]* as LF-only, the
  following tests are now adjusted *not* to expect LF-only line endings
  in files they do not control: t4003, t4005, t4007 & t4008.

- as a consequence, files used in the tests but living outside
  t/t[0-9]*, such as COPYING, etc, are no longer marked as LF-only.

- clarified in the commit message of the last patch why t4051 passes on
  Linux with core.autocrlf=true but not on Windows.


Johannes Schindelin (7):
  Fix build with core.autocrlf=true
  git-new-workdir: mark script as LF-only
  completion: mark bash script as LF-only
  t3901: move supporting files into t/t3901/
  t4003, t4005, t4007 & t4008: handle CR/LF in t/README &
    t/diff-lib/README
  Fix the remaining tests that failed with core.autocrlf=true
  t4051: mark supporting files as requiring LF-only line endings

 .gitattributes                           |  8 ++++++-
 contrib/completion/.gitattributes        |  1 +
 contrib/workdir/.gitattributes           |  1 +
 git-gui/.gitattributes                   |  1 +
 t/.gitattributes                         | 21 +++++++++++++++++-
 t/t0203-gettext-setlocale-sanity.sh      |  4 ++--
 t/t3901-i18n-patch.sh                    | 38 ++++++++++++++++----------------
 t/{t3901-8859-1.txt => t3901/8859-1.txt} |  0
 t/{t3901-utf8.txt => t3901/utf8.txt}     |  0
 t/t4003-diff-rename-1.sh                 |  4 ++--
 t/t4005-diff-rename-2.sh                 |  4 ++--
 t/t4007-rename-3.sh                      |  2 +-
 t/t4008-diff-break-rewrite.sh            |  4 ++--
 t/t9350-fast-export.sh                   |  2 +-
 t/t9500-gitweb-standalone-no-errors.sh   |  4 ++--
 15 files changed, 61 insertions(+), 33 deletions(-)
 create mode 100644 contrib/completion/.gitattributes
 create mode 100644 contrib/workdir/.gitattributes
 rename t/{t3901-8859-1.txt => t3901/8859-1.txt} (100%)
 rename t/{t3901-utf8.txt => t3901/utf8.txt} (100%)


base-commit: d2bbb7c2bcf6e77ebfcabf4e12110fe6d5c91de6
Published-As: https://github.com/dscho/git/releases/tag/lf-attrs-v2
Fetch-It-Via: git fetch https://github.com/dscho/git lf-attrs-v2

Interdiff vs v1:

 diff --git a/t/.gitattributes b/t/.gitattributes
 index 1bdc46a53f1..bdd82cf31f7 100644
 --- a/t/.gitattributes
 +++ b/t/.gitattributes
 @@ -1,9 +1,7 @@
 -README eol=lf
  t[0-9][0-9][0-9][0-9]/* -whitespace
 -/diff-lib/COPYING eol=lf
  /t0110/url-* binary
  /t3900/*.txt eol=lf
 -/t3901*.txt eol=lf
 +/t3901/*.txt eol=lf
  /t4034/*/* eol=lf
  /t4013/* eol=lf
  /t4018/* eol=lf
 @@ -20,10 +18,4 @@ t[0-9][0-9][0-9][0-9]/* -whitespace
  /t556x_common eol=lf
  /t7500/* eol=lf
  /t8005/*.txt eol=lf
 -/t9110/svm.dump eol=lf
 -/t9111/svnsync.dump eol=lf
 -/t9115/funky-names.dump eol=lf
 -/t9121/renamed-dir.dump eol=lf
 -/t913[56]/svn.dump eol=lf
 -/t915[0134]/*.dump eol=lf
 -/t9161/branches.dump eol=lf
 +/t9*/*.dump eol=lf
 diff --git a/t/t0203-gettext-setlocale-sanity.sh b/t/t0203-gettext-setlocale-sanity.sh
 index a2124600811..71b0d74b4dd 100755
 --- a/t/t0203-gettext-setlocale-sanity.sh
 +++ b/t/t0203-gettext-setlocale-sanity.sh
 @@ -8,7 +8,7 @@ test_description="The Git C functions aren't broken by setlocale(3)"
  . ./lib-gettext.sh
  
  test_expect_success 'git show a ISO-8859-1 commit under C locale' '
 -	. "$TEST_DIRECTORY"/t3901-8859-1.txt &&
 +	. "$TEST_DIRECTORY"/t3901/8859-1.txt &&
  	test_commit "iso-c-commit" iso-under-c &&
  	git show >out 2>err &&
  	! test -s err &&
 @@ -16,7 +16,7 @@ test_expect_success 'git show a ISO-8859-1 commit under C locale' '
  '
  
  test_expect_success GETTEXT_LOCALE 'git show a ISO-8859-1 commit under a UTF-8 locale' '
 -	. "$TEST_DIRECTORY"/t3901-8859-1.txt &&
 +	. "$TEST_DIRECTORY"/t3901/8859-1.txt &&
  	test_commit "iso-utf8-commit" iso-under-utf8 &&
  	LANGUAGE=is LC_ALL="$is_IS_locale" git show >out 2>err &&
  	! test -s err &&
 diff --git a/t/t3901-i18n-patch.sh b/t/t3901-i18n-patch.sh
 index f663d567c8a..923eb01f0ea 100755
 --- a/t/t3901-i18n-patch.sh
 +++ b/t/t3901-i18n-patch.sh
 @@ -31,7 +31,7 @@ test_expect_success setup '
  
  	# use UTF-8 in author and committer name to match the
  	# i18n.commitencoding settings
 -	. "$TEST_DIRECTORY"/t3901-utf8.txt &&
 +	. "$TEST_DIRECTORY"/t3901/utf8.txt &&
  
  	test_tick &&
  	echo "$GIT_AUTHOR_NAME" >mine &&
 @@ -55,7 +55,7 @@ test_expect_success setup '
  		# the second one on the side branch is ISO-8859-1
  		git config i18n.commitencoding ISO8859-1 &&
  		# use author and committer name in ISO-8859-1 to match it.
 -		. "$TEST_DIRECTORY"/t3901-8859-1.txt
 +		. "$TEST_DIRECTORY"/t3901/8859-1.txt
  	fi &&
  	test_tick &&
  	echo Yet another >theirs &&
 @@ -100,7 +100,7 @@ test_expect_success 'rebase (U/U)' '
  
  	# The result will be committed by GIT_COMMITTER_NAME --
  	# we want UTF-8 encoded name.
 -	. "$TEST_DIRECTORY"/t3901-utf8.txt &&
 +	. "$TEST_DIRECTORY"/t3901/utf8.txt &&
  	git checkout -b test &&
  	git rebase master &&
  
 @@ -110,7 +110,7 @@ test_expect_success 'rebase (U/U)' '
  test_expect_success 'rebase (U/L)' '
  	git config i18n.commitencoding UTF-8 &&
  	git config i18n.logoutputencoding ISO8859-1 &&
 -	. "$TEST_DIRECTORY"/t3901-utf8.txt &&
 +	. "$TEST_DIRECTORY"/t3901/utf8.txt &&
  
  	git reset --hard side &&
  	git rebase master &&
 @@ -122,7 +122,7 @@ test_expect_success !MINGW 'rebase (L/L)' '
  	# In this test we want ISO-8859-1 encoded commits as the result
  	git config i18n.commitencoding ISO8859-1 &&
  	git config i18n.logoutputencoding ISO8859-1 &&
 -	. "$TEST_DIRECTORY"/t3901-8859-1.txt &&
 +	. "$TEST_DIRECTORY"/t3901/8859-1.txt &&
  
  	git reset --hard side &&
  	git rebase master &&
 @@ -135,7 +135,7 @@ test_expect_success !MINGW 'rebase (L/U)' '
  	# to get ISO-8859-1 results.
  	git config i18n.commitencoding ISO8859-1 &&
  	git config i18n.logoutputencoding UTF-8 &&
 -	. "$TEST_DIRECTORY"/t3901-8859-1.txt &&
 +	. "$TEST_DIRECTORY"/t3901/8859-1.txt &&
  
  	git reset --hard side &&
  	git rebase master &&
 @@ -148,7 +148,7 @@ test_expect_success 'cherry-pick(U/U)' '
  
  	git config i18n.commitencoding UTF-8 &&
  	git config i18n.logoutputencoding UTF-8 &&
 -	. "$TEST_DIRECTORY"/t3901-utf8.txt &&
 +	. "$TEST_DIRECTORY"/t3901/utf8.txt &&
  
  	git reset --hard master &&
  	git cherry-pick side^ &&
 @@ -163,7 +163,7 @@ test_expect_success !MINGW 'cherry-pick(L/L)' '
  
  	git config i18n.commitencoding ISO8859-1 &&
  	git config i18n.logoutputencoding ISO8859-1 &&
 -	. "$TEST_DIRECTORY"/t3901-8859-1.txt &&
 +	. "$TEST_DIRECTORY"/t3901/8859-1.txt &&
  
  	git reset --hard master &&
  	git cherry-pick side^ &&
 @@ -178,7 +178,7 @@ test_expect_success 'cherry-pick(U/L)' '
  
  	git config i18n.commitencoding UTF-8 &&
  	git config i18n.logoutputencoding ISO8859-1 &&
 -	. "$TEST_DIRECTORY"/t3901-utf8.txt &&
 +	. "$TEST_DIRECTORY"/t3901/utf8.txt &&
  
  	git reset --hard master &&
  	git cherry-pick side^ &&
 @@ -194,7 +194,7 @@ test_expect_success !MINGW 'cherry-pick(L/U)' '
  
  	git config i18n.commitencoding ISO8859-1 &&
  	git config i18n.logoutputencoding UTF-8 &&
 -	. "$TEST_DIRECTORY"/t3901-8859-1.txt &&
 +	. "$TEST_DIRECTORY"/t3901/8859-1.txt &&
  
  	git reset --hard master &&
  	git cherry-pick side^ &&
 @@ -207,7 +207,7 @@ test_expect_success !MINGW 'cherry-pick(L/U)' '
  test_expect_success 'rebase --merge (U/U)' '
  	git config i18n.commitencoding UTF-8 &&
  	git config i18n.logoutputencoding UTF-8 &&
 -	. "$TEST_DIRECTORY"/t3901-utf8.txt &&
 +	. "$TEST_DIRECTORY"/t3901/utf8.txt &&
  
  	git reset --hard side &&
  	git rebase --merge master &&
 @@ -218,7 +218,7 @@ test_expect_success 'rebase --merge (U/U)' '
  test_expect_success 'rebase --merge (U/L)' '
  	git config i18n.commitencoding UTF-8 &&
  	git config i18n.logoutputencoding ISO8859-1 &&
 -	. "$TEST_DIRECTORY"/t3901-utf8.txt &&
 +	. "$TEST_DIRECTORY"/t3901/utf8.txt &&
  
  	git reset --hard side &&
  	git rebase --merge master &&
 @@ -230,7 +230,7 @@ test_expect_success 'rebase --merge (L/L)' '
  	# In this test we want ISO-8859-1 encoded commits as the result
  	git config i18n.commitencoding ISO8859-1 &&
  	git config i18n.logoutputencoding ISO8859-1 &&
 -	. "$TEST_DIRECTORY"/t3901-8859-1.txt &&
 +	. "$TEST_DIRECTORY"/t3901/8859-1.txt &&
  
  	git reset --hard side &&
  	git rebase --merge master &&
 @@ -243,7 +243,7 @@ test_expect_success 'rebase --merge (L/U)' '
  	# to get ISO-8859-1 results.
  	git config i18n.commitencoding ISO8859-1 &&
  	git config i18n.logoutputencoding UTF-8 &&
 -	. "$TEST_DIRECTORY"/t3901-8859-1.txt &&
 +	. "$TEST_DIRECTORY"/t3901/8859-1.txt &&
  
  	git reset --hard side &&
  	git rebase --merge master &&
 @@ -254,7 +254,7 @@ test_expect_success 'rebase --merge (L/U)' '
  test_expect_success 'am (U/U)' '
  	# Apply UTF-8 patches with UTF-8 commitencoding
  	git config i18n.commitencoding UTF-8 &&
 -	. "$TEST_DIRECTORY"/t3901-utf8.txt &&
 +	. "$TEST_DIRECTORY"/t3901/utf8.txt &&
  
  	git reset --hard master &&
  	git am out-u1 out-u2 &&
 @@ -265,7 +265,7 @@ test_expect_success 'am (U/U)' '
  test_expect_success !MINGW 'am (L/L)' '
  	# Apply ISO-8859-1 patches with ISO-8859-1 commitencoding
  	git config i18n.commitencoding ISO8859-1 &&
 -	. "$TEST_DIRECTORY"/t3901-8859-1.txt &&
 +	. "$TEST_DIRECTORY"/t3901/8859-1.txt &&
  
  	git reset --hard master &&
  	git am out-l1 out-l2 &&
 @@ -276,7 +276,7 @@ test_expect_success !MINGW 'am (L/L)' '
  test_expect_success 'am (U/L)' '
  	# Apply ISO-8859-1 patches with UTF-8 commitencoding
  	git config i18n.commitencoding UTF-8 &&
 -	. "$TEST_DIRECTORY"/t3901-utf8.txt &&
 +	. "$TEST_DIRECTORY"/t3901/utf8.txt &&
  	git reset --hard master &&
  
  	# am specifies --utf8 by default.
 @@ -288,7 +288,7 @@ test_expect_success 'am (U/L)' '
  test_expect_success 'am --no-utf8 (U/L)' '
  	# Apply ISO-8859-1 patches with UTF-8 commitencoding
  	git config i18n.commitencoding UTF-8 &&
 -	. "$TEST_DIRECTORY"/t3901-utf8.txt &&
 +	. "$TEST_DIRECTORY"/t3901/utf8.txt &&
  
  	git reset --hard master &&
  	git am --no-utf8 out-l1 out-l2 2>err &&
 @@ -303,7 +303,7 @@ test_expect_success 'am --no-utf8 (U/L)' '
  test_expect_success !MINGW 'am (L/U)' '
  	# Apply UTF-8 patches with ISO-8859-1 commitencoding
  	git config i18n.commitencoding ISO8859-1 &&
 -	. "$TEST_DIRECTORY"/t3901-8859-1.txt &&
 +	. "$TEST_DIRECTORY"/t3901/8859-1.txt &&
  
  	git reset --hard master &&
  	# mailinfo will re-code the commit message to the charset specified by
 diff --git a/t/t3901-8859-1.txt b/t/t3901/8859-1.txt
 similarity index 100%
 rename from t/t3901-8859-1.txt
 rename to t/t3901/8859-1.txt
 diff --git a/t/t3901-utf8.txt b/t/t3901/utf8.txt
 similarity index 100%
 rename from t/t3901-utf8.txt
 rename to t/t3901/utf8.txt
 diff --git a/t/t4003-diff-rename-1.sh b/t/t4003-diff-rename-1.sh
 index df2accb6555..c3e0a3c3fc9 100755
 --- a/t/t4003-diff-rename-1.sh
 +++ b/t/t4003-diff-rename-1.sh
 @@ -11,7 +11,7 @@ test_description='More rename detection
  
  test_expect_success \
      'prepare reference tree' \
 -    'cat "$TEST_DIRECTORY"/diff-lib/COPYING >COPYING &&
 +    'tr -d "\015" <"$TEST_DIRECTORY"/diff-lib/COPYING >COPYING &&
       echo frotz >rezrov &&
      git update-index --add COPYING rezrov &&
      tree=$(git write-tree) &&
 @@ -99,7 +99,7 @@ test_expect_success \
  
  test_expect_success \
      'prepare work tree once again' \
 -    'cat "$TEST_DIRECTORY"/diff-lib/COPYING >COPYING &&
 +    'tr -d "\015" <"$TEST_DIRECTORY"/diff-lib/COPYING >COPYING &&
       git update-index --add --remove COPYING COPYING.1'
  
  # tree has COPYING and rezrov.  work tree has COPYING and COPYING.1,
 diff --git a/t/t4005-diff-rename-2.sh b/t/t4005-diff-rename-2.sh
 index 135addbfbda..f1641c35ee2 100755
 --- a/t/t4005-diff-rename-2.sh
 +++ b/t/t4005-diff-rename-2.sh
 @@ -11,7 +11,7 @@ test_description='Same rename detection as t4003 but testing diff-raw.
  
  test_expect_success \
      'prepare reference tree' \
 -    'cat "$TEST_DIRECTORY"/diff-lib/COPYING >COPYING &&
 +    'tr -d "\015" <"$TEST_DIRECTORY"/diff-lib/COPYING >COPYING &&
       echo frotz >rezrov &&
      git update-index --add COPYING rezrov &&
      tree=$(git write-tree) &&
 @@ -71,7 +71,7 @@ test_expect_success \
  
  test_expect_success \
      'prepare work tree once again' \
 -    'cat "$TEST_DIRECTORY"/diff-lib/COPYING >COPYING &&
 +    'tr -d "\015" <"$TEST_DIRECTORY"/diff-lib/COPYING >COPYING &&
       git update-index --add --remove COPYING COPYING.1'
  
  git diff-index -C --find-copies-harder $tree >current
 diff --git a/t/t4007-rename-3.sh b/t/t4007-rename-3.sh
 index dae327fabbf..0157fde5503 100755
 --- a/t/t4007-rename-3.sh
 +++ b/t/t4007-rename-3.sh
 @@ -11,7 +11,7 @@ test_description='Rename interaction with pathspec.
  
  test_expect_success 'prepare reference tree' '
  	mkdir path0 path1 &&
 -	cp "$TEST_DIRECTORY"/diff-lib/COPYING path0/COPYING &&
 +	tr -d "\015" <"$TEST_DIRECTORY"/diff-lib/COPYING >path0/COPYING &&
  	git update-index --add path0/COPYING &&
  	tree=$(git write-tree) &&
  	echo $tree
 diff --git a/t/t4008-diff-break-rewrite.sh b/t/t4008-diff-break-rewrite.sh
 index 9dd1bc5e162..5af4fa6aadb 100755
 --- a/t/t4008-diff-break-rewrite.sh
 +++ b/t/t4008-diff-break-rewrite.sh
 @@ -25,8 +25,8 @@ Further, with -B and -M together, these should turn into two renames.
  . "$TEST_DIRECTORY"/diff-lib.sh ;# test-lib chdir's into trash
  
  test_expect_success setup '
 -	cat "$TEST_DIRECTORY"/diff-lib/README >file0 &&
 -	cat "$TEST_DIRECTORY"/diff-lib/COPYING >file1 &&
 +	tr -d "\015" <"$TEST_DIRECTORY"/diff-lib/README >file0 &&
 +	tr -d "\015" <"$TEST_DIRECTORY"/diff-lib/COPYING >file1 &&
  	git update-index --add file0 file1 &&
  	git tag reference $(git write-tree)
  '
 diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
 index b5149fde6ec..8dcb05c4a57 100755
 --- a/t/t9350-fast-export.sh
 +++ b/t/t9350-fast-export.sh
 @@ -70,7 +70,7 @@ test_expect_success 'iso-8859-1' '
  
  	git config i18n.commitencoding ISO8859-1 &&
  	# use author and committer name in ISO-8859-1 to match it.
 -	. "$TEST_DIRECTORY"/t3901-8859-1.txt &&
 +	. "$TEST_DIRECTORY"/t3901/8859-1.txt &&
  	test_tick &&
  	echo rosten >file &&
  	git commit -s -m den file &&
 diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
 index 6d06ed96cbc..cc8d463e01a 100755
 --- a/t/t9500-gitweb-standalone-no-errors.sh
 +++ b/t/t9500-gitweb-standalone-no-errors.sh
 @@ -519,7 +519,7 @@ test_expect_success \
  
  test_expect_success \
  	'encode(commit): utf8' \
 -	'. "$TEST_DIRECTORY"/t3901-utf8.txt &&
 +	'. "$TEST_DIRECTORY"/t3901/utf8.txt &&
  	 test_when_finished "GIT_AUTHOR_NAME=\"A U Thor\"" &&
  	 test_when_finished "GIT_COMMITTER_NAME=\"C O Mitter\"" &&
  	 echo "UTF-8" >> file &&
 @@ -529,7 +529,7 @@ test_expect_success \
  
  test_expect_success \
  	'encode(commit): iso-8859-1' \
 -	'. "$TEST_DIRECTORY"/t3901-8859-1.txt &&
 +	'. "$TEST_DIRECTORY"/t3901/8859-1.txt &&
  	 test_when_finished "GIT_AUTHOR_NAME=\"A U Thor\"" &&
  	 test_when_finished "GIT_COMMITTER_NAME=\"C O Mitter\"" &&
  	 echo "ISO-8859-1" >> file &&

-- 
2.12.2.windows.2.800.gede8f145e06

