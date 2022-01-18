Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15170C433F5
	for <git@archiver.kernel.org>; Tue, 18 Jan 2022 17:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347248AbiARR7T (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 12:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237348AbiARR7R (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 12:59:17 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAF7C061574
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 09:59:16 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id s61-20020a17090a69c300b001b4d0427ea2so3042370pjj.4
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 09:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=O3jupZ6aCtmUYaDEn1UYzgkjSaIAUVOwbp72sr5G3qo=;
        b=j8mefC/7X9CuP8priVSTxPrZgZrNNgYyM0/hCMRfvBpsPygiVujQwn6uKvxaDzGgkd
         PiIlKnLftiaJxFQSpx2WZH1H1wSNBKR3ViPE2nLlsmtNzz+P9YB18H0K/U2roLk+QyfT
         9rXGxbMjwapqMtZ5OxPVzccfZpa2qPOQ2Pqlz3c2g1e/Q+v3auWiPQX05PH4Gr6Mdv2b
         wiBLpoczncOJ61+sAxYV9jZot3IXIph7bxoqJA3m+S7J4ydO9A56Mt+5dywowPAAI02y
         EEfic0uFklxaAtEpE4ACE82lIO3ml2u1uSaue2aXCSRwje+pWvMZeCHo7wFmXY5YGird
         5CMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=O3jupZ6aCtmUYaDEn1UYzgkjSaIAUVOwbp72sr5G3qo=;
        b=vW+LCG4MeUrt0Wpf3N3JAVll6//J67v/xH3MLNaNO3oDsrZaxC6wc7RV6vREqdwlpC
         exxl709cgUsuXpM8kryb+gvAIvpRNkerqmHFR5IKIQjKWv1s8XysDALQJE6HOsqg28lp
         oBr8h1rsEHLAfxtjS4zXayM4DWFFnBiDtZvuUoAf8FfMY13e32nXyb11SDUcD3xhx7gY
         7nBitWIlJ6ee6K51RoQgvFEQ+1VEyidBaS79VABt566ZpzVUrKoJPlYotSpaXcS2yXin
         NYXdwJGw8yj+msXCt0nAw6+9r+oEG5rzj/f71UokBj+sSSRGgYEZTY+23Nwdrh5DApB5
         FS0w==
X-Gm-Message-State: AOAM530oHB6JHbO/oRizH3ILc8ufYplr9OyQuhc4uyVIVlBaY9oiE347
        izXFGO3ddr1MvO8d3olPoGHY7g5OWAo=
X-Google-Smtp-Source: ABdhPJzbtZd/JD7hm1cNOlQJD7NBAi7aURrdu23NiBf8ofU7UtW06GFardJ5x/1xI3LXlSsOfQZb/w==
X-Received: by 2002:a17:90a:e7ce:: with SMTP id kb14mr32674883pjb.245.1642528756401;
        Tue, 18 Jan 2022 09:59:16 -0800 (PST)
Received: from ?IPV6:2601:602:9e81:12c0:2d18:26b4:c539:428e? ([2601:602:9e81:12c0:2d18:26b4:c539:428e])
        by smtp.gmail.com with ESMTPSA id c19sm19553134pfl.118.2022.01.18.09.59.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 09:59:15 -0800 (PST)
Message-ID: <14ada2ac-9a10-9653-6ced-9cfc675b9419@gmail.com>
Date:   Tue, 18 Jan 2022 09:59:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH v3 2/3] sparse-checkout: custom tab completion
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        johannes.schindelin@gmail.com
References: <pull.1108.v2.git.1640892413.gitgitgadget@gmail.com>
 <pull.1108.v3.git.1641841193.gitgitgadget@gmail.com>
 <256e5f034c6072b6e3621adfa96c5c6319752fae.1641841193.git.gitgitgadget@gmail.com>
 <20220115095725.GA1738@szeder.dev>
 <CABPp-BGR+UrW5ej-8+XXHPkjMfFgURycd9rWC+2awUvYcr_PXA@mail.gmail.com>
From:   Lessley Dennington <lessleydennington@gmail.com>
In-Reply-To: <CABPp-BGR+UrW5ej-8+XXHPkjMfFgURycd9rWC+2awUvYcr_PXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 1/15/22 5:03 PM, Elijah Newren wrote:
> On Sat, Jan 15, 2022 at 1:57 AM SZEDER Gábor <szeder.dev@gmail.com> wrote:
>>
>> On Mon, Jan 10, 2022 at 06:59:51PM +0000, Lessley Dennington via GitGitGadget wrote:
>>> Subject: Re: [PATCH v3 2/3] sparse-checkout: custom tab completion
>>
>> None of these patches touch sparse-checkout, but only the completion
>> script and its tests.  Therefore "completion:" would be a better
>> matching area prefix.
> 
> Thanks for the detailed feedback and guidance in your review.  Very
> helpful.  I'll omit quoting most of it here, but I do want to comment
> on the point about directories.
> 
I second this - am planning to apply all feedback (with the exception of 
completing
on both files and directories) in v4 of this series.

