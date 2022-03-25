Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79C4C433F5
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 19:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbiCYTlP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233510AbiCYTj7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 15:39:59 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8190120A398
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:12:31 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id e7so4751813vkh.2
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QtddBMjbwzmEfPyV3H3LssJlmLtJA87LJAVLrHQPKeI=;
        b=eJWHDttAR1ILKrzm5mdMLXWYdIRSbc0qLP0YDauaCowpRYBxkYcL0q1k22lY8f4bj6
         dfKjyaKd2p+2JL2jEkL782sqXn5rlKxa35PNeVp+uxMWHJtBENDXS2MrhzHd5clmWA6J
         8JTMdSthxJGvqKEr6lJsd6FOi02Mwl+vm/ECS0IjFckKNr+46F5Eg3lv5Jrsu8/4YDpz
         tj3N9Jxg6tL/88rpbZlSS15Dj0CEtYn7PeX3Ol26ewRjOKnUpz22V8xLGMRkQDOOa48Y
         lm/ijoQjWJfJFw9qA75F4y4PpK1555P5bfdE6kKNE1HTzFT7XGbJ5aj72rEp3mg4yt9P
         xA3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QtddBMjbwzmEfPyV3H3LssJlmLtJA87LJAVLrHQPKeI=;
        b=u6HgXpKO/RNLwXHSGzI6898YKb6ynM+hVpRuzHX3///DwUQrZ9BgQ40rJOsaP9L7oN
         aEzsHHEJcIb5Pt6fk4zA1diY/C97+u/mxPOzf7v50ck6Zqz3XihxM/15jaexhu4pN2jI
         l+QnDDov2xv7bU96Ldg1Ylv9c9KrchI/kNejJmBG1APEw6E7BI9ID5SyB3cNkc+CrdqQ
         GbCff3S0htTKwQM6yEqNdxxWv+1iQIRlXnmF1S2ZGCuAcCeVn3SXTj1miQA7ubCZVs7P
         1DAFmxGL+WLwQvar3K6Qfq1OxhL2byMN4zSm37l2GOZ5D7jQB2R+koXCpdXvYYl039oj
         7iRQ==
X-Gm-Message-State: AOAM531kVOq/4b92nt058H0QBH6hR6tKLA37imvOJPUP1e2u0yrxJAKT
        JNBzej0ShYEa1Q8dxPmasSSaASzSmi4Y
X-Google-Smtp-Source: ABdhPJypV7ZlSphYvNWjd2HnowWZGqxxqXQXD/Q3w4qIEofO2WceT32P9grlx+LWYPTK+T3spMrCpQ==
X-Received: by 2002:a05:6a00:3316:b0:4fa:80fd:f3f6 with SMTP id cq22-20020a056a00331600b004fa80fdf3f6mr11302922pfb.65.1648233500089;
        Fri, 25 Mar 2022 11:38:20 -0700 (PDT)
Received: from [192.168.0.102] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id hg5-20020a17090b300500b001c795eedcffsm8640921pjb.13.2022.03.25.11.38.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 11:38:19 -0700 (PDT)
Message-ID: <888aa48b-3e1c-9cb7-e51f-0adacaa45118@github.com>
Date:   Fri, 25 Mar 2022 11:38:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v2 0/9] ci: make Git's GitHub workflow output much more
 helpful
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com>
 <pull.1117.v2.git.1646130289.gitgitgadget@gmail.com>
 <6b83bb83-32b9-20c9-fa02-c1c3170351c3@github.com>
 <220325.864k3mmm2x.gmgdl@evledraar.gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <220325.864k3mmm2x.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Mar 24 2022, Victoria Dye wrote:
> 
>> Johannes Schindelin via GitGitGadget wrote:
>> [...]
>>> Is this the best UI we can have for test failures in CI runs? I hope we can
>>> do better. Having said that, this patch series presents a pretty good start,
>>> and offers a basis for future improvements.
>>>
>>
>> I think these are really valuable improvements over our current state, but I
>> also understand the concerns about performance elsewhere in this thread
>> (it's really slow to load for me as well, and scrolling/expanding the log
>> groups can be a bit glitchy in my browser). That said, I think there are a
>> couple ways you could improve the load time without sacrificing the (very
>> helpful) improvements you've made to error log visibility. I experimented a
>> bit (example result [1]) and came up with some things that may help:
>>
>> * group errors by test file, rather than by test case (to reduce
>>   parsing/rendering time for lots of groups).
>> * print the verbose logs only for the failed test cases (to massively cut
>>   down on the size of the log, particularly when there's only a couple
>>   failures in a test file with a lot of passing tests).
>> * skip printing the full text of the test in 'finalize_test_case_output'
>>   when creating the group, i.e., use '$1' instead of '$*' (in both passing
>>   and failing tests, this information is already printed via some other
>>   means).
>>
>> If you wanted to make sure a user could still access the full failure logs
>> (i.e., including the "ok" test results), you could print a link to the
>> artifacts page as well - that way, all of the information we currently
>> provide to users can still be found somewhere.
>>
>> [1] https://github.com/vdye/git/runs/5666973267
> 
> Thanks a lot for trying to address those concerns.
> 
> I took a look at this and it definitely performs better, although in
> this case the overall output is ~3k lines.
> 
> I'd be curious to see how it performs on some of the cases discussed in
> earlier threads of >~50k lines, although it looks like in this case that
> would require failures to be really widespread in the test suite.
> 

Unfortunately, I don't have a direct comparison to that (the longest I found
elsewhere in the thread was ~33k lines [1], but those failures came from
strange interactions on the 'shears/seen' branch of Git for Windows that I
couldn't easily replicate). If it helps, though, here's a 1:1 comparison of
my "experiment" branch's forced test failures with and without the
optimizations I tried (without optimization, the total log is ~28k lines):

without optimization: https://github.com/vdye/git/runs/5696305589 with
optimization: https://github.com/vdye/git/runs/5666973267

So it's definitely faster - it still takes a couple seconds to load, but not
so long that my browser struggles with it (which was my main issue with the
original approach).

[1] https://github.com/dscho/git/runs/4840190622

> I just looked at this briefly, but looking at the branch I see you
> removed the "checking known breakage of[...]" etc. from the non-GitHub
> markdown output, I didn't spot how that was related/needed.
> 

It was mostly just another attempt to cut down on extraneous output (since,
if a test fails, the test definition is printed after the failure, so we
would end up with the same information twice). 

That said, if that were to be incorporated here, it'd need to be smarter
than what I tried - my change removed it entirely from the '.out' logs, and
it means that any test that *does* pass wouldn't have its test definition
logged anywhere (I think). The ideal situation would be the extraneous test
definition is only removed from the '.markup' files, but that's probably a
change better saved for a future patch/series.

>>> Johannes Schindelin (9):
>>>   ci: fix code style
>>>   ci/run-build-and-tests: take a more high-level view
>>>   ci: make it easier to find failed tests' logs in the GitHub workflow
>>>   ci/run-build-and-tests: add some structure to the GitHub workflow
>>>     output
>>>   tests: refactor --write-junit-xml code
>>>   test(junit): avoid line feeds in XML attributes
>>>   ci: optionally mark up output in the GitHub workflow
>>>   ci: use `--github-workflow-markup` in the GitHub workflow
>>>   ci: call `finalize_test_case_output` a little later
>>>
>>
>> The organization of these commits makes the series a bit confusing to read,
>> mainly due to the JUnit changes in the middle. Patches 5-6 don't appear to
>> be dependent on patches 1-4, so they could be moved to the beginning (after
>> patch 1). With that change, I think this series would flow more smoothly:
>> "Cleanup/non-functional change" -> "JUnit XML improvements" -> "Log UX
>> improvements".
> 
> Have you had a change to look at the approach my suggestion of an
> alternate approach to the early part of this series takes?:
> https://lore.kernel.org/git/cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com/
> 
> I.e. to not build up ci/lib.sh to know to group the "build" etc. within
> the "run-build-and-test" step, but instead just to pull those to the
> top-level by running separate build & test steps.
> 

I looked at it a while ago, but I actually had a similar issue following
that series as I did this one; it's difficult to tell what's cleanup, what's
refactoring unrelated to this series, and what's an explicit difference in
approach compared with this series. 

Revisiting it now, I did the same thing I did with dscho's series: ran your
branch with some forced test failures and looked at the results [2]. Based
on that, there are a couple of helpful things I see in your series that
contribute to the same overarching goal as this dscho's:

* Separating build & test into different steps.
    * This makes it more immediately obvious to a user whether the issue was
      a compiler error or a test failure. Since test failures can only even
      happen if the compilation passes, this doesn't create (another)
      situation where the relevant failure information is in a different
      step than the auto-expanded failing one.
* Separating 'lib.sh --build' and 'make' into different steps. 
    * I was initially unsure of the value of this (conceptually, wouldn't
      they both be part of "build"?), but I eventually understood it to be
      "setup the environment for [build|test]" followed by "run the
      [build|test]". Since the main thing dscho's series is addressing is
      information visibility, I like that this similarly "unburies" the
      environment configuration at the beginning of build/test.

Those changes are great (and they probably have some positive impact on load
times). But as far as I can tell, nothing else in your series directly
addresses the main problem dscho is fixing here, which is that the verbose
failure logs are effectively hidden from the user (unless you know exactly
where to look). As a result, it doesn't really fit as a "replacement" to
this one for me. Honestly, my ideal "final form" of all of this may be a
combination of both series, having the CI steps:

- setup build environment
- run build (make)
- setup test environment
- run test (make test) & print failure logs

You can still pull the 'make' executions out of 'run-build-and-test.sh', but
I think the "& print failure logs" part of the 'test' step (i.e., the added
'|| handle_failed_tests') is the critical piece that, although it would slow
things down to some extent (and, of course, it's subjective where the "too
slow" line is), it would relevant failure information a whole lot more
accessible. That's the real "value-add" of this series for me, if only
because I know it would have helped me a bunch of times in the past - I
absolutely believe it would similarly help new contributors in the future.

[2] https://github.com/vdye/git/runs/5695895629
