Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71469C433F5
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 18:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356315AbiALSfR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 13:35:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356295AbiALSfO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 13:35:14 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBADAC06173F
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 10:35:13 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id n30-20020a17090a5aa100b001b2b6509685so6555226pji.3
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 10:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=MHo36GDD40bbjKCa4KBl3OCWlz6Ps7xa+rx1AFe/dec=;
        b=KjEbK7jfhopAP/mUMzdabCljttGADTESJUOqxIRucxjUfxT9Bdw6LILJrsDfMCpe3r
         w4Z4niRRbLT6OyvMBvsD1IB2LW/0HykO+SeFGaaWkLWT5ZFsHC8/nOImJi8mMRm//KnJ
         U7bQW12q622wWxHEa07MsaHIDZf30ebWXzoNYuP+3V1pMtXMH/smmwPz+mQMO/wVsDXh
         1M9GInFuFHFvmeu8H/tEV/UMtRTh8i8NH9+npvaL+YGO7TpRblj1WRJEW0gkkNMDV9ZR
         KISm4sKT5lGkDVVki6/MLw/gkWkCouDS6zef4723SUnG1Zba/UQRPDbmv3tGO3xmLWUg
         t1rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MHo36GDD40bbjKCa4KBl3OCWlz6Ps7xa+rx1AFe/dec=;
        b=avS1l2cYfQqBoyDlVel/6aQogtBQaP/aouYeJuKwd1lT1ngCO68afqrMFeNlnprQsD
         NVsvtJhygeYeGBQc0OjxVQ0nNnhadE4j9RnG0INrDnptsc6PCQtENJ4+p53ZmRHUqRx2
         W3D/e7nWKnFKS2bsN05GFfPXuPAZGb4Eto3HbhVfKhbumewNUj5wZnBd913f5B58ETPd
         PBGGIgIMkWVZaZw6EXgQkiWxCgJv6oMNcxXhcpf8h4Y/oaaFHUSZSEH4wXpIQf4G3hcd
         /6FJBGuUPys6lHRc+8pdK1HeTal+hIuzoybnfIWA3+1ZZHdXyMjGfG1ZxB+rpeHCcxb8
         OYDg==
X-Gm-Message-State: AOAM533dRkJguuqrgQeGVZmXju5OWpMf25JYnHqJiBrl3YOhfFFREkoA
        HBj7mbIn28zJyxKrviapwZU=
X-Google-Smtp-Source: ABdhPJyUhEdLA+KHD0NvrEyYiLYhA9uR/0xVN/DlMS/qRyPQzHl9LLhzqSVI/ZQyWXd7J/bUMiAVxw==
X-Received: by 2002:aa7:96bd:0:b0:4c1:232c:818a with SMTP id g29-20020aa796bd000000b004c1232c818amr806813pfk.35.1642012513422;
        Wed, 12 Jan 2022 10:35:13 -0800 (PST)
Received: from ?IPV6:2601:602:9e81:12c0:b8d6:f480:77a5:ee68? ([2601:602:9e81:12c0:b8d6:f480:77a5:ee68])
        by smtp.gmail.com with ESMTPSA id om7sm374543pjb.47.2022.01.12.10.35.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 10:35:13 -0800 (PST)
Message-ID: <b4a8fb17-ff20-aac9-73bf-54d872fb67b1@gmail.com>
Date:   Wed, 12 Jan 2022 10:35:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH v3 0/3] sparse checkout: custom bash completion updates
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        johannes.schindelin@gmail.com, Denton Liu <liu.denton@gmail.com>
References: <pull.1108.v2.git.1640892413.gitgitgadget@gmail.com>
 <pull.1108.v3.git.1641841193.gitgitgadget@gmail.com>
 <CABPp-BG=wr81CPtW1M12xFN_0dyS8mAZjM6o=77LA20Zge8Xng@mail.gmail.com>
 <92913af3-7985-0789-eee0-c84601d2a31f@gmail.com>
 <Yd3eXHzEG7nJi8ZB@nand.local>
From:   Lessley Dennington <lessleydennington@gmail.com>
In-Reply-To: <Yd3eXHzEG7nJi8ZB@nand.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 1/11/22 1:45 PM, Taylor Blau wrote:
> On Tue, Jan 11, 2022 at 09:17:38AM -0800, Lessley Dennington wrote:
>> On 1/10/22 2:38 PM, Elijah Newren wrote:
>>> Other than that one nit, patches 1-2 (and the testcases in patch 3) are:
>>>
>>> Reviewed-by: Elijah Newren <newren@gmail.com>
>>>
>>> Since I wrote the new __gitcomp() function in patch 3, it might be
>>> nice if we can find another reviewer for it. Especially since I've
>>> only lightly touched the completion code and there might be better
>>> ways of achieving what I wrote there.
>>
>> I agree - I'll chat with some folks today to try to find the best person
>> to take a look.
> 
> Having another set of eyes on this code never hurts, but looking through
> this file's shortlog (especially with `--since=1.year.ago`), I'm not
> sure how many active reviewers in this area we still have.
> 
> Perhaps the best thing to do would be to grow some new area experts here
> instead. If I were in Lessley's shoes, I would "think aloud" to make
> sure I agreed with your implementation for the new `__gitcomp()`
> function.
> 
> If other reviewers happen to be around (perhaps Denton, who I added to
> the CC) that doesn't hurt either, but short of that...
> 
> 
> Thanks,
> Taylor

Thanks for the help here, Taylor! I like this suggestion and will add my
thoughts to Elijah's __gitcomp_directories function.
