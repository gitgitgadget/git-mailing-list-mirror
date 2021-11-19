Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA822C433F5
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 10:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DC9961A53
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 10:05:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbhKSKIj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 05:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbhKSKIj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 05:08:39 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68852C061574
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 02:05:37 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id w29so17152989wra.12
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 02:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mdbXRywrOaY8AoYYIZafP7fU9dfAnC2iVsxzQgtz0Dk=;
        b=aJLZXqAcbVvxKXiEWAy2XAqTf/G2rNxjIsWk4pkie0xSrMCzTORRsc4UsG1UUcEknQ
         xuuCvMpT4T5En3MIMwmZUwUxk0Jv522awH6YX0hpInAmxAjQn/eyYpYhwFymZ8F4oFoN
         IgkOQ7zM38eBNgEblPref0t5FQtP6SBXziU8p3wfWhlbz5HkQL81NsgmjaTKMJUz2Krd
         Ck6Iqzo90QNNxEzdmMO4oBZVF6uYQ5sGlB9yEnprk3iqyFx56Nh3DCAugXyOsTTgF/5G
         djmftwn4JIHt6NkwAtUrSgFTbyRXbPTd+zzWGZxR8lCdZR/TcgU5QaOsG423d86TAkXB
         29aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mdbXRywrOaY8AoYYIZafP7fU9dfAnC2iVsxzQgtz0Dk=;
        b=E+8r0PdrU//sQFpDhm4JYmj8OQkE3ej0i5M14IXnYB7tKgvXUDDbLYXt5r3/Cn6H+0
         deoaa8xCVfmwYk7X5svRrH1qaXJQe1fJDi4UHbW7Dd11sfSnSQl7BYUCCZuOiBS1T5k1
         1gVkkxSHbFjKkk2nPuUyYTgH+0ZQmS7dfxHzIyqizG2WdlmmxTa7IdcnRc8f0EAp2f53
         YolXVxaTMmTntJc7Y+gVfaA1h0GJj5ocf3EU2v1euvZir93eTTjNW16P68PB3Veb4pyd
         xI3jCezuEJRuppg8EJGC30FA1EA0RS2VSlo6Vm+cS8eBa4V7q5G4w2P96HNiGtlRizDv
         fEwQ==
X-Gm-Message-State: AOAM530JsEI0JmmkK5hG4eaxT+ZjT56jt9yMHQEXqwQGKa6Fab9G6fo7
        HOSmWkc5Riel2tC43hlae/U=
X-Google-Smtp-Source: ABdhPJzqmfu0JWVv+NrZGviEMf170n0cDAuJp5cyeg5j1vtLMs9LCNRsExMNmVSoc9QPdCeSW1+tIg==
X-Received: by 2002:a5d:6dc1:: with SMTP id d1mr5742617wrz.282.1637316336012;
        Fri, 19 Nov 2021 02:05:36 -0800 (PST)
Received: from [192.168.1.240] ([31.185.185.186])
        by smtp.gmail.com with ESMTPSA id c1sm2466423wrt.14.2021.11.19.02.05.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 02:05:35 -0800 (PST)
Message-ID: <86d38148-7b97-76aa-148b-346cc179615a@gmail.com>
Date:   Fri, 19 Nov 2021 10:05:32 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/3] diff histogram: intern strings
Content-Language: en-GB-large
To:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Derrick Stolee <stolee@gmail.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.1079.git.1637148025.gitgitgadget@gmail.com>
 <38c771a74d2a348e6a752555f95b746de029b1d7.1637148025.git.gitgitgadget@gmail.com>
 <2b2bd380-540f-959b-b950-cfdc95cbff29@gmail.com>
 <88eaee89-4536-fba4-3aa0-c3693f58eae0@gmail.com>
 <nycvar.QRO.7.76.6.2111181631260.11028@tvgsbejvaqbjf.bet>
 <YZZ0e7CCGW5QbQlW@coredump.intra.peff.net>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <YZZ0e7CCGW5QbQlW@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18/11/2021 15:42, Jeff King wrote:
> On Thu, Nov 18, 2021 at 04:35:48PM +0100, Johannes Schindelin wrote:
> 
>> I think the really important thing to point out is that
>> `xdl_classify_record()` ensures that the `ha` attribute is different for
>> different text. AFAIR it even "linearizes" the `ha` values, i.e. they
>> won't be all over the place but start at 0 (or 1).
>>
>> So no, I'm not worried about collisions. That would be a bug in
>> `xdl_classify_record()` and I think we would have caught this bug by now.
> 
> Ah, thanks for that explanation. That addresses my collision concern from
> earlier in the thread completely.

Yes, thanks for clarifying I should have been clearer in my reply to 
Stolee. The reason I was waffling on about file sizes is that there can 
only be a collision if there are more than 2^32 unique lines. I think 
the minimum file size where that happens is just below 10GB when one 
side of the diff has 2^31 lines and the other has 2^31 + 1 lines and all 
the lines are unique.

Best Wishes

Phillip
