Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 634D11F403
	for <e@80x24.org>; Fri, 15 Jun 2018 14:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756226AbeFOOfD (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Jun 2018 10:35:03 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:36976 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756165AbeFOOfC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jun 2018 10:35:02 -0400
Received: by mail-qk0-f194.google.com with SMTP id j12-v6so5708868qkk.4
        for <git@vger.kernel.org>; Fri, 15 Jun 2018 07:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=YKVt12nikkqM6fp+S5tvkJ3HxsWFxoOCSiy8j/MltMs=;
        b=t0iChFTQIPcH9Eu52vifNNgr/wvH3hUbiZo9J3I8K3UZfFYs1uGbFn6r1aVMTvJvJ4
         3dgwkJ7jGb9/gjlFUzexKNf5ZcyUXzqccQkVNC4DsSI7tGGeb87LGMa8pKpxdgEr1iXl
         gGPEt3vwyTI/ksaREvCkqYJ2U/7IukW3yb31M6x26aFRQONBhMESw4ewoHMTxTdgXR/b
         s5xq7kW+FJc4U4RBQes/oPUdsfPeaBInIl9RMSDzDdMhaWWLm+R63zxYNilxRZadGdhQ
         W3Uqb/CrOsjLm1p3oiQy0anARnFIVha90pzzz549GuzmoOCBFaFd+e+K9pXYFhQCLPWL
         +25A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=YKVt12nikkqM6fp+S5tvkJ3HxsWFxoOCSiy8j/MltMs=;
        b=ng+jUlPZtYrorASTdb7u1JoZR38AfofrcP6CaxgU0zLR4XANZTgsUWj3UJHZaxJxMU
         PNDeaksD6mv3b6jbhycBS5YxD6Kf3Rqotu10V/sQZU0fD3EHtutO5i/LXbFw2wTqOn9G
         GiyA+uptDXHXc03wrHI7EwjucjQOildvwhmZJmJWjIWfgVjNxHsEpYw6ZnwaGL5JoCtW
         5MWRGQeO8IUcQCC4s6WWZN7oSi0qyLX/Nm+xRdNwd6ii3iCbQdjtQZHiNJ5BjCHsbbfv
         LR2hAMPK9nB4HSRpKaKBjvhL+s9Ykv3TA5dX8R9GG+Li+tY181PtR/AFeMdNWXhLVm5K
         sIjQ==
X-Gm-Message-State: APt69E2wocO4/kVs1lRX/b69P3Ey5LX9OZ9xVy7ErCFglBdJaAgEpgdT
        ntQLrVmoN4ln/EvxlMFHKJU=
X-Google-Smtp-Source: ADUXVKK7DesSrt6yB3G+SyHIFJLucL47a0X8jIW2XRjtmHsbEY4r0P9jeE8djmxD0mOWQSSeBTIw5Q==
X-Received: by 2002:a37:8ac3:: with SMTP id m186-v6mr1583894qkd.6.1529073301784;
        Fri, 15 Jun 2018 07:35:01 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:936:68f2:e294:88e9? ([2001:4898:8010:0:f26b:68f2:e294:88e9])
        by smtp.gmail.com with ESMTPSA id e11-v6sm944504qkb.4.2018.06.15.07.35.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 07:35:01 -0700 (PDT)
Subject: Re: [PATCH 0/8] Delete unused methods in EWAH bitmap
To:     Derrick Stolee <dstolee@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Cc:     "ramsay@ramsayjones.plus.com" <ramsay@ramsayjones.plus.com>,
        "peff@peff.next" <peff@peff.net>
References: <f25c0798-7778-7146-5349-ae2c2fb560dd@ramsayjones.plus.com>
 <20180615143018.170686-1-dstolee@microsoft.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <117a06ba-9ea1-ca7e-7967-e92db0e27c38@gmail.com>
Date:   Fri, 15 Jun 2018 10:35:00 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180615143018.170686-1-dstolee@microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/15/2018 10:30 AM, Derrick Stolee wrote:
> The EWAH bitmap code includes several logical operations that are
> important for a general-purpose bitmap library. However, Git only
> uses the XOR operation for storing deltas between reachability
> bitmaps. This means that we can delete the following unused methods:
>
> * ewah_and()
> * ewah_and_not()
> * ewah_not()
> * ewah_or()
> * ewah_serialize()
> * ewah_serialize_native()
>
> We can also delete the unused methods bitmap_clear() and
> bitmap_each_bit().
>
> Derrick Stolee (8):
>    ewah/bitmap.c: delete unused 'bitmap_clear()'
>    ewah/bitmap.c: delete unused 'bitmap_each_bit()'
>    ewah_bitmap: delete unused 'ewah_and()'
>    ewah_bitmap: delete unused 'ewah_and_not()'
>    ewah_bitmap: delete unused 'ewah_not()'
>    ewah_bitmap: delete unused 'ewah_or()'
>    ewah_io: delete unused 'ewah_serialize()'
>    ewah_io: delete unused 'ewah_serialize_native()'
>
>   ewah/bitmap.c      |  32 -------
>   ewah/ewah_bitmap.c | 229 ---------------------------------------------
>   ewah/ewah_io.c     |  36 -------
>   ewah/ewok.h        |  24 -----
>   4 files changed, 321 deletions(-)
>
>
> base-commit: fc54c1af3ec09bab8b8ea09768c2da4069b7f53e

Responders to this thread beware: I accidentally added an extra letter 
in Peff's email address, so be careful with reply-all.

Sorry!
-Stolee
