Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4652C433EF
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 11:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356167AbiBULXI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 06:23:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356309AbiBULWB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 06:22:01 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C302BD0
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 03:14:30 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id d3so10769912wrf.1
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 03:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qtlq/dxlUUQ4jjkZKd1Pdxc0BY58W2SqfFI9r3+hsh0=;
        b=EKR4Lkdm57DECw6nRTCtXkInv92KreX6775Jv5kNC88yWrK6ld+oyIlS1V6fRWqB7e
         tuIiYhEuGmGe/zM7d2J6EN0P0oHgaVM7WlwrliuCFGHa8gi3wHJHk6bsjCrUhrg1juH4
         /W1FDU5vT73zrJfxFX6avXkj36Y2pPc7dcE+TAeP7hHKggL1ro/kEQrNx4TWZkpWzr+6
         CqBjIWlGRUnkfAhv+V7WpT2iMFBrWR2cAkbTapqG25ktbOjsF3DEIbrHnLcecT4Qk2Lw
         ysgtviUv0Aps5P7oeu8hofFBxoyy6VugxTDx+EPvwjORiLp9B7msXaNaN+8FHxfQ9yl6
         WbIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qtlq/dxlUUQ4jjkZKd1Pdxc0BY58W2SqfFI9r3+hsh0=;
        b=HrFiJCommRN1KrnhkarWd1f43aUNIHNR1rrpRabTJOwRM1YNhJp9LSw2Vu5pLDwI//
         0eU92vrZZR/Z/QmJOzC/r+65EHh53rE2dRaousVDhQsBoTpwbGGW6JKbFURdPIyJAo4P
         PrtMQATBr6nkrPBIBHFDHhOHVrYMdEoCVJ09ECv2rbqcofpwigPuJKX4/FSn+by9epB3
         ABvd9KruAU/0e59QjvHuLYq2cXpLRBkLMHMAuIuMOe9+xo4gd0Go2W1NuWWqu7oBx0e6
         8zvryi1MeMaK1qFbANtojSvFP4HpdXgaQ16txmEHcuRLmcVcMHyriC0m2wWDSH0pAR4h
         DYcg==
X-Gm-Message-State: AOAM5302ko5C4d6BTkLCl6asNFzTmh5tvpbtOeH6uT/6mAPdZpntpCyZ
        15jehIBHSyvV2coPfellIFo=
X-Google-Smtp-Source: ABdhPJzQRAo1oMD93+wO6gZjITgGLP9uWUvefW2ZlnavJhhdcaUh5fzEXr//vfrfvJtfpaZ97oUmXw==
X-Received: by 2002:a5d:64cc:0:b0:1e8:f4ad:bf85 with SMTP id f12-20020a5d64cc000000b001e8f4adbf85mr14421587wri.630.1645442069014;
        Mon, 21 Feb 2022 03:14:29 -0800 (PST)
Received: from [192.168.1.201] ([31.185.185.186])
        by smtp.googlemail.com with ESMTPSA id x1sm20732602wrn.12.2022.02.21.03.14.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 03:14:28 -0800 (PST)
Message-ID: <c86845f4-b93c-d9be-cfd1-8d806fb59595@gmail.com>
Date:   Mon, 21 Feb 2022 11:14:26 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: pw/single-key-interactive (was Re: What's cooking in git.git (Feb
 2022, #05; Thu, 17))
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqley93rkw.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqley93rkw.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> * pw/single-key-interactive (2022-02-16) 3 commits
>   - add -p: disable stdin buffering when interactive.singlekey is set
>   - terminal: set VMIN and VTIME in non-canonical mode
>   - terminal: pop signal handler when terminal is restored
> 
>   The single-key interactive operation used by "git add -p" has been
>   made more robust.
> 
>   Will merge to 'next'?
>   source: <pull.1146.git.1645008873.gitgitgadget@gmail.com>

Can you hold off please, I'll send a reroll in the next couple of days 
which has a additional fix for read_key_without_echo()

Thanks

Phillip
