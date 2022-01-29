Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97AAC433F5
	for <git@archiver.kernel.org>; Sat, 29 Jan 2022 18:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244826AbiA2SUB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Jan 2022 13:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233508AbiA2ST7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jan 2022 13:19:59 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E0CC061714
        for <git@vger.kernel.org>; Sat, 29 Jan 2022 10:19:59 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id b1-20020a17090a990100b001b14bd47532so9604905pjp.0
        for <git@vger.kernel.org>; Sat, 29 Jan 2022 10:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eDNtctWVQ6+hojGHxTTUP4Jn0rTI9y743SY4wWjzWSU=;
        b=MZ12JISidd7Vas/ogpOylnKb5vBEPCqNEhcyt4PSTW6I2OP00PfozVQ7lJ6PGA3aMI
         TJ+PgtKIDPC8L5gC+QaT8RFyICRQnIfHFHnYchJvUhZFo5PeQDLfBFyTiNIOWYy+UXNQ
         MHRS1iWznA372o3oyzq4cVtetyReRnBMXObbtMpxPg5Wq9ALlqQ6Doh5apVQ759S5O2f
         dL6ITDjJKcsUrrKyuycSLbR54ZfuDp48fRwkgwkIdazPFmc4kKhPDF0UqZWCaoCgmbI8
         F0LXtNRpzB15+RFYn16kH3TxMSqwe6wjeh6tvSLupDRw+5sE4yuCYpcd3TI3ijXQD5i+
         PEUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eDNtctWVQ6+hojGHxTTUP4Jn0rTI9y743SY4wWjzWSU=;
        b=X3orK7DTdorvjwANVE+6Flj8VJnnooLCZ44MVtvrtHmPm5uDPUtassdxN3fxHxHrW+
         pXcMEBj//O9bz0TbohbLrE/286P6Q1Ohoiykthxptd0+rOuU1UOP/V6hj7d4kMXISqj+
         +06ZDezManfErFB/YiHQ/WT5gGbJYsuFJOqQ2Cywf9qkGk0BSRkUK6W0Y3/cP1+2Z1zF
         fwHyg/jOaWSpwAREWoJsuy3hdyUzfF1y725BCZtrPNQA3BkINSjf8VOEZF+EJV8SuaOH
         4KLzx8mfcNcxjh2IMJitXFmNgKxeykweqZkN7ae16bdo4VlbcM0BnWHbim5hYcHfcvpY
         QFVA==
X-Gm-Message-State: AOAM531F9pVhpAFEEGO3DgU/5SKLdPgJYKnA3Q7jfmmxbBK1jwO5zItP
        2HggO93msJVYoyeQIXZvTbg2RQ9veuo=
X-Google-Smtp-Source: ABdhPJxAbgkT+h1BDGz7IW8ri52YVRtEB0L3gezGrBQTPRnoqnOhO6o9VPl9SwCbgUd6DCVmKUNMng==
X-Received: by 2002:a17:90b:146:: with SMTP id em6mr26174595pjb.214.1643480398635;
        Sat, 29 Jan 2022 10:19:58 -0800 (PST)
Received: from [192.168.208.38] ([49.204.143.33])
        by smtp.gmail.com with ESMTPSA id w11sm13481185pfu.50.2022.01.29.10.19.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Jan 2022 10:19:58 -0800 (PST)
Subject: Re: Git in GSoC 2022?
To:     Derrick Stolee <stolee@gmail.com>,
        Git Community <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>,
        Victoria Dye <vdye@github.com>
References: <439ebfba-d493-2cff-434a-b1073e755688@gmail.com>
 <ca51848c-d3e1-7f85-0268-ab4c999ea2bd@gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <aa324a28-2336-c7b0-c1b7-ca4d440d9ff5@gmail.com>
Date:   Sat, 29 Jan 2022 23:49:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <ca51848c-d3e1-7f85-0268-ab4c999ea2bd@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/01/22 8:09 pm, Derrick Stolee wrote:
> On 1/26/2022 1:29 PM, Kaartic Sivaraam wrote:
>> If we are interested in participating we need:
>>
>>    - Volunteers who are wiling to act as mentors. I would be
>>      willing to be volunteer myself as a mentor for one student.
>>   
>>    - Microprojects: I believe we could repurpose the Outreachy
>>      microproject ideas[2] for GSoC too. If others have suggestions
>>      for microproject ideas, please share them.
>>
>>    - Project ideas: There are two mentioned in SoC-2021-Ideas[3]
>>      but both were picked by GSoC students the previous year. So,
>>      we would need new ones this year.
> 
> One project that could be interesting for GSoC (and the timing
> should work out) is to complete the sparse index integrations for
> some of the less critical commands. Some examples include 'git mv'
> and 'git rm', I think.
> 
> This of course depends on some ongoing work to integrate more of
> the critical commands that we implemented early in microsoft/git,
> such as Victoria's current series which is leading to a 'git stash'
> integration and a series I have waiting in the wings for a 'git
> sparse-checkout' integration.
> 
> However, I think we have a decent paved-path for a new contributor
> to jump in and get started on the remaining commands. The granularity
> means that the project has multiple milestones that can be hit
> without an all-in-one series.
> 

Sounds good.

As I mentioned up thread, you could feel free to share the project
description here or open a PR by adding it directly to this document:

   https://github.com/git/git.github.io/blob/master/SoC-2022-Ideas.md

   (note: currently returns a 404; it should work when the
    related PR [pr-1] is merged)

Just to be sure, would you be willing to mentor in case a student
picks this project?

[pr-1]: https://github.com/git/git.github.io/pull/540

>>    - Multiple Sizes of Projects: In 2021, project size was reduced
>>      (~175 hours). This year, both medium sized projects (~175 hours)
>>      and large projects (~350 hours) are supported.
>>
>>      GSoC organizers recommend communities to have both medium _and_
>>      large size projects.
> 
> I think this project would fit in the "medium" category.
>

-- 
Sivaraam
