Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 119A5C433EF
	for <git@archiver.kernel.org>; Sat, 22 Jan 2022 01:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiAVBHz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jan 2022 20:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiAVBHy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jan 2022 20:07:54 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28DCC06173B
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 17:07:54 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id v74so7104701pfc.1
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 17:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=5+0+SBA5a3cVdu1VRGMPQqi/WXwBGoAGQAo9BIIAajg=;
        b=cmY3B5KvTqoH7iPEZbHwmM3BKwLOVU5Pg2B6VE1b2VLaSvKf9PagEBXA3rSgGKwiCZ
         GN2vtkLFuwRNsY9lekh0qZpUMB5cFzNnziiTkg1h4tOI9BAIMeSxgCn0TDWcjKJtFCXf
         JmWo5H+FZd5R+s7NrKn07MDx8ATtUtrY38iu6u0ctuXL/bq/IMPTyqblxBs94e6iV/PL
         N4FQppilb8vtXpyD1PSRH7sw8Xo58E3V1ugXVB0A1g4aDKMtWQi8HmHpRl7tuPVLfP5E
         4v12Y20pFfQah28NjlgYltCNwuCW7BVtEazxq62okkP5MlIJam0R6sxQRBXjCoZdXGsJ
         1GrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=5+0+SBA5a3cVdu1VRGMPQqi/WXwBGoAGQAo9BIIAajg=;
        b=27dpGFc24mej/Y4p+CMAEh8NTHzgSz8B+vupU7V1Q5rmwADvc4ON4qIKAPMWKmb0Qs
         7xpQEbrXGs55+w07a2jqXIFxbkgL1y/G1h+X+rhqO4pyFbZ/Et2djlzkXG4KpdRr9DR7
         qushp1cINwGO/LO0waKc0xO8gpKSpQas9B+utOHoL8bySiB2T3Vyfg4xKqYn4uR93Odk
         /2GuzKlOd+iGavmUq1lroQcklEELLM4Nd3VvpAtjyFLi1IWmDIf9uTGsUKJBSJTM4TLK
         cOOoBVyZFZKD1dq2L+eEaAHtl6m0Uy/ZSqt/ZugAlksBmzBBwnrU2v4VomzdnZBWrsXZ
         /o4g==
X-Gm-Message-State: AOAM5309Nuj10TqICYtqnfWr71p19XzgtA+kuZnqszcPW2Cd0v/WIoYP
        Spu9b1lN6owTAOpwoK72UDU=
X-Google-Smtp-Source: ABdhPJyPtBfsOPCpeW1GPVocG89XaL7S+/2iXJcLlAXrHShWAEuuvU8IJgqbs+aCYNKWd/BDW5M2KA==
X-Received: by 2002:a63:c145:: with SMTP id p5mr4565807pgi.355.1642813674173;
        Fri, 21 Jan 2022 17:07:54 -0800 (PST)
Received: from ?IPV6:2601:602:9e81:12c0:59d7:62f6:f657:9932? ([2601:602:9e81:12c0:59d7:62f6:f657:9932])
        by smtp.gmail.com with ESMTPSA id u8sm8495240pfi.150.2022.01.21.17.07.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jan 2022 17:07:53 -0800 (PST)
Message-ID: <78956982-f5fc-1681-1efe-42e408132a4f@gmail.com>
Date:   Fri, 21 Jan 2022 17:07:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH v3 2/3] sparse-checkout: custom tab completion
Content-Language: en-US
From:   Lessley Dennington <lessleydennington@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        johannes.schindelin@gmail.com
References: <pull.1108.v2.git.1640892413.gitgitgadget@gmail.com>
 <pull.1108.v3.git.1641841193.gitgitgadget@gmail.com>
 <256e5f034c6072b6e3621adfa96c5c6319752fae.1641841193.git.gitgitgadget@gmail.com>
 <20220115095725.GA1738@szeder.dev>
 <CABPp-BGR+UrW5ej-8+XXHPkjMfFgURycd9rWC+2awUvYcr_PXA@mail.gmail.com>
 <xmqqv8yjz5us.fsf@gitster.g>
 <CABPp-BErg-RtyycXaRXYfQHEQXA4q-FU9Q6nYkSHJsqL-04oXw@mail.gmail.com>
 <xmqq7dayup5d.fsf@gitster.g> <ee58a0d5-5773-238d-706f-3fb264b6e8db@gmail.com>
In-Reply-To: <ee58a0d5-5773-238d-706f-3fb264b6e8db@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> I know it is your preference to complete only directories and
>> exclude filenames, but I question if the confusion such a design
>> causes to end-users is worth it.
> 
> I think perhaps we're a little caught up in exemplifying commands that
> are unrelated to sparse-checkout. As Elijah said in [1], the documentation
> states that directories and patterns are acceptable to sparse-checkout but
> not files. While it is not reasonable to try to offer every pattern a user
> could possibly pass to sparse-checkout, it is reasonable to offer
> directories and (in my opinion) will help guide users toward correct usage
> of the command.
> 
> However, since completion on directories is cone-mode-specific, I am
> willing to accept the suggestion to only complete directories if we are in
> a cone-mode sparse-checkout and apply it in v4 of this series.
> 
> [1]: 
> https://lore.kernel.org/git/CABPp-BErg-RtyycXaRXYfQHEQXA4q-FU9Q6nYkSHJsqL-04oXw@mail.gmail.com/ 
> 

In light of non-cone mode being removed in the near future (see [1]), it
actually seems it does not make sense to add different behaviors for cone
mode and non-cone mode. I also ran this by some other contributors, who
thought it would be best to complete on both files and directories so as
not to confuse users (as Junio and Szeder have indicated). So, instead of
differentiating between cone mode and non-cone mode in V4, I will plan to
remove directory completion.

[1]: 
https://lore.kernel.org/git/CABPp-BEwMAPHGt5xD9jDU58grbrAqCdqNY9Nh8UJGLKuLbArXQ@mail.gmail.com/
