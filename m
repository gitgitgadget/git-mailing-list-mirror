Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3335FC43334
	for <git@archiver.kernel.org>; Wed, 29 Jun 2022 09:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbiF2J1o (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jun 2022 05:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiF2J1n (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jun 2022 05:27:43 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1709E38D9A
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 02:27:42 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id fd6so21317102edb.5
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 02:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Sd5u79vMZrlYSnXOZQmdePECrzdmaFJODfdRWd7kTFw=;
        b=U+HoVMU65m4tkDpvlrcMs42RWnw8f2MViOBqQ/Tt62t89lPCGC38H+ZjbLdPb7WkEX
         FEv3jFS+aOJJf1EcoB+8HGZpvJkFyBBVljna0cf2zTlgywauc/2KdW7UICVZ/fqqqedS
         Eq0HdqvVp9XkX/hP/X+m2Bmnrk6MWA7zLADw0BAMtAhB5BTN1G5pSlq0eAqHQJ6Xr9HS
         ZdNrp4Kc3QMCgwP+KNxxOpcsVZgOrwSXeZmzTXV1j42cVdPQUq04EM02gbaZvOilZ2Zc
         sCpmf63Rfu/C2NdvIILYWpWnHaZc4Gn2Jdw48bYYMJXef1mxmtcjVcmXwYiepsBhCiRf
         2x9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Sd5u79vMZrlYSnXOZQmdePECrzdmaFJODfdRWd7kTFw=;
        b=qhgtt1l2GQwiF6W28Pee3ObYDSz+bAul8+T5gQrHcZSFiQZbLR/SVi7j3kKq/axRhY
         CWMKR8J50JAfqIZpT02Knzza8UuMnCCm/dcC0CH6b4f6twTl2bg5J2mQnSMPuRkXv3Ay
         O86Qco3+zowGIYbObfU3fwLTxFbC5qIfTYSlDBBS2/iOhoHNKlzVXF/0qLVplI9hxUOF
         YLo/oXp5oZQ2iq3s6L2cCkfcr5f80uqiYCsSCknUvPlYp4vz7yAriNW6LM0saPZK5/Jf
         mSw9OwRLusnmmb/K4M8LhR1gcUgHTk4fbBU4OJxSqjpPGRf9S9rtFhT1fRCWpIKpqsr/
         geYg==
X-Gm-Message-State: AJIora/mnpENI9cxLjIyZ8ClpTNFLyDQmFm7WoU3EhuvARaYerPzwTck
        +2ttBKjXz2TM6GqGyOHKcXY=
X-Google-Smtp-Source: AGRyM1svlhco3fKYwRq2X2lmx6f0cmXE462iPJSOW9V0AIrdv+ivZT+RqVBL7AboO+GcZmCB5+E4UA==
X-Received: by 2002:a05:6402:3707:b0:437:61f9:57a9 with SMTP id ek7-20020a056402370700b0043761f957a9mr2819881edb.1.1656494860708;
        Wed, 29 Jun 2022 02:27:40 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.192])
        by smtp.gmail.com with ESMTPSA id q24-20020a170906b29800b0072629374590sm7591334ejz.120.2022.06.29.02.27.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 02:27:40 -0700 (PDT)
Message-ID: <35e1e681-2666-a7fd-9b30-05a78ae9e957@gmail.com>
Date:   Wed, 29 Jun 2022 10:27:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] git-rebase.txt: use back-ticks consistently
Content-Language: en-GB-large
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, Johannes.Schindelin@gmx.de,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1270.git.1656364861242.gitgitgadget@gmail.com>
 <pull.1270.v2.git.1656446577611.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.1270.v2.git.1656446577611.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28/06/2022 21:02, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
> 
> While inspecting the 'git rebase' documentation, I noticed that it is
> inconsistent with how it uses back-ticks (or other punctuation) for
> identifying Git commands, command-line arguments, or values for those
> arguments.
> 
> Sometimes, an argument (like '--interactive') would appear without any
> punctuation, causing the argument to not have any special formatting.
> Other times, arguments or 'git rebase' itself would have single-quotes
> giving a bold look (in the HTML documentation at least).
> 
> By consistently using back-ticks, these types of strings appear in a
> monospace font with special highlighting to appear more clearly as text
> that exists in a command-line invocation of a Git command.
> 
> This rather-large diff is the result of scanning git-rebase.txt and
> adding back-ticks as appropriate. Some are adding back-ticks where there
> was no punctuation. Others are replacing single quotes.
> 
> There are also a few minor cleanups in the process, including those
> found by reviwers.

Not worth a re-roll on its own: s/reviwers/reviewers/
> 
> Helped-by: Phillip Wood <phillip.wood123@gmail.com>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>

This is looking good, I've one minor comment below

> -git rebase has two primary backends: apply and merge.  (The apply
> -backend used to be known as the 'am' backend, but the name led to
> -confusion as it looks like a verb instead of a noun.  Also, the merge
> +`git rebase` has two primary backends: 'apply' and 'merge'.  (The 'apply'
> +backend used to be known as the `am` backend, but the name led to

I think we should keep single quotes around "am" as it is being used as 
a name like 'apply'

Thanks again for cleaning up the documentation

Phillip
