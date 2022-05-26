Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 036D7C433EF
	for <git@archiver.kernel.org>; Thu, 26 May 2022 18:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236835AbiEZSbf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 14:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348900AbiEZSax (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 14:30:53 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8414F4BFDA
        for <git@vger.kernel.org>; Thu, 26 May 2022 11:30:52 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id f18so2176528plg.0
        for <git@vger.kernel.org>; Thu, 26 May 2022 11:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=iqwpJrN0lC2Tsui/IlbyBiYQztNw6nfDjD/iKJhFh4Y=;
        b=KtrPdIoJG8OrFTVK/MwnRED0vN2JawuLhT7RB9OkWXkQ5kbs10hsAsE0W2JOuM81ms
         D/njllrc6MTqLi8PsM6X8lfWJO5ArZCEjlu4Rq0SaMIPybSz1455lilqwTMccg9oCaUP
         UDM1E8ml044m53XuGWlnrbQdPbqDxlWipfyghKQ7lJYRahq7l9QrE6JHlZ5iFd4MiHWW
         TV/z5V1erORnTqIxPjoWLP87xj5EnNCD6EtHe12LTEdNoblWNEYHvYiOc3JENSdy9L/w
         jCpihZfSMqNuOrSOWcAK3cnPUTDiSE+s3iGPQjIxoKvjL0bMW+uBevcpBvTZvoFfGPZX
         s42Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iqwpJrN0lC2Tsui/IlbyBiYQztNw6nfDjD/iKJhFh4Y=;
        b=BG7dt1Y0I+L51BsDgR1Qu/gvySUGuSYRM1DrSBspKo2YIaBT8m6duX4MLjzo5aH/WN
         bHvaAPVfVsXdJfMiQLLZtK8joSWiUK1Ls/eWPj5sit/BpMALTM5ickjyuj/54ny5sbYJ
         SEv5ze4jsAdqB9pXyFihifn6ZS+5DTae20ZZ9prmtiyIk0HHXRxC3Lwp+qmvx5Mw+yCG
         4DEbGNFDJ3ziyOJOTTaQPINF4P2N7wuRLTIo53/o7njEQeecRknz8dGbTG5NvtcfE7PR
         BTsOFMKCMkc5vBHQMdi99kniLC3o2xUcuhgloTJZ3p1/EO5CPhLUG1zeSP72HrnV8Xdn
         0Ekw==
X-Gm-Message-State: AOAM53158Y276m2vLsfEwKuPebzyoELvio7Z+hBVzwgwY4AKT5OkPCVm
        eY4XV7rNSguiq1am9q+BbTzk
X-Google-Smtp-Source: ABdhPJyxRYxXGR5dE6OQtXlZmN8iErSddmXl6C5hoN/yE3RIIpGfSq56xrMwHGXUI8viZ0GKXPZ7yA==
X-Received: by 2002:a17:902:f652:b0:156:701b:9a2a with SMTP id m18-20020a170902f65200b00156701b9a2amr39091982plg.14.1653589852019;
        Thu, 26 May 2022 11:30:52 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id m5-20020a63f605000000b003faebbb772esm1872808pgh.25.2022.05.26.11.30.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 May 2022 11:30:51 -0700 (PDT)
Message-ID: <8b57f907-3db1-9fe1-d582-e2d05acbe5ce@github.com>
Date:   Thu, 26 May 2022 11:30:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: What's cooking in git.git (May 2022, #07; Wed, 25)
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <xmqqzgj41ya2.fsf@gitster.g>
 <df44b0cd-bba7-19f0-4e45-c0988239cc4d@github.com>
 <xmqq4k1c1a34.fsf@gitster.g>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <xmqq4k1c1a34.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Victoria Dye <vdye@github.com> writes:
> 
>>> * js/ci-github-workflow-markup (2022-05-21) 12 commits
>>>  - ci: call `finalize_test_case_output` a little later
>>>  - ci(github): mention where the full logs can be found
>>>  - ci: use `--github-workflow-markup` in the GitHub workflow
>>>  - ci(github): avoid printing test case preamble twice
>>>  - ci(github): skip the logs of the successful test cases
>>>  - ci: optionally mark up output in the GitHub workflow
>>>  - ci/run-build-and-tests: add some structure to the GitHub workflow output
>>>  - ci: make it easier to find failed tests' logs in the GitHub workflow
>>>  - ci/run-build-and-tests: take a more high-level view
>>>  - test(junit): avoid line feeds in XML attributes
>>>  - tests: refactor --write-junit-xml code
>>>  - ci: fix code style
>>>
>>>  Update the GitHub workflow support to make it quicker to get to the
>>>  failing test.
>>>
>>>  Will merge to 'next'?
>>>  source: <pull.1117.v3.git.1653171536.gitgitgadget@gmail.com>
>>
>> The latest version of this nicely addressed the feedback I originally had,
>> particularly in improving page loading time. It's still slower than before
>> this series, but IMO it's manageable (especially taking into account the
>> improved information accessibility). 
>>
>> I don't see (or have) any other unaddressed concerns, so I'm in favor of
>> moving it to 'next'.
> 
> I see Ævar sent another reroll of "rebuild the base" and "then
> rebase a (hopefully) equivalent of this series on top", but I think
> it is unhealthy to keep doing that.  Does the latest "rebuild the
> base" part look unsalvageably and fundamentally bad that it is not
> worth our time to consider joining forces to polish it sufficiently
> and then build this on top?
> 

My impression of 'ab/ci-setup-simplify' is that its core changes are either
unrelated to, or at least not mutually exclusive with, the
'js/ci-github-workflow-markup' series. While Ævar has sent an example/RFC
with one series rebased on top of the other, I don't see the two as
inextricably linked, or even really comparable. Because of that, I don't
think it would be fair to either series if we continued to hold up *both*
because of different levels of consensus, review, etc.

As for my thoughts on each series, I do still think
'js/ci-github-workflow-markup' is ready for 'next' (for the reasons I sent
earlier). I think 'ab/ci-setup-simplify' needs more review - especially
given its length and the variety of changes - to ensure it doesn't introduce
regressions or hurt developer quality-of-life. I've personally had a
difficult time making sense of the series enough to review it, so I can't
confidently judge it one way or another myself.

> If that is the case, then I am OK to merge this to 'next' to cast it
> in stone, and then the let "rebuild the base" part once die, to be
> reborn as many "tweak the way things work to (clarify|optimize) X"
> follow-up topics.
> 

I'm not sure 'ab/ci-setup-simplify' would need to "die", more that it would
be adjusted to rebase on top of an updated 'next' (including
'js/ci-github-workflow-markup'). That said, a re-sent version focusing on
its own optimizations/improvements (rather than a comparisons against an IMO
largely unrelated series) would almost certainly benefit both the series and
its readers.

> Thanks.

