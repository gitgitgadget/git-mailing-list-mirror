Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8B6C433EF
	for <git@archiver.kernel.org>; Fri,  8 Apr 2022 13:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236140AbiDHNSc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Apr 2022 09:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbiDHNSb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Apr 2022 09:18:31 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3ED45AE3
        for <git@vger.kernel.org>; Fri,  8 Apr 2022 06:16:28 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id t19so10587995qtc.4
        for <git@vger.kernel.org>; Fri, 08 Apr 2022 06:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=a6jwapo1y/7LRl3R7pFXUOD91rvcN42ONP/E0At1/Mw=;
        b=Gy1V28fUJdYXkuBMlQ5+Y9AjyoMYJ3wZFvqlSkId1Abztd2swloB/ZCYgSHz+4MZG7
         k5eKjqtu9foH11WLEVBO7uG/04FxjAomosTY2oxSvoLVQFvxtu/WDs765Hq0tEDOgBhs
         pnu+sUBNiLShDF5QLLxRV7aXS55ldzgocngVo0/G7zubs3sa/fFe/8njsYclm1k6Smri
         c4u0km4N3snpsSVOO8s5UQENyrc7FtUnjDaOXLNf9mzDCu8yE0V8RknF1BD5qcsMG3Jf
         ExHqLG6mw8K8gw4fDR79ia79pfxbHYsYVpVfk6MJUlpWtpwSGU7g+x0nqan4Yu1Lw1Lp
         /v7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=a6jwapo1y/7LRl3R7pFXUOD91rvcN42ONP/E0At1/Mw=;
        b=sBntc2ImatVNXM6OqYkFz054BdX/oRSiSrwMr8xskF7XlxycimfUJxuaJth6PceTq8
         RPTzO+fun87XNsDTJ0Af4f16CBPz1k1bPOj+1/JQzTDu7JJUb1Yf53dRtSMhSlP+WDX9
         vkYYtoVHPDEEchf28+c7dvgUKZJ7vbVgUi+gwGUDTSW8eOkbkDdw8G/csaIXM2Kl5SgS
         r8zp3eHMmzAvw9F6eFgE0NUHwOkUCPuGNZrRl0PmOgH3TMYdzag9wcp88UCpzAib64/A
         rCGD7xB29YmbrkGHiJ88ksnPBKs0y8mcLbRhzbm5I1CP91cWXb9UQmEJ80BtcKsWHT/i
         uVdA==
X-Gm-Message-State: AOAM533MWj4BIea7AL3e4/3ZbxfBHfwErYSE2Gf5KrVUUbzkUGFShpln
        oYe22Bwjht4CoAB7WRp9yoMQ
X-Google-Smtp-Source: ABdhPJyxhCZ8D6f6icUb+HwP/1qOSDgmEMERjFckE6GDSFooacWR1cXOS2E8AgZF3Bkh3EQgmWKsag==
X-Received: by 2002:a05:622a:11c7:b0:2e1:b594:cb1d with SMTP id n7-20020a05622a11c700b002e1b594cb1dmr15861151qtk.59.1649423787149;
        Fri, 08 Apr 2022 06:16:27 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id b2-20020ac87fc2000000b002e1b9ddb629sm17372686qtk.47.2022.04.08.06.13.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 06:14:55 -0700 (PDT)
Message-ID: <b4f85515-945b-51e1-285f-85345124e9b4@github.com>
Date:   Fri, 8 Apr 2022 09:13:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 00/25] [RFC] Bundle URIs
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        newren@gmail.com, "Robin H . Johnson" <robbat2@gentoo.org>,
        Teng Long <dyroneteng@gmail.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
References: <pull.1160.git.1645641063.gitgitgadget@gmail.com>
 <220224.86czjdb22l.gmgdl@evledraar.gmail.com>
 <15aed4cc-2d16-0b3f-5235-f7858a705c52@github.com>
 <a6981d6e-16b0-b0e1-a94d-a87ec20871bd@github.com>
 <220304.86a6e5g44z.gmgdl@evledraar.gmail.com>
 <1469e420-63e5-e2db-21d5-c70674ab04d5@github.com>
 <ddebc223-1e13-e758-f9b1-d3f23961e459@github.com>
 <1b63a8eb-9a6d-a07e-9070-9cdc0c4d5a1c@github.com>
 <220408.86zgkwaq2i.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <220408.86zgkwaq2i.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/8/2022 5:15 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Apr 07 2022, Derrick Stolee wrote:
>> Ævar: I'm still waiting on the full version of this. While you
>> updated [1] your original RFC [2], it was incomplete. I am still
>> looking forward to seeing your full vision of how it works with
>> incremental fetch and how your optimizations to download only the
>> headers of the bundles will work.
>>
>> [1] [RFC PATCH v2 00/13] bundle-uri: a "dumb CDN" for git
>>     https://lore.kernel.org/git/RFC-cover-v2-00.13-00000000000-20220311T155841Z-avarab@gmail.com/
>>
>> [2] [RFC PATCH 00/13] Add bundle-uri: resumably clones, static "dumb" CDN etc.
>>     https://lore.kernel.org/git/RFC-cover-00.13-0000000000-20210805T150534Z-avarab@gmail.com/
>>
>>> 2. Ævar will then do a round of taking both series and combining
>>>    them in a way that allows the union of possible functionality
>>>    to work.
>>
>> Or perhaps you are jumping straight to this part?
> 
> Yeah, that was part of it...
> 
>>> 3. As these things come out, I will make it a priority to read the
>>>    patches and provide feedback focusing on high-level concepts
>>>    and ways we can split the future, non-RFC series into chunks
>>>    that provide incremental functionality while keeping review
>>>    easier than reading the whole series.
>>
>> I'm still looking forward to seeing progress in this area. Please
>> let me know what your plan is here.
> 
> Hi. I'm sorry about the delay, I ran into various life/software things,
> and found that this topic required a lot of continuous "sit down for a
> day and work on it" attention from me v.s. some other topics where I'd
> deal with interruption better.
> 
> Then I was hoping that the merger of your bundle.c changes would come a
> bit earlier before the rc, but they pretty much coincided, and since the
> rc dropped I've been hesitant to send a very large topic to the list
> (c.f. e.g. [1]).
> 
> Maybe I should just bite the bullet and submit it anyway, what do you
> think?
> 
> 1. https://lore.kernel.org/git/nycvar.QRO.7.76.6.2204071407160.347@tvgsbejvaqbjf.bet/

We could err on the side of not distracting from the list. I tend to
think the release phase can be a good time to talk about an RFC, since
Junio can ignore the thread until it is actually ready for full review.

At minimum, I appreciate knowing your progress. I can be patient for a
few more weeks as long as I have confidence that it will be shared as
soon as external blockers are cleared.

Thanks!
-Stolee
