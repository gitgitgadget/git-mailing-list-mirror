Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E51C54EE9
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 04:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbiIVEZB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 00:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiIVEY7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 00:24:59 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2635140D
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 21:24:58 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id h28so5477132qka.0
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 21:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=76xMlEV0wYNG8qmPY50IvZvXyeYO7RyBHVdqk1dAVpw=;
        b=Xffl2ocvpr2mm8Buxnt/vMEdvrrPujn0uNlXLgFPYJ1oZFsGUNQrfe+wnRv1CYQlES
         gzeAFiYhj1h5ByA15yurCfmxoh4sZDzoWKLW3pltSzEcRD6snhxjDA9z0QSQwcs3KuCi
         HIy8BVpABFCJQZlG/iIk9vncMVH2AWD0KZ6xs9rn0Ywyw72r6Mg4HSs16OwdOSJUpilc
         io2x0+Lxx8XLSGt5js42svbhtRLxsfe+32D0vP+udo3gKHwwe1TMmr9T1Y2l5uefGQu/
         d/EcmNj7eXvlJhSyfztvUwwz5PMKEjvOe4HZhWhORJ0UWw5nGEGvEiI9IiUmQJfV2u5g
         kbcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=76xMlEV0wYNG8qmPY50IvZvXyeYO7RyBHVdqk1dAVpw=;
        b=mo72v9Xv3sBs0l47Gye//czuQ5BGtCjsih1tie5RtuBc9celgc37tQCbQFS7pU7JUf
         OHh+/CY2nURp6kZb0KW8drr6vKrCpm4RCwsA3aoQ7km5NR3nV97cY/yQWt/jkD7ER1pM
         CMxPGH4SCf7KEOrZ76EHEOFOF25UDdHyj/jS4czHYc1DP2oWpQGSshA6d0f5+GpJDLX6
         fNpgVkwVZZJei67C6dul3Q55XYwJMb5fdcVtD2ikQAmAr5vQ/K0zL50cNbiZwQ7a/ICC
         Jz3oKRDL+VoI1f9tlJ5tte1Qfs3D6GnMFQbnQ4XRjbfpenlo7Idd+nWr9QpxlD+oqLVB
         BWrw==
X-Gm-Message-State: ACrzQf0TELcTJerglN/DztcmuS/qZOno0YRKwPZeV7koJjb9ndhIp1PK
        kdSxlb46n9pXb2WSdJQW53Q=
X-Google-Smtp-Source: AMsMyM4QnNYI6Zqckk4fv4vLhubQKGwRYeUvB9ik6gUAZyRFU8Bd8rswnvWN4KAGLc709/dDNGTXhg==
X-Received: by 2002:a05:620a:254e:b0:6c9:cc85:c41a with SMTP id s14-20020a05620a254e00b006c9cc85c41amr953264qko.260.1663820697729;
        Wed, 21 Sep 2022 21:24:57 -0700 (PDT)
Received: from [192.168.1.69] (99-110-131-145.lightspeed.irvnca.sbcglobal.net. [99.110.131.145])
        by smtp.gmail.com with ESMTPSA id d1-20020a05620a240100b006ce16588056sm3206614qkn.89.2022.09.21.21.24.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 21:24:57 -0700 (PDT)
Message-ID: <df9b1022-fc96-f0fe-8652-78e8891e3c99@gmail.com>
Date:   Wed, 21 Sep 2022 21:24:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2] Documentation: add ReviewingGuidelines
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Josh Steadmon <steadmon@google.com>,
        Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>
References: <pull.1348.git.1662747205235.gitgitgadget@gmail.com>
 <pull.1348.v2.git.1663614767058.gitgitgadget@gmail.com>
 <CABPp-BEB_+YoKZ=U6NPc8J+KZyMSYRsom34CeqjxUCyw0=LEyg@mail.gmail.com>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
In-Reply-To: <CABPp-BEB_+YoKZ=U6NPc8J+KZyMSYRsom34CeqjxUCyw0=LEyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/19/2022 5:43 PM, Elijah Newren wrote:
> On Mon, Sep 19, 2022 at 12:21 PM Victoria Dye via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
> [...]
>> +==== Performing your review
>> +- Provide your review comments per-patch in a plaintext "Reply-All" email to the
>> +  relevant patch. Comments should be made inline, immediately below the relevant
>> +  section(s).
>> +
>> +- You may find that the limited context provided in the patch diff is sometimes
>> +  insufficient for a thorough review. In such cases, you can review patches in
>> +  your local tree by either applying patches with linkgit:git-am[1] or checking
>> +  out the associated branch from https://github.com/gitster/git once the series
>> +  is tracked there.
> 
> Lots of reviews also come with "Fetch-It-Via" instructions in the
> cover letter, making it really easy to grab.  Might be worth
> mentioning?
> 
> Also, would it make sense for us to replace "applying" with
> "downloading and applying", perhaps mentioning `b4 am` for the
> downloading half?
> 
> (I tend to use the Fetch-It-Via or wait for it to show up in
> gitster/git, but b4 is really nice for the other cases.)

Thanks, I did not know about b4, it looks quite helpful!

I think it is worth mentioning some recommended practices to operate
'git-am'. 'git-am' was a bit confusing the first time I tried to grab
people's patches from the mailing list without using "Fetch-It-Via",
e.g. what is mailbox and how to convert emails into mailbox.

b4 sounds like a good start to add these practices, and probably some
other recommendations (I don't know much here)?

Please note that these are just some thoughts, the document itself looks
good without adding these practices (maybe we can add them later) :-)

[...]

Thanks,
Shaoxuan
