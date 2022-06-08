Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC6FC43334
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 17:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiFHRKU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jun 2022 13:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiFHRJX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jun 2022 13:09:23 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4A83F5750
        for <git@vger.kernel.org>; Wed,  8 Jun 2022 09:56:19 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id a9so14860808qvt.6
        for <git@vger.kernel.org>; Wed, 08 Jun 2022 09:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=AQnR/Z5lfPMbLSr8N2bd5DE5S0YuFvJ0tZTjNbJkuRU=;
        b=UnQKvvZh9MdgDwvsXElS8xYv8ytc7GfA80cXRDrQg+p1rxb+pAPiVS/ruB8Qnljm2R
         jCU3yKTMoDA7ksiUb0rMRDb9hqf71U16iXWaoIDfHcUspUg1kxdfKhCFUw6WLjikKuh4
         V4YEbBAFsmKzXs/xakxKKwbVVtc1MH+v4b0l+u/IbsjMhtHqrebdcfkq1TuVytTD+8/r
         hh+RkQliIqqLMIyUz+8LA7929yJidmvlfbqFY/yGY06Pddy4SAyZCwTN4vxiWhIhIQyC
         n8/DGhFtYRzQFBWsUW6kyJljrawgWqkMX0SqXDwpReFHKqYaNKBj3O+8hdzIIlknW/CC
         xEuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AQnR/Z5lfPMbLSr8N2bd5DE5S0YuFvJ0tZTjNbJkuRU=;
        b=Pkolhjt0mrmqWxJfwDz5lsQZkdXQ+/VuRZ/yRy74CGvDQAFPZs2WmCVUz3IUhT8UCz
         5LiDlo1Nn/FT548MJqDjZAiydrXHCXofykWR08jkxO6G+soMjij8zHTxHp0ss+YNzfHj
         S7XTwmSc06vE6BTSNaMLjfNfD8uRnYClpCR/7s4y/UYb/f9ZSAi5FBVYTGOBdmbxNRHN
         tyeyCFKb0WNevD1yiRoOFMIVzUDOgBO9ukJDxNhIq32cspBgGLc9xx80ydX20S3Em+1z
         m9ryhBLou48WJBXGTv21TzBTKhO9gFR8Ori+kGXWJAxMevkFgjympT46GN4LqgvylP9h
         zskQ==
X-Gm-Message-State: AOAM530894OCRlR3NXlm/4agwuDYaz89YQlN7dLowTwClE1bUYucXskW
        dyESQpkVD7nU42lbOF/UBh48773x/mA=
X-Google-Smtp-Source: ABdhPJy2oyyRjI2sXD9K/tq7rfTu8H+3PjlM+/5aB7XyVgGrMzlAXgVUqwBlILNFzAcWlA2Gg7qLxw==
X-Received: by 2002:a05:6214:19ce:b0:46c:4ca7:6c3a with SMTP id j14-20020a05621419ce00b0046c4ca76c3amr2096598qvc.57.1654707378516;
        Wed, 08 Jun 2022 09:56:18 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id j1-20020ac84041000000b00304e8938800sm8382845qtl.96.2022.06.08.09.56.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 09:56:18 -0700 (PDT)
Subject: Re: What's cooking in git.git (Jun 2022, #02; Tue, 7)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqwndsrm99.fsf@gitster.g>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <15dd34af-14c1-5b41-5d33-a2e3b9611c25@gmail.com>
Date:   Wed, 8 Jun 2022 12:56:17 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqwndsrm99.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Le 2022-06-07 à 21:12, Junio C Hamano a écrit :

> * pb/range-diff-with-submodule (2022-06-06) 1 commit
>   (merged to 'next' on 2022-06-07 at e5e31590c4)
>  + range-diff: show submodule changes irrespective of diff.submodule
> 
>  "git range-diff" did not show anything for submodules that changed
>  in the ranges being compared.  Change the behaviour to include the
>  "--submodule=short" output unconditionally to be compared.
> 
>  Will merge to 'master'.
>  source: <pull.1244.v2.git.1654549153769.gitgitgadget@gmail.com>
> 
I think the merge message (and thus the mention in the release notes)
could be more precise, maybe something like this: 

"git -c diff.submodule=log range-diff" did not show anything for 
submodules that changed in the ranges being compared, and 
"git -c diff.submodule=diff range-diff" did not work correctly.
Change the behaviour to include the "--submodule=short" output 
unconditionally to be compared.
