Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A81B1F453
	for <e@80x24.org>; Tue, 29 Jan 2019 14:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbfA2OT1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 09:19:27 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46169 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbfA2OTZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 09:19:25 -0500
Received: by mail-ed1-f66.google.com with SMTP id o10so16041720edt.13
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 06:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=j9EM6XsfuKEeChyhTJCMU8IKFoy8nvEN0O425mc8G7k=;
        b=AtnP5JbGgNaMSgL2JwVzlFiv8ZS1CKCZr6/oavyo1dKRQYGPFE8WEiWCFNt2C5eIe3
         bQeZ3zSuzrgoNXycnAjunMenn8NeqZFEnj+4l51BJZ44ES0UVyEZaJuoqztmj0sl8I/0
         Gp962ypNEl520LYRoVfYXYeQRmSJlT6NXEHXG7ZT0yv11lqt/Iyk6pbx+MjqsWyDl46M
         7EV80HXdDkOv1TOZN6LtCu5Xy6cBDyr//VoJCsWNuG7YiiSkOxWtz3bLrGYL2p+R7Egb
         MqWBMtt5KQ1CjXTj6NNjfP1R7YkQntKE6uNTFcogv3LPIt3EQbX9ugS/RFuEoRtLlOOt
         j53w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=j9EM6XsfuKEeChyhTJCMU8IKFoy8nvEN0O425mc8G7k=;
        b=rRJsIkxjoJE/sVHJhGwBzftghDJ7E3fckeBpwstlu7xbGchwnW35PSTHe+gb3N22mu
         yarQFDG/24JQ83bHuX9PrBESPro4KXLk/MrSpZTvQRJb2LuPjCGvDAy32wSAkaNXS8kF
         Eklb7mVRD3U8Y2PLgD4OTTR2/T5RrxpDAAZt/ASJsAytxbIyOF/3TEfpBu/l7pi/ur8O
         lwvtYZlmax52XbTUIPKQi5PvOI8lD8YuI/5hpmJmX9IarRrbzfysldpaoAKTccJdR+nB
         guLgvf3zQuxXGaEsZcCiOf6xsJg5oDWOoNMJ1jJKXR9HGJ0ZdweLLc9iZJkqb1m/+E2C
         +fzA==
X-Gm-Message-State: AJcUukfvYl75RquFL2BJCV3vrQF7nn7D1MimA33pxcrtsXcwN0zGEbQB
        JHRz8Qe2rXytBLWFy289FErbgNyB
X-Google-Smtp-Source: ALg8bN68pwH6Or83gWmpxjSdVWKkzhf1FQFg8V+PNlN7c569/o6nwv66a0BUNeW2/BK1qYnrjANBMA==
X-Received: by 2002:a50:9770:: with SMTP id d45mr24332391edb.49.1548771562315;
        Tue, 29 Jan 2019 06:19:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q3-v6sm8370593ejz.30.2019.01.29.06.19.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 06:19:21 -0800 (PST)
Date:   Tue, 29 Jan 2019 06:19:21 -0800 (PST)
X-Google-Original-Date: Tue, 29 Jan 2019 14:18:59 GMT
Message-Id: <pull.31.v6.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v5.git.gitgitgadget@gmail.com>
References: <pull.31.v5.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v6 00/21] Offer to run CI/PR builds in Azure Pipelines
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
, as are public projects
[https://docs.microsoft.com/en-us/azure/devops/organizations/public/about-public-projects]
, i.e. it is possible to configure a Azure Pipelines project so that anybody 
can view the logs. Since I offered v1, Azure Pipelines has been made
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

Changes since v5:

 * Fixed sparse warnings.
 * Reworded the commit message of "t0061: fix for --with-dashes and RUN
   TIME_PREFIX" to clarify why there is a warning message in the first
   place, why this cannot be fixed, and that we introduce a simple
   workaround here.

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
  t0061: workaround issues with --with-dashes and RUNTIME_PREFIX
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
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-31%2Fdscho%2Fvsts-ci-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-31/dscho/vsts-ci-v6
Pull-Request: https://github.com/gitgitgadget/git/pull/31

Range-diff vs v5:

  1:  f553fd4fb3 =  1:  f553fd4fb3 travis: fix skipping tagged releases
  2:  f0852de8ab =  2:  f0852de8ab ci: rename the library of common functions
  3:  7c16d31b46 =  3:  7c16d31b46 ci/lib.sh: encapsulate Travis-specific things
  4:  bf72fb1004 =  4:  bf72fb1004 ci: inherit --jobs via MAKEFLAGS in run-build-and-tests
  5:  681f8e65b4 =  5:  681f8e65b4 ci: use a junction on Windows instead of a symlink
  6:  ccf8bf53d7 =  6:  ccf8bf53d7 test-date: add a subcommand to measure times in shell scripts
  7:  31fbe11425 !  7:  e9a869df57 tests: optionally write results as JUnit-style .xml
     @@ -91,7 +91,7 @@
      +		if (tmp2) {
      +			if ((ch & 0xc0) != 0x80) {
      +				fputs(utf8_replace_character, stdout);
     -+				tmp2 = 0;
     ++				tmp2 = NULL;
      +				cur--;
      +				continue;
      +			}
     @@ -99,7 +99,7 @@
      +			tmp2++;
      +			if (--remaining == 0) {
      +				fwrite(tmp, tmp2 - tmp, 1, stdout);
     -+				tmp2 = 0;
     ++				tmp2 = NULL;
      +			}
      +			continue;
      +		}
  8:  47fe8aa84a =  8:  4c78085af7 ci/lib.sh: add support for Azure Pipelines
  9:  6044b919b0 =  9:  d34812bdf6 Add a build definition for Azure DevOps
 10:  3a2993c826 = 10:  d565131781 ci: add a Windows job to the Azure Pipelines definition
 11:  52d63018c9 = 11:  1ab1d14e06 ci: use git-sdk-64-minimal build artifact
 12:  1cef14e4c0 = 12:  c1ab8df677 mingw: be more generous when wrapping up the setitimer() emulation
 13:  eda46863e8 = 13:  b6316e1f7d README: add a build badge (status of the Azure Pipelines build)
 14:  4303bbd4e8 = 14:  7a5caa2e0f tests: avoid calling Perl just to determine file sizes
 15:  dfd3516f39 = 15:  2593b9ba7e tests: include detailed trace logs with --write-junit-xml upon failure
 16:  9984c6d17b = 16:  991b41afa4 mingw: try to work around issues with the test cleanup
 17:  a8101ae3e1 = 17:  77896b2f8e tests: add t/helper/ to the PATH with --with-dashes
 18:  7518266a19 ! 18:  4ec6cc83ef t0061: fix with --with-dashes and RUNTIME_PREFIX
     @@ -1,23 +1,29 @@
      Author: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     -    t0061: fix with --with-dashes and RUNTIME_PREFIX
     +    t0061: workaround issues with --with-dashes and RUNTIME_PREFIX
      
          When building Git with RUNTIME_PREFIX and starting a test helper from
     -    t/helper/, it fails to detect the system prefix correctly.
     -
     -    This is the reason that the warning
     +    t/helper/, it fails to detect a system prefix. The reason is that the
     +    RUNTIME_PREFIX feature wants to use the location of the Git executable
     +    to determine where the support files can be found, e.g. system-wide Git
     +    config or the translations. This does not make any sense for the test
     +    helpers, though, as they are distinctly not in a directory structure
     +    resembling the final installation location of Git.
     +
     +    That is the reason why the test helpers rely on environment variables to
     +    indicate the location of the needed support files, e.g.
     +    GIT_TEXTDOMAINDIR. If this information is missing, the output will
     +    contain warnings like this one:
      
                  RUNTIME_PREFIX requested, but prefix computation failed. [...]
      
     -    to be printed.
     -
     -    In t0061, we did not expect that to happen, and it actually did not
     -    happen in the normal case, because bin-wrappers/test-tool specifically
     -    sets GIT_TEXTDOMAINDIR (and as a consequence, nothing in test-tool wants
     -    to know about the runtime prefix).
     +    In t0061, we did not expect that to happen, and it actually does not
     +    happen in the regular case, because bin-wrappers/test-tool specifically
     +    sets GIT_TEXTDOMAINDIR (and as a consequence, nothing in test-tool needs
     +    to know anything about any runtime prefix).
      
          However, with --with-dashes, bin-wrappers/test-tool is no longer called,
     -    but t/helper/test-tool is called directly.
     +    but t/helper/test-tool is called directly instead.
      
          So let's just ignore the RUNTIME_PREFIX warning.
      
 19:  6a8adbe8ba = 19:  248473d9fa tests: optionally skip bin-wrappers/
 20:  b39e16527d = 20:  3532811a49 ci: speed up Windows phase
 21:  6ff87d1772 = 21:  1572444361 ci: parallelize testing on Windows

-- 
gitgitgadget
