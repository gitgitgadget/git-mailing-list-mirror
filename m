Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37AA51F453
	for <e@80x24.org>; Mon, 15 Oct 2018 10:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbeJOR4f (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 13:56:35 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36334 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbeJOR4e (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 13:56:34 -0400
Received: by mail-pl1-f195.google.com with SMTP id y11-v6so9065356plt.3
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 03:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wG+qM+QMtDVEu016q+/gWQcU3K9JYMMa0TN25ZM4ULY=;
        b=GiEsnMLu7k9RvmrWYuKDepSpcU/YR+mr/9dkJ8DeuEtpPfjYn8ZmL3r9yuLaYVVqrH
         1y/EVgXwVtKOLmwdKy+llrijFz8BAMRt7eQpSOtLd85ubKMn+s2tuzixWYJT253yopuR
         Gm0qAHYBjCSaFtYRrWPxLg0t356ygQD11Ov32hAVbJipPsf0NKKD6M+tgkM1sse2YJ+c
         KmneaFylqLXBRDWxQv32ugXbo0SM2qgL3f2yM6gj/wxi85PB61pEyIfkA85/4uIpmf7g
         vZq6WtvGHojhkFRF3Ykd949xbn3IVxsxacYe/bjDbbE7To0/6gQBh14SmKlj90qdqhN8
         sqZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wG+qM+QMtDVEu016q+/gWQcU3K9JYMMa0TN25ZM4ULY=;
        b=OmBZhP24x2wonLx7ZbK2xjxfQdoogjGOfOfnqm8cM+MdkDy6GBQ1owGXW+E2Wdjcrk
         5SmtNbZYNVFOZrGZPF3s2u7Ly2q8uT3Vu8xAntN3tUQECHwkphvt/C2hmfZflYPgG8bb
         H/Em312qxGj5qq8hH0hNJ+PWxY8+1ETSTp8lwBTAJHEyOcW3CuqyIjCZ8xTu2LHRUFf3
         DOKGwGOwEzNiHH6bVAzJCBEZOijwqANOPr01ZolGG1eNGc3542yhPzjZsviwxgK3rA9f
         XKOapuKdcgEsLdrZmiU03GQ5vrg3+Ewd85LB1Nsrl87YncS4nifgcJlp5EzCDH0lfNG6
         qQKA==
X-Gm-Message-State: ABuFfoibHhvhSON9pjkB4OMLWFUv1/LVMD7FGR4zThmZpJEEma27C8TH
        Cnws7B21OB5MvBk4JK5LkJsRp/vR
X-Google-Smtp-Source: ACcGV63qAR8SOm/Pty9hQpOW3TlKB1sy3PDXtG6eQy45+BMR1rVjSndQKbuP4Hcd+CWecJGs/JzekA==
X-Received: by 2002:a17:902:1c3:: with SMTP id b61-v6mr3447639plb.65.1539598318449;
        Mon, 15 Oct 2018 03:11:58 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id s85-v6sm15873340pfi.15.2018.10.15.03.11.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 03:11:57 -0700 (PDT)
Date:   Mon, 15 Oct 2018 03:11:57 -0700 (PDT)
X-Google-Original-Date: Mon, 15 Oct 2018 10:11:42 GMT
Message-Id: <pull.31.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.git.gitgitgadget@gmail.com>
References: <pull.31.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 00/13] Offer to run CI/PR builds in Azure Pipelines
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

For a long time already, we have Git's source code continuously tested via
Travis CI, see e.g. https://travis-ci.org/git/git/builds/421738884. It has
served us well, and more and more developers actually pay attention and
benefit from the testing this gives us.

It is also an invaluable tool for contributors who can validate their code
contributions via PRs on GitHub, e.g. to verify that their tests do actually
run on macOS (i.e. with the BSD family of Unix tools instead of the GNU
one).

The one sad part about this is the Windows support. Travis lacks it, and we
work around that by using Azure Pipelines (the CI part of Azure DevOps,
formerly known as Visual Studio Team Services) indirectly: one phase in
Travis would trigger a build, wait for its log, and then paste that log.

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
, and there is a limited preview of "public projects"
[https://blogs.msdn.microsoft.com/devops/2018/04/27/vsts-public-projects-limited-preview/]
, i.e. it is possible to configure a Azure Pipelines project so that anybody
can view the logs.

I had secured such a public project for Git for Windows already, and I
recently also got one for Git. For now, the latter is hooked up with my
personal git.git fork on GitHub, but it is my hope that I convince y'all
that these Azure Pipelines builds are a good idea, and then hook it up with 
https://github.com/git/git.

As a special treat, this patch series adds the ability to present the
outcome of Git's test suite as JUnit-style .xml files. This allows the Azure
Pipelines build to present fun diagrams, trends, and makes it a lot easier
to drill down to test failures than before. See for example 
https://dev.azure.com/git/git/_build/results?buildId=113&view=ms.vss-test-web.test-result-details
[https://dev.azure.com/git/git/_build/results?buildId=113&view=ms.vss-test-web.test-result-details] 
(you can click on the label of the failed test, and then see the detailed
output in the right pane).

This patch series took way more time than I had originally planned, but I
think that in particular the advanced display of the test results was worth
it. Please let me know what you think about this.

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

Johannes Schindelin (13):
  ci: rename the library of common functions
  ci/lib.sh: encapsulate Travis-specific things
  test-date: add a subcommand to measure times in shell scripts
  tests: optionally write results as JUnit-style .xml
  ci/lib.sh: add support for Azure Pipelines
  Add a build definition for Azure DevOps
  tests: introduce `test_atexit`
  git-daemon: use `test_atexit` in the tests
  git-p4: use `test_atexit` to kill the daemon
  tests: include detailed trace logs with --write-junit-xml upon failure
  tests: record more stderr with --write-junit-xml in case of failure
  README: add a build badge (status of the Azure Pipelines build)
  travis: fix skipping tagged releases

 README.md                                  |   2 +
 azure-pipelines.yml                        | 319 +++++++++++++++++++++
 ci/install-dependencies.sh                 |   5 +-
 ci/{lib-travisci.sh => lib.sh}             |  67 ++++-
 ci/mount-fileshare.sh                      |  26 ++
 ci/print-test-failures.sh                  |   4 +-
 ci/run-build-and-tests.sh                  |   2 +-
 ci/run-linux32-docker.sh                   |   2 +-
 ci/run-static-analysis.sh                  |   2 +-
 ci/run-windows-build.sh                    |   2 +-
 ci/test-documentation.sh                   |   3 +-
 t/.gitignore                               |   1 +
 t/helper/test-date.c                       |  12 +
 t/interop/i5500-git-daemon.sh              |   1 -
 t/lib-git-daemon.sh                        |   3 +-
 t/lib-git-p4.sh                            |  10 +-
 t/t0000-basic.sh                           |  20 ++
 t/t5570-git-daemon.sh                      |   1 -
 t/t9800-git-p4-basic.sh                    |   4 -
 t/t9801-git-p4-branch.sh                   |   4 -
 t/t9802-git-p4-filetype.sh                 |   4 -
 t/t9803-git-p4-shell-metachars.sh          |   4 -
 t/t9804-git-p4-label.sh                    |   4 -
 t/t9805-git-p4-skip-submit-edit.sh         |   4 -
 t/t9806-git-p4-options.sh                  |   5 -
 t/t9807-git-p4-submit.sh                   |   4 -
 t/t9808-git-p4-chdir.sh                    |   4 -
 t/t9809-git-p4-client-view.sh              |   4 -
 t/t9810-git-p4-rcs.sh                      |   4 -
 t/t9811-git-p4-label-import.sh             |   5 -
 t/t9812-git-p4-wildcards.sh                |   4 -
 t/t9813-git-p4-preserve-users.sh           |   4 -
 t/t9814-git-p4-rename.sh                   |   4 -
 t/t9815-git-p4-submit-fail.sh              |   4 -
 t/t9816-git-p4-locked.sh                   |   4 -
 t/t9817-git-p4-exclude.sh                  |   4 -
 t/t9818-git-p4-block.sh                    |   4 -
 t/t9819-git-p4-case-folding.sh             |   4 -
 t/t9820-git-p4-editor-handling.sh          |   4 -
 t/t9821-git-p4-path-variations.sh          |   4 -
 t/t9822-git-p4-path-encoding.sh            |   4 -
 t/t9823-git-p4-mock-lfs.sh                 |   4 -
 t/t9824-git-p4-git-lfs.sh                  |   4 -
 t/t9825-git-p4-handle-utf16-without-bom.sh |   4 -
 t/t9826-git-p4-keep-empty-commits.sh       |   4 -
 t/t9827-git-p4-change-filetype.sh          |   4 -
 t/t9828-git-p4-map-user.sh                 |   4 -
 t/t9829-git-p4-jobs.sh                     |   4 -
 t/t9830-git-p4-symlink-dir.sh              |   4 -
 t/t9831-git-p4-triggers.sh                 |   4 -
 t/t9832-unshelve.sh                        |   4 -
 t/t9833-errors.sh                          |   5 -
 t/test-lib-functions.sh                    |  29 ++
 t/test-lib.sh                              | 140 +++++++++
 54 files changed, 616 insertions(+), 174 deletions(-)
 create mode 100644 azure-pipelines.yml
 rename ci/{lib-travisci.sh => lib.sh} (61%)
 create mode 100755 ci/mount-fileshare.sh


base-commit: 5a0cc8aca797dbd7d2be3b67458ff880ed45cddf
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-31%2Fdscho%2Fvsts-ci-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-31/dscho/vsts-ci-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/31

Range-diff vs v1:

  1:  858b80bfcf !  1:  c963184510 ci: rename the library of common functions
     @@ -5,8 +5,8 @@
          The name is hard-coded to reflect that we use Travis CI for continuous
          testing.
      
     -    In the next commits, we will extend this to be able use Visual Studio
     -    Team Services, too.
     +    In the next commits, we will extend this to be able use Azure DevOps,
     +    too.
      
          So let's adjust the name to make it more generic.
      
  2:  18e6beec5f !  2:  815152e0f5 ci/lib.sh: encapsulate Travis-specific things
     @@ -2,8 +2,9 @@
      
          ci/lib.sh: encapsulate Travis-specific things
      
     -    The upcoming patches will allow building git.git via VSTS CI, where
     -    variable names and URLs look a bit different than in Travis CI.
     +    The upcoming patches will allow building git.git via Azure Pipelines
     +    (i.e. Azure DevOps' Continuous Integration), where variable names and
     +    URLs look a bit different than in Travis CI.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     @@ -16,7 +17,7 @@
       	# brew install gnu-time
      -	brew install git-lfs gettext
      +	test -z "$BREW_INSTALL_PACKAGES" ||
     -+	eval brew install $BREW_INSTALL_PACKAGES
     ++	brew install $BREW_INSTALL_PACKAGES
       	brew link --force gettext
       	brew install caskroom/cask/perforce
       	;;
     @@ -27,7 +28,7 @@
      @@
       # Library of functions shared by all CI scripts
       
     -+if test -n "$TRAVIS_COMMIT"
     ++if test true = "$TRAVIS"
      +then
      +	# We are running within Travis CI
      +	CI_BRANCH="$TRAVIS_BRANCH"
  3:  064db77669 =  3:  52337f1875 test-date: add a subcommand to measure times in shell scripts
  4:  2b5d678594 !  4:  cf4c5ae470 tests: optionally write results as JUnit-style .xml
     @@ -3,7 +3,7 @@
          tests: optionally write results as JUnit-style .xml
      
          This will come in handy when publishing the results of Git's test suite
     -    during an automated VSTS CI run.
     +    during an automated Azure DevOps run.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
  5:  127dfcfb09 !  5:  486d1d2518 ci/lib.sh: add support for VSTS CI
     @@ -1,6 +1,6 @@
      Author: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     -    ci/lib.sh: add support for VSTS CI
     +    ci/lib.sh: add support for Azure Pipelines
      
          This patch introduces a conditional arm that defines some environment
          variables and a function that displays the URL given the job id (to
     @@ -17,7 +17,7 @@
       	export GIT_TEST_OPTS="--verbose-log -x --immediate"
      +elif test -n "$SYSTEM_TASKDEFINITIONSURI"
      +then
     -+	# We are running in VSTS CI
     ++	# We are running in Azure Pipelines
      +	CI_BRANCH="$BUILD_SOURCEBRANCH"
      +	CI_COMMIT="$BUILD_SOURCEVERSION"
      +	CI_JOB_ID="$BUILD_BUILDID"
     @@ -29,7 +29,7 @@
      +
      +	# use a subdirectory of the cache dir (because the file share is shared
      +	# among *all* phases)
     -+	cache_dir="$HOME/vsts-cache/$SYSTEM_PHASENAME"
     ++	cache_dir="$HOME/test-cache/$SYSTEM_PHASENAME"
      +
      +	url_for_job_id () {
      +		echo "$SYSTEM_TASKDEFINITIONSURI$SYSTEM_TEAMPROJECT/_build/results?buildId=$1"
  6:  ab66060c57 !  6:  1a22efe849 Add a build definition for VSTS
     @@ -1,8 +1,8 @@
      Author: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     -    Add a build definition for VSTS
     +    Add a build definition for Azure DevOps
      
     -    This commit adds a .vsts-ci.yml which is Visual Studio Team Services'
     +    This commit adds an azure-pipelines.yml file which is Azure DevOps'
          equivalent to Travis CI's .travis.yml.
      
          To make things a bit easier to understand, we refrain from using the
     @@ -19,10 +19,10 @@
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     -diff --git a/.vsts-ci.yml b/.vsts-ci.yml
     +diff --git a/azure-pipelines.yml b/azure-pipelines.yml
      new file mode 100644
      --- /dev/null
     -+++ b/.vsts-ci.yml
     ++++ b/azure-pipelines.yml
      @@
      +resources:
      +- repo: self
     @@ -36,12 +36,12 @@
      +    name: Hosted Ubuntu 1604
      +  steps:
      +  - bash: |
     -+       ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/vsts-cache gitfileshare "$(gitfileshare.pwd)" "$HOME/vsts-cache" || exit 1
     ++       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
      +
     -+       sudo apt-get update
     -+       sudo apt-get -y install git gcc make libssl-dev libcurl4-openssl-dev libexpat-dev tcl tk gettext git-email zlib1g-dev apache2-bin
     ++       sudo apt-get update &&
     ++       sudo apt-get -y install git gcc make libssl-dev libcurl4-openssl-dev libexpat-dev tcl tk gettext git-email zlib1g-dev apache2-bin &&
      +
     -+       export CC=clang
     ++       export CC=clang || exit 1
      +
      +       ci/install-dependencies.sh
      +       ci/run-build-and-tests.sh || {
     @@ -49,8 +49,10 @@
      +           exit 1
      +       }
      +
     -+       sudo umount "$HOME/vsts-cache" || exit 1
     ++       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || sudo umount "$HOME/test-cache" || exit 1
      +    displayName: 'ci/run-build-and-tests.sh'
     ++    env:
     ++      GITFILESHAREPWD: $(gitfileshare.pwd)
      +  - task: PublishTestResults@2
      +    displayName: 'Publish Test Results **/TEST-*.xml'
      +    inputs:
     @@ -67,10 +69,10 @@
      +    name: Hosted Ubuntu 1604
      +  steps:
      +  - bash: |
     -+       ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/vsts-cache gitfileshare "$(gitfileshare.pwd)" "$HOME/vsts-cache" || exit 1
     ++       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
      +
     -+       sudo apt-get update
     -+       sudo apt-get -y install git gcc make libssl-dev libcurl4-openssl-dev libexpat-dev tcl tk gettext git-email zlib1g-dev apache2-bin
     ++       sudo apt-get update &&
     ++       sudo apt-get -y install git gcc make libssl-dev libcurl4-openssl-dev libexpat-dev tcl tk gettext git-email zlib1g-dev apache2-bin || exit 1
      +
      +       ci/install-dependencies.sh
      +       ci/run-build-and-tests.sh || {
     @@ -78,8 +80,10 @@
      +           exit 1
      +       }
      +
     -+       sudo umount "$HOME/vsts-cache" || exit 1
     ++       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || sudo umount "$HOME/test-cache" || exit 1
      +    displayName: 'ci/run-build-and-tests.sh'
     ++    env:
     ++      GITFILESHAREPWD: $(gitfileshare.pwd)
      +  - task: PublishTestResults@2
      +    displayName: 'Publish Test Results **/TEST-*.xml'
      +    inputs:
     @@ -96,7 +100,7 @@
      +    name: Hosted macOS
      +  steps:
      +  - bash: |
     -+       ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/vsts-cache gitfileshare "$(gitfileshare.pwd)" "$HOME/vsts-cache" || exit 1
     ++       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
      +
      +       export CC=clang
      +
     @@ -106,8 +110,10 @@
      +           exit 1
      +       }
      +
     -+       umount "$HOME/vsts-cache" || exit 1
     ++       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || umount "$HOME/test-cache" || exit 1
      +    displayName: 'ci/run-build-and-tests.sh'
     ++    env:
     ++      GITFILESHAREPWD: $(gitfileshare.pwd)
      +  - task: PublishTestResults@2
      +    displayName: 'Publish Test Results **/TEST-*.xml'
      +    inputs:
     @@ -124,7 +130,7 @@
      +    name: Hosted macOS
      +  steps:
      +  - bash: |
     -+       ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/vsts-cache gitfileshare "$(gitfileshare.pwd)" "$HOME/vsts-cache" || exit 1
     ++       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
      +
      +       ci/install-dependencies.sh
      +       ci/run-build-and-tests.sh || {
     @@ -132,8 +138,10 @@
      +           exit 1
      +       }
      +
     -+       umount "$HOME/vsts-cache" || exit 1
     ++       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || umount "$HOME/test-cache" || exit 1
      +    displayName: 'ci/run-build-and-tests.sh'
     ++    env:
     ++      GITFILESHAREPWD: $(gitfileshare.pwd)
      +  - task: PublishTestResults@2
      +    displayName: 'Publish Test Results **/TEST-*.xml'
      +    inputs:
     @@ -150,20 +158,22 @@
      +    name: Hosted Ubuntu 1604
      +  steps:
      +  - bash: |
     -+       ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/vsts-cache gitfileshare "$(gitfileshare.pwd)" "$HOME/vsts-cache" || exit 1
     ++       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
      +
     -+       sudo apt-get update
     -+       sudo apt-get -y install git gcc make libssl-dev libcurl4-openssl-dev libexpat-dev tcl tk gettext git-email zlib1g-dev
     ++       sudo apt-get update &&
     ++       sudo apt-get -y install git gcc make libssl-dev libcurl4-openssl-dev libexpat-dev tcl tk gettext git-email zlib1g-dev &&
      +
     -+       export jobname=GETTEXT_POISON
     ++       export jobname=GETTEXT_POISON || exit 1
      +
      +       ci/run-build-and-tests.sh || {
      +           ci/print-test-failures.sh
      +           exit 1
      +       }
      +
     -+       sudo umount "$HOME/vsts-cache" || exit 1
     ++       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || sudo umount "$HOME/test-cache" || exit 1
      +    displayName: 'ci/run-build-and-tests.sh'
     ++    env:
     ++      GITFILESHAREPWD: $(gitfileshare.pwd)
      +  - task: PublishTestResults@2
      +    displayName: 'Publish Test Results **/TEST-*.xml'
      +    inputs:
     @@ -184,8 +194,10 @@
      +       # Helper to check the error level of the latest command (exit with error when appropriate)
      +       function c() { if (!$?) { exit(1) } }
      +
     -+       net use s: \\gitfileshare.file.core.windows.net\vsts-cache "$(gitfileshare.pwd)" /user:AZURE\gitfileshare /persistent:no; c
     -+       cmd /c mklink /d "$(Build.SourcesDirectory)\vsts-cache" S:\; c
     ++       if ("$GITFILESHAREPWD" -ne "" -and "$GITFILESHAREPWD" -ne "`$`(gitfileshare.pwd)") {
     ++         net use s: \\gitfileshare.file.core.windows.net\test-cache "$GITFILESHAREPWD" /user:AZURE\gitfileshare /persistent:no; c
     ++         cmd /c mklink /d "$(Build.SourcesDirectory)\test-cache" S:\; c
     ++       }
      +
      +       # Add build agent's MinGit to PATH
      +       $env:PATH = $env:AGENT_HOMEDIRECTORY +"\externals\\git\cmd;" +$env:PATH
     @@ -215,7 +227,7 @@
      +
      +       # Initialize Git for Windows' SDK
      +       $sdk_path = "$(Build.SourcesDirectory)\git-sdk-64"
     -+       init "$sdk_path" "https://git-for-windows.visualstudio.com/_git/git-sdk-64" 0
     ++       init "$sdk_path" "https://dev.azure.com/git-for-windows/git-sdk-64/_git/git-sdk-64" 0
      +       init usr\src\build-extra https://github.com/git-for-windows/build-extra 1
      +
      +       cd "$(Build.SourcesDirectory)"; c
     @@ -227,14 +239,19 @@
      +
      +         make -j10 DEVELOPER=1 NO_PERL=1 || exit 1
      +         NO_PERL=1 NO_SVN_TESTS=1 GIT_TEST_OPTS=\"--quiet --write-junit-xml\" time make -j15 -k DEVELOPER=1 test || {
     -+           NO_PERL=1 NO_SVN_TESTS=1 GIT_TEST_OPTS=\"-i -v -x\" make -k failed; exit 1
     ++           NO_PERL=1 NO_SVN_TESTS=1 GIT_TEST_OPTS=\"-i -v -x\" make -k -C t failed; exit 1
      +         }
      +
      +         save_good_tree
      +       "@
     ++       c
      +
     -+       cmd /c rmdir "$(Build.SourcesDirectory)\vsts-cache"
     ++       if ("$GITFILESHAREPWD" -ne "" -and "$GITFILESHAREPWD" -ne "`$`(gitfileshare.pwd)") {
     ++         cmd /c rmdir "$(Build.SourcesDirectory)\test-cache"
     ++       }
      +    displayName: 'build & test'
     ++    env:
     ++      GITFILESHAREPWD: $(gitfileshare.pwd)
      +  - task: PublishTestResults@2
      +    displayName: 'Publish Test Results **/TEST-*.xml'
      +    inputs:
     @@ -251,28 +268,30 @@
      +    name: Hosted Ubuntu 1604
      +  steps:
      +  - bash: |
     -+       ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/vsts-cache gitfileshare "$(gitfileshare.pwd)" "$HOME/vsts-cache" || exit 1
     ++       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
      +
     -+       sudo apt-get update
     ++       sudo apt-get update &&
      +       sudo apt-get -y install \
      +           apt-transport-https \
      +           ca-certificates \
      +           curl \
     -+           software-properties-common
     -+       curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
     ++           software-properties-common &&
     ++       curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - &&
      +       sudo add-apt-repository \
      +          "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
      +          $(lsb_release -cs) \
     -+          stable"
     -+       sudo apt-get update
     -+       sudo apt-get -y install docker-ce
     ++          stable" &&
     ++       sudo apt-get update &&
     ++       sudo apt-get -y install docker-ce &&
      +
      +       sudo AGENT_OS="$AGENT_OS" BUILD_BUILDNUMBER="$BUILD_BUILDNUMBER" BUILD_REPOSITORY_URI="$BUILD_REPOSITORY_URI" BUILD_SOURCEBRANCH="$BUILD_SOURCEBRANCH" BUILD_SOURCEVERSION="$BUILD_SOURCEVERSION" SYSTEM_PHASENAME="$SYSTEM_PHASENAME" SYSTEM_TASKDEFINITIONSURI="$SYSTEM_TASKDEFINITIONSURI" SYSTEM_TEAMPROJECT="$SYSTEM_TEAMPROJECT" CC=$CC MAKEFLAGS=-j3 bash -lxc ci/run-linux32-docker.sh || exit 1
      +
      +       sudo chmod a+r t/out/TEST-*.xml
      +
     -+       sudo umount "$HOME/vsts-cache" || exit 1
     ++       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || sudo umount "$HOME/test-cache" || exit 1
      +    displayName: 'ci/run-linux32-docker.sh'
     ++    env:
     ++      GITFILESHAREPWD: $(gitfileshare.pwd)
      +  - task: PublishTestResults@2
      +    displayName: 'Publish Test Results **/TEST-*.xml'
      +    inputs:
     @@ -289,17 +308,19 @@
      +    name: Hosted Ubuntu 1604
      +  steps:
      +  - bash: |
     -+       ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/vsts-cache gitfileshare "$(gitfileshare.pwd)" "$HOME/vsts-cache" || exit 1
     ++       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
      +
     -+       sudo apt-get update
     -+       sudo apt-get install -y coccinelle
     ++       sudo apt-get update &&
     ++       sudo apt-get install -y coccinelle &&
      +
     -+       export jobname=StaticAnalysis
     ++       export jobname=StaticAnalysis &&
      +
      +       ci/run-static-analysis.sh || exit 1
      +
     -+       sudo umount "$HOME/vsts-cache" || exit 1
     ++       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || sudo umount "$HOME/test-cache" || exit 1
      +    displayName: 'ci/run-static-analysis.sh'
     ++    env:
     ++      GITFILESHAREPWD: $(gitfileshare.pwd)
      +
      +- phase: documentation
      +  displayName: Documentation
     @@ -308,18 +329,20 @@
      +    name: Hosted Ubuntu 1604
      +  steps:
      +  - bash: |
     -+       ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/vsts-cache gitfileshare "$(gitfileshare.pwd)" "$HOME/vsts-cache" || exit 1
     ++       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
      +
     -+       sudo apt-get update
     -+       sudo apt-get install -y asciidoc xmlto asciidoctor
     ++       sudo apt-get update &&
     ++       sudo apt-get install -y asciidoc xmlto asciidoctor &&
      +
     -+       export ALREADY_HAVE_ASCIIDOCTOR=yes.
     -+       export jobname=Documentation
     ++       export ALREADY_HAVE_ASCIIDOCTOR=yes. &&
     ++       export jobname=Documentation &&
      +
      +       ci/test-documentation.sh || exit 1
      +
     -+       sudo umount "$HOME/vsts-cache" || exit 1
     ++       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || sudo umount "$HOME/test-cache" || exit 1
      +    displayName: 'ci/test-documentation.sh'
     ++    env:
     ++      GITFILESHAREPWD: $(gitfileshare.pwd)
      
      diff --git a/ci/mount-fileshare.sh b/ci/mount-fileshare.sh
      new file mode 100755
  -:  ---------- >  7:  12d6137f8d tests: introduce `test_atexit`
  -:  ---------- >  8:  3bb226b79b git-daemon: use `test_atexit` in the tests
  -:  ---------- >  9:  3e2193a73d git-p4: use `test_atexit` to kill the daemon
  7:  942bf423a4 ! 10:  ae3c42519a tests: include detailed trace logs with --write-junit-xml upon failure
     @@ -14,9 +14,9 @@
          almost all of those cases: only when a test fails do we have a way to
          include the trace.
      
     -    So let's do something different in VSTS: let's run all the tests with
     -    `--quiet` first, and only if a failure is encountered, try to trace the
     -    commands as they are executed.
     +    So let's do something different when using Azure DevOps: let's run all
     +    the tests with `--quiet` first, and only if a failure is encountered,
     +    try to trace the commands as they are executed.
      
          Of course, we cannot turn on `--verbose-log` after the fact. So let's
          just re-run the test with all the same options, adding `--verbose-log`.
     @@ -25,15 +25,10 @@
          Note: there is an off chance that re-running the test in verbose mode
          "fixes" the failures (and this does happen from time to time!). That is
          a possibility we should be able to live with. Ideally, we would label
     -    this as "Passed upon rerun", and that outcome even exists on VSTS, but
     -    it is not available when using the JUnit XML format for now:
     -    https://github.com/Microsoft/vsts-agent/blob/master/src/Agent.Worker/TestResults/JunitResultReader.cs
     -
     -    This patch contains a slightly inelegant workaround for the p4 and
     -    git-daemon tests: when we try to re-run the p4/git-daemon tests after
     -    the daemon has been started already, we need to kill said daemon. We do
     -    this by detecting the presence of the `kill_p4d` and `stop_git_daemon`
     -    shell functions and calling them if available.
     +    this as "Passed upon rerun", and Azure Pipelines even know about that
     +    outcome, but it is not available when using the JUnit XML format for
     +    now:
     +    https://github.com/Microsoft/azure-pipelines-agent/blob/master/src/Agent.Worker/TestResults/JunitResultReader.cs
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     @@ -60,14 +55,8 @@
       	then
      +		if test -z "$GIT_TEST_TEE_OUTPUT_FILE"
      +		then
     -+			case "$(type kill_p4d 2>/dev/null | head -n 1)" in
     -+			*function*) kill_p4d;;
     -+			esac
     -+
     -+			case "$(type stop_git_daemon 2>/dev/null |
     -+				head -n 1)" in
     -+			*function*) stop_git_daemon;;
     -+			esac
     ++			# clean up
     ++			test_atexit_handler
      +
      +			# re-run with --verbose-log
      +			echo "# Re-running: $junit_rerun_options_sq" >&2
  8:  3e83c64090 = 11:  2466a48aa3 tests: record more stderr with --write-junit-xml in case of failure
  9:  dc1d890d71 ! 12:  d112b3fe86 README: add a build badge (status of the VSTS build)
     @@ -1,6 +1,6 @@
      Author: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     -    README: add a build badge (status of the VSTS build)
     +    README: add a build badge (status of the Azure Pipelines build)
      
          Just like so many other OSS projects, we now also have a build badge.
      
     @@ -10,7 +10,7 @@
      --- a/README.md
      +++ b/README.md
      @@
     -+[![Build Status](https://git.visualstudio.com/git/_apis/build/status/test-git.git)](https://git.visualstudio.com/git/_build/latest?definitionId=2)
     ++[![Build Status](https:/dev.azure.com/git/git/_apis/build/status/test-git.git)](https://dev.azure.com/git/git/_build/latest?definitionId=2)
      +
       Git - fast, scalable, distributed revision control system
       =========================================================
  -:  ---------- > 13:  0a53f37135 travis: fix skipping tagged releases

-- 
gitgitgadget
