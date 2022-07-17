Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A25C43334
	for <git@archiver.kernel.org>; Sun, 17 Jul 2022 12:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbiGQMZp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Jul 2022 08:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiGQMZo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jul 2022 08:25:44 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692CB13D63
        for <git@vger.kernel.org>; Sun, 17 Jul 2022 05:25:43 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id y15so2117146plp.10
        for <git@vger.kernel.org>; Sun, 17 Jul 2022 05:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PRw54J+7JfYwUbkBvzZRFkI7j9cwJMrLmDX6W8YRGuo=;
        b=pzlD+yCkH/suV8x70MVytRqVaMccw0n9I1eDDPWUBLOgT8YdIKgLCQfxV6nq68G1AF
         XeNnYKumW2PZFIB2wT9287F82S4nDt2yHeMcJCwIRyP0UIokEpF9LmMtudQiFTRT7RoE
         rpdx/BTS/GqGmn2vW6Yfxneo1a7GUxP9vkB8SNZ9N59GknkRARa/LO2YNNXZypi2sWeP
         vHpA9/Aj+7mqQ/EfqRycjG45bPMB7kRAXs3rDqQhl9vSv1kDajke/dDmEBS9luPxg3Nc
         e3THImYiWvcy+sMtjg6aADWXb8Eeq0WQOXZML6qA2DI3WbEgFVvWV2hhF6sbSfRjvTsI
         aktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PRw54J+7JfYwUbkBvzZRFkI7j9cwJMrLmDX6W8YRGuo=;
        b=Wy7s2WZf4vK84PNHNo9xh5kLY+cxyz4iuz0dKypyuA8FZDio4e/F+mJKUz5SkEiKQA
         TsGYekAW5LEOuqB9RzQz8Mi00f1rny84sKwRlMUkGzfE2Q3js7YD4c/UmDvNHG/ZXr0D
         Hy8YFRJK8IglH4q+4dpIegbWUNKZdfJ+tM14liTj0Kbn79eiYdO45m2C/H7Y+7BJQKF/
         hp/tj3g92gIeGEbLJ0LWef9vqntLqQDUcJgxb74DO1DKxru94C/OZkTcD3rq7l40vxxw
         Y3EPUNHWH9d1wcSdWBPcVFCleKEYrXKNug5TPHe51NCDK0TYLKoxCp9lFpGsesNt2xD3
         s//Q==
X-Gm-Message-State: AJIora9p9wfFYG475M6ag+L9uCTeu6ZHjypZyfO1So2TcaEReksAkQww
        LVh/A/+ZGKs7AgiXXzFie+M=
X-Google-Smtp-Source: AGRyM1uaxJAYd+0DZdqzFnL/afo8dFszWu26nvrvwgMMtEYCX4gqYwxYcI2gpf+qogBH8AA8cPteig==
X-Received: by 2002:a17:902:e802:b0:16b:ef57:d9 with SMTP id u2-20020a170902e80200b0016bef5700d9mr22887753plg.54.1658060742879;
        Sun, 17 Jul 2022 05:25:42 -0700 (PDT)
Received: from [192.168.208.37] ([49.204.131.140])
        by smtp.gmail.com with ESMTPSA id g2-20020a63fa42000000b0040c74f0cdb5sm6318007pgk.6.2022.07.17.05.25.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Jul 2022 05:25:42 -0700 (PDT)
Message-ID: <e574ac20-c287-c395-5bc3-b481d81764c7@gmail.com>
Date:   Sun, 17 Jul 2022 17:55:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Can I use CRoaring library in Git?
Content-Language: en-US
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
References: <CAPOJW5x4McofC5fxBvsRAzum28wmeDJCMTMRmY_0oy=32JjKqQ@mail.gmail.com>
 <220716.86y1wtxhok.gmgdl@evledraar.gmail.com>
 <CAPOJW5zNsETYwD=MXCFLn91qaemgooPN-JB1sx7KagkKxOXTnQ@mail.gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <CAPOJW5zNsETYwD=MXCFLn91qaemgooPN-JB1sx7KagkKxOXTnQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16-07-2022 21:56, Abhradeep Chakraborty wrote:
> On Sat, Jul 16, 2022 at 7:50 PM Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>>
>> Another possibility is to get the library to dual-license itself,
>> running "git shortlog -sn" on it it seems it's mainly written by one
>> contributor, with a relatively short tail of others, perhaps they'd be
>> willing to dual-license at the prospect of having git use it?
> 
> Kaartic suggested the same and it seems better than the previous one.
> 
> As a side note, the current EWAH implementation is also relicensed[1]
> to make it compatible with Git. As these two are mainly written by the
> same person, I think he will help us this time also.
>

The EWAH case is a bit different. The original EWAH implementation
[ewah-cpp] was in C++. It was then ported to C [ewah-c] by Git
contributors [ewah-git]. The ported version has been relicensed under
GPLv2 with Deniel Lemire's permission.

The case with CRoaring is that the implementation already exists in C
[croaring] and that is the one which is licensed under Apache V2. I'm
not sure how relicensing works for already existing code.

I suppose we could enquire Daniel Lemire about using the Apache licensed
code for Git. Let's hope for the best.


[[ References ]]

[ewah-cpp]: https://github.com/lemire/EWAHBoolArray

[ewah-c]: https://github.com/vmg/libewok
 [ewah-git]: The initial commit of 'ewah' directory mentions the
    relicensing:

    e1273106f6 (ewah: compressed bitmap implementation, 2013-11-14)

[croaring]: https://github.com/RoaringBitmap/CRoaring

> Thanks!
> 
> [1]  https://github.blog/2015-09-22-counting-objects/#footnote-1

--
Sivaraam
