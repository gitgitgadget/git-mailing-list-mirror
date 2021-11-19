Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D653C433EF
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 21:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233322AbhKSV6Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 16:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbhKSV6Q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 16:58:16 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2399FC061574
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 13:55:14 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id t83so11630942qke.8
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 13:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=gNzdCNGLvU8tbtrW0uVTo3ml7Ay8I4xruGJqI1mKX34=;
        b=h7+jBEmdC+uQmy4ePX73Ugg4vtXidXGgiiyEItWOAl8TALKEA1B0NVRbgm88V9wKqi
         T4cr1bMHGOA2Omkn20xa0fY91Hxx8xKzeK8u0B4/Rb47gm9Fy+riM7xlWeY6PJFAJBzG
         +u+NOvn4h/lc4iy03b6Gze3YAz3vwkmKrQnUpsW96u2p8CmYvHAd6TDQDA9vQPFRNoMc
         uNO9O8XhukA/4e+BxD19NiPijJU4/+IAb262rFNBQcarzt0BT3/nM6PwnwQIFJkj1/ZF
         Q7hhKnpEvzqX5IGvzDkU1DuAmb6aH/zjx4PZiYE/xfpluPojM5oExs8AerauUkBMHhb2
         Ssqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gNzdCNGLvU8tbtrW0uVTo3ml7Ay8I4xruGJqI1mKX34=;
        b=4IOdaIXZy2HmO9H6F6r4r7yZrMuX97VNakpmfqZGcd1ZFjl1fLrMHPIu5diStYt+lp
         fcMr4joCl+lZJOesIKQCpQ7IXmCHJNJVH+Agum3KmFt7czD5c7HMltMy7opAt9tRkrJt
         +iNf4EqGwLkbZmieIWZmSVKsJvt9K08iZI8GLy8kb6hScrSLsYMf19tc4GluXEgOJaQA
         SS+ZWmuRj18LttaonplFJyvFYyZrgENBi+38SIBbjywShqZCkK/frDMiYa5i9EqbL9KY
         EtoGznCjX4jp04srLrervEv5I9UsBNq/0Kq4ULcz+YiXgzH8ipVGk7XYWth2LR9I0LpY
         fiOg==
X-Gm-Message-State: AOAM531lw3s4BPmn5tvBJkwip+xnPmuYMmqssfxA/2i5gblDjj1uHX3q
        1wRWk4Y8hjm7HjZ7HWINLleO
X-Google-Smtp-Source: ABdhPJwneWYrod1RxNejoXrb/A5/J0I2e++LiDowLzrK9dRQAUezO8mya+zm7i2LmE7WjFdcCJGpZg==
X-Received: by 2002:a05:620a:141b:: with SMTP id d27mr30302854qkj.233.1637358913240;
        Fri, 19 Nov 2021 13:55:13 -0800 (PST)
Received: from [192.168.0.105] (70.15.20.152.res-cmts.sm.ptd.net. [70.15.20.152])
        by smtp.gmail.com with ESMTPSA id bm25sm543671qkb.4.2021.11.19.13.55.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 13:55:12 -0800 (PST)
Message-ID: <8efbd4bd-09bc-eabd-37ea-53501f75f8a6@github.com>
Date:   Fri, 19 Nov 2021 16:55:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH 1/2] CI: use shorter names that fit in UX tooltips
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <cover-0.2-00000000000-20211119T135343Z-avarab@gmail.com>
 <patch-1.2-26f80c87c8d-20211119T135343Z-avarab@gmail.com>
 <b9da6658-2b00-cc13-e1ae-124d8222dab8@github.com>
 <211119.86czmv3mow.gmgdl@evledraar.gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <211119.86czmv3mow.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, Nov 19 2021, Victoria Dye wrote:
> 
>> Ævar Arnfjörð Bjarmason wrote:
>>> Change the names used for the GitHub CI workflows to be short enough
>>> to (mostly) fit in the pop-up tool-tips that GitHub shows in the
>>> commit view. I.e. when mouse-clicking on the passing or failing
>>> check-mark next to the commit subject.
>>>
>>> That description is truncated to 24 characters, with the 3 at the end
>>> being placed by "...".
>>>
>>> E.g. the full job name (visible at [1]):
>>>
>>>     "regular (linux-gcc-default, gcc, ubuntu-latest)"
>>>
>>> Will, when shown in the tool-tip be truncated to:
>>>
>>>     "CI/PR / regular (linu..."
>>>
>>> There's then a further limit in the expanded view where the job names
>>> are observably truncated to 44 characters (including "..."). I.e.:
>>>
>>>     "regular (linux-gcc-default, gcc, ubuntu-l..."
>>>
>>
>> Tooltips like the ones you've pointed out here appear intended to be an "at
>> a glance" view of the jobs (mostly for showing pass/fail/skip status) - each
>> job in the tooltip has a "Details" link that takes you to the job summary
>> and logs. In the current state, although the names of the are truncated in
>> the tooltip, the information is still easily accessible in the full workflow
>> details (one click away). For example, the details for the "linux-leaks" job
>> [1] tell me the image, compiler, and job name right at the top of the page.
>>
>> [1] https://github.com/git/git/runs/4214606314?check_suite_focus=true
>>
>>> With this change we shorten both the job names, and change the
>>> top-level "name" from "CI/PR" to "CI", since it will be used as a
>>> prefix in the tooltips. We also remove redundant or superfluous
>>> information from the name, e.g. "ubuntu-latest" isn't really needed
>>> for "linux-leaks", it'll suffice to say linux. For discovering what
>>> image runs that specifically we can consult main.yml itself.
>>>
>>
>> By optimizing for the tooltip, this patch shortens names to the point that
>> they're more difficult to interpret (w32 vs. w32/VS) and/or removes valuable
>> context about platform/image/etc. When a user *does* want more information
>> on the job, they now have to: 
>>
>> 1) know that the "CI/PR" job definition is in ".github/workflows/main.yml"
>> 2) parse through the file to find the job they want
>> 3) correlate that back to the job in the workflow details they're
>>    investigating. 
>>
>> That's a strictly worse experience for an extremely common use-case. What
>> use-case is this patch attempting to improve?
> 
> That I can click on the button that your co-workers implemented and see
> the relevant information about the job :)
> 

I'm sure you meant this in good faith, but I don't see how where I work is
relevant. GitHub is a tool you can use to develop Git, and I'm reviewing
because this patch would affect how I work on Git.

> Given that it's truncated we need to pick and choose what we display if
> we're not going to force the user to have to go to the full view every
> time.
> 

This is what I wanted to dig into by asking for a use-case. Which users do
you expect are using this tooltip view so heavily that what's displayed
there justifies this change? If you're one of those users, then waiting for
more feedback on this patch will hopefully provide a better idea of what the
"average" user finds helpful.

> I'll change s/w32/win/ etc, and there's room to move stuff around here,
> but I think it's fine to just not display that it's e.g. "ubuntu" or
> "fedora" at all. That's almost never been relevant.
> 
> If we were trying to do the opposite and lengthen the names to shove
> every bit of useful information in there at a glance I can think of 5-10
> things we'd put there before "fedora". libc/version, compiler/version,
> kernel/version etc.
> 

I'm sure there's plenty of information that would be helpful to have there;
however, that's not really a justification for removing some of what we
already have.

> Whether it's a recent Gentoo or Ubuntu is something that's OK to omit.
> 
> But maybe I'm wrong, are there cases you can think of where we really
> need "ubuntu" or "fedora" etc.?
> 

Yes, absolutely - knowing that `fedora-latest` was the image used in the
failing builds for v2.34.0-rc1 led to learning that the image was updated
the day before the build failed, which was instrumental in quickly
identifying the root cause of the bug [1]. In that case, I got the
information to start debugging from the web UI, *not* from digging into
`main.yml`. 

In general, easily finding what image a CI job was built on can help with
investigating bugs that arise from environmental differences. It's a minor
quality-of-life improvement, but it's no less significant than the benefit
you're suggesting this patch provides.

[1] https://lore.kernel.org/git/pull.1072.git.1635990465854.gitgitgadget@gmail.com/

>>> The above "regular (linux-gcc-default, gcc, ubuntu-latest)" job name
>>> then becomes a 1=1 match to the "$jobname" used in
>>> "ci/run-build-and-tests.sh". A "( push" or " (pull_request" is then
>>> added implicitly as before (from the top-level "on" parameter in
>>> "main.yml"). In the tooltip we'll now show:
>>>
>>>     "CI / linux-leaks (pu..."
>>>
>>> We then have no truncation in the expanded view. See [2] for a
>>> currently visible CI run using this commit, and [3] for the GitHub
>>> workflow syntax involved being changed here.
>>>
>>
>> If the only problem this patch really "solves" is making some job names fit
>> a bit better into the tooltip and, I think the costs (namely the loss of
>> accessible contextual info) outweigh any potential benefits you gain. 
> 
> Yeah it's a trade-off for sure, but now you can't see some of the
> relevant information at all in some views, so it's a gain for
> accessibility too.
> 

It may be a "gain for accessibility" in this one particular case but, in my
opinion, the relative decrease in accessibility by outright removing
information from the *all* CI views is greater. Of course, I don't represent
*all* users, so I'm interested in hearing what others have to say. For now,
though, I'm still unconvinced this patch is beneficial. 
