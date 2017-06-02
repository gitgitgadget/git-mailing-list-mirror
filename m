Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E1E92027C
	for <e@80x24.org>; Fri,  2 Jun 2017 23:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751157AbdFBXGk (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 19:06:40 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:36328 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750971AbdFBXGi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 19:06:38 -0400
Received: by mail-it0-f44.google.com with SMTP id m47so20262187iti.1
        for <git@vger.kernel.org>; Fri, 02 Jun 2017 16:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dPI49zUJ1Adbi3uQdqys/zrgBO/kEMbccjcPiJfKAAk=;
        b=Ncsbep8Iu1V+FOD0Bc1zkHV7GhHEExpr8/eeMfEF8dWGhykiOz7WzT6PvfQPLMGOvl
         y5lMZZvmsoh2DyHZu1UrTKHFjai4YYFHQaxK3y0jTAxFSaPdlKudEKia5C/YtT2o6iR+
         9BVVvc1Bvr2Pfo6y6i/gBpUue6XugaXsAUbOO1BVyirgaXiCILa8GPvhL3B+IoHwr89Y
         TVb31jQTX/UP4zBpSX/B/goM+ZIsHrk8VTnxTGu+/W6F+4wVNHZmY63nxqAjqCiGWh39
         Iv/G3u22+1m6xowJ493x1fo1eOrayW2J1fUszPhHLKjQxknU31E1ZksMWRCGAXuUWryb
         MxzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dPI49zUJ1Adbi3uQdqys/zrgBO/kEMbccjcPiJfKAAk=;
        b=F9wP7tCK/M1MxGlQLo56lwBW1fuMH98vdIVUQMLxWcJ3jHzC0rC7vs46RH18Y2lEqG
         m9nicTLfBX5qzs6MzUueYrvcNJXtVSLizQotS19L4SaZobAzr10rP93jz9+iE9n7vWIq
         MKtfVEdqViF6WiuD2/YLF3UwosS6YxBkrh8kiQeC38JkHW6y9JAJTcUEFNbiMX9/jOLH
         GvNbG7acZm1MWtCPP5XOXF3ZEildyovbYVa7nJgaVopU2GffqDsn5KMj/BKmkofMcmw/
         +U6SMWqaWIjMiQOeXa6mVqDwcJn3brFktkMO8dEd4BwvUjfdZJBre9eXH+jA0zLRtlPP
         ivWg==
X-Gm-Message-State: AODbwcAxB8f/mhKeLdlMr9KyttTuOuPhjn5KWRvpwBtz32eDah8H6VXk
        QDe87jLRyv+mLqUYtItbRX5LF9O0vQ==
X-Received: by 10.36.53.79 with SMTP id k76mr1799120ita.71.1496444797277; Fri,
 02 Jun 2017 16:06:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.3.231 with HTTP; Fri, 2 Jun 2017 16:06:16 -0700 (PDT)
In-Reply-To: <c84864d3-9823-0b02-a337-29592b7c01f3@gmail.com>
References: <4c3fed40-774b-8ae6-fa1b-50efe6ef552f@gmail.com>
 <20170602102853.23073-1-avarab@gmail.com> <c84864d3-9823-0b02-a337-29592b7c01f3@gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sat, 3 Jun 2017 01:06:16 +0200
Message-ID: <CACBZZX48t3Jcy=eiga1f_ATSZZvy9_LG9wEe7avD2NCq2bsmJA@mail.gmail.com>
Subject: Re: [WIP/PATCH 7/6] perf: add a performance test for core.fsmonitor
To:     Ben Peart <peartben@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        David Turner <David.Turner@twosigma.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Ben Peart <benpeart@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 3, 2017 at 12:05 AM, Ben Peart <peartben@gmail.com> wrote:
>
>
> On 6/2/2017 6:28 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>
>> Add a performance test for the new core.fsmonitor facility using the
>> sample query-fsmonitor hook.
>>
>> This is WIP code for the reasons explained in the setup comments,
>> unfortunately the perf code doesn't easily allow you to run different
>> setup code for different versions you're testing. This test will stop
>> working if the fsmonitor is merged into the master branch.
>>
>> Output against linxu.git:
>>
>>      $ GIT_PERF_REPEAT_COUNT=3D10 GIT_PERF_LARGE_REPO=3D~/g/linux
>> GIT_PERF_MAKE_OPTS=3D'-j8' ./run origin/master avar/fsmonitor
>> ./p7519-fsmonitor.sh
>>      [...]
>>      Test                          origin/master     avar/fsmonitor
>>
>> -----------------------------------------------------------------------
>>      7519.2: status (first)        0.08(0.04+0.09)   0.12(0.07+0.10)
>> +50.0%
>>      7519.3: status (subsequent)   0.08(0.04+0.09)   0.12(0.06+0.11)
>> +50.0%
>>      7519.4: status -uno           0.02(0.02+0.05)   0.06(0.05+0.06)
>> +200.0%
>>      7519.5: status -uall          0.08(0.06+0.07)   0.12(0.07+0.10)
>> +50.0%
>>
>
> With regular status times this low, the overhead of calling the hook +
> watchman + perl results in slower overall times as I noted in my initial
> cover letter.  If status calls are already this fast, fsmonitor + watchma=
n
> isn't needed and obviously doesn't help.
>
> This does highlight an optimization I could add.  Even though -uno is
> passed, the fsmonitor code currently still goes through the work of marki=
ng
> the untracked entries as dirty.  I'll look at optimizing that out to spee=
d
> status up when using that option.
>
>> And against a larger in-house monorepo I have here, with the same
>> options (except the repo path):
>>
>>      Test                          origin/master     avar/fsmonitor
>>
>> -----------------------------------------------------------------------
>>      7519.2: status (first)        0.20(0.11+0.18)   0.27(0.15+0.21)
>> +35.0%
>>      7519.3: status (subsequent)   0.20(0.11+0.18)   0.27(0.15+0.21)
>> +35.0%
>>      7519.4: status -uno           0.04(0.03+0.10)   0.22(0.08+0.12)
>> +450.0%
>>      7519.5: status -uall          0.20(0.13+0.16)   0.27(0.18+0.19)
>> +35.0%
>>
>> Against linux.git with a hack to flush the FS cache (on Linux) before
>> running the first 'git status', only running one test so the result
>> isn't discarded as the slowest of N:
>>
>
> I don't know know about on Linux but with Windows, when you flush the fil=
e
> system cache via unmount/mount, it causes Watchman to do a full scan with
> the next query.  This has a significant negative performance impact on th=
e
> next status call as it returns the set of _all_ files which git then uses=
 to
> find and mark all index and untracked cache entries as fsmonitor dirty th=
en
> does a complete scan.  This combination makes the first status after thes=
e
> events slower than without Watchman.

I'm not sure, but I don't think this is a thing at all on Linux. How
inotify works is unrelated to whether some part of the filesystem
happens to be cached, and the echo+proc command I have is just
flushing all those pages. That I'm flushing all the pages at once
should be as much of a non-event as one page being claimed from the
fscache for use by the RAM allocation of some application.

I suspect Windows somehow conflates its fs watching implementation
with what on Linux is the inotify queue the application has to
consume, if that queue isn't consumed watchman will need to re-scan.

Or maybe my mental model of this whole thing is wrong and this also
happens on Linux...

> I'm currently working with the Watchman team to return a code indicating =
we
> should just scan everything ourselves to avoid the extra overhead, but th=
at
> solution is TBD.  Given it only happens the first time a query is done on=
 a
> new clone or the first time after watchman is started, I didn't intend to
> hold up the patch series for it but will submit an enhanced version once =
a
> solution is available.  The enhanced version will then be the same
> performance (for the first status call) as when not running with fsmonito=
r -
> not faster - as the state is unknown so must be gathered from the working
> directory.

I don't have time to update the perf test now or dig into it, but most
of what you're describing in this mail doesn't at all match with the
ad-hoc tests I ran in
https://public-inbox.org/git/CACBZZX5e58bWuf3NdDYTxu2KyZj29hHONzN=3Drp-7vXd=
8nURyWQ@mail.gmail.com/

There (at the very end of the E-Mail) I'm running watchman in a tight
loop while I flush the entire fs cache, its runtime is never longer
than 600ms, with 3ms being the norm.

I.e. flushing the cache doesn't slow things down much at all compared
to how long a "git status" takes from cold cache. Something else must
be going on, and the smoking gun is the gprof output I posted in the
follow-up E-Mail:
https://public-inbox.org/git/CACBZZX4eZ3G8LQ8O+_BkbkJ-ZXTOkUi9cW=3DQKYjfHKt=
mA3pgrA@mail.gmail.com/

There with the fsmonitor we end up calling blk_SHA1_Block ~100K times
during "status", but IIRC (I don't have the output in front of me,
this is from memory) something like twenty times without the
fsmonitor.

It can't be a coincidence that with the fscache:

$ pwd; git ls-files | wc -l
/home/avar/g/linux
59844

And you can see that in the fsmonitor "git status" we make exactly
that many calls to cache_entry_from_ondisk(), but those calls don't
show up at all in the non-fscache codepath.

So, again, I haven't dug and really must step away from the computer
now, but this really looks like the fscache saves us the recursive
readdir() / lstat() etc, but in return we somehow fall though to a
codepath where we re-read the entire on-disk state back into the
index, which we don't do in the non-fscache codepath.

>>      $ GIT_PERF_REPEAT_COUNT=3D1 GIT_PERF_LARGE_REPO=3D~/g/linux
>> GIT_PERF_MAKE_COMMAND=3D'sudo sync && echo 3 | sudo tee
>> /proc/sys/vm/drop_caches >/dev/null && make -j8' ./run origin/master
>> avar/fsmonitor ./p7519-fsmonitor.sh
>>      [...]
>>      Test                          origin/master     avar/fsmonitor
>>
>> ------------------------------------------------------------------------
>>      7519.2: status (first)        0.30(0.18+0.10)   8.26(0.22+0.10)
>> +2653.3%
>>      7519.3: status (subsequent)   0.08(0.04+0.08)   0.81(0.09+0.07)
>> +912.5%
>>      7519.4: status -uno           0.02(0.01+0.06)   0.08(0.04+0.07)
>> +300.0%
>>      7519.5: status -uall          0.08(0.06+0.07)   0.15(0.08+0.09)
>> +87.5%
>>
>> Now obviously due to 1 run that has a lot of noise, but I would expect
>> that first invocation to be blindingly fast since watchman has info on
>> what files were modified since the cache was flushed.
>>
>
> Every (first) run of the performance test will be very expensive for the
> reasons outlined above.  This is clearest when you only have 1 run as it
> doesn't get masked by the faster 2nd+ runs.  That first run will never be
> "blindingly fast" as git has to gather the initial state and save out the
> cache - it's all the subsequent calls that will be faster.
>
>> The same on the large monorepo noted above:
>>
>>      Test                          origin/master     avar/fsmonitor
>>
>> -----------------------------------------------------------------------
>>      7519.2: status (first)        0.59(0.28+0.24)   0.93(0.35+0.19)
>> +57.6%
>>      7519.3: status (subsequent)   0.20(0.10+0.19)   0.28(0.16+0.20)
>> +40.0%
>>      7519.4: status -uno           0.04(0.04+0.09)   0.11(0.08+0.12)
>> +175.0%
>>      7519.5: status -uall          0.29(0.11+0.18)   0.40(0.16+0.19)
>> +37.9%
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>
>
> Same issue here - the overhead of the hook + watchman + perl outweighs an=
y
> savings for these status calls that are already so fast.
>
> There is certainly noise from run to run but on my machine, the minimum t=
ime
> I saw with fsmonitor was in the .25+ range.  Where fsmonitor really becom=
es
> useful is when status times get over a second and in extreme cases where =
it
> gets to a minute or more.
>>
>> On Fri, Jun 2, 2017 at 2:40 AM, Ben Peart <peartben@gmail.com> wrote:
>>>
>>> Any chance you can provide me with a bash script that contains the exac=
t
>>> sequence of commands you are running to get this result?  I've been
>>> trying
>>> to replicate it using your notes but have not been able to.  I'd like t=
o
>>> see
>>> if it is a repo difference, a platform difference, a command sequence
>>> difference (or something else entirely :)).
>>
>>
>> I can do better than that, here's a new perf test on top of this
>> series which demonstates the issue. I've only tested this on Linux
>> 4.9.0 with watchman 4.9.0 compiled from git (yes, they're
>> coincidentally the same version).
>>
>
> Thank you!  Great addition.  I've included an updated version below.
>
>> A good addition to this would be `printf <fmt for date N sec in the
>> past> | watchman -j` as noted in my earlier mail, but I ran out of
>> time.
>>
>> You can also set any combination of GIT_PERF_7519_UNTRACKED_CACHE &
>> GIT_PERF_7519_SPLIT_INDEX to play with turning that on. I haven't
>> tested all combinations of that, but e.g. testing with untrackedCache
>> didn't give results that looked different from the performance
>> regressions noted above.
>>
>
> Makes sense, given how the performance framework creates the test repo,
> there typically aren't untracked files to optimize.  I updated the perf t=
est
> to turn it on anyway for platforms where it is available.

The unfortunately named core.untrackedCache option has almost nothing
to do with untracked files per-se. It's about caching mtimes of
directories on the fs to avoid looking at them the next time, here on
a linux.git with no untracked files whatsoever:

    $ strace git -c core.untrackedCache=3Dfalse status 2>&1 | wc -l
    22780
    $ strace git -c core.untrackedCache=3Dtrue status 2>&1 | wc -l
    5105

I.e. syscalls are cut down by 4x. This will/can matter in an isolated
performance test like this.

It should really have been called core.mtimeCache or something like that...

>> Aside from performance, I think a very good addition to stress-test
>> this series would be a patch to t/test-lib*sh guarded by some env flag
>> to do a similar watchman watch-del/watch/watch-list dance as the one
>> I'm doing here in the setup, and setting up the hook / config.
>> That would allow testing the entire git test suite with this feature,
>> to find any subtle bugs this might have introduced in git-status.
>>
>
> Another good idea.  I had started that but ran into bugs with Watchman on
> Windows (https://github.com/facebook/watchman/issues/461) where running t=
he
> git test suite actually causes Watchman to stop monitoring folders.  Once=
 I
> can get past that, I'll give it another go.
>
>
>
> diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
> new file mode 100755
> index 0000000000..e658254ecf
> --- /dev/null
> +++ b/t/perf/p7519-fsmonitor.sh
> @@ -0,0 +1,68 @@
> +#!/bin/sh
> +
> +test_description=3D"Test core.fsmonitor"
> +
> +. ./perf-lib.sh
> +
> +test_perf_large_repo
> +test_checkout_worktree
> +
> +# fsmonitor works correctly with or without the untracked cache
> +# but if it is available, we'll turn it on to ensure we test that
> +# codepath as well.
> +
> +test_lazy_prereq UNTRACKED_CACHE '
> +       { git update-index --test-untracked-cache; ret=3D$?; } &&
> +       test $ret -ne 1
> +'
> +
> +if test_have_prereq UNTRACKED_CACHE; then
> +       git config core.untrackedcache true
> +else
> +       git config core.untrackedcache false
> +fi
> +
> +test_expect_success 'setup' '
> +       # set splitIndex depending on the environment, defaulting to fals=
e.
> +       if test -n "$GIT_PERF_7519_SPLIT_INDEX"
> +       then
> +               git config core.splitIndex true
> +       else
> +               git config core.splitIndex false
> +       fi &&
> +
> +       # Hook scaffolding
> +       mkdir .git/hooks &&
> +       cp ../../../templates/hooks--query-fsmonitor.sample
> .git/hooks/query-fsmonitor &&
> +
> +       watchman watch "$PWD" >/dev/null 2>&1 &&
> +       watchman watch-list | grep -q -F "$PWD"
> +'
> +
> +# Setting:
> +#
> +#    GIT_PERF_REPEAT_COUNT=3D1 GIT_PERF_MAKE_COMMAND=3D'sudo sync && ech=
o 3 |
> sudo tee /proc/sys/vm/dro
> p_caches && make -j8'
> +#
> +# Can be used as a hack to performance test 'git status' on a cold fs
> +# cache with an existing watchman watching the directory, which should
> +# be blindingly fast, compared to amazingly slow without watchman.
> +
> +# Run git status without using fsmonitor as a baseline.
> +test_perf 'status (without fsmonitor)' 'git -c core.fsmonitor=3Dfalse st=
atus'
> +
> +# The first time you query Watchman after the daemon starts or the first
> +# call after adding a new folder to watch, it scans the folder and retur=
ns
> +# _all_ files which makes the initial status call slower than without.
> +# Working with Watchman team to return a code indicating we should just
> +# scan everything ourselves to avoid the extra overhead, solution TBD.
> +test_perf 'status (populate cache)' 'git -c core.fsmonitor=3Dtrue status=
'
> +
> +# Now Watchman has done the initial scan and the fsmonitor index extensi=
on
> +# is populated so we'll see the performance win.
> +test_perf 'status (with fsmonitor)' 'git -c core.fsmonitor=3Dtrue status=
'
> +
> +# Let's see if -uno & -uall make any difference
> +test_perf 'status -uno'          'git -c core.fsmonitor=3Dtrue status -u=
no'
> +test_perf 'status -uall'         'git -c core.fsmonitor=3Dtrue status -u=
all'
> +
> +test_done
>
>
