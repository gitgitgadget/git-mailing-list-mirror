Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43ED4C433F5
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 16:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348184AbiCHQJs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 11:09:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbiCHQJq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 11:09:46 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7421E4D61B
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 08:08:49 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id 12so19316873oix.12
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 08:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=NJbGZaRGTXFh9DUxvavCr7l6KMH34QtXGHF3drJOBOw=;
        b=BPVWq9O4HsabjIF6TjXQ8TOUJQPEJqPSC6NZzusQctFrW1GXYrPqYrn/YeTxPCw2Ez
         6Y7rRl2e3pxdMhacvV/Du/a6G5Fdk3STbUDEaDv+HN+uGr+gZ4XFxrFV7n2UMydnQTeX
         g8lTtAl/vr86C2rvZ7ISRiKeih58MngPuQftkOZz7vhg5laD9UJWq6u2WTzNYF0VFuHy
         j3lc29lax4YyfMstnVySz5NFZbiWL+ihGnURhkcH8OpDC4G4p4zHOpck+jiA7Nk1ejac
         CXF8jlNHzZIZGy43OZa5a8UAfgI0a7Cf42mdzlZrXk8jN007UC6NYPPlByEH/GvF6LyN
         PDFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NJbGZaRGTXFh9DUxvavCr7l6KMH34QtXGHF3drJOBOw=;
        b=sRnL7mOSValIUgiPKbedbdmT9jBtaNo4v5hKxqYUOovV6MQou1c550Vxh1y+2Qp+sL
         9XDOxuMzX1SGE79Ed0VA218SHrvJ1wo6yIW3F3CV3nP2PKxqXcXIkgmfTOEYXMMc2i9R
         4FjHuyzCBRzmQd5zHtSoDlpGx6YUvm+2YqAd6mA5yVOFWlPua75CC/RvbQdCMpT8LQ80
         LPbNNue/IJUBafls+0a5GwsWDyFdOFm9IT8QYTNLzc8EYgmy5VXER2Sf/vvwumyQ27bx
         ifhFPNSLJxVYHUPnecmsejfxqBnjdtJT5zrZr9c0bmOfM6dlTjYjDf5xY0bo4mwXCPmD
         7QzQ==
X-Gm-Message-State: AOAM533BguO7KXI60UHWJE0M14W27mToszjJ/4GokgUwekgGhLI7liqX
        eAQAvmrz7mPm9Ei+/CBB2lNAFee3vN3R
X-Google-Smtp-Source: ABdhPJyEr+GNv0ZtdU2FCp9bo/sX2Tk0VDx/CzCpYP1uT4X/VBvXU3GSJ9eUZXmRsgxQ1SdOsRWz+g==
X-Received: by 2002:a05:6808:d4b:b0:2d9:e193:18b2 with SMTP id w11-20020a0568080d4b00b002d9e19318b2mr2935778oik.227.1646755728696;
        Tue, 08 Mar 2022 08:08:48 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id k22-20020a056830243600b005af5fb99326sm7761919ots.63.2022.03.08.08.08.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 08:08:48 -0800 (PST)
Message-ID: <618539f0-4f9f-1185-b929-e768054440c1@github.com>
Date:   Tue, 8 Mar 2022 11:08:46 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: ds/partial-bundles (was Re: What's cooking in git.git (Mar 2022, #02;
 Mon, 7))
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <xmqqilspp5yg.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqilspp5yg.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/7/2022 8:51 PM, Junio C Hamano wrote:
> * ds/partial-bundles (2022-03-07) 12 commits
>  - clone: fail gracefully when cloning filtered bundle
>  - bundle: unbundle promisor packs
>  - bundle: create filtered bundles
>  - rev-list: move --filter parsing into revision.c
>  - bundle: parse filter capability
>  - bundle: safely handle --objects option
>  - MyFirstObjectWalk: update recommended usage
>  - list-objects: consolidate traverse_commit_list[_filtered]
>  - pack-bitmap: drop filter in prepare_bitmap_walk()
>  - pack-objects: use rev.filter when possible
>  - revision: put object filter into struct rev_info
>  - index-pack: document and test the --promisor option
> 
>  Bundle file format gets extended to allow a partial bundle,
>  filtered by similar criteria you would give when making a
>  partial/lazy clone.
> 
>  Will merge to 'next'?
>  source: <pull.1159.v2.git.1646689840.gitgitgadget@gmail.com>

I just sent a v3 [1] that takes more of Ævar's suggestions to make
the changes more robust.

Thanks,
-Stolee

[1] https://lore.kernel.org/git/pull.1159.v3.git.1646750359.gitgitgadget@gmail.com
