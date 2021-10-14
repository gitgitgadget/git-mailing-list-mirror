Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C1EC433F5
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 09:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76AE460E96
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 09:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhJNJmg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Oct 2021 05:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbhJNJmf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Oct 2021 05:42:35 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D957C061570
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 02:40:30 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id r18so17493665wrg.6
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 02:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SjehJyuYhtLExdUBO28fTzJrKok0hs4K/p6eine5y28=;
        b=Sqww26W9DAsqAQOuwHaFhDSet7d4vQjoOC0oc19lwt5JCQrP7b9I4sT/BNRD/EVdW+
         p1+U2WlVso0mLWIS7h0S/rpOzG6qlL+rBavgdxG5z9WJCRK9RqkyA5M6UsEK9dnDZbO+
         +yOgLMvB1qBtBV7oFLtrRwq3lMuB/F1oTGNp72C25u8eYX+1w+5JgsXYtuO95ITyyTxD
         ds1cKYpDIhWP/bL4WJVig7wBWkOQVoWYwrpNsg+wrzoUSXninhHfcg2UYM2cBNQV4bcL
         3/E8jQ/5btL9n8iNAHSuWLL9Jf0JZyhOXBOtO8ZQfa/nPt8rK1ZjUyBbFSQExL7VcSsd
         Ki3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SjehJyuYhtLExdUBO28fTzJrKok0hs4K/p6eine5y28=;
        b=e2r+7r63JKiHmM7hFqU3r9Xal9KkZbBTay1hnZXuAgqxXy0CGlb+BrNgX10+04YO67
         JHk8uLOadTDZ94d7xkQrfWrlyff4oHzC0ww40GGz/QNxENWrvxbu75u0KyiO4ZDHtGoO
         /Kbn2qNW7ohV3JiUEwaJuMnQHw3+nWR6zJz1jWlXX+VZgGHOmwy9Aq7yBsAgLEjHBm3v
         u65TxvXHXeB5DLEO2rdc2RHG552Z3u3/C+A6UosbbuPQIgLfI3rHc0fsyh0L0e6XX9ts
         V4yyUoIPfgiOutSg+HPpt3lP1POtBkrHpy0duP5B9zPVvKOscrAkwYIdfLc2tnxMfXNy
         fJmg==
X-Gm-Message-State: AOAM530Gfsxabu+DoGYN2t6sU8jgYR13QD89HxOtWNYm2a30BBYMiaUm
        2ap16F8hmRzpfUnYPJusMSc=
X-Google-Smtp-Source: ABdhPJxJxSKfY2hMrzvLxIvELtI5iVncZdn2eor+cJCgb7AzuoDBg0mKeclIyklHHCKJc1p/tD727Q==
X-Received: by 2002:a5d:4248:: with SMTP id s8mr5199055wrr.195.1634204429241;
        Thu, 14 Oct 2021 02:40:29 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.186])
        by smtp.gmail.com with ESMTPSA id p3sm7677855wmp.43.2021.10.14.02.40.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 02:40:28 -0700 (PDT)
Message-ID: <554ebfd6-63bd-50ec-5f55-4b5ea4a9fd03@gmail.com>
Date:   Thu, 14 Oct 2021 10:40:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3] sparse index: fix use-after-free bug in
 cache_tree_verify()
Content-Language: en-GB-large
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1053.v2.git.1633600244854.gitgitgadget@gmail.com>
 <pull.1053.v3.git.1633630041829.gitgitgadget@gmail.com>
 <905e3d0f-0541-ffad-c05b-e7ebc6bed94c@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <905e3d0f-0541-ffad-c05b-e7ebc6bed94c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Bagas

On 08/10/2021 10:38, Bagas Sanjaya wrote:
> On 08/10/21 01.07, Phillip Wood via GitGitGadget wrote:
>> -static void verify_one(struct repository *r,
>> -               struct index_state *istate,
>> -               struct cache_tree *it,
>> -               struct strbuf *path)
>> +/*
>> + * Returns:
>> + *  0 - Verification completed.
>> + *  1 - Restart verification - a call to ensure_full_index() freed 
>> the cache
>> + *      tree that is being verified and verification needs to be 
>> restarted from
>> + *      the new toplevel cache tree.
>> + */
>> +static int verify_one(struct repository *r,
>> +              struct index_state *istate,
>> +              struct cache_tree *it,
>> +              struct strbuf *path)
>>   {
>>       int i, pos, len = path->len;
>>       struct strbuf tree_buf = STRBUF_INIT;
> 
> What is verify_one() doing? I think it worth mentioning it in the 
> comment above.

I think it's pretty obvious if you read the code rather than my patch. 
It is a common pattern in git that a function with "one" in the name is 
a helper for another similarly named function without the "one". In this 
case verify_one() is a recursive helper for cache_tree_verify()

Best Wishes

Phillip
