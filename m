Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50723C433F5
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 00:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357054AbiCYAuI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 20:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239525AbiCYAuE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 20:50:04 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47B82AE00
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 17:48:28 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id c23so6534282plo.0
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 17:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fVOjtjnHP2IDpN5I1IPatd9qOcjYXVVnW2eaG+TQKVw=;
        b=a06ZBIAWiFAxDXYsBIYhWSKkGPkNW9SElWxBhRZThktwd/aRrv4+9XM3LYmKUdXMJV
         fR0jWJV8MVzrmfMiYdyEHDvAvrNwN1w+AhlSRXRDotnHzVqVTTuoX6Cim3aaFjXTkG43
         rkhbpNlioHYaYfhx4feABtX1DKZa42J6MUgoYy5dqIIyuvpRNaHUyN9UdT6erD5AaHR8
         ffhpKOWXxVVPxswupw/m+vy/ooE8Ac1IccRwRkhFrMjZuZne3+2qRPD6SeRBVV94kEup
         fPbelLwiPlBJWkuydEiAyRR/XJZnpe8TpUFNJ058TNvBiEjV0DJ+DzR8SY22EFV3IEqX
         ddDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fVOjtjnHP2IDpN5I1IPatd9qOcjYXVVnW2eaG+TQKVw=;
        b=EIvGGGnrJSv0zFQaJrb/aRgRcMnLTpzZHsKYKixhGvhAoPp7p+a+PLXqodc3lq9v6H
         j+X6Ry4nqZci2ibLpwHuYR7wYRkepR1cFIxAC8BDA64Rl+aXQ8XV/ya5hsUdwchHl2uq
         WU77sOZCIZsype4MKsOk9u8B0Pet5cR3HuI7FMtv2t8r9Q0puQ8YIp1x9agSqErrjHBm
         0zdEnMJBRGR6+U9CougqYRpsX3NIzSrJpv58FDm4Dr43JCNQQz7F/jBwuzLjWBA7nxSF
         C0nv3tXa7o7DI/19eN+leUd8lnR29nVfD3X44j/9zV6UTiYMO+2N4vKGwTScAXDDiVHE
         K0ew==
X-Gm-Message-State: AOAM531eTl3TDRImGXgOBXcuDkMvn4wE/lYZaWbCTaHvGf8b97gFMkgJ
        ohEJatUuP/y4+Fp2bWSagA+e
X-Google-Smtp-Source: ABdhPJxveQDsaKH1qw01nitflStxKUEde0mKBrdYi1M/YlZ/hpCWP+mG8YXjQDyN7ykxa8kEvQ47Ug==
X-Received: by 2002:a17:902:db0f:b0:154:665e:af75 with SMTP id m15-20020a170902db0f00b00154665eaf75mr8584050plx.147.1648169308009;
        Thu, 24 Mar 2022 17:48:28 -0700 (PDT)
Received: from [192.168.0.102] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id w13-20020a17090a5e0d00b001c7d4099670sm1455193pjf.28.2022.03.24.17.48.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 17:48:27 -0700 (PDT)
Message-ID: <6b83bb83-32b9-20c9-fa02-c1c3170351c3@github.com>
Date:   Thu, 24 Mar 2022 17:48:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v2 0/9] ci: make Git's GitHub workflow output much more
 helpful
Content-Language: en-US
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com>
 <pull.1117.v2.git.1646130289.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <pull.1117.v2.git.1646130289.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin via GitGitGadget wrote:
> Changes since v1:
> 
>  * In the patch that removed MAKE_TARGETS, a stale comment about that
>    variable is also removed.
>  * The comment about set -x has been adjusted because it no longer applies
>    as-is.
>  * The commit message of "ci: make it easier to find failed tests' logs in
>    the GitHub workflow" has been adjusted to motivate the improvement
>    better.
> 
> 
> Background
> ==========
> 
> Recent patches intended to help readers figure out CI failures much quicker
> than before. Unfortunately, they haven't been entirely positive for me. For
> example, they broke the branch protections in Microsoft's fork of Git, where
> we require Pull Requests to pass a certain set of Checks (which are
> identified by their names) and therefore caused follow-up work.
> 
> Using CI and in general making it easier for new contributors is an area I'm
> passionate about, and one I'd like to see improved.
> 
> 
> The current situation
> =====================
> 
> Let me walk you through the current experience when a PR build fails: I get
> a notification mail that only says that a certain job failed. There's no
> indication of which test failed (or was it the build?). I can click on a
> link at it takes me to the workflow run. Once there, all it says is "Process
> completed with exit code 1", or even "code 2". Sure, I can click on one of
> the failed jobs. It even expands the failed step's log (collapsing the other
> steps). And what do I see there?
> 
> Let's look at an example of a failed linux-clang (ubuntu-latest) job
> [https://github.com/git-for-windows/git/runs/4822802185?check_suite_focus=true]:
> 
> [...]
> Test Summary Report
> -------------------
> t1092-sparse-checkout-compatibility.sh           (Wstat: 256 Tests: 53 Failed: 1)
>   Failed test:  49
>   Non-zero exit status: 1
> t3701-add-interactive.sh                         (Wstat: 0 Tests: 71 Failed: 0)
>   TODO passed:   45, 47
> Files=957, Tests=25489, 645 wallclock secs ( 5.74 usr  1.56 sys + 866.28 cusr 364.34 csys = 1237.92 CPU)
> Result: FAIL
> make[1]: *** [Makefile:53: prove] Error 1
> make[1]: Leaving directory '/home/runner/work/git/git/t'
> make: *** [Makefile:3018: test] Error 2
> 
> 
> That's it. I count myself lucky not to be a new contributor being faced with
> something like this.
> 
> Now, since I am active in the Git project for a couple of days or so, I can
> make sense of the "TODO passed" label and know that for the purpose of
> fixing the build failures, I need to ignore this, and that I need to focus
> on the "Failed test" part instead.
> 
> I also know that I do not have to get myself an ubuntu-latest box just to
> reproduce the error, I do not even have to check out the code and run it
> just to learn what that "49" means.
> 
> I know, and I do not expect any new contributor, not even most seasoned
> contributors to know, that I have to patiently collapse the "Run
> ci/run-build-and-tests.sh" job's log, and instead expand the "Run
> ci/print-test-failures.sh" job log (which did not fail and hence does not
> draw any attention to it).
> 

You can count me as one of the ones that, until this series, had no idea
this information existed in the CI logs. And it definitely would have been
helpful in figuring out some of the OS-specific bugs I've run into in the
past. :) 

> I know, and again: I do not expect many others to know this, that I then
> have to click into the "Search logs" box (not the regular web browser's
> search via Ctrl+F!) and type in "not ok" to find the log of the failed test
> case (and this might still be a "known broken" one that is marked via
> test_expect_failure and once again needs to be ignored).
> 
> To be excessively clear: This is not a great experience!
> 
> 
> Improved output
> ===============
> 
> Our previous Azure Pipelines-based CI builds had a much nicer UI, one that
> even showed flaky tests, and trends e.g. how long the test cases ran. When I
> ported Git's CI over to GitHub workflows (to make CI more accessible to new
> contributors), I knew fully well that we would leave this very nice UI
> behind, and I had hoped that we would get something similar back via new,
> community-contributed GitHub Actions that can be used in GitHub workflows.
> However, most likely because we use a home-grown test framework implemented
> in opinionated POSIX shells scripts, that did not happen.
> 
> So I had a look at what standards exist e.g. when testing PowerShell
> modules, in the way of marking up their test output in GitHub workflows, and
> I was not disappointed: GitHub workflows support "grouping" of output lines,
> i.e. marking sections of the output as a group that is then collapsed by
> default and can be expanded. And it is this feature I decided to use in this
> patch series, along with GitHub workflows' commands to display errors or
> notices that are also shown on the summary page of the workflow run. Now, in
> addition to "Process completed with exit code" on the summary page, we also
> read something like:
> 
> ⊗ linux-gcc (ubuntu-latest)
>    failed: t9800.20 submit from detached head
> 
> 
> Even better, this message is a link, and following that, the reader is
> presented with something like this
> [https://github.com/dscho/git/runs/4840190622?check_suite_focus=true]:
> 
> ⏵ Run ci/run-build-and-tests.sh
> ⏵ CI setup
>   + ln -s /home/runner/none/.prove t/.prove
>   + run_tests=t
>   + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>   + group Build make
>   + set +x
> ⏵ Build
> ⏵ Run tests
>   === Failed test: t9800-git-p4-basic ===
> ⏵ ok: t9800.1 start p4d
> ⏵ ok: t9800.2 add p4 files
> ⏵ ok: t9800.3 basic git p4 clone
> ⏵ ok: t9800.4 depot typo error
> ⏵ ok: t9800.5 git p4 clone @all
> ⏵ ok: t9800.6 git p4 sync uninitialized repo
> ⏵ ok: t9800.7 git p4 sync new branch
> ⏵ ok: t9800.8 clone two dirs
> ⏵ ok: t9800.9 clone two dirs, @all
> ⏵ ok: t9800.10 clone two dirs, @all, conflicting files
> ⏵ ok: t9800.11 clone two dirs, each edited by submit, single git commit
> ⏵ ok: t9800.12 clone using non-numeric revision ranges
> ⏵ ok: t9800.13 clone with date range, excluding some changes
> ⏵ ok: t9800.14 exit when p4 fails to produce marshaled output
> ⏵ ok: t9800.15 exit gracefully for p4 server errors
> ⏵ ok: t9800.16 clone --bare should make a bare repository
> ⏵ ok: t9800.17 initial import time from top change time
> ⏵ ok: t9800.18 unresolvable host in P4PORT should display error
> ⏵ ok: t9800.19 run hook p4-pre-submit before submit
>   Error: failed: t9800.20 submit from detached head
> ⏵ failure: t9800.20 submit from detached head 
>   Error: failed: t9800.21 submit from worktree
> ⏵ failure: t9800.21 submit from worktree 
>   === Failed test: t9801-git-p4-branch ===
>   [...]
> 
> 
> The "Failed test:" lines are colored in yellow to give a better visual clue
> about the logs' structure, the "Error:" label is colored in red to draw the
> attention to the important part of the log, and the "⏵" characters indicate
> that part of the log is collapsed and can be expanded by clicking on it.
> 
> To drill down, the reader merely needs to expand the (failed) test case's
> log by clicking on it, and then study the log. If needed (e.g. when the test
> case relies on side effects from previous test cases), the logs of preceding
> test cases can be expanded as well. In this example, when expanding
> t9800.20, it looks like this (for ease of reading, I cut a few chunks of
> lines, indicated by "[...]"):
> 
> [...]
> ⏵ ok: t9800.19 run hook p4-pre-submit before submit
>   Error: failed: t9800.20 submit from detached head
> ⏷ failure: t9800.20 submit from detached head 
>       test_when_finished cleanup_git &&
>       git p4 clone --dest="$git" //depot &&
>         (
>           cd "$git" &&
>           git checkout p4/master &&
>           >detached_head_test &&
>           git add detached_head_test &&
>           git commit -m "add detached_head" &&
>           git config git-p4.skipSubmitEdit true &&
>           git p4 submit &&
>             git p4 rebase &&
>             git log p4/master | grep detached_head
>         )
>     [...]
>     Depot paths: //depot/
>     Import destination: refs/remotes/p4/master
>     
>     Importing revision 9 (100%)Perforce db files in '.' will be created if missing...
>     Perforce db files in '.' will be created if missing...
>     
>     Traceback (most recent call last):
>       File "/home/runner/work/git/git/git-p4", line 4455, in <module>
>         main()
>       File "/home/runner/work/git/git/git-p4", line 4449, in main
>         if not cmd.run(args):
>       File "/home/runner/work/git/git/git-p4", line 2590, in run
>         rebase.rebase()
>       File "/home/runner/work/git/git/git-p4", line 4121, in rebase
>         if len(read_pipe("git diff-index HEAD --")) > 0:
>       File "/home/runner/work/git/git/git-p4", line 297, in read_pipe
>         retcode, out, err = read_pipe_full(c, *k, **kw)
>       File "/home/runner/work/git/git/git-p4", line 284, in read_pipe_full
>         p = subprocess.Popen(
>       File "/usr/lib/python3.8/subprocess.py", line 858, in __init__
>         self._execute_child(args, executable, preexec_fn, close_fds,
>       File "/usr/lib/python3.8/subprocess.py", line 1704, in _execute_child
>         raise child_exception_type(errno_num, err_msg, err_filename)
>     FileNotFoundError: [Errno 2] No such file or directory: 'git diff-index HEAD --'
>     error: last command exited with $?=1
>     + cleanup_git
>     + retry_until_success rm -r /home/runner/work/git/git/t/trash directory.t9800-git-p4-basic/git
>     + nr_tries_left=60
>     + rm -r /home/runner/work/git/git/t/trash directory.t9800-git-p4-basic/git
>     + test_path_is_missing /home/runner/work/git/git/t/trash directory.t9800-git-p4-basic/git
>     + test 1 -ne 1
>     + test -e /home/runner/work/git/git/t/trash directory.t9800-git-p4-basic/git
>     + retry_until_success mkdir /home/runner/work/git/git/t/trash directory.t9800-git-p4-basic/git
>     + nr_tries_left=60
>     + mkdir /home/runner/work/git/git/t/trash directory.t9800-git-p4-basic/git
>     + exit 1
>     + eval_ret=1
>     + :
>     not ok 20 - submit from detached head
>     #    
>     #        test_when_finished cleanup_git &&
>     #        git p4 clone --dest="$git" //depot &&
>     #        (
>     #            cd "$git" &&
>     #            git checkout p4/master &&
>     #            >detached_head_test &&
>     #            git add detached_head_test &&
>     #            git commit -m "add detached_head" &&
>     #            git config git-p4.skipSubmitEdit true &&
>     #            git p4 submit &&
>     #            git p4 rebase &&
>     #            git log p4/master | grep detached_head
>     #        )
>     #    
>   Error: failed: t9800.21 submit from worktree
>   [...]
> 
> 
> Is this the best UI we can have for test failures in CI runs? I hope we can
> do better. Having said that, this patch series presents a pretty good start,
> and offers a basis for future improvements.
> 

I think these are really valuable improvements over our current state, but I
also understand the concerns about performance elsewhere in this thread
(it's really slow to load for me as well, and scrolling/expanding the log
groups can be a bit glitchy in my browser). That said, I think there are a
couple ways you could improve the load time without sacrificing the (very
helpful) improvements you've made to error log visibility. I experimented a
bit (example result [1]) and came up with some things that may help:

* group errors by test file, rather than by test case (to reduce
  parsing/rendering time for lots of groups).
* print the verbose logs only for the failed test cases (to massively cut
  down on the size of the log, particularly when there's only a couple
  failures in a test file with a lot of passing tests).
* skip printing the full text of the test in 'finalize_test_case_output'
  when creating the group, i.e., use '$1' instead of '$*' (in both passing
  and failing tests, this information is already printed via some other
  means).

If you wanted to make sure a user could still access the full failure logs
(i.e., including the "ok" test results), you could print a link to the
artifacts page as well - that way, all of the information we currently
provide to users can still be found somewhere.

[1] https://github.com/vdye/git/runs/5666973267

> Johannes Schindelin (9):
>   ci: fix code style
>   ci/run-build-and-tests: take a more high-level view
>   ci: make it easier to find failed tests' logs in the GitHub workflow
>   ci/run-build-and-tests: add some structure to the GitHub workflow
>     output
>   tests: refactor --write-junit-xml code
>   test(junit): avoid line feeds in XML attributes
>   ci: optionally mark up output in the GitHub workflow
>   ci: use `--github-workflow-markup` in the GitHub workflow
>   ci: call `finalize_test_case_output` a little later
> 

The organization of these commits makes the series a bit confusing to read,
mainly due to the JUnit changes in the middle. Patches 5-6 don't appear to
be dependent on patches 1-4, so they could be moved to the beginning (after
patch 1). With that change, I think this series would flow more smoothly:
"Cleanup/non-functional change" -> "JUnit XML improvements" -> "Log UX
improvements".

>  .github/workflows/main.yml           |  12 ---
>  ci/lib.sh                            |  82 +++++++++++++++--
>  ci/run-build-and-tests.sh            |  14 +--
>  ci/run-test-slice.sh                 |   5 +-
>  t/test-lib-functions.sh              |   4 +-
>  t/test-lib-github-workflow-markup.sh |  50 ++++++++++
>  t/test-lib-junit.sh                  | 132 +++++++++++++++++++++++++++
>  t/test-lib.sh                        | 128 ++++----------------------
>  8 files changed, 288 insertions(+), 139 deletions(-)
>  create mode 100644 t/test-lib-github-workflow-markup.sh
>  create mode 100644 t/test-lib-junit.sh
> 
> 
> base-commit: af4e5f569bc89f356eb34a9373d7f82aca6faa8a
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1117%2Fdscho%2Fuse-grouping-in-ci-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1117/dscho/use-grouping-in-ci-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/1117
> 
> Range-diff vs v1:
> 
>   1:  db08b07c37a =  1:  db08b07c37a ci: fix code style
>   2:  d2ff51bb5da !  2:  42ff3e170bf ci/run-build-and-tests: take a more high-level view
>      @@ ci/run-build-and-tests.sh: pedantic)
>        	;;
>        esac
>        
>      - # Any new "test" targets should not go after this "make", but should
>      - # adjust $MAKE_TARGETS. Otherwise compilation-only targets above will
>      - # start running tests.
>      +-# Any new "test" targets should not go after this "make", but should
>      +-# adjust $MAKE_TARGETS. Otherwise compilation-only targets above will
>      +-# start running tests.
>       -make $MAKE_TARGETS
>       +make
>       +if test -n "$run_tests"
>   3:  98891b0d3f7 !  3:  bbbe1623257 ci: make it easier to find failed tests' logs in the GitHub workflow
>      @@ Metadata
>        ## Commit message ##
>           ci: make it easier to find failed tests' logs in the GitHub workflow
>       
>      +    When investigating a test failure, the time that matters most is the
>      +    time it takes from getting aware of the failure to displaying the output
>      +    of the failing test case.
>      +
>           You currently have to know a lot of implementation details when
>           investigating test failures in the CI runs. The first step is easy: the
>           failed job is marked quite clearly, but when opening it, the failed step
>      @@ Commit message
>           The actually interesting part is in the detailed log of said failed
>           test script. But that log is shown in the CI run's step that runs
>           `ci/print-test-failures.sh`. And that step is _not_ expanded in the web
>      -    UI by default.
>      +    UI by default. It is even marked as "successful", which makes it very
>      +    easy to miss that there is useful information hidden in there.
>       
>           Let's help the reader by showing the failed tests' detailed logs in the
>           step that is expanded automatically, i.e. directly after the test suite
>   4:  9333ba781b8 !  4:  f72254a9ac6 ci/run-build-and-tests: add some structure to the GitHub workflow output
>      @@ ci/lib.sh
>       +
>       +# Set 'exit on error' for all CI scripts to let the caller know that
>       +# something went wrong.
>      -+# Set tracing executed commands, primarily setting environment variables
>      -+# and installing dependencies.
>      ++#
>      ++# We already enabled tracing executed commands earlier. This helps by showing
>      ++# how # environment variables are set and and dependencies are installed.
>       +set -e
>       +
>        skip_branch_tip_with_tag () {
>      @@ ci/lib.sh: linux-leaks)
>       +set -x
>       
>        ## ci/run-build-and-tests.sh ##
>      -@@ ci/run-build-and-tests.sh: esac
>      - # Any new "test" targets should not go after this "make", but should
>      - # adjust $MAKE_TARGETS. Otherwise compilation-only targets above will
>      - # start running tests.
>      +@@ ci/run-build-and-tests.sh: pedantic)
>      + 	;;
>      + esac
>      + 
>       -make
>       +group Build make
>        if test -n "$run_tests"
>   5:  94dcbe1bc43 =  5:  9eda6574313 tests: refactor --write-junit-xml code
>   6:  41230100091 =  6:  c8b240af749 test(junit): avoid line feeds in XML attributes
>   7:  98b32630fcd =  7:  15f199e810e ci: optionally mark up output in the GitHub workflow
>   8:  1a6bd1846bc =  8:  91ea54f36c5 ci: use `--github-workflow-markup` in the GitHub workflow
>   9:  992b1575889 =  9:  be2a83f5da3 ci: call `finalize_test_case_output` a little later
> 

