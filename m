Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECDEC433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 15:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234244AbiCAQAf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 11:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbiCAQAe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 11:00:34 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC81B45AFC
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 07:59:53 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id g6-20020a9d6486000000b005acf9a0b644so12534092otl.12
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 07:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zWFbH1FbJ4VETCMvkWAFdeOW8bq3/G95oQav9bevGXE=;
        b=K8tGp4EJHJ3k5halLLj1jlrzETTlC0VzrPRpffmkqcQJD9aBSG2HaoPrsGEB3rdGTT
         S4OfB00awk3uIKWFpzblC0xeBAHouFPUjEShqq4bUsyNKv4rMifUhoVCXpSg7w+tg00w
         ybMolOdNKXftUcLQBx3pASJeM5Hyim2ZAz3C5f2dUy6igHWUdsSaeG9QEwZyHAhLMFO2
         usbQI9VbjiiMoWjvfcN+o8XNvgHcWEVnHc5iYAAoxkSRICJfJ8/S6f1iXk+9huxHkE0I
         pPzi8s1z4wRMPAx3uplWzuFKH7KfCKC2jbySZEYgmSfomMD4M8skF7jH8fscpP/Z9ts0
         OdAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zWFbH1FbJ4VETCMvkWAFdeOW8bq3/G95oQav9bevGXE=;
        b=7FV4oUdMLPDV+hlKPABqRjIz1/m8nOhXn4jQZOWfcQl0uORl1fo8iGsGcFDV+ZEsy5
         XqdvDdvvwVjvCA4JTOy0bmUYAvzCQfaZHsrpgGTp3H7tqdfvXf+7N1UWPwobdw4e6VCE
         GKn3UFPlVse2eLNxVK+bQZ85c2omKML8SiS/R2t8sajKlnwMnBbgb4eUeZel8g/aSBWd
         SSW1XO1AZCHnZI67lPvfXldO1MEDfsMWhfq41JGBoeWGd5HSicuCjnJZVqeQKL9lHU9V
         7pzfP+yxsINmzAgGTPMZCjSJp+hAf1BAYha4iCGm1XHnARsp7Ctms45GK8qBrkjRShQA
         TZjw==
X-Gm-Message-State: AOAM5317aa4i+kFmbg8Hxr/HdQskNXUoXHrTN7gpAec5RLWTNfJKUFgG
        ZqoXlc3Y1meSwalr8r5uaX5z
X-Google-Smtp-Source: ABdhPJwTZFqc1d6SN6MdhKjX/3vu4X7gcKfNlIYKwR/EWFQpRu3owqhLHJiWcCmI5eTw5fa4iCpDow==
X-Received: by 2002:a05:6830:4006:b0:5ad:cd4:3957 with SMTP id h6-20020a056830400600b005ad0cd43957mr12923764ots.195.1646150393123;
        Tue, 01 Mar 2022 07:59:53 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id t15-20020a4aadcf000000b0031c33fdb5d9sm6348864oon.39.2022.03.01.07.59.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 07:59:52 -0800 (PST)
Message-ID: <8860432e-9440-2f6b-3647-550f908c893d@github.com>
Date:   Tue, 1 Mar 2022 10:59:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 5/7] commit-graph: document file format v2
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, gitster@pobox.com,
        abhishekkumar8222@gmail.com
References: <pull.1163.git.1645735117.gitgitgadget@gmail.com>
 <7f9b65bd22551fd7fd5d2f0bf18aee8c25f1db99.1645735117.git.gitgitgadget@gmail.com>
 <220225.86a6ee7eid.gmgdl@evledraar.gmail.com>
 <d19f5ee8-af92-805f-7ea2-8285862c1123@github.com>
 <220228.86pmn73toq.gmgdl@evledraar.gmail.com>
 <e74d72bc-b6f5-2e1c-63d1-d3a580f3dc11@github.com>
 <220228.86ilsy3a8b.gmgdl@evledraar.gmail.com>
 <9b52fdd3-64fc-34b1-d4ee-660b4fb73f39@github.com>
 <220301.86y21tznw3.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <220301.86y21tznw3.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/1/2022 9:29 AM, Ævar Arnfjörð Bjarmason wrote:

I agree that this discussion has mostly run its course and I'll do my
best to summarize it in the commit messages of a future patch series.

I just wanted to focus on two things in the most-recent reply:

> On Tue, Mar 01 2022, Derrick Stolee wrote:
> 
>> On 2/28/2022 4:14 PM, Ævar Arnfjörð Bjarmason wrote:
>>>
>>> On Mon, Feb 28 2022, Derrick Stolee wrote:
>>> I think arguable that's OK/worth it, but it's "not [any] issues", no?
>>
>> What I mean is that this change does not enable the new graph version
>> by default, so these users do not have any issues unless someone opts
>> in to the feature while in this mixed scenario.
> 
> Indeed. FWIW I wasn't confused about that bit. I'm just commenting on
> /how/ we do version upgrades, and if we can save users unnecessary
> hassle relatively easily.
> 
> But I also think the writing is on the wall that you'll want to
> (understandably) bump the default sooner than later, or if not for this
> data for other future chunks.

I think somewhere I said we wouldn't want to update this default for
at least a year after it ships, but I'm also happy to never update it
and let experts opt-in when they want.

>> Finally, the end result becomes "older versions get slower without
>> any warning" instead of "older versions get a message about not
>> understanding the commit-graph file".
> 
> Sure, IF you want to write such an empty chunk. The point is that you
> now have the option.
> 
> And this is the same edge case we already dealt with for
> GDAT/GDOV. I.e. older readers who didn't understand it would be slower.
> 
> We can still have a feature to make older clients intentionally
> break/warn, it seems to me that if you'd want such a thing you'd want it
> aside from the specific mechanism of this proposed upgrade.
> 
> Or you could dual-write the data for older clients, which I think
> probably isn't worth the hassle.
> 
> I.e. if you're worried about silent slowdown older clients happily
> ignoring the BIDX and BDAT chunks are silently slower.

Older clients ignoring BIDX and BDAT chunks means they are silently
slower than newer clients, but they are still as fast as they were
yesterday. The empty chunk approach will make those older Git versions
slower than they were yesterday.

Thanks,
-Stolee
