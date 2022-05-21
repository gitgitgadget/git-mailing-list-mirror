Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA4BC433EF
	for <git@archiver.kernel.org>; Sat, 21 May 2022 22:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347088AbiEUWTH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 May 2022 18:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiEUWTC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 May 2022 18:19:02 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE52E4EF53
        for <git@vger.kernel.org>; Sat, 21 May 2022 15:18:59 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id k126-20020a1ca184000000b003943fd07180so6161784wme.3
        for <git@vger.kernel.org>; Sat, 21 May 2022 15:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=W/jpIwMW0wo+/0Gmn8ss+Kom2DtbSriIllXIX0rRpUs=;
        b=Nj+64L/A354aVHpxKqYa332JaxbSgaHZoL56cnSC7IQsF1qip7LLq/1sRqsb7f4ZlZ
         Xmmd8yVHv3I9gJgrx0MwJRFH8/lEWSkmsmjV67aaAgrW0CCpO39IUGetLy9QGLZiOXgQ
         vFzqPrsv3CYGcHsFGH2SHNt5RllUcCmbtNtzr/axCL+R6kEYarb4S/0JaSCmVF6NnINq
         oONV6khYOzSz5oXT0LwrSEfPlo4kvPLpZlYBEfpkoGgOTLLTPKUErbobc+i0ZVx13diO
         wHms/oJU4jCkgYShI7B/pKUOgbU6P7OTpWVy+xruC9LdRY4HNps9+Oav7cpoS40TFS79
         T5Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=W/jpIwMW0wo+/0Gmn8ss+Kom2DtbSriIllXIX0rRpUs=;
        b=im0FeflZaBKai6DCIiZyZ8mhW8J/eH8SrLdlnjmxK2DllHzIKc4cG5dBosw87kIr0r
         vrQ7yc7iCX1ohompPtWlyWjejf5B4HNr8AgQDv5CgKiKbWA8QAKr/eC2sc/ymoGyq7u5
         dgKcSvQyaWdXP5dNrRTJyg/i/Bfz/1VcfWrpuJu3CCZ0Vp9/qBXdu9QMkKpeY8HpVSHm
         6XQ6SZfIGE8L9RtJpEl4J7ny0+XJ1NCVQ4/ojTu9OmfTMmIBeGbHOo3AmnSCjDWvG9pV
         +dH3pAhv8Ljl78oGA+WgPqIVS5OKAORAP7hsVSMk00hhSY/dVfwYsMGXE0ya5xUO1ya9
         4Tvw==
X-Gm-Message-State: AOAM532udFjGVJ+chDMZt8177XDj6p7sPL9uCsB+BxQ/wTpHLPhRIOBP
        GPn+ngUvEcCs532RflwLTw9gt2t+rAQ=
X-Google-Smtp-Source: ABdhPJxlx7nmYjXzQQbGHOHPXSfKN9YmY2E4DGY7Uxw+RxJ8uz/6UdJ0ASWLUSMZ3CXxNlF7yH87sA==
X-Received: by 2002:a05:600c:4f52:b0:394:63eb:ad27 with SMTP id m18-20020a05600c4f5200b0039463ebad27mr14151230wmq.35.1653171537786;
        Sat, 21 May 2022 15:18:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bg30-20020a05600c3c9e00b003942a244f39sm6066685wmb.18.2022.05.21.15.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 15:18:56 -0700 (PDT)
Message-Id: <pull.1117.v3.git.1653171536.gitgitgadget@gmail.com>
In-Reply-To: <pull.1117.v2.git.1646130289.gitgitgadget@gmail.com>
References: <pull.1117.v2.git.1646130289.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 May 2022 22:18:44 +0000
Subject: [PATCH v3 00/12] ci: make Git's GitHub workflow output much more helpful
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v2:

 * Logs for successful test cases are no longer shown, which improves the
   time to load pages (thanks Victoria!).
 * The preamble for each test case is no longer shown twice (thanks
   Victoria!).
 * We now explicitly mention where the full logs can be found.
 * Some patches were reordered to make the story line of this patch series
   more coherent.
 * Rebased onto main due resolve merge conflicts with
   ab/test-tap-fix-for-immediate.

I cannot thank Victoria enough for the thorough investigation; It was
exactly what I had hoped for, and if I had not been pulled into too many
directions at once, I would have incorporated her suggestions and provided a
new iteration much earlier.

It might not be all bad that this iteration had to wait a little longer,
though: In the meantime, the errors on the summary page are now deep-linked
into the part of the logs where the corresponding error message was
generated (just click on the job name above the error message).

Note: I tried to add another patch that would turn GCC's compile errors into
GitHub workflow commands
[https://docs.github.com/en/actions/using-workflows/workflow-commands-for-github-actions]
that would list the error messages on the summary page. However, that would
have required piping the output of make through a sed call, which in turn
would have required set -o pipefail (which is not supported by all the
shells that are used in our CI). I even dabbled with using process
substitution, but that made things even worse: the sed process would
continue outputting after make was finished and after the ::endgroup::
command, meaning that the output was garbled. I'll probably continue
investigating at some stage, but for now I'll call my time-boxed experiment
a wash.

Changes since v1:

 * In the patch that removed MAKE_TARGETS, a stale comment about that
   variable is also removed.
 * The comment about set -x has been adjusted because it no longer applies
   as-is.
 * The commit message of "ci: make it easier to find failed tests' logs in
   the GitHub workflow" has been adjusted to motivate the improvement
   better.


Background
==========

Using CI and in general making it easier for new contributors is an area I'm
passionate about, and one I'd like to see improved.


The current situation
=====================

Let me walk you through the current experience when a PR build fails: I get
a notification mail that only says that a certain job failed. There's no
indication of which test failed (or was it the build?). I can click on a
link at it takes me to the workflow run. Once there, all it says is "Process
completed with exit code 1", or even "code 2". Sure, I can click on one of
the failed jobs. It even expands the failed step's log (collapsing the other
steps). And what do I see there?

Let's look at an example of a failed linux-clang (ubuntu-latest) job
[https://github.com/git-for-windows/git/runs/4822802185?check_suite_focus=true]:

[...]
Test Summary Report
-------------------
t1092-sparse-checkout-compatibility.sh           (Wstat: 256 Tests: 53 Failed: 1)
  Failed test:  49
  Non-zero exit status: 1
t3701-add-interactive.sh                         (Wstat: 0 Tests: 71 Failed: 0)
  TODO passed:   45, 47
Files=957, Tests=25489, 645 wallclock secs ( 5.74 usr  1.56 sys + 866.28 cusr 364.34 csys = 1237.92 CPU)
Result: FAIL
make[1]: *** [Makefile:53: prove] Error 1
make[1]: Leaving directory '/home/runner/work/git/git/t'
make: *** [Makefile:3018: test] Error 2


That's it. I count myself lucky not to be a new contributor being faced with
something like this.

Now, since I am active in the Git project for a couple of days or so, I can
make sense of the "TODO passed" label and know that for the purpose of
fixing the build failures, I need to ignore this, and that I need to focus
on the "Failed test" part instead.

I also know that I do not have to get myself an ubuntu-latest box just to
reproduce the error, I do not even have to check out the code and run it
just to learn what that "49" means.

I know, and I do not expect any new contributor, not even most seasoned
contributors to know, that I have to patiently collapse the "Run
ci/run-build-and-tests.sh" job's log, and instead expand the "Run
ci/print-test-failures.sh" job log (which did not fail and hence does not
draw any attention to it).

I know, and again: I do not expect many others to know this, that I then
have to click into the "Search logs" box (not the regular web browser's
search via Ctrl+F!) and type in "not ok" to find the log of the failed test
case (and this might still be a "known broken" one that is marked via
test_expect_failure and once again needs to be ignored).

To be excessively clear: This is not a great experience!


Improved output
===============

Our previous Azure Pipelines-based CI builds had a much nicer UI, one that
even showed flaky tests, and trends e.g. how long the test cases ran. When I
ported Git's CI over to GitHub workflows (to make CI more accessible to new
contributors), I knew fully well that we would leave this very nice UI
behind, and I had hoped that we would get something similar back via new,
community-contributed GitHub Actions that can be used in GitHub workflows.
However, most likely because we use a home-grown test framework implemented
in opinionated POSIX shells scripts, that did not happen.

So I had a look at what standards exist e.g. when testing PowerShell
modules, in the way of marking up their test output in GitHub workflows, and
I was not disappointed: GitHub workflows support "grouping" of output lines,
i.e. marking sections of the output as a group that is then collapsed by
default and can be expanded. And it is this feature I've decided to use in
this patch series, along with GitHub workflows' commands to display errors
or notices that are also shown on the summary page of the workflow run. Now,
in addition to "Process completed with exit code" on the summary page, we
also read something like:

⊗ linux-clang (ubuntu-latest)
   failed: t3400.22 rebase --apply -q is quiet


Even better, this message is a link, and following that, the reader is
presented with something like this
[https://github.com/dscho/git/runs/6539591442?check_suite_focus=true#step:4:2954]:

[...]
=== Failed test: t3420-rebase-autostash ===
The full logs are in the artifacts attached to this run.
Error: failed: t3420.12 rebase --apply: --quit
⏵ failure: t3420.12 rebase --apply: --quit 
Error: failed: t3420.13 rebase --apply: non-conflicting rebase, conflicting stash
⏵ failure: t3420.13 rebase --apply: non-conflicting rebase, conflicting stash 
Error: failed: t3420.14 rebase --apply: check output with conflicting stash
⏵ failure: t3420.14 rebase --apply: check output with conflicting stash 
Error: failed: t3420.23 rebase --merge: --quit
⏵ failure: t3420.23 rebase --merge: --quit 
Error: failed: t3420.24 rebase --merge: non-conflicting rebase, conflicting stash
⏵ failure: t3420.24 rebase --merge: non-conflicting rebase, conflicting stash 
Error: failed: t3420.25 rebase --merge: check output with conflicting stash
⏵ failure: t3420.25 rebase --merge: check output with conflicting stash 
Error: failed: t3420.34 rebase --interactive: --quit
⏵ failure: t3420.34 rebase --interactive: --quit 
Error: failed: t3420.35 rebase --interactive: non-conflicting rebase, conflicting stash
⏵ failure: t3420.35 rebase --interactive: non-conflicting rebase, conflicting stash 
Error: failed: t3420.36 rebase --interactive: check output with conflicting stash
⏵ failure: t3420.36 rebase --interactive: check output with conflicting stash 
Error: failed: t3420.39 autostash is saved on editor failure with conflict
⏵ failure: t3420.39 autostash is saved on editor failure with conflict 
[...]


The "Failed test:" lines are colored in yellow to give a better visual clue
about the logs' structure, the "Error:" label is colored in red to draw the
attention to the important part of the log, and the "⏵" characters indicate
that part of the log is collapsed and can be expanded by clicking on it.

To drill down, the reader merely needs to expand the test case's log by
clicking on it, and then study the log. If needed (e.g. when the test case
relies on side effects from previous test cases), the logs of preceding test
cases can be expanded as well. In case the full log is needed, including the
successful test cases, they are included in the artifacts that are attached
to the CI/PR run.

Is this the best UI we can have for test failures in CI runs? I hope we can
do better. Having said that, this patch series presents a pretty good start,
and offers a basis for future improvements.

Johannes Schindelin (11):
  ci: fix code style
  tests: refactor --write-junit-xml code
  test(junit): avoid line feeds in XML attributes
  ci/run-build-and-tests: take a more high-level view
  ci: make it easier to find failed tests' logs in the GitHub workflow
  ci/run-build-and-tests: add some structure to the GitHub workflow
    output
  ci: optionally mark up output in the GitHub workflow
  ci(github): skip the logs of the successful test cases
  ci: use `--github-workflow-markup` in the GitHub workflow
  ci(github): mention where the full logs can be found
  ci: call `finalize_test_case_output` a little later

Victoria Dye (1):
  ci(github): avoid printing test case preamble twice

 .github/workflows/main.yml           |  12 ---
 ci/lib.sh                            |  83 +++++++++++++++--
 ci/run-build-and-tests.sh            |  14 +--
 ci/run-test-slice.sh                 |   5 +-
 t/test-lib-functions.sh              |   6 +-
 t/test-lib-github-workflow-markup.sh |  56 ++++++++++++
 t/test-lib-junit.sh                  | 132 +++++++++++++++++++++++++++
 t/test-lib.sh                        | 128 ++++----------------------
 8 files changed, 297 insertions(+), 139 deletions(-)
 create mode 100644 t/test-lib-github-workflow-markup.sh
 create mode 100644 t/test-lib-junit.sh


base-commit: f9b95943b68b6b8ca5a6072f50a08411c6449b55
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1117%2Fdscho%2Fuse-grouping-in-ci-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1117/dscho/use-grouping-in-ci-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1117

Range-diff vs v2:

  1:  db08b07c37a =  1:  68793fcec62 ci: fix code style
  5:  9eda6574313 =  2:  cbf476e4e98 tests: refactor --write-junit-xml code
  6:  c8b240af749 =  3:  30ccd602108 test(junit): avoid line feeds in XML attributes
  2:  42ff3e170bf =  4:  8f5b112bd08 ci/run-build-and-tests: take a more high-level view
  3:  bbbe1623257 !  5:  417f702a245 ci: make it easier to find failed tests' logs in the GitHub workflow
     @@ ci/lib.sh: check_unignored_build_artifacts () {
       
      @@ ci/lib.sh: then
       	CI_JOB_ID="$GITHUB_RUN_ID"
     - 	CC="${CC:-gcc}"
     + 	CC="${CC_PACKAGE:-${CC:-gcc}}"
       	DONT_SKIP_TAGS=t
      +	handle_failed_tests () {
      +		mkdir -p t/failed-test-artifacts
  4:  f72254a9ac6 =  6:  7d2284314ef ci/run-build-and-tests: add some structure to the GitHub workflow output
  7:  15f199e810e =  7:  98059b94a88 ci: optionally mark up output in the GitHub workflow
  -:  ----------- >  8:  d3db5252fb8 ci(github): skip the logs of the successful test cases
  -:  ----------- >  9:  51573ef6c54 ci(github): avoid printing test case preamble twice
  8:  91ea54f36c5 = 10:  7f921ffef12 ci: use `--github-workflow-markup` in the GitHub workflow
  -:  ----------- > 11:  370b08d3a11 ci(github): mention where the full logs can be found
  9:  be2a83f5da3 ! 12:  fe355a6f03b ci: call `finalize_test_case_output` a little later
     @@ t/test-lib.sh: trap '{ code=$?; set +x; } 2>/dev/null; exit $code' INT TERM HUP
       	test_failure=$(($test_failure + 1))
       	say_color error "not ok $test_count - $1"
       	shift
     - 	printf '%s\n' "$*" | sed -e 's/^/#	/'
     - 	test "$immediate" = "" || _error_exit
     +@@ t/test-lib.sh: test_failure_ () {
     + 		say_color error "1..$test_count"
     + 		_error_exit
     + 	fi
      +	finalize_test_case_output failure "$failure_label" "$@"
       }
       

-- 
gitgitgadget
