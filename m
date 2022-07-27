Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D26EC04A68
	for <git@archiver.kernel.org>; Wed, 27 Jul 2022 11:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbiG0L31 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jul 2022 07:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbiG0L30 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jul 2022 07:29:26 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF2E42ADC
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 04:29:25 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id r21so12357146qtn.11
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 04:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=lJBVpE65qHO3rSqxeABtrjCj9D20Rhu6PUSeiEcag/8=;
        b=T+f3MlYy0bkApaZptigXWR6P7ksWs3uci5UD4UuNLvoVpjxI+Dg7qaun1eWyUChzbu
         p38SMEl4lvGt3xgy9HfHyEmxS2Poh+iga/efdWE/DZhAr+cLtWRv5Jyn15/WnlOFGBII
         EqRyDi1S0FBPMYyoa/CSVxBnqhpJ0zvPA4qUDVnHRczNsXi3nE/s+pYLYwsPDL7hptib
         Ixd+D4BQjXJyKKknhTIklLjk4UL1OLO7Nm35l56FB1JpvMM9SKMmEVBvHZu3Rsoh6LJk
         KHjyiYu/SDqN8HoyJRWcW/MqCruP0TbqRl+1jF/dbwOCA7duzDvpfjw0hL39lD6ZRS0i
         bacA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lJBVpE65qHO3rSqxeABtrjCj9D20Rhu6PUSeiEcag/8=;
        b=fvVqWe5VUNuDSSdenPGg+K/ZYiqSMRAnPLtgMAE/v/CPMU1zNHPnqRU23VENUXMuFw
         zQBeIrHzIFYcsxm5T2bEH+M5Cfp5txiQAiY3TOpLz7RxXPHo8hs/QaLb9+9ndtLmiAaT
         LdWABUQKrneDi+92QT8V647q3rIH2YojEtQ12JswG3e1YuOiAkmzGLgKWrrs9l70ss+x
         dlZNEuX7Q38v1b8dOFmus/3ZXiee1JvMq229JaptW17XGa4xYg2CvOtDJtuX3mrXKpOJ
         +Emv1uYQfnddj68CWYK5G3vZla2fbPPsvKQiyATINf2gsK6wjy1RJY/RM22E8Ne/loL9
         TXAg==
X-Gm-Message-State: AJIora+b/+AbEunIgoFCqeyNWmSKFUiGTbhZ2bll8zRGYc6HoEpEMIXu
        sW0PbLTRD/L2+FWb0LK4LkKO
X-Google-Smtp-Source: AGRyM1u9JGS7GnmC/ig1h7BP+hGC0zSQG0UWFE62Euf/CQ2XcVRzIXygy7i9a2Aejz/6p3eVVRiISQ==
X-Received: by 2002:a05:622a:1210:b0:31e:e139:a6d4 with SMTP id y16-20020a05622a121000b0031ee139a6d4mr18071233qtx.160.1658921364227;
        Wed, 27 Jul 2022 04:29:24 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:85f5:c696:22d5:b5a5? ([2600:1700:e72:80a0:85f5:c696:22d5:b5a5])
        by smtp.gmail.com with ESMTPSA id r11-20020ac8520b000000b0031bf5677d96sm10470324qtn.84.2022.07.27.04.29.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 04:29:23 -0700 (PDT)
Message-ID: <1b2f7486-faeb-c71e-76c4-1afce2a1519d@github.com>
Date:   Wed, 27 Jul 2022 07:29:22 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: ds/midx-with-less-memory
Content-Language: en-US
To:     Jeff King <peff@peff.net>, Junio C Hamano <junio@pobox.com>
Cc:     git@vger.kernel.org
References: <xmqqh738bq21.fsf@gitster.g>
 <YuBlD3o5bYMg8f6i@coredump.intra.peff.net>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <YuBlD3o5bYMg8f6i@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/26/22 6:05 PM, Jeff King wrote:
> On Fri, Jul 22, 2022 at 06:01:10PM -0700, Junio C Hamano wrote:
> 
>> * ds/midx-with-less-memory (2022-07-19) 3 commits
>>   (merged to 'next' on 2022-07-20 at 250d257c3e)
>>  + midx: reduce memory pressure while writing bitmaps
>>  + midx: extract bitmap write setup
>>  + pack-bitmap-write: use const for hashes
>>
>>  The codepath to write multi-pack index has been taught to release a
>>  large chunk of memory that holds an array of objects in the packs,
>>  as soon as it is done with the array, to reduce memory consumption.
>>
>>  Will merge to 'master'.
>>  source: <pull.1292.v2.git.1658244366.gitgitgadget@gmail.com>
> 
> This topic looks very nice, but I think we might want this additional
> cleanup on top:
> 
> -- >8 --
> Subject: [PATCH] write_midx_bitmap(): drop unused refs_snapshot parameter
> 
> The refactoring in 90b2bb710d (midx: extract bitmap write setup,
> 2022-07-19) hoisted our call to find_commits_for_midx_bitmap() into the
> caller, which means we no longer need to see the refs_snapshot at all.

Good find! I'm happy to see the unused parameter work is coming
along ;)

> @@ -1059,7 +1059,6 @@ static int write_midx_bitmap(const char *midx_name,
>  			     struct commit **commits,
>  			     uint32_t commits_nr,
>  			     uint32_t *pack_order,
> -			     const char *refs_snapshot,
>  			     unsigned flags)
>  {
>  	int ret, i;
> @@ -1462,7 +1461,7 @@ static int write_midx_internal(const char *object_dir,
>  
>  		if (write_midx_bitmap(midx_name.buf, midx_hash, &pdata,
>  				      commits, commits_nr, ctx.pack_order,
> -				      refs_snapshot, flags) < 0) {
> +				      flags) < 0) {
>  			error(_("could not write multi-pack bitmap"));
>  			result = 1;
>  			goto cleanup;

Thanks for the patch!

-Stolee
