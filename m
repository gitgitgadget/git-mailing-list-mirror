Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 356A5C433F5
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 06:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0352B60FBF
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 06:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244226AbhI2Gdc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Sep 2021 02:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244177AbhI2Gdc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Sep 2021 02:33:32 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1344C06161C
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 23:31:51 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id g13-20020a17090a3c8d00b00196286963b9so3474497pjc.3
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 23:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=z/uF5xC/bUh1ii/lii2VKZsOXEfoN6pEycf1PqQaoTo=;
        b=YOmhVXfIZubSrqXN+wLdKziZ4MlXqJ5PdPOnXv+bBwpHYJ7GqaFwFhWFMI+sDVGwVl
         NEtZ35tUwtthB86hCAJgp6IVkXSeK/cT7/jXwIk9SZDt6yFSvyog0GR2X4Ic94aaoTY9
         7EeMLYde43gORXbeQV5SkHLy5IP2llEu4uoftZgfMbQnfB1vWBgnO9l6h0h6xrIgmsAr
         u1wvXg6I27rck+eZHxy48VGwWzfS7RpClGZvDCLw/UBO8qf1dHginTYdO8NpOoxLVcNz
         Gu4TBApE4lJPMCz77JaO1Yf2/nXOxNrBOe2qMCnIPph+TIMUSBkMt9mvS18jdKAQP2zS
         RqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z/uF5xC/bUh1ii/lii2VKZsOXEfoN6pEycf1PqQaoTo=;
        b=sPh6UEIf4cEYp770E2a8youZdt9046Qp9zG6bsuFyd1F/CtzGR3qsIHN1O08N68SxS
         30KITPFcy1qa+EYJDyySp5FcOzyKUUFjxeMKqNXOIJDrBaUMwQ/TeDs8KfoLrADhYE5M
         LMy0FpUQHxX8QL7vpRZF8yo6tvG3kvkH4eVSCp8pluzkZuUVMRAAenLwEROgBn4XYTzM
         3hSA0wojXDbbNZRQwORS/JDR0sORjeQc4ummzqHiQ+SlEyOTy/S7t0L7YATAG2BeNHPp
         BUE86sUhHdS/1zI3zePWXdRAUKGu6/R2tC3HueW8xa3WUBpuCt1IgzrPaZHRsoS8iP79
         xW+Q==
X-Gm-Message-State: AOAM532l7a8FeESOXI/IefZOnVsMuOz0d/juToqVrSqbKBCCKBZ6mAJV
        ptFtvJ6SKSnbEyZ2qg+rZPQZrMyhM5mTNA==
X-Google-Smtp-Source: ABdhPJzqLVFZHAbrmJv+rUfBMH+8xKy6SW2382LGbxNOBWIjHi1tSzaASpZHZUfMjTsDNfWEPUfJAQ==
X-Received: by 2002:a17:902:d345:b0:13e:27a5:58b5 with SMTP id l5-20020a170902d34500b0013e27a558b5mr8745322plk.79.1632897110854;
        Tue, 28 Sep 2021 23:31:50 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-66.three.co.id. [180.214.233.66])
        by smtp.gmail.com with ESMTPSA id d5sm684226pjg.53.2021.09.28.23.31.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 23:31:50 -0700 (PDT)
Subject: Re: Commit is marked as new, despite on it already on branch
To:     Eugen Konkov <kes-kes@yandex.ru>,
        Git Mailing List <git@vger.kernel.org>
References: <691467377.20210928163616@yandex.ru>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <7ebed419-8588-7574-c25a-9018d07881c7@gmail.com>
Date:   Wed, 29 Sep 2021 13:31:47 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <691467377.20210928163616@yandex.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28/09/21 20.36, Eugen Konkov wrote:
> Hi.
> 
> Here is comparison of two branches. All same commits are marked as '='
> But in my situaltion commit is marked as new '>'
> 
> Here is my main 'dev' branch
> *   8fd53c7d (HEAD -> dev, local/dev) Merge branch 'frontend' into test-dev
> |\
> | * 3da9e49c (local/frontend, frontend) 'Save/sync' button is active always
> | * d192d9a7 Added library 'materialize' and facelifted the contractor table
> |/
> * 0cb280f5 Do not export test data
> *   ce1df25f Merge branch 'frontend' into dev
> |\
> | * da78b64f Display disabled element title
> | * 5f741628 Gen podio ref using document or agreement info
> | * 2d756923 Added ref to 'Podio'
> | * 129c972d Clean forms when load o reload the page
> | * d96c45e4 Use production and test modes in parallel
> | * 20bf7186 Added refs to download document and sandbox link for agreement
> * | a0e338cb Display only tick for user experience
> * | 2b2fb1d5 Merge branch 'frontend' into dev
> |\|
> | * d868d72b Added fonts link and some changes for user experience
> | * 74426fd0 Added message to say "The docn has been used. Use another docn."
> | * b183803b Fill client passport form by parsed passport data
> | * b40234ed Fill client form by parsed client data string
> |/
> * ed3f3026 Invert data to show provider as 'true' value
> 
> Here we see our interesting commit:
> a0e338cb Display only tick for user experience
> 
> Here is branch I do comparison to:
> *   ec655271 (HEAD, xtucha/dev) Merge branch 'frontend' into dev
> |\
> | * a6085d95 'Save/sync' button is active always
> | * bbca694b Added library 'materialize' and facelifted the contractor table
> | * 92103b2d Display only tick for user experience
> | *   4f0a1881 Merge branch 'frontend' into dev
> | |\
> * | | 0cb280f5 Do not export test data
> * | |   ce1df25f Merge branch 'frontend' into dev
> |\ \ \
> | | |/
> | |/|
> | * | da78b64f Display disabled element title
> | * | 5f741628 Gen podio ref using document or agreement info
> | * | 2d756923 Added ref to 'Podio'
> | * | 129c972d Clean forms when load o reload the page
> | * | d96c45e4 Use production and test modes in parallel
> | * | 20bf7186 Added refs to download document and sandbox link for agreement
> * | | a0e338cb Display only tick for user experience
> * | | 2b2fb1d5 Merge branch 'frontend' into dev
> |\| |
> | |/
> |/|
> | * d868d72b Added fonts link and some changes for user experience
> | * 74426fd0 Added message to say "The docn has been used. Use another docn."
> | * b183803b Fill client passport form by parsed passport data
> | * b40234ed Fill client form by parsed client data string
> |/
> * ed3f3026 Invert data to show provider as 'true' value
> 
> 
> $git log --graph --decorate --pretty=oneline --abbrev-commit --cherry-mark --boundary --left-right dev...xtucha/dev
> <   8fd53c7d (HEAD -> dev, local/dev) Merge branch 'frontend' into test-dev
> |\
> | = 3da9e49c (local/frontend, frontend) 'Save/sync' button is active always
> | = d192d9a7 Added library 'materialize' and facelifted the contractor table
> |/
> | > ec655271 (xtucha/dev) Merge branch 'frontend' into dev
> |/|
> | = a6085d95 'Save/sync' button is active always
> | = bbca694b Added library 'materialize' and facelifted the contractor table
> | > 92103b2d Display only tick for user experience
> | >   4f0a1881 Merge branch 'frontend' into dev
> | |\
> | | o da78b64f Display disabled element title
> | o ed3f3026 Invert data to show provider as 'true' value
> o 0cb280f5 Do not export test data
> 
> Here you can see that '92103b2d Display only tick for user experience' commit is marked as new
> 
> If I do explicite comarison of a0e338cb and 92103b2d, then we see that is marked as '='
> 
> git range-diff a0e338cb...92103b2d
> -:  -------- > 1:  20bf7186 Added refs to download document and sandbox link for agreement
> -:  -------- > 2:  d96c45e4 Use production and test modes in parallel
> -:  -------- > 3:  129c972d Clean forms when load o reload the page
> -:  -------- > 4:  2d756923 Added ref to 'Podio'
> -:  -------- > 5:  5f741628 Gen podio ref using document or agreement info
> -:  -------- > 6:  da78b64f Display disabled element title
> 1:  a0e338cb = 7:  92103b2d Display only tick for user experience
> 
> if I do range-diff between branches dev...xtucha/dev
> git range-diff 8fd53c7d...ec655271
> -:  -------- > 1:  92103b2d Display only tick for user experience
> 1:  d192d9a7 = 2:  bbca694b Added library 'materialize' and facelifted the contractor tabl
> 2:  3da9e49c = 3:  a6085d95 'Save/sync' button is active always
> 
> We again see 'Display only tick for user experience' commit as new
> 
> 
> I think problem arise because git does not see that all three commits:
>     
> | | o da78b64f Display disabled element title
> | o ed3f3026 Invert data to show provider as 'true' value
> o 0cb280f5 Do not export test data
> 
> have same fork-point  "ed3f3026 Invert data to show provider as 'true' value"
> 
> 
> Probably because git merge-base get analyzed only left branch and not right:
> $ git merge-base ec655271 8fd53c7d
> 0cb280f544113926e1059568811f99c311489d4c
> 
> 
> 
> 
> 
> I expect that end of out should look like this:
> 
> | |  |
> | |  * da78b64f Display disabled element title
> | * |   0cb280f5 Do not export test data
> | |  |
> ........
> | |  /
> ---
> |/
> o ed3f3026 Invert data to show provider as 'true' value
> 
> 
> 
> 
> 

Can you create minimal reproducible case so that everyone here can test it?

-- 
An old man doll... just what I always wanted! - Clara
