Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74C6E2027C
	for <e@80x24.org>; Fri,  2 Jun 2017 22:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751363AbdFBWFd (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 18:05:33 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:34432 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751180AbdFBWFb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 18:05:31 -0400
Received: by mail-qt0-f194.google.com with SMTP id o21so2991636qtb.1
        for <git@vger.kernel.org>; Fri, 02 Jun 2017 15:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=v9Z3tWRyYxeQnF86fszQBprHXtQ29wq43NGI+P7E+kE=;
        b=YILTYXl3q6+5HDnMEIHy7a7e9lRq8bdktAe3NVRGtD8hW3dONSfu2na3sECZhwFqUy
         TsKkRHGr1KWkF9ttpSJcw07EongeBckT2NAyoqBf7OdFxPMYSLoEXK/+sMNuXDI0kRKC
         lGrbKTPq2U+6wz6SLsJAMZvxhEoiaXAKR5gfK3g+sLwEgfpdlUgZ5fT/cD3bNjSHFFYX
         hIEOJ8oSj0SP0ck0TH8TVxLrjInBDrjGHRqg5LuvCi0/GxagoUXRuMJLW/iaNYKHQLXs
         Fma6r3PHH71Pf4MuxbgCIRG/uRM/4d5yZ4APcH+mJ2UZPaZT0d6kNXAp9E71Gm+uVFZJ
         /u1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v9Z3tWRyYxeQnF86fszQBprHXtQ29wq43NGI+P7E+kE=;
        b=fYhmDC+MUJJYsRx/miD0bP1/SdL1qOcyy/YrzOnUCQz0RdK3QvDuHROh8sbYG4HhHs
         SAnh8JynZdAP4wWPZZn/vskae6z8/5g5+ZYGJtrYpRMjosI/+d6OR5/5PdbNBOHh13Zc
         cPvOx0G7LqymjbVduhbnJz8Ik1S6is+tue8jwitO6rS0vbc6l778PaTekJrk03eUSzho
         HR63tz6Qlj5bILNd9FQ3V0YTO8iMhXLSAr5q+Md/OBtJHinNiVqi6OIv61JNb1Spknlg
         8AzRSsQVrN3OijkC7eVnP38NH9qV3PYu4SiDt/uh0pGhJ4GS4KeVVSV3wDJ1b4UU3n6J
         qxXA==
X-Gm-Message-State: AODbwcDLfwS/Jk0F4y8GMyTy588L6JTeLP5fXVEElwNQTIIyawY4nwXS
        p5UXR9QGV2p5VQ==
X-Received: by 10.200.58.39 with SMTP id w36mr11146868qte.131.1496441130800;
        Fri, 02 Jun 2017 15:05:30 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id m51sm3972540qtb.62.2017.06.02.15.05.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Jun 2017 15:05:30 -0700 (PDT)
Subject: Re: [WIP/PATCH 7/6] perf: add a performance test for core.fsmonitor
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        David Turner <David.Turner@twosigma.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        benpeart@microsoft.com
References: <4c3fed40-774b-8ae6-fa1b-50efe6ef552f@gmail.com>
 <20170602102853.23073-1-avarab@gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <c84864d3-9823-0b02-a337-29592b7c01f3@gmail.com>
Date:   Fri, 2 Jun 2017 18:05:28 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20170602102853.23073-1-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 6/2/2017 6:28 AM, Ævar Arnfjörð Bjarmason wrote:
> Add a performance test for the new core.fsmonitor facility using the
> sample query-fsmonitor hook.
> 
> This is WIP code for the reasons explained in the setup comments,
> unfortunately the perf code doesn't easily allow you to run different
> setup code for different versions you're testing. This test will stop
> working if the fsmonitor is merged into the master branch.
> 
> Output against linxu.git:
> 
>      $ GIT_PERF_REPEAT_COUNT=10 GIT_PERF_LARGE_REPO=~/g/linux GIT_PERF_MAKE_OPTS='-j8' ./run origin/master avar/fsmonitor ./p7519-fsmonitor.sh
>      [...]
>      Test                          origin/master     avar/fsmonitor
>      -----------------------------------------------------------------------
>      7519.2: status (first)        0.08(0.04+0.09)   0.12(0.07+0.10) +50.0%
>      7519.3: status (subsequent)   0.08(0.04+0.09)   0.12(0.06+0.11) +50.0%
>      7519.4: status -uno           0.02(0.02+0.05)   0.06(0.05+0.06) +200.0%
>      7519.5: status -uall          0.08(0.06+0.07)   0.12(0.07+0.10) +50.0%
> 

With regular status times this low, the overhead of calling the hook + 
watchman + perl results in slower overall times as I noted in my initial 
cover letter.  If status calls are already this fast, fsmonitor + 
watchman isn't needed and obviously doesn't help.

This does highlight an optimization I could add.  Even though -uno is 
passed, the fsmonitor code currently still goes through the work of 
marking the untracked entries as dirty.  I'll look at optimizing that 
out to speed status up when using that option.

> And against a larger in-house monorepo I have here, with the same
> options (except the repo path):
> 
>      Test                          origin/master     avar/fsmonitor
>      -----------------------------------------------------------------------
>      7519.2: status (first)        0.20(0.11+0.18)   0.27(0.15+0.21) +35.0%
>      7519.3: status (subsequent)   0.20(0.11+0.18)   0.27(0.15+0.21) +35.0%
>      7519.4: status -uno           0.04(0.03+0.10)   0.22(0.08+0.12) +450.0%
>      7519.5: status -uall          0.20(0.13+0.16)   0.27(0.18+0.19) +35.0%
> 
> Against linux.git with a hack to flush the FS cache (on Linux) before
> running the first 'git status', only running one test so the result
> isn't discarded as the slowest of N:
> 

I don't know know about on Linux but with Windows, when you flush the 
file system cache via unmount/mount, it causes Watchman to do a full 
scan with the next query.  This has a significant negative performance 
impact on the next status call as it returns the set of _all_ files 
which git then uses to find and mark all index and untracked cache 
entries as fsmonitor dirty then does a complete scan.  This combination 
makes the first status after these events slower than without Watchman.

I'm currently working with the Watchman team to return a code indicating 
we should just scan everything ourselves to avoid the extra overhead, 
but that solution is TBD.  Given it only happens the first time a query 
is done on a new clone or the first time after watchman is started, I 
didn't intend to hold up the patch series for it but will submit an 
enhanced version once a solution is available.  The enhanced version 
will then be the same performance (for the first status call) as when 
not running with fsmonitor - not faster - as the state is unknown so 
must be gathered from the working directory.

>      $ GIT_PERF_REPEAT_COUNT=1 GIT_PERF_LARGE_REPO=~/g/linux GIT_PERF_MAKE_COMMAND='sudo sync && echo 3 | sudo tee /proc/sys/vm/drop_caches >/dev/null && make -j8' ./run origin/master avar/fsmonitor ./p7519-fsmonitor.sh
>      [...]
>      Test                          origin/master     avar/fsmonitor
>      ------------------------------------------------------------------------
>      7519.2: status (first)        0.30(0.18+0.10)   8.26(0.22+0.10) +2653.3%
>      7519.3: status (subsequent)   0.08(0.04+0.08)   0.81(0.09+0.07) +912.5%
>      7519.4: status -uno           0.02(0.01+0.06)   0.08(0.04+0.07) +300.0%
>      7519.5: status -uall          0.08(0.06+0.07)   0.15(0.08+0.09) +87.5%
> 
> Now obviously due to 1 run that has a lot of noise, but I would expect
> that first invocation to be blindingly fast since watchman has info on
> what files were modified since the cache was flushed.
> 

Every (first) run of the performance test will be very expensive for the 
reasons outlined above.  This is clearest when you only have 1 run as it 
doesn't get masked by the faster 2nd+ runs.  That first run will never 
be "blindingly fast" as git has to gather the initial state and save out 
the cache - it's all the subsequent calls that will be faster.

> The same on the large monorepo noted above:
> 
>      Test                          origin/master     avar/fsmonitor
>      -----------------------------------------------------------------------
>      7519.2: status (first)        0.59(0.28+0.24)   0.93(0.35+0.19) +57.6%
>      7519.3: status (subsequent)   0.20(0.10+0.19)   0.28(0.16+0.20) +40.0%
>      7519.4: status -uno           0.04(0.04+0.09)   0.11(0.08+0.12) +175.0%
>      7519.5: status -uall          0.29(0.11+0.18)   0.40(0.16+0.19) +37.9%
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
> 

Same issue here - the overhead of the hook + watchman + perl outweighs 
any savings for these status calls that are already so fast.

There is certainly noise from run to run but on my machine, the minimum 
time I saw with fsmonitor was in the .25+ range.  Where fsmonitor really 
becomes useful is when status times get over a second and in extreme 
cases where it gets to a minute or more.
> On Fri, Jun 2, 2017 at 2:40 AM, Ben Peart <peartben@gmail.com> wrote:
>> Any chance you can provide me with a bash script that contains the exact
>> sequence of commands you are running to get this result?  I've been trying
>> to replicate it using your notes but have not been able to.  I'd like to see
>> if it is a repo difference, a platform difference, a command sequence
>> difference (or something else entirely :)).
> 
> I can do better than that, here's a new perf test on top of this
> series which demonstates the issue. I've only tested this on Linux
> 4.9.0 with watchman 4.9.0 compiled from git (yes, they're
> coincidentally the same version).
> 

Thank you!  Great addition.  I've included an updated version below.

> A good addition to this would be `printf <fmt for date N sec in the
> past> | watchman -j` as noted in my earlier mail, but I ran out of
> time.
> 
> You can also set any combination of GIT_PERF_7519_UNTRACKED_CACHE &
> GIT_PERF_7519_SPLIT_INDEX to play with turning that on. I haven't
> tested all combinations of that, but e.g. testing with untrackedCache
> didn't give results that looked different from the performance
> regressions noted above.
> 

Makes sense, given how the performance framework creates the test repo, 
there typically aren't untracked files to optimize.  I updated the perf 
test to turn it on anyway for platforms where it is available.

> Aside from performance, I think a very good addition to stress-test
> this series would be a patch to t/test-lib*sh guarded by some env flag
> to do a similar watchman watch-del/watch/watch-list dance as the one
> I'm doing here in the setup, and setting up the hook / config.
> That would allow testing the entire git test suite with this feature,
> to find any subtle bugs this might have introduced in git-status.
> 

Another good idea.  I had started that but ran into bugs with Watchman 
on Windows (https://github.com/facebook/watchman/issues/461) where 
running the git test suite actually causes Watchman to stop monitoring 
folders.  Once I can get past that, I'll give it another go.



diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
new file mode 100755
index 0000000000..e658254ecf
--- /dev/null
+++ b/t/perf/p7519-fsmonitor.sh
@@ -0,0 +1,68 @@
+#!/bin/sh
+
+test_description="Test core.fsmonitor"
+
+. ./perf-lib.sh
+
+test_perf_large_repo
+test_checkout_worktree
+
+# fsmonitor works correctly with or without the untracked cache
+# but if it is available, we'll turn it on to ensure we test that
+# codepath as well.
+
+test_lazy_prereq UNTRACKED_CACHE '
+       { git update-index --test-untracked-cache; ret=$?; } &&
+       test $ret -ne 1
+'
+
+if test_have_prereq UNTRACKED_CACHE; then
+       git config core.untrackedcache true
+else
+       git config core.untrackedcache false
+fi
+
+test_expect_success 'setup' '
+       # set splitIndex depending on the environment, defaulting to false.
+       if test -n "$GIT_PERF_7519_SPLIT_INDEX"
+       then
+               git config core.splitIndex true
+       else
+               git config core.splitIndex false
+       fi &&
+
+       # Hook scaffolding
+       mkdir .git/hooks &&
+       cp ../../../templates/hooks--query-fsmonitor.sample 
.git/hooks/query-fsmonitor &&
+
+       watchman watch "$PWD" >/dev/null 2>&1 &&
+       watchman watch-list | grep -q -F "$PWD"
+'
+
+# Setting:
+#
+#    GIT_PERF_REPEAT_COUNT=1 GIT_PERF_MAKE_COMMAND='sudo sync && echo 3 
| sudo tee /proc/sys/vm/dro
p_caches && make -j8'
+#
+# Can be used as a hack to performance test 'git status' on a cold fs
+# cache with an existing watchman watching the directory, which should
+# be blindingly fast, compared to amazingly slow without watchman.
+
+# Run git status without using fsmonitor as a baseline.
+test_perf 'status (without fsmonitor)' 'git -c core.fsmonitor=false status'
+
+# The first time you query Watchman after the daemon starts or the first
+# call after adding a new folder to watch, it scans the folder and returns
+# _all_ files which makes the initial status call slower than without.
+# Working with Watchman team to return a code indicating we should just
+# scan everything ourselves to avoid the extra overhead, solution TBD.
+test_perf 'status (populate cache)' 'git -c core.fsmonitor=true status'
+
+# Now Watchman has done the initial scan and the fsmonitor index extension
+# is populated so we'll see the performance win.
+test_perf 'status (with fsmonitor)' 'git -c core.fsmonitor=true status'
+
+# Let's see if -uno & -uall make any difference
+test_perf 'status -uno'          'git -c core.fsmonitor=true status -uno'
+test_perf 'status -uall'         'git -c core.fsmonitor=true status -uall'
+
+test_done


