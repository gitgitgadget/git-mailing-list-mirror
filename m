Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1644A1FDEA
	for <e@80x24.org>; Tue,  9 May 2017 12:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754076AbdEIMxg (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 08:53:36 -0400
Received: from mout.gmx.net ([212.227.17.21]:50714 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753105AbdEIMxf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 08:53:35 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MHbpA-1dBMxO3yTk-003JdI; Tue, 09
 May 2017 14:53:19 +0200
Date:   Tue, 9 May 2017 14:53:17 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v3 0/6] Abide by our own rules regarding line endings
In-Reply-To: <cover.1493891336.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1494334366.git.johannes.schindelin@gmx.de>
References: <cover.1493891336.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:0qTe+jQsf0YGJzCpOdSYWugROT4d/1WhZ3iTtpwhlKiKFJPHuyr
 x/6vTIJnGYfhnrNCosUCvnYwSbF712b/sWHhFaQ91qRPecXKNQ+TOFab9i/Rl2LUbuGuAHX
 uaOsDNQZqI6l3wYQW6U77d8T0LXCpxcmcB5BvGWBK2hNtaxMjHWNhpPb7yFgBkon1lzqeh3
 FQoHHnMslOYqjvyzXCU2A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KaS7zroe4Ug=:iiDBZT/k8Gs3gRoncpcmJ2
 KQ0u03jQU4UiAzDPyb4sBcls+wzSp+sOQEs/BvTuO4NxHZ5Y/QhBm78MOk3S3Ccy3x7DvmE+S
 j8twoA/7UhpQHwWO05e2ru1jhPar0QtkcRn2mMfMUskNa07v3CzVI61d5kCjN1Xnb2wfKFga5
 mqcScCvEY9kyJMLkqQfwmoiLsgZzGZUE3C3UfX2eSfCTej3coCA+G2bTXnVahhI//vUhrcrRz
 vUCpkH5zxFUph5au5IQUf/8yQFDs/vp9QEXV5R7ZxnjCATjP33nhxCy7GMteuO/iWrYBXVxub
 V78FcmRrB8jQ5qFeK1d5YNpJ+yfpYgllaPM6pjzkJlkj2Q3cHJekLiwfsrNVWGEgOtzsKo+xd
 n+jR5vRmVaqk3MMDpsSm07bxoe+W4FQxshJ0/5+q15yTAwuPAMCMrw655jF2gv8fYmWL1MXhY
 emH72h+koafQKAl47VvQXsm/WbMELhmcFkdsuGvjZmS9FjyKlg7qO2HY+EYeY+VT5vFL+iBU3
 XNCBaif0KCc75Q++Zh8TXcMb0l7wkv4vOvV9QDfeHBMYMNTZah97vy6lKSsFzJ9Ycy++ZDHPO
 2GmdBV3l3+pvgBvD5SibNTjuzb7wCwRum0JwUQ9r7x3gdgAWek7AcfWb36nA9Dd/FTTc7gdVO
 akUYkdAaeI/voeOnA7QXJ+2gtoVfZ3vOKihZ1d2vZ5YNDOEjsv9ss+QH+oY8jz0r32QgPJK64
 ZvPfKuNY3H8szTGHqKRdhmvvOiwa2hT/io4VikTBlJOT52Y0+U4HE6lsu4MwKWRrNOQv2Z4Pu
 cexfrJM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
LF-only. This includes the two files in t/diff-lib/ (which does not, in
fact contain library functions as suggested by its name, but a copy of
the README and the COPYING files, specifically for use in the tests).

There are a few SVN dump files, too, supporting the Subversion-related
tests, requiring LF-only line endings.

Without these fixes, Git will fail to build and pass the test suite, as
can be verified even on Linux using this cadence:

	git config core.autocrlf true
	rm .git/index && git stash
	make DEVELOPER=1 -j15 test

Note: I separated out the change marking t/t4051/* as LF-only into an
individual commit for one reason: it would appear that some grep builds
on Windows automagically convert CR/LF input into LF-only output. I went
the easy route to work around this issue, as I do not want to bother
changing MSYS2 grep's behavior.

Changes since v2:

- marked t/diff-lib/* as LF-only, dropping the ugly `tr -d "\015"` patch.


Johannes Schindelin (6):
  Fix build with core.autocrlf=true
  git-new-workdir: mark script as LF-only
  completion: mark bash script as LF-only
  t3901: move supporting files into t/t3901/
  Fix the remaining tests that failed with core.autocrlf=true
  t4051: mark supporting files as requiring LF-only line endings

 .gitattributes                           |  8 ++++++-
 contrib/completion/.gitattributes        |  1 +
 contrib/workdir/.gitattributes           |  1 +
 git-gui/.gitattributes                   |  1 +
 t/.gitattributes                         | 22 +++++++++++++++++-
 t/t0203-gettext-setlocale-sanity.sh      |  4 ++--
 t/t3901-i18n-patch.sh                    | 38 ++++++++++++++++----------------
 t/{t3901-8859-1.txt => t3901/8859-1.txt} |  0
 t/{t3901-utf8.txt => t3901/utf8.txt}     |  0
 t/t9350-fast-export.sh                   |  2 +-
 t/t9500-gitweb-standalone-no-errors.sh   |  4 ++--
 11 files changed, 55 insertions(+), 26 deletions(-)
 create mode 100644 contrib/completion/.gitattributes
 create mode 100644 contrib/workdir/.gitattributes
 rename t/{t3901-8859-1.txt => t3901/8859-1.txt} (100%)
 rename t/{t3901-utf8.txt => t3901/utf8.txt} (100%)


base-commit: 9b669787fc6ebc527df9ad058c4bcaf46bacc267
Published-As: https://github.com/dscho/git/releases/tag/lf-attrs-v3
Fetch-It-Via: git fetch https://github.com/dscho/git lf-attrs-v3

Interdiff vs v2:

 diff --git a/t/.gitattributes b/t/.gitattributes
 index bdd82cf31f7..3bd959ae523 100644
 --- a/t/.gitattributes
 +++ b/t/.gitattributes
 @@ -1,4 +1,5 @@
  t[0-9][0-9][0-9][0-9]/* -whitespace
 +/diff-lib/* eol=lf
  /t0110/url-* binary
  /t3900/*.txt eol=lf
  /t3901/*.txt eol=lf
 diff --git a/t/t4003-diff-rename-1.sh b/t/t4003-diff-rename-1.sh
 index c3e0a3c3fc9..df2accb6555 100755
 --- a/t/t4003-diff-rename-1.sh
 +++ b/t/t4003-diff-rename-1.sh
 @@ -11,7 +11,7 @@ test_description='More rename detection
  
  test_expect_success \
      'prepare reference tree' \
 -    'tr -d "\015" <"$TEST_DIRECTORY"/diff-lib/COPYING >COPYING &&
 +    'cat "$TEST_DIRECTORY"/diff-lib/COPYING >COPYING &&
       echo frotz >rezrov &&
      git update-index --add COPYING rezrov &&
      tree=$(git write-tree) &&
 @@ -99,7 +99,7 @@ test_expect_success \
  
  test_expect_success \
      'prepare work tree once again' \
 -    'tr -d "\015" <"$TEST_DIRECTORY"/diff-lib/COPYING >COPYING &&
 +    'cat "$TEST_DIRECTORY"/diff-lib/COPYING >COPYING &&
       git update-index --add --remove COPYING COPYING.1'
  
  # tree has COPYING and rezrov.  work tree has COPYING and COPYING.1,
 diff --git a/t/t4005-diff-rename-2.sh b/t/t4005-diff-rename-2.sh
 index f1641c35ee2..135addbfbda 100755
 --- a/t/t4005-diff-rename-2.sh
 +++ b/t/t4005-diff-rename-2.sh
 @@ -11,7 +11,7 @@ test_description='Same rename detection as t4003 but testing diff-raw.
  
  test_expect_success \
      'prepare reference tree' \
 -    'tr -d "\015" <"$TEST_DIRECTORY"/diff-lib/COPYING >COPYING &&
 +    'cat "$TEST_DIRECTORY"/diff-lib/COPYING >COPYING &&
       echo frotz >rezrov &&
      git update-index --add COPYING rezrov &&
      tree=$(git write-tree) &&
 @@ -71,7 +71,7 @@ test_expect_success \
  
  test_expect_success \
      'prepare work tree once again' \
 -    'tr -d "\015" <"$TEST_DIRECTORY"/diff-lib/COPYING >COPYING &&
 +    'cat "$TEST_DIRECTORY"/diff-lib/COPYING >COPYING &&
       git update-index --add --remove COPYING COPYING.1'
  
  git diff-index -C --find-copies-harder $tree >current
 diff --git a/t/t4007-rename-3.sh b/t/t4007-rename-3.sh
 index 0157fde5503..dae327fabbf 100755
 --- a/t/t4007-rename-3.sh
 +++ b/t/t4007-rename-3.sh
 @@ -11,7 +11,7 @@ test_description='Rename interaction with pathspec.
  
  test_expect_success 'prepare reference tree' '
  	mkdir path0 path1 &&
 -	tr -d "\015" <"$TEST_DIRECTORY"/diff-lib/COPYING >path0/COPYING &&
 +	cp "$TEST_DIRECTORY"/diff-lib/COPYING path0/COPYING &&
  	git update-index --add path0/COPYING &&
  	tree=$(git write-tree) &&
  	echo $tree
 diff --git a/t/t4008-diff-break-rewrite.sh b/t/t4008-diff-break-rewrite.sh
 index 5af4fa6aadb..9dd1bc5e162 100755
 --- a/t/t4008-diff-break-rewrite.sh
 +++ b/t/t4008-diff-break-rewrite.sh
 @@ -25,8 +25,8 @@ Further, with -B and -M together, these should turn into two renames.
  . "$TEST_DIRECTORY"/diff-lib.sh ;# test-lib chdir's into trash
  
  test_expect_success setup '
 -	tr -d "\015" <"$TEST_DIRECTORY"/diff-lib/README >file0 &&
 -	tr -d "\015" <"$TEST_DIRECTORY"/diff-lib/COPYING >file1 &&
 +	cat "$TEST_DIRECTORY"/diff-lib/README >file0 &&
 +	cat "$TEST_DIRECTORY"/diff-lib/COPYING >file1 &&
  	git update-index --add file0 file1 &&
  	git tag reference $(git write-tree)
  '

-- 
2.12.2.windows.2.800.gede8f145e06

