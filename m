Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E5801F453
	for <e@80x24.org>; Wed, 23 Jan 2019 14:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbfAWOkR (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 09:40:17 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38781 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbfAWOkR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 09:40:17 -0500
Received: by mail-ed1-f67.google.com with SMTP id h50so1880907ede.5
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 06:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aJrekr0Ks4qmNP9E8tgTThdOIos+6tIg4L3IgJ9XQlI=;
        b=PJHLY9j1i/f1ONFu+O6aurPTu2iU/cGu/t9tS7un8Ky6k7NuSnCnlXsYQAB4A23PK8
         N4A4ShnMJzfOFU2ll8Tg9VRrRAlE1sbplWOG2Whb4isg4ArhWBt6lOuVe/vJ2Mm9E3s+
         A3w3rSddVbBm5wbXtslimC+UHaCroofJ9JOjbfXA5wPU2/idGUEb11+3OyLCXYayytdT
         OFji9zGTLyhCBXhibHk9m5KUd/amzF6VIvTdJhNDjgXgXzDVA4veaIAOzaCzInvD5Zv+
         PHriXVRR0YEubvbbkylal5ZslXF3FU7BgdCxHh0PQcg+405kmrvz3DcoDfTFIV68h0dT
         erwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=aJrekr0Ks4qmNP9E8tgTThdOIos+6tIg4L3IgJ9XQlI=;
        b=FWi6ybJRegpToxFoihfEm+2jFBtcWDSFoJqE0/i8qTPv4KYUmvRfOuxftsgY0OIDbX
         EAEaUWXXhepO6dwEzz4qzimkbSDc780/ghgrHNWathRy4SUOftC/u6NsPcdDUzHBrEmZ
         TcVNs7BXtL5TYxUpqO7IA91G3tDkxcwU8HZ1TxsdBWYyqHVgbuIl406tB7GYExhuA9Nm
         Kw2yazxOcFmw1eliwnV4iJ+rIy+8ZRmxRJx+jZCN88ynknBfnh11XP+4/+PoL3O1GkUZ
         w94Sj5N4V52hil5uYJuRvmbaTs645rYyQZ8kyhkTvfDFwqw3qjviVB0yh1wTI/uzykVb
         DOfg==
X-Gm-Message-State: AJcUukdGOgoAEgUzPMaG1QX/cD/mNRC+fMIvMnQ1PjwFGIViQZm893em
        JmfvJLom6mFndTSUKYXNAXUkGysA
X-Google-Smtp-Source: ALg8bN7YpToBejwEtnJLwaxBOhx8p7+ZGsuuYL5zVi6Pmk9Qg5I371Wu0uJIjl+mj2RK+jFsJwLX2w==
X-Received: by 2002:aa7:ccc8:: with SMTP id y8mr2826271edt.118.1548254414146;
        Wed, 23 Jan 2019 06:40:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p21sm9978176edr.67.2019.01.23.06.40.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 06:40:13 -0800 (PST)
Date:   Wed, 23 Jan 2019 06:40:13 -0800 (PST)
X-Google-Original-Date: Wed, 23 Jan 2019 14:39:51 GMT
Message-Id: <pull.31.v4.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v3.git.gitgitgadget@gmail.com>
References: <pull.31.v3.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 00/21] Offer to run CI/PR builds in Azure Pipelines
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For a long time already, we have tested Git's source code continuously via
Travis CI, see e.g. https://travis-ci.org/git/git/builds/421738884. It has
served us well, and more and more developers actually pay attention and
benefit from the testing this gives us.

It is also an invaluable tool for contributors who can validate their code
contributions via PRs on GitHub, e.g. to verify that their tests do actually
run on macOS (i.e. with the BSD family of Unix tools instead of the GNU
one).

The one sad part about this is the Windows support. Travis used to lack it
(Travis announced some early support for Windows, hot off the press
[https://blog.travis-ci.com/2018-10-11-windows-early-release]), and we work
around that by using Azure Pipelines (the CI part of Azure DevOps, formerly
known as Visual Studio Team Services) indirectly: one phase in Travis would
trigger a build, wait for its log, and then paste that log.

As Git's Windows builds (and tests!) take quite a bit of time, Travis often
timed out, or somehow the trigger did not work, and for security reasons
(the Windows builds are performed in a private pool of containers), the
Windows builds are completely disabled for Pull Requests on GitHub.

One might ask why we did not use Azure Pipelines directly. There were a
couple of reasons for that:

 * most notably, Azure Pipelines' build logs could not be viewed
   anonymously,
 * while Azure Pipelines had Linux and Windows agents, it lacked macOS
   agents,
 * etc

The main two reasons no longer apply: macOS agents are available now
[https://docs.microsoft.com/en-us/azure/devops/release-notes/2018/jul-10-vsts]
, and are public projects
[https://docs.microsoft.com/en-us/azure/devops/organizations/public/about-public-projects] 
now, i.e. it is possible to configure a Azure Pipelines project so that 
anybody can view the logs. Since I offered v1, Azure Pipelines has been made
available via the GitHub Marketplace, free of cost for open source projects.

I had secured such a public project for Git for Windows already, and I also
got one for Git. For now, the latter is hooked up with my personal git.git
fork on GitHub, but it is my hope that I convince y'all that these Azure
Pipelines builds are a good idea, and then hook it up with 
https://github.com/git/git.

As a special treat, this patch series adds the ability to present the
outcome of Git's test suite as JUnit-style .xml files. This allows the Azure
Pipelines build to present fun diagrams, trends, and makes it a lot easier
to drill down to test failures than before. See for example 
https://dev.azure.com/git/git/_build/results?buildId=113&view=ms.vss-test-web.test-result-details
[https://dev.azure.com/git/git/_build/results?buildId=113&view=ms.vss-test-web.test-result-details] 
(you can click on the label of the failed test, and then see the detailed
output in the right pane).

But maybe you're not interested as much in the presentation of test failures
as in the speed? Well, I got you covered with that, too. As of v3, the test
suite is run in parallel on Windows, cutting the overall run time to ~33
minutes (see one of the latest builds
[https://dev.azure.com/git/git/_build/results?buildId=302&view=logs], for
example).

This patch series took waaaaaaaay more time than I had originally
anticipated, but I think that in particular the advanced display of the test
results and the reduction of the overall run time was worth it. Please let
me know what you think about this.

Changes since v3:

 * Fixed the incorrect usage of cut -c that resulted in an empty trace when
   failed tests were published (except if the very first test case in a test
   script failed, then it was correct by mistake).
 * Excluded the previous test case's "ok" (or "not ok") line from the trace
   published with failed tests.
 * Renamed TRAVIS_BRANCH to CI_BRANCH already in the first commit, as we
   should not override TRAVIS_BRANCH with something that it is not.
 * Rebased onto current master to avoid merge conflicts with the
   recently-merged sg/stress-test branch (no, Junio, I really trust myself
   more than you to resolve those merge conflicts).

Changes since v2:

 * Removed left-over debugging code that would skip a good chunk of 
   t0000-init.sh.
 * Fixed the URL of the build badge.
 * Removed a trailing empty line from, and added a missing closing pointy
   bracket to, ci/mount-fileshare.sh.
 * Moved the "travis: fix skipping tagged releases" commit up to the
   beginning of the patch series.
 * The commit message of "ci/lib.sh: add support for Azure Pipelines" now
   mentions explicitly that the Homebrew packages that need to be installed
   on Travis' macOS agents are already installed on Azure Pipelines'.
 * Some commands were not guarded by || exit 1, i.e. if they would fail, the
   build would not have failed.
 * We now install gcc-8 for the linux-gcc job.
 * We no longer try to re-run failed tests with verbose log. Instead, we
   simply use the verbose log to begin with. Tests showed that it had a
   negligible impact on the overall run time.
 * The test_atexit_handler function was scratched; It would be the right
   thing to do, but is actually an independent topic (it was only
   implemented in v2 to accommodate the "re-run with verbose log on failure"
   trick)
 * We now use a new YAML schema (most notably, "phase" is now known as
   "job")
 * The Windows job contained PowerShell sections that were indented with 3
   spaces instead of 2.
 * The Windows job is now structured better, by separating different
   concerns into different "tasks" so that it is easier to see what exactly
   failed (was it the build? was it the test?)
 * The Windows job was split into a job to build Git and 10 parallel jobs to
   run the test suite with the artifacts built by the first job. This
   reduces the overall run time from ~1h20 (which was the run time by the
   Windows job) to ~35 minutes (which is the run time of the linux-gcc job).
 * The JUnit XML is now written using a test helper rather than a fragile
   and probably not even portable sed call.
 * Since we needed to determine the file size of the verbose log (to cut out
   individual test cases' log output), we now introduce a test helper to do
   that, and use it throughout the test suite (where Perl was used before).
 * It would appear that a recent change either in Cygwin or in the Azure VMs
   causes problems sporadically where the trash directories cannot be
   removed, but a subsequent rm will succeed. We now simply do that, because
   it won't harm the common case (where the first rm succeeds already) and
   because it helps the Windows job succeed pretty reliably.

Changes since v1:

 * Removed a superfluous eval.
 * Added the commit that fixes the Travis PR builds targeting master that 
   just happens to be tagged (see 
   https://travis-ci.org/git/git/jobs/424276413 for an incorrectly-skipped
   build).
 * The commit messages and the cover letter now reflect the name change from
   Visual Studio Team Services to Azure DevOps (and in particular, Azure
   Pipelines for the automated builds).
 * Now we're using test_atexit (which we introduced for that purpose)
   instead of hard-coding kill_p4d and stop_git_daemon.
 * The build should now also succeed for Pull Requests (where secret
   variables are not available, for security reasons, and as a consequence
   the file share cannot be mounted).
 * The shell scripted parts now use proper && chains.

Johannes Schindelin (21):
  travis: fix skipping tagged releases
  ci: rename the library of common functions
  ci/lib.sh: encapsulate Travis-specific things
  ci: inherit --jobs via MAKEFLAGS in run-build-and-tests
  ci: use a junction on Windows instead of a symlink
  test-date: add a subcommand to measure times in shell scripts
  tests: optionally write results as JUnit-style .xml
  ci/lib.sh: add support for Azure Pipelines
  Add a build definition for Azure DevOps
  ci: move the Windows job to the top
  ci: use git-sdk-64-minimal build artifact
  mingw: be more generous when wrapping up the setitimer() emulation
  README: add a build badge (status of the Azure Pipelines build)
  tests: avoid calling Perl just to determine file sizes
  tests: include detailed trace logs with --write-junit-xml upon failure
  mingw: try to work around issues with the test cleanup
  tests: add t/helper/ to the PATH with --with-dashes
  t0061: fix with --with-dashes and RUNTIME_PREFIX
  tests: optionally skip bin-wrappers/
  ci: speed up Windows phase
  ci: parallelize testing on Windows

 Makefile                            |  11 +
 README.md                           |   2 +
 azure-pipelines.yml                 | 344 ++++++++++++++++++++++++++++
 ci/install-dependencies.sh          |   5 +-
 ci/{lib-travisci.sh => lib.sh}      |  85 +++++--
 ci/make-test-artifacts.sh           |  12 +
 ci/mount-fileshare.sh               |  25 ++
 ci/print-test-failures.sh           |   4 +-
 ci/run-build-and-tests.sh           |   9 +-
 ci/run-linux32-docker.sh            |   2 +-
 ci/run-static-analysis.sh           |   2 +-
 ci/run-test-slice.sh                |  17 ++
 ci/run-windows-build.sh             |   2 +-
 ci/test-documentation.sh            |   3 +-
 compat/mingw.c                      |   2 +-
 t/.gitignore                        |   1 +
 t/README                            |   9 +
 t/helper/test-date.c                |  12 +
 t/helper/test-path-utils.c          |  64 ++++++
 t/helper/test-tool.c                |   1 +
 t/helper/test-tool.h                |   1 +
 t/helper/test-xml-encode.c          |  80 +++++++
 t/t0021-conversion.sh               |   2 +-
 t/t0061-run-command.sh              |   3 +-
 t/t1050-large.sh                    |   2 +-
 t/t5315-pack-objects-compression.sh |   2 +-
 t/t9303-fast-import-compression.sh  |   2 +-
 t/test-lib.sh                       | 138 ++++++++++-
 28 files changed, 796 insertions(+), 46 deletions(-)
 create mode 100644 azure-pipelines.yml
 rename ci/{lib-travisci.sh => lib.sh} (52%)
 create mode 100755 ci/make-test-artifacts.sh
 create mode 100755 ci/mount-fileshare.sh
 create mode 100755 ci/run-test-slice.sh
 create mode 100644 t/helper/test-xml-encode.c


base-commit: 16a465bc018d09e9d7bbbdc5f40a7fb99c21f8ef
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-31%2Fdscho%2Fvsts-ci-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-31/dscho/vsts-ci-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/31

Range-diff vs v3:

  1:  75ec97b392 <  -:  ---------- travis: fix skipping tagged releases
  -:  ---------- >  1:  6ed2f2a35c travis: fix skipping tagged releases
  2:  d520f45108 =  2:  b086f36660 ci: rename the library of common functions
  3:  06fa564386 !  3:  2d0b62f186 ci/lib.sh: encapsulate Travis-specific things
     @@ -30,7 +30,7 @@
       
      -# When building a PR, TRAVIS_BRANCH refers to the *target* branch. Not what we
      -# want here. We want the source branch instead.
     --TRAVIS_BRANCH="${TRAVIS_PULL_REQUEST_BRANCH:-$TRAVIS_BRANCH}"
     +-CI_BRANCH="${TRAVIS_PULL_REQUEST_BRANCH:-$TRAVIS_BRANCH}"
      +if test true = "$TRAVIS"
      +then
      +	# When building a PR, TRAVIS_BRANCH refers to the *target* branch. Not
     @@ -55,20 +55,6 @@
       
       skip_branch_tip_with_tag () {
       	# Sometimes, a branch is pushed at the same time the tag that points
     -@@
     - 	# we can skip the build because we won't be skipping a build
     - 	# of a tag.
     - 
     --	if TAG=$(git describe --exact-match "$TRAVIS_BRANCH" 2>/dev/null) &&
     --		test "$TAG" != "$TRAVIS_BRANCH"
     -+	if TAG=$(git describe --exact-match "$CI_BRANCH" 2>/dev/null) &&
     -+		test "$TAG" != "$CI_BRANCH"
     - 	then
     --		echo "$(tput setaf 2)Tip of $TRAVIS_BRANCH is exactly at $TAG$(tput sgr0)"
     -+		echo "$(tput setaf 2)Tip of $CI_BRANCH is exactly at $TAG$(tput sgr0)"
     - 		exit 0
     - 	fi
     - }
      @@
       # job if we encounter the same tree again and can provide a useful info
       # message.
  4:  52fb8e72fb =  4:  83b92a87e7 ci: inherit --jobs via MAKEFLAGS in run-build-and-tests
  5:  a35bc43a04 =  5:  6c9eb4e33e ci: use a junction on Windows instead of a symlink
  6:  16090ff67c =  6:  aa053ed993 test-date: add a subcommand to measure times in shell scripts
  7:  272c0c0446 !  7:  07fb37e0a6 tests: optionally write results as JUnit-style .xml
     @@ -148,15 +148,15 @@
       --- a/t/test-lib.sh
       +++ b/t/test-lib.sh
      @@
     - 	-V|--verbose-log)
       		verbose_log=t
     - 		shift ;;
     + 		tee=t
     + 		;;
      +	--write-junit-xml)
      +		write_junit_xml=t
     -+		shift ;;
     - 	*)
     - 		echo "error: unknown test option '$1'" >&2; exit 1 ;;
     - 	esac
     ++		;;
     + 	--stress)
     + 		stress=t ;;
     + 	--stress=*)
      @@
       # the test_expect_* functions instead.
       
     @@ -278,7 +278,7 @@
      +
       	if test -z "$HARNESS_ACTIVE"
       	then
     - 		test_results_dir="$TEST_OUTPUT_DIRECTORY/test-results"
     + 		mkdir -p "$TEST_RESULTS_DIR"
      @@
       else
       	mkdir -p "$TRASH_DIRECTORY"
  8:  fefab79d46 =  8:  178dc9b789 ci/lib.sh: add support for Azure Pipelines
  9:  ddee8ecd8a =  9:  eaba471b89 Add a build definition for Azure DevOps
 10:  58bb8d0469 = 10:  5bdc6a08a8 ci: move the Windows job to the top
 11:  b6bb6a87a3 = 11:  93eebb74ce ci: use git-sdk-64-minimal build artifact
 12:  2b6ee78f02 = 12:  18d76823e5 mingw: be more generous when wrapping up the setitimer() emulation
 13:  df326039d9 = 13:  5d593acee5 README: add a build badge (status of the Azure Pipelines build)
 14:  0d547db8f7 = 14:  3083041e33 tests: avoid calling Perl just to determine file sizes
 15:  f678b105f8 <  -:  ---------- tests: include detailed trace logs with --write-junit-xml upon failure
  -:  ---------- > 15:  1c44d3b8b8 tests: include detailed trace logs with --write-junit-xml upon failure
 16:  8ef674a236 = 16:  59c1194ae2 mingw: try to work around issues with the test cleanup
 17:  b503167084 = 17:  966c412f03 tests: add t/helper/ to the PATH with --with-dashes
 18:  713910e1dc = 18:  d613c79aff t0061: fix with --with-dashes and RUNTIME_PREFIX
 19:  3a77eafb44 ! 19:  a198885b76 tests: optionally skip bin-wrappers/
     @@ -31,13 +31,13 @@
       --- a/t/test-lib.sh
       +++ b/t/test-lib.sh
      @@
     - 		test -z "$HARNESS_ACTIVE" && quiet=t; shift ;;
     + 		test -z "$HARNESS_ACTIVE" && quiet=t ;;
       	--with-dashes)
     - 		with_dashes=t; shift ;;
     + 		with_dashes=t ;;
      +	--no-bin-wrappers)
     -+		no_bin_wrappers=t; shift ;;
     ++		no_bin_wrappers=t ;;
       	--no-color)
     - 		color=; shift ;;
     + 		color= ;;
       	--va|--val|--valg|--valgr|--valgri|--valgrin|--valgrind)
      @@
       	PATH=$GIT_TEST_INSTALLED:$GIT_BUILD_DIR/t/helper:$PATH
 20:  fba97133bf = 20:  6520f4603c ci: speed up Windows phase
 21:  e568349930 ! 21:  8bdd9804a1 ci: parallelize testing on Windows
     @@ -229,7 +229,7 @@ $^
       {
       	if (argc == 3 && !strcmp(argv[1], "normalize_path_copy")) {
      @@
     - 		return !!res;
     + 		return 0;
       	}
       
      +	if (argc > 5 && !strcmp(argv[1], "slice-tests")) {

-- 
gitgitgadget
