Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF9DD1F453
	for <e@80x24.org>; Sun, 27 Jan 2019 23:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfA0X0y (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Jan 2019 18:26:54 -0500
Received: from mail-ed1-f47.google.com ([209.85.208.47]:42124 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbfA0X0x (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jan 2019 18:26:53 -0500
Received: by mail-ed1-f47.google.com with SMTP id y20so11587406edw.9
        for <git@vger.kernel.org>; Sun, 27 Jan 2019 15:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AsNtPOcBQmdaLK4NH1ElXwZ66qwSCajOjboyA0OzL88=;
        b=R0SZAwKm8Bp22qgRu1TjQgRW+Hsj84Wg5tQpOJAorkgIxc0jDiD/ZIcYq/pqrN2o6x
         eJz/LGMvZ+3yvfRqWvYMR6T1dk7wI7WfG/R/aqTgxxZ52zde2yul7u8f37fGd1K66n02
         JFAA6SzgIOvy4hXljgiVBzfSAaK4/hmGb+ZBJ1X6TdG/8ioTGt6De5CxkRlEvOJ2hR8v
         zvH+whXi8A5srGCuQDXz74MLZcxSJ4hHDYtuPw0flpALJAolpSuj2EENXlw7MCe7Z89Y
         2AWBDFCppfSsDj2zEQjPUubNUqtWx8e/wAtKsRgy5NZ3dW+BNod/73T1a6vp+Oa2NYsK
         F2pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=AsNtPOcBQmdaLK4NH1ElXwZ66qwSCajOjboyA0OzL88=;
        b=H24Z+syGGkdqgKERMX3IidP9Zfv46QKLC5+Ffr0pg8oEmMYgql8X6XELoWOXNIvRWh
         gW4Kj9fxhbzr9Ogkqb5yBNU/q0dxKOqgsqRgCbdBCJ4dMwn0Z8jzxQBK88bc+XOsQTWY
         pZ0Dtkr1GpRwqxd26iohZTTgRu9CP6xnf2xjgOfgdY2nBbF6LVaGWiBMz/B3b82sObAf
         xzwG2bnvYXyNYrsZgDpZRxh0HripAMTBp96FE9yLbPC4ZZywYm4H+8Fy8eBSFicJ4wNG
         cnXBan2hKKM9cRZscPLliafhOBrBGJHxJ1mVL5G8k9HD1Gwxks7E1qjgUW4MtA2mcXRA
         P3CA==
X-Gm-Message-State: AJcUuke3YDrsdSYWN4dNJfPrZtJVKD/v3/l7hFFTX2dvXlTzpZ/eT1ab
        PajfqSgctyTB6c+2qEh9gzUmNvuZ
X-Google-Smtp-Source: ALg8bN7YHfvuL5/gRfSmFcS8Wq89rSg0It/kvw6IPNxom9KlEuROacHgj0aGNfQVcmBTJ+1xy8Z/6w==
X-Received: by 2002:a50:cdd0:: with SMTP id h16mr19780797edj.151.1548631609207;
        Sun, 27 Jan 2019 15:26:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m10sm1522059eja.38.2019.01.27.15.26.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Jan 2019 15:26:48 -0800 (PST)
Date:   Sun, 27 Jan 2019 15:26:48 -0800 (PST)
X-Google-Original-Date: Sun, 27 Jan 2019 23:26:26 GMT
Message-Id: <pull.31.v5.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v4.git.gitgitgadget@gmail.com>
References: <pull.31.v4.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 00/21] Offer to run CI/PR builds in Azure Pipelines
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
[https://dev.azure.com/git/git/_build/results?buildId=311&view=logs], for
example).

This patch series took waaaaaaaay more time than I had originally
anticipated, but I think that in particular the advanced display of the test
results and the reduction of the overall run time was worth it. Please let
me know what you think about this.

Changes since v4:

 * Clarified in the commit message why BREW_INSTALL_PACKAGES is needed.
 * Added a clause to error out if we could not detect the CI type.
 * Introduced a CI_TYPE variable to guard CI type-specific code.
 * MAKEFLAGS is now actually configured in the CI type-specific section.
 * Moved the inadvertent fixup for GIT_TEST_OPTS from "Add a build
   definition for Azure DevOps" to "ci/lib.sh: add support for Azure
   Pipelines".
 * Backed out the Windows support from the commit adding the initial Azure
   Pipelines support, instead adding it later to help the flow of the patch
   series.
 * Clarified in "test-date: add a subcommand to measure times in shell
   scripts"'s commit message that one of the goals is portability.
 * Moved all of those CI type-specific definitions in ci/lib.sh after the 
   set -ex statement (as suggested by Gábor a loooong time ago already).
 * Guarded the Travis-specific way to "publish" trash directories of failed
   tests via base64-encoded tar files in the log; For Azure Pipelines, these
   are published as build artifacts instead.

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
  ci: add a Windows job to the Azure Pipelines definition
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
 azure-pipelines.yml                 | 387 ++++++++++++++++++++++++++++
 ci/install-dependencies.sh          |   5 +-
 ci/{lib-travisci.sh => lib.sh}      |  92 +++++--
 ci/make-test-artifacts.sh           |  12 +
 ci/mount-fileshare.sh               |  25 ++
 ci/print-test-failures.sh           |  15 +-
 ci/run-build-and-tests.sh           |   9 +-
 ci/run-linux32-build.sh             |   2 +-
 ci/run-linux32-docker.sh            |   2 +-
 ci/run-static-analysis.sh           |   4 +-
 ci/run-test-slice.sh                |  17 ++
 ci/run-windows-build.sh             |   2 +-
 ci/test-documentation.sh            |   7 +-
 compat/mingw.c                      |   2 +-
 t/.gitignore                        |   1 +
 t/README                            |   9 +
 t/helper/test-date.c                |  12 +
 t/helper/test-path-utils.c          |  64 +++++
 t/helper/test-tool.c                |   1 +
 t/helper/test-tool.h                |   1 +
 t/helper/test-xml-encode.c          |  80 ++++++
 t/t0021-conversion.sh               |   2 +-
 t/t0061-run-command.sh              |   3 +-
 t/t1050-large.sh                    |   2 +-
 t/t5315-pack-objects-compression.sh |   2 +-
 t/t9303-fast-import-compression.sh  |   2 +-
 t/test-lib.sh                       | 138 +++++++++-
 29 files changed, 862 insertions(+), 49 deletions(-)
 create mode 100644 azure-pipelines.yml
 rename ci/{lib-travisci.sh => lib.sh} (50%)
 create mode 100755 ci/make-test-artifacts.sh
 create mode 100755 ci/mount-fileshare.sh
 create mode 100755 ci/run-test-slice.sh
 create mode 100644 t/helper/test-xml-encode.c


base-commit: 16a465bc018d09e9d7bbbdc5f40a7fb99c21f8ef
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-31%2Fdscho%2Fvsts-ci-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-31/dscho/vsts-ci-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/31

Range-diff vs v4:

  1:  6ed2f2a35c !  1:  f553fd4fb3 travis: fix skipping tagged releases
     @@ -21,14 +21,6 @@
       --- a/ci/lib-travisci.sh
       +++ b/ci/lib-travisci.sh
      @@
     - # Library of functions shared by all CI scripts
     - 
     -+# When building a PR, TRAVIS_BRANCH refers to the *target* branch. Not what we
     -+# want here. We want the source branch instead.
     -+CI_BRANCH="${TRAVIS_PULL_REQUEST_BRANCH:-$TRAVIS_BRANCH}"
     -+
     - skip_branch_tip_with_tag () {
     - 	# Sometimes, a branch is pushed at the same time the tag that points
       	# at the same commit as the tip of the branch is pushed, and building
       	# both at the same time is a waste.
       	#
     @@ -57,3 +49,14 @@
       		exit 0
       	fi
       }
     +@@
     + # and installing dependencies.
     + set -ex
     + 
     ++# When building a PR, TRAVIS_BRANCH refers to the *target* branch. Not what we
     ++# want here. We want the source branch instead.
     ++CI_BRANCH="${TRAVIS_PULL_REQUEST_BRANCH:-$TRAVIS_BRANCH}"
     ++
     + cache_dir="$HOME/travis-cache"
     + good_trees_file="$cache_dir/good-trees"
     + 
  2:  b086f36660 =  2:  f0852de8ab ci: rename the library of common functions
  3:  2d0b62f186 !  3:  7c16d31b46 ci/lib.sh: encapsulate Travis-specific things
     @@ -6,6 +6,18 @@
          (i.e. Azure DevOps' Continuous Integration), where variable names and
          URLs look a bit different than in Travis CI.
      
     +    Also, the configurations of the available agents are different. For
     +    example, Travis' and Azure Pipelines' macOS agents are set up
     +    differently, so that on Travis, we have to install the git-lfs and
     +    gettext Homebrew packages, and on Azure Pipelines we do not need to.
     +    Likewise, Azure Pipelines' Ubuntu agents already have asciidoctor
     +    installed.
     +
     +    Finally, on Azure Pipelines the natural way is not to base64-encode tar
     +    files of the trash directories of failed tests, but to publish build
     +    artifacts instead. Therefore, that code to log those base64-encoded tar
     +    files is guarded to be Travis-specific.
     +
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
     @@ -25,36 +37,6 @@
       diff --git a/ci/lib.sh b/ci/lib.sh
       --- a/ci/lib.sh
       +++ b/ci/lib.sh
     -@@
     - # Library of functions shared by all CI scripts
     - 
     --# When building a PR, TRAVIS_BRANCH refers to the *target* branch. Not what we
     --# want here. We want the source branch instead.
     --CI_BRANCH="${TRAVIS_PULL_REQUEST_BRANCH:-$TRAVIS_BRANCH}"
     -+if test true = "$TRAVIS"
     -+then
     -+	# When building a PR, TRAVIS_BRANCH refers to the *target* branch. Not
     -+	# what we want here. We want the source branch instead.
     -+	CI_BRANCH="${TRAVIS_PULL_REQUEST_BRANCH:-$TRAVIS_BRANCH}"
     -+	CI_COMMIT="$TRAVIS_COMMIT"
     -+	CI_JOB_ID="$TRAVIS_JOB_ID"
     -+	CI_JOB_NUMBER="$TRAVIS_JOB_NUMBER"
     -+	CI_OS_NAME="$TRAVIS_OS_NAME"
     -+	CI_REPO_SLUG="$TRAVIS_REPO_SLUG"
     -+
     -+	cache_dir="$HOME/travis-cache"
     -+
     -+	url_for_job_id () {
     -+		echo "https://travis-ci.org/$CI_REPO_SLUG/jobs/$1"
     -+	}
     -+
     -+	BREW_INSTALL_PACKAGES="git-lfs gettext"
     -+	export GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save"
     -+	export GIT_TEST_OPTS="--verbose-log -x --immediate"
     -+fi
     - 
     - skip_branch_tip_with_tag () {
     - 	# Sometimes, a branch is pushed at the same time the tag that points
      @@
       # job if we encounter the same tree again and can provide a useful info
       # message.
     @@ -100,6 +82,35 @@
       # and installing dependencies.
       set -ex
       
     +-# When building a PR, TRAVIS_BRANCH refers to the *target* branch. Not what we
     +-# want here. We want the source branch instead.
     +-CI_BRANCH="${TRAVIS_PULL_REQUEST_BRANCH:-$TRAVIS_BRANCH}"
     ++if test true = "$TRAVIS"
     ++then
     ++	CI_TYPE=travis
     ++	# When building a PR, TRAVIS_BRANCH refers to the *target* branch. Not
     ++	# what we want here. We want the source branch instead.
     ++	CI_BRANCH="${TRAVIS_PULL_REQUEST_BRANCH:-$TRAVIS_BRANCH}"
     ++	CI_COMMIT="$TRAVIS_COMMIT"
     ++	CI_JOB_ID="$TRAVIS_JOB_ID"
     ++	CI_JOB_NUMBER="$TRAVIS_JOB_NUMBER"
     ++	CI_OS_NAME="$TRAVIS_OS_NAME"
     ++	CI_REPO_SLUG="$TRAVIS_REPO_SLUG"
     ++
     ++	cache_dir="$HOME/travis-cache"
     ++
     ++	url_for_job_id () {
     ++		echo "https://travis-ci.org/$CI_REPO_SLUG/jobs/$1"
     ++	}
     ++
     ++	BREW_INSTALL_PACKAGES="git-lfs gettext"
     ++	export GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save"
     ++	export GIT_TEST_OPTS="--verbose-log -x --immediate"
     ++else
     ++	echo "Could not identify CI type" >&2
     ++	exit 1
     ++fi
     + 
      -cache_dir="$HOME/travis-cache"
       good_trees_file="$cache_dir/good-trees"
       
     @@ -124,14 +135,20 @@
       --- a/ci/print-test-failures.sh
       +++ b/ci/print-test-failures.sh
      @@
     - 	fi
     - done
     - 
     --if [ $combined_trash_size -gt 0 ]
     -+if [ -n "$TRAVIS_JOB_ID" -a $combined_trash_size -gt 0 ]
     - then
     - 	echo "------------------------------------------------------------------------"
     - 	echo "Trash directories embedded in this log can be extracted by running:"
     + 		test_name="${TEST_EXIT%.exit}"
     + 		test_name="${test_name##*/}"
     + 		trash_dir="trash directory.$test_name"
     ++		case "$CI_TYPE" in
     ++		travis)
     ++			;;
     ++		*)
     ++			echo "Unhandled CI type: $CI_TYPE" >&2
     ++			exit 1
     ++			;;
     ++		esac
     + 		trash_tgz_b64="trash.$test_name.base64"
     + 		if [ -d "$trash_dir" ]
     + 		then
      
       diff --git a/ci/test-documentation.sh b/ci/test-documentation.sh
       --- a/ci/test-documentation.sh
  4:  83b92a87e7 <  -:  ---------- ci: inherit --jobs via MAKEFLAGS in run-build-and-tests
  -:  ---------- >  4:  bf72fb1004 ci: inherit --jobs via MAKEFLAGS in run-build-and-tests
  5:  6c9eb4e33e =  5:  681f8e65b4 ci: use a junction on Windows instead of a symlink
  6:  aa053ed993 !  6:  ccf8bf53d7 test-date: add a subcommand to measure times in shell scripts
     @@ -14,7 +14,10 @@
          be able to obtain precise timings).
      
          So let's introduce `test-tool date getnanos`, with an optional start
     -    time, that outputs preciser values.
     +    time, that outputs preciser values. Note that this might not actually
     +    give us nanosecond precision on some platforms, but it will give us as
     +    precise information as possible, without the portability issues of shell
     +    commands.
      
          Granted, it is a bit pointless to try measuring times accurately in
          shell scripts, certainly to nanosecond precision. But it is better than
  7:  07fb37e0a6 =  7:  31fbe11425 tests: optionally write results as JUnit-style .xml
  8:  178dc9b789 !  8:  47fe8aa84a ci/lib.sh: add support for Azure Pipelines
     @@ -6,9 +6,12 @@
          variables and a function that displays the URL given the job id (to
          identify previous runs for known-good trees).
      
     -    For example, we do not have to install the git-lfs and gettext packages
     -    on Azure Pipelines' macOS agents: they are already installed, and trying
     -    to install them again would result in an error.
     +    Because Azure Pipeline's macOS agents already have git-lfs and gettext
     +    installed, we can leave `BREW_INSTALL_PACKAGES` empty (unlike in
     +    Travis' case).
     +
     +    Note: this patch does not introduce an Azure Pipelines definition yet;
     +    That is left for the next patch.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     @@ -16,11 +19,12 @@
       --- a/ci/lib.sh
       +++ b/ci/lib.sh
      @@
     - 	BREW_INSTALL_PACKAGES="git-lfs gettext"
       	export GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save"
       	export GIT_TEST_OPTS="--verbose-log -x --immediate"
     + 	export MAKEFLAGS="--jobs=2"
      +elif test -n "$SYSTEM_COLLECTIONURI" || test -n "$SYSTEM_TASKDEFINITIONSURI"
      +then
     ++	CI_TYPE=azure-pipelines
      +	# We are running in Azure Pipelines
      +	CI_BRANCH="$BUILD_SOURCEBRANCH"
      +	CI_COMMIT="$BUILD_SOURCEVERSION"
     @@ -41,7 +45,24 @@
      +
      +	BREW_INSTALL_PACKAGES=
      +	export GIT_PROVE_OPTS="--timer --jobs 10 --state=failed,slow,save"
     -+	export GIT_TEST_OPTS="--quiet --write-junit-xml"
     - fi
     - 
     - skip_branch_tip_with_tag () {
     ++	export GIT_TEST_OPTS="--verbose-log -x --write-junit-xml"
     ++	export MAKEFLAGS="--jobs=10"
     + else
     + 	echo "Could not identify CI type" >&2
     + 	exit 1
     +
     + diff --git a/ci/print-test-failures.sh b/ci/print-test-failures.sh
     + --- a/ci/print-test-failures.sh
     + +++ b/ci/print-test-failures.sh
     +@@
     + 		case "$CI_TYPE" in
     + 		travis)
     + 			;;
     ++		azure-pipelines)
     ++			mkdir -p failed-test-artifacts
     ++			mv "$trash_dir" failed-test-artifacts
     ++			continue
     ++			;;
     + 		*)
     + 			echo "Unhandled CI type: $CI_TYPE" >&2
     + 			exit 1
  9:  eaba471b89 !  9:  6044b919b0 Add a build definition for Azure DevOps
     @@ -5,6 +5,19 @@
          This commit adds an azure-pipelines.yml file which is Azure DevOps'
          equivalent to Travis CI's .travis.yml.
      
     +    The main idea is to replicate the Travis configuration as faithfully as
     +    possible, to make it easy to compare the Azure Pipeline builds to the
     +    Travis ones (spoiler: some parts, especially the macOS jobs, are way
     +    faster in Azure Pileines). Meaning: the number and the order of the jobs
     +    added in this commit faithfully replicates what we have in .travis.yml.
     +
     +    Note: Our .travis.yml configuration has a Windows part that is *not*
     +    replicated in the Azure Pipelines definition. The reason is easy to see:
     +    As Travis cannot support our Windws needs (even with the preliminary
     +    Windows support that was recently added to Travis after waiting for
     +    *years* for that feature, our test suite would simply hit Travis'
     +    timeout every single time).
     +
          To make things a bit easier to understand, we refrain from using the
          `matrix` feature here because (while it is powerful) it can be a bit
          confusing to users who are not familiar with CI setups. Therefore, we
     @@ -15,7 +28,9 @@
          test suite can output JUnit-style .xml files. This information is made
          available in a nice UI that allows the viewer to filter by phase and/or
          test number, and to see trends such as: number of (failing) tests, time
     -    spent running the test suite, etc.
     +    spent running the test suite, etc. (While this seemingly contradicts the
     +    intention to replicate the Travis configuration as faithfully as
     +    possible, it is just too nice to show off that capability here already.)
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     @@ -60,6 +75,12 @@
      +      platform: Linux
      +      publishRunAttachments: false
      +    condition: succeededOrFailed()
     ++  - task: PublishBuildArtifacts@1
     ++    displayName: 'Publish trash directories of failed tests'
     ++    condition: failed()
     ++    inputs:
     ++      PathtoPublish: t/failed-test-artifacts
     ++      ArtifactName: failed-test-artifacts
      +
      +- job: linux_gcc
      +  displayName: linux-gcc
     @@ -91,6 +112,12 @@
      +      platform: Linux
      +      publishRunAttachments: false
      +    condition: succeededOrFailed()
     ++  - task: PublishBuildArtifacts@1
     ++    displayName: 'Publish trash directories of failed tests'
     ++    condition: failed()
     ++    inputs:
     ++      PathtoPublish: t/failed-test-artifacts
     ++      ArtifactName: failed-test-artifacts
      +
      +- job: osx_clang
      +  displayName: osx-clang
     @@ -120,6 +147,12 @@
      +      platform: macOS
      +      publishRunAttachments: false
      +    condition: succeededOrFailed()
     ++  - task: PublishBuildArtifacts@1
     ++    displayName: 'Publish trash directories of failed tests'
     ++    condition: failed()
     ++    inputs:
     ++      PathtoPublish: t/failed-test-artifacts
     ++      ArtifactName: failed-test-artifacts
      +
      +- job: osx_gcc
      +  displayName: osx-gcc
     @@ -147,6 +180,12 @@
      +      platform: macOS
      +      publishRunAttachments: false
      +    condition: succeededOrFailed()
     ++  - task: PublishBuildArtifacts@1
     ++    displayName: 'Publish trash directories of failed tests'
     ++    condition: failed()
     ++    inputs:
     ++      PathtoPublish: t/failed-test-artifacts
     ++      ArtifactName: failed-test-artifacts
      +
      +- job: gettext_poison
      +  displayName: GETTEXT_POISON
     @@ -178,92 +217,12 @@
      +      platform: Linux
      +      publishRunAttachments: false
      +    condition: succeededOrFailed()
     -+
     -+- job: windows
     -+  displayName: Windows
     -+  condition: succeeded()
     -+  pool: Hosted
     -+  timeoutInMinutes: 240
     -+  steps:
     -+  - powershell: |
     -+      if ("$GITFILESHAREPWD" -ne "" -and "$GITFILESHAREPWD" -ne "`$`(gitfileshare.pwd)") {
     -+        net use s: \\gitfileshare.file.core.windows.net\test-cache "$GITFILESHAREPWD" /user:AZURE\gitfileshare /persistent:no
     -+        cmd /c mklink /d "$(Build.SourcesDirectory)\test-cache" S:\
     -+      }
     -+    displayName: 'Mount test-cache'
     -+    env:
     -+      GITFILESHAREPWD: $(gitfileshare.pwd)
     -+  - powershell: |
     -+      # Helper to check the error level of the latest command (exit with error when appropriate)
     -+      function c() { if (!$?) { exit(1) } }
     -+
     -+      # Add build agent's MinGit to PATH
     -+      $env:PATH = $env:AGENT_HOMEDIRECTORY +"\externals\\git\cmd;" +$env:PATH
     -+
     -+      # Helper to initialize (or update) a Git worktree
     -+      function init ($path, $url, $set_origin) {
     -+        if (Test-Path $path) {
     -+          cd $path; c
     -+          if (Test-Path .git) {
     -+            & git init; c
     -+          } else {
     -+            & git status
     -+          }
     -+        } else {
     -+          & git init $path; c
     -+          cd $path; c
     -+        }
     -+        & git config core.autocrlf false; c
     -+        & git config core.untrackedCache true; c
     -+        if (($set_origin -ne 0) -and !(git config remote.origin.url)) {
     -+          & git remote add origin $url; c
     -+        }
     -+        & git fetch --depth=1 $url master; c
     -+        & git reset --hard FETCH_HEAD; c
     -+        & git clean -df; c
     -+      }
     -+
     -+      # Initialize Git for Windows' SDK
     -+      $sdk_path = "$(Build.SourcesDirectory)\git-sdk-64"
     -+      init "$sdk_path" "https://dev.azure.com/git-for-windows/git-sdk-64/_git/git-sdk-64" 0
     -+
     -+      # Let Git ignore the SDK and the test-cache
     -+      "/git-sdk-64/`n/test-cache/`n" | Out-File -NoNewLine -Encoding ascii -Append "$(Build.SourcesDirectory)\.git\info\exclude"
     -+    displayName: 'Initialize the Git for Windows SDK'
     -+  - powershell: |
     -+      & "git-sdk-64\git-cmd.exe" --command=usr\\bin\\bash.exe -lc @"
     -+        export MAKEFLAGS=-j10
     -+        export DEVELOPER=1
     -+        export NO_PERL=1
     -+        export NO_SVN_TESTS=1
     -+        export GIT_TEST_SKIP_REBASE_P=1
     -+
     -+        ci/run-build-and-tests.sh || {
     -+          ci/print-test-failures.sh
     -+          exit 1
     -+        }
     -+      "@
     -+      if (!$?) { exit(1) }
     -+    displayName: 'Build & Test'
     -+    env:
     -+      HOME: $(Build.SourcesDirectory)
     -+      MSYSTEM: MINGW64
     -+  - powershell: |
     -+      if ("$GITFILESHAREPWD" -ne "" -and "$GITFILESHAREPWD" -ne "`$`(gitfileshare.pwd)") {
     -+        cmd /c rmdir "$(Build.SourcesDirectory)\test-cache"
     -+      }
     -+    displayName: 'Unmount test-cache'
     -+    condition: true
     -+    env:
     -+      GITFILESHAREPWD: $(gitfileshare.pwd)
     -+  - task: PublishTestResults@2
     -+    displayName: 'Publish Test Results **/TEST-*.xml'
     ++  - task: PublishBuildArtifacts@1
     ++    displayName: 'Publish trash directories of failed tests'
     ++    condition: failed()
      +    inputs:
     -+      mergeTestResults: true
     -+      testRunTitle: 'windows'
     -+      platform: Windows
     -+      publishRunAttachments: false
     -+    condition: succeededOrFailed()
     ++      PathtoPublish: t/failed-test-artifacts
     ++      ArtifactName: failed-test-artifacts
      +
      +- job: linux32
      +  displayName: Linux32
     @@ -273,11 +232,14 @@
      +  - bash: |
      +       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
      +
     -+       sudo AGENT_OS="$AGENT_OS" BUILD_BUILDNUMBER="$BUILD_BUILDNUMBER" BUILD_REPOSITORY_URI="$BUILD_REPOSITORY_URI" BUILD_SOURCEBRANCH="$BUILD_SOURCEBRANCH" BUILD_SOURCEVERSION="$BUILD_SOURCEVERSION" SYSTEM_PHASENAME="$SYSTEM_PHASENAME" SYSTEM_TASKDEFINITIONSURI="$SYSTEM_TASKDEFINITIONSURI" SYSTEM_TEAMPROJECT="$SYSTEM_TEAMPROJECT" CC=$CC MAKEFLAGS=-j3 bash -lxc ci/run-linux32-docker.sh || exit 1
     ++       res=0
     ++       sudo AGENT_OS="$AGENT_OS" BUILD_BUILDNUMBER="$BUILD_BUILDNUMBER" BUILD_REPOSITORY_URI="$BUILD_REPOSITORY_URI" BUILD_SOURCEBRANCH="$BUILD_SOURCEBRANCH" BUILD_SOURCEVERSION="$BUILD_SOURCEVERSION" SYSTEM_PHASENAME="$SYSTEM_PHASENAME" SYSTEM_TASKDEFINITIONSURI="$SYSTEM_TASKDEFINITIONSURI" SYSTEM_TEAMPROJECT="$SYSTEM_TEAMPROJECT" CC=$CC MAKEFLAGS="$MAKEFLAGS" bash -lxc ci/run-linux32-docker.sh || res=1
      +
      +       sudo chmod a+r t/out/TEST-*.xml
     ++       test ! -d t/failed-test-artifacts || sudo chmod a+r t/failed-test-artifacts
      +
     -+       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || sudo umount "$HOME/test-cache" || exit 1
     ++       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || sudo umount "$HOME/test-cache" || res=1
     ++       exit $res
      +    displayName: 'ci/run-linux32-docker.sh'
      +    env:
      +      GITFILESHAREPWD: $(gitfileshare.pwd)
     @@ -289,6 +251,12 @@
      +      platform: Linux
      +      publishRunAttachments: false
      +    condition: succeededOrFailed()
     ++  - task: PublishBuildArtifacts@1
     ++    displayName: 'Publish trash directories of failed tests'
     ++    condition: failed()
     ++    inputs:
     ++      PathtoPublish: t/failed-test-artifacts
     ++      ArtifactName: failed-test-artifacts
      +
      +- job: static_analysis
      +  displayName: StaticAnalysis
     @@ -331,19 +299,6 @@
      +    env:
      +      GITFILESHAREPWD: $(gitfileshare.pwd)
      
     - diff --git a/ci/lib.sh b/ci/lib.sh
     - --- a/ci/lib.sh
     - +++ b/ci/lib.sh
     -@@
     - 
     - 	BREW_INSTALL_PACKAGES=
     - 	export GIT_PROVE_OPTS="--timer --jobs 10 --state=failed,slow,save"
     --	export GIT_TEST_OPTS="--quiet --write-junit-xml"
     -+	export GIT_TEST_OPTS="--verbose-log -x --write-junit-xml"
     - fi
     - 
     - skip_branch_tip_with_tag () {
     -
       diff --git a/ci/mount-fileshare.sh b/ci/mount-fileshare.sh
       new file mode 100755
       --- /dev/null
 10:  5bdc6a08a8 ! 10:  3a2993c826 ci: move the Windows job to the top
     @@ -1,17 +1,30 @@
      Author: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     -    ci: move the Windows job to the top
     +    ci: add a Windows job to the Azure Pipelines definition
      
     -    The Windows job currently takes a whopping ~1h20m to complete. Which is
     -    *far* longer than the next-longest job takes (linux-gcc, ~35m). As such,
     -    it makes sense to start the Windows job first, to minimize the overall
     -    run time (which is now pretty safely the run time of the Windows job).
     +    Previously, we did not have robust support for Windows in our CI
     +    definition, simply because Travis cannot accommodate our needs (even
     +    after Travis added experimental Windows support very recently, it takes
     +    longer than Travis' 50 minute timeout to build Git and run the test
     +    suite on Windows). Instead, we used a hack that started a dedicated
     +    Azure Pipeline from Travis and waited for the output, often timing out
     +    (which is quite fragile, as we found out).
      
     -    This affects only the Azure Pipelines configuration, not the Travis one,
     -    of course, as Travis cannot run our Windows job: 1h20m is distinctly
     -    longer than the 50 minute timeout of Travis' free tier.
     +    With this commit, we finally have first-class support for Windows in our
     +    CI definition (in the Azure Pipelines one, that is).
      
     -    This commit is best viewed with `--color-moved`.
     +    Due to our reliance on Unix shell scripting in the test suite, combined
     +    with the challenges on executing such scripts on Windows, the Windows
     +    job currently takes a whopping ~1h20m to complete. Which is *far* longer
     +    than the next-longest job takes (linux-gcc, ~35m).
     +
     +    Now, Azure Pipelines's free tier for open source projects (such as Git)
     +    offers up to 10 concurrent jobs for free, meaning that the overall run
     +    time will be dominated by the slowest job(s).
     +
     +    Therefore, it makes sense to start the Windows job first, to minimize
     +    the time the entire build takes from start to end (which is now pretty
     +    safely the run time of the Windows job).
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     @@ -75,7 +88,6 @@
      +    displayName: 'Initialize the Git for Windows SDK'
      +  - powershell: |
      +      & "git-sdk-64\git-cmd.exe" --command=usr\\bin\\bash.exe -lc @"
     -+        export MAKEFLAGS=-j10
      +        export DEVELOPER=1
      +        export NO_PERL=1
      +        export NO_SVN_TESTS=1
     @@ -107,100 +119,13 @@
      +      platform: Windows
      +      publishRunAttachments: false
      +    condition: succeededOrFailed()
     ++  - task: PublishBuildArtifacts@1
     ++    displayName: 'Publish trash directories of failed tests'
     ++    condition: failed()
     ++    inputs:
     ++      PathtoPublish: t/failed-test-artifacts
     ++      ArtifactName: failed-test-artifacts
      +
       - job: linux_clang
         displayName: linux-clang
         condition: succeeded()
     -@@
     -       publishRunAttachments: false
     -     condition: succeededOrFailed()
     - 
     --- job: windows
     --  displayName: Windows
     --  condition: succeeded()
     --  pool: Hosted
     --  timeoutInMinutes: 240
     --  steps:
     --  - powershell: |
     --      if ("$GITFILESHAREPWD" -ne "" -and "$GITFILESHAREPWD" -ne "`$`(gitfileshare.pwd)") {
     --        net use s: \\gitfileshare.file.core.windows.net\test-cache "$GITFILESHAREPWD" /user:AZURE\gitfileshare /persistent:no
     --        cmd /c mklink /d "$(Build.SourcesDirectory)\test-cache" S:\
     --      }
     --    displayName: 'Mount test-cache'
     --    env:
     --      GITFILESHAREPWD: $(gitfileshare.pwd)
     --  - powershell: |
     --      # Helper to check the error level of the latest command (exit with error when appropriate)
     --      function c() { if (!$?) { exit(1) } }
     --
     --      # Add build agent's MinGit to PATH
     --      $env:PATH = $env:AGENT_HOMEDIRECTORY +"\externals\\git\cmd;" +$env:PATH
     --
     --      # Helper to initialize (or update) a Git worktree
     --      function init ($path, $url, $set_origin) {
     --        if (Test-Path $path) {
     --          cd $path; c
     --          if (Test-Path .git) {
     --            & git init; c
     --          } else {
     --            & git status
     --          }
     --        } else {
     --          & git init $path; c
     --          cd $path; c
     --        }
     --        & git config core.autocrlf false; c
     --        & git config core.untrackedCache true; c
     --        if (($set_origin -ne 0) -and !(git config remote.origin.url)) {
     --          & git remote add origin $url; c
     --        }
     --        & git fetch --depth=1 $url master; c
     --        & git reset --hard FETCH_HEAD; c
     --        & git clean -df; c
     --      }
     --
     --      # Initialize Git for Windows' SDK
     --      $sdk_path = "$(Build.SourcesDirectory)\git-sdk-64"
     --      init "$sdk_path" "https://dev.azure.com/git-for-windows/git-sdk-64/_git/git-sdk-64" 0
     --
     --      # Let Git ignore the SDK and the test-cache
     --      "/git-sdk-64/`n/test-cache/`n" | Out-File -NoNewLine -Encoding ascii -Append "$(Build.SourcesDirectory)\.git\info\exclude"
     --    displayName: 'Initialize the Git for Windows SDK'
     --  - powershell: |
     --      & "git-sdk-64\git-cmd.exe" --command=usr\\bin\\bash.exe -lc @"
     --        export MAKEFLAGS=-j10
     --        export DEVELOPER=1
     --        export NO_PERL=1
     --        export NO_SVN_TESTS=1
     --        export GIT_TEST_SKIP_REBASE_P=1
     --
     --        ci/run-build-and-tests.sh || {
     --          ci/print-test-failures.sh
     --          exit 1
     --        }
     --      "@
     --      if (!$?) { exit(1) }
     --    displayName: 'Build & Test'
     --    env:
     --      HOME: $(Build.SourcesDirectory)
     --      MSYSTEM: MINGW64
     --  - powershell: |
     --      if ("$GITFILESHAREPWD" -ne "" -and "$GITFILESHAREPWD" -ne "`$`(gitfileshare.pwd)") {
     --        cmd /c rmdir "$(Build.SourcesDirectory)\test-cache"
     --      }
     --    displayName: 'Unmount test-cache'
     --    condition: true
     --    env:
     --      GITFILESHAREPWD: $(gitfileshare.pwd)
     --  - task: PublishTestResults@2
     --    displayName: 'Publish Test Results **/TEST-*.xml'
     --    inputs:
     --      mergeTestResults: true
     --      testRunTitle: 'windows'
     --      platform: Windows
     --      publishRunAttachments: false
     --    condition: succeededOrFailed()
     --
     - - job: linux32
     -   displayName: Linux32
     -   condition: succeeded()
 11:  93eebb74ce ! 11:  52d63018c9 ci: use git-sdk-64-minimal build artifact
     @@ -78,6 +78,6 @@
         - powershell: |
      -      & "git-sdk-64\git-cmd.exe" --command=usr\\bin\\bash.exe -lc @"
      +      & git-sdk-64-minimal\usr\bin\bash.exe -lc @"
     -         export MAKEFLAGS=-j10
               export DEVELOPER=1
               export NO_PERL=1
     +         export NO_SVN_TESTS=1
 12:  18d76823e5 = 12:  1cef14e4c0 mingw: be more generous when wrapping up the setitimer() emulation
 13:  5d593acee5 = 13:  eda46863e8 README: add a build badge (status of the Azure Pipelines build)
 14:  3083041e33 = 14:  4303bbd4e8 tests: avoid calling Perl just to determine file sizes
 15:  1c44d3b8b8 = 15:  dfd3516f39 tests: include detailed trace logs with --write-junit-xml upon failure
 16:  59c1194ae2 = 16:  9984c6d17b mingw: try to work around issues with the test cleanup
 17:  966c412f03 = 17:  a8101ae3e1 tests: add t/helper/ to the PATH with --with-dashes
 18:  d613c79aff = 18:  7518266a19 t0061: fix with --with-dashes and RUNTIME_PREFIX
 19:  a198885b76 = 19:  6a8adbe8ba tests: optionally skip bin-wrappers/
 20:  6520f4603c <  -:  ---------- ci: speed up Windows phase
  -:  ---------- > 20:  b39e16527d ci: speed up Windows phase
 21:  8bdd9804a1 ! 21:  6ff87d1772 ci: parallelize testing on Windows
     @@ -78,7 +78,6 @@ $^
           displayName: 'Download git-sdk-64-minimal'
         - powershell: |
             & git-sdk-64-minimal\usr\bin\bash.exe -lc @"
     --        export MAKEFLAGS=-j10
      -        export DEVELOPER=1
      -        export NO_PERL=1
      -        export NO_SVN_TESTS=1
     @@ -90,7 +89,6 @@ $^
      +    env:
      +      HOME: $(Build.SourcesDirectory)
      +      MSYSTEM: MINGW64
     -+      MAKEFLAGS: -j10
      +      DEVELOPER: 1
      +      NO_PERL: 1
      +  - task: PublishPipelineArtifact@0
     @@ -162,7 +160,6 @@ $^
           env:
             HOME: $(Build.SourcesDirectory)
             MSYSTEM: MINGW64
     -+      MAKEFLAGS: -j10
      +      NO_SVN_TESTS: 1
      +      GIT_TEST_SKIP_REBASE_P: 1
         - powershell: |

-- 
gitgitgadget
