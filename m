Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B73C433EF
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 17:42:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239112AbiBBRmX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 12:42:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiBBRmW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 12:42:22 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27997C061714
        for <git@vger.kernel.org>; Wed,  2 Feb 2022 09:42:22 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id q14-20020a05683022ce00b005a6162a1620so188938otc.0
        for <git@vger.kernel.org>; Wed, 02 Feb 2022 09:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=X2lXRPlXm9OqnQm1hUSiGlXAFEyQKpkhaX0mBl3hv4Q=;
        b=LVfTHdLJS6u8UOfDR+0jAPR/l2pzZ8H08Aa4IGxv34ZtXalMAnliZwH4Ac8Yx0j6Ys
         kIwiVzwkQMeFfy9o18st4RmU0JNirECbpjK5FjJBnap11+Sz2BqIhr3Zzam/D+5GHpg1
         FdM/3sQV9XYRfMFkxqJ8dtefR7HKAHavs8lFsIdIiBN4jOW7K718dDaLkUEzDeHbMZwh
         RDR3BEA+bCqjYzIH+D04lEdoC2fIIMOdWk+Yem4K1qx/fCxMwOPeacqSywsgdgZ9btkI
         QtoxxU2vkkvLN8WQtlUQQ9dFWVyxrZVbUWe0hQoWc+ff2SESKea14533ZScW8oR6rx8z
         sFzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=X2lXRPlXm9OqnQm1hUSiGlXAFEyQKpkhaX0mBl3hv4Q=;
        b=uLytKMKImp30Bl/oqLMkkl7ei2ww9tim2HQlD1ws087NteTvO70QQK0ZxCGgAk58se
         IkoSgHaBoMZ337AJcKi11cETxtNOfQKOBh06yM2rnqnGPUjwCEqkGeQ88rxGu35nY0nz
         bGmQaGBbbiva65TMHzN6lj7GDGU8uVWOhPWVVA8ibwsZcegB1m+uoCZvSUD5Law/oeb0
         xAS8xrZgztWfLH1LcLJX4zOPchk50LLebSKVA24Q2/HZpMmLnWVrk2Iw4CLOh2ZkxIeJ
         oT6XopKwcrA3MSUJB74U0kwgI63PWpeY192x2GX1DXzVWAsXk0zNHXYH8T+b97WC3PQX
         rahw==
X-Gm-Message-State: AOAM533zVfdDHIAZYT80mq3U5g4ceJzz3sX8YfjU6/+3Sw2PXOPr73X8
        Mt9QLkniI4RSyuX9ZvReDdo=
X-Google-Smtp-Source: ABdhPJxROWmVryPPcXj3da0ydTqg25LvUMyJYSGlZPltPRMy8I6EHFbEDUhMPAUsziwlCg8zIErLBA==
X-Received: by 2002:a05:6830:24b5:: with SMTP id v21mr11536911ots.130.1643823741178;
        Wed, 02 Feb 2022 09:42:21 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:958a:5e6f:d530:1ec5? ([2600:1700:e72:80a0:958a:5e6f:d530:1ec5])
        by smtp.gmail.com with ESMTPSA id v78sm9847018oie.18.2022.02.02.09.42.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 09:42:20 -0800 (PST)
Message-ID: <356a8f62-9ab7-9c80-6d5f-337a2dc4049a@gmail.com>
Date:   Wed, 2 Feb 2022 12:42:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: Git in GSoC 2022?
Content-Language: en-US
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
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
 <aa324a28-2336-c7b0-c1b7-ca4d440d9ff5@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <aa324a28-2336-c7b0-c1b7-ca4d440d9ff5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/29/2022 1:19 PM, Kaartic Sivaraam wrote:
> On 27/01/22 8:09 pm, Derrick Stolee wrote:
>> On 1/26/2022 1:29 PM, Kaartic Sivaraam wrote:
>>> If we are interested in participating we need:
>>>
>>>    - Volunteers who are wiling to act as mentors. I would be
>>>      willing to be volunteer myself as a mentor for one student.
>>>      - Microprojects: I believe we could repurpose the Outreachy
>>>      microproject ideas[2] for GSoC too. If others have suggestions
>>>      for microproject ideas, please share them.
>>>
>>>    - Project ideas: There are two mentioned in SoC-2021-Ideas[3]
>>>      but both were picked by GSoC students the previous year. So,
>>>      we would need new ones this year.
>>
>> One project that could be interesting for GSoC (and the timing
>> should work out) is to complete the sparse index integrations for
>> some of the less critical commands. Some examples include 'git mv'
>> and 'git rm', I think.
>>
>> This of course depends on some ongoing work to integrate more of
>> the critical commands that we implemented early in microsoft/git,
>> such as Victoria's current series which is leading to a 'git stash'
>> integration and a series I have waiting in the wings for a 'git
>> sparse-checkout' integration.
>>
>> However, I think we have a decent paved-path for a new contributor
>> to jump in and get started on the remaining commands. The granularity
>> means that the project has multiple milestones that can be hit
>> without an all-in-one series.
>>
> 
> Sounds good.
> 
> As I mentioned up thread, you could feel free to share the project
> description here or open a PR by adding it directly to this document:
> 
>   https://github.com/git/git.github.io/blob/master/SoC-2022-Ideas.md
> 
>   (note: currently returns a 404; it should work when the
>    related PR [pr-1] is merged)
> 
> Just to be sure, would you be willing to mentor in case a student
> picks this project?

Victoria Dye and I are willing to co-mentor if a student picks this
project.

I'll make a PR that adds a description to the linked doc soon.
 
Thanks,
-Stolee

