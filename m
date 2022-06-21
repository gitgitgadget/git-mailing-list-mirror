Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9667C43334
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 21:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355898AbiFUVW3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 17:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356034AbiFUVWG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 17:22:06 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F17831505
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 14:10:07 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id y14so17015894qvs.10
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 14:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=GGfnv5PHEjAcI6+CWCKxqrfkI4IVVabH8gxrnoMdLt4=;
        b=HQ1PLoffhE1b0axGWvlNgLZLtM/7W4n3QQkBaOfIeD5RhyZw8qAdEw1gbJ76c844Ec
         tW9CXim96pKHOWJV+qJmMir6nAzQKfis8ZFWzc4vOVaaaMMusWf22waT4OITXbjEWVJC
         pnugfRktj0Kd0WOWGoWl9m9sZnzB3JB+uVVytlsGFPv/tP13BJOj2/KI6b7bQ0wy0zt1
         RU+6/kFBY+u8no+kyjnSFcWembZG1Kmjeg1XkfjtwCfNI/Mj/cfZYrZNKjkMCyOGnPSN
         9f1lZt8hcvsjtO9R6+AjZyuHOT6EObVaFF3lMsXkBR7icSZpqvbyDKKgexZjUao+hxKo
         LENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GGfnv5PHEjAcI6+CWCKxqrfkI4IVVabH8gxrnoMdLt4=;
        b=bfoC12UYo6aA5t3mE1VF0aVwIlxxZHogAA7VGkwWiLz59B2DFZMohrbOuKUJt0a9gE
         tQWeuI0FAAn/yKuou2dGEvNASFIFguSdveAE4vUoyKW8Xi0DuIxEV9r14EKSUsqRwzjA
         Q2jk30gx3tmE/XCKhy52s1vkIz8yR2UbJRYGArA4VJI5TvBIhTDmeh6QHETHMI4L4xb7
         Q6WWNiVIuU+1lsPhhKA+ffg2e7+WVA9puTVmBKFw62vbYiavo2Xt4K0BQB59OALIIe8d
         A2U3ScTsYb98TCHh5MCcWfkNa+WMl+5kwBx0kvwsD8u/s11vOW+R3CCEJm5B9JUY3caJ
         TsMA==
X-Gm-Message-State: AJIora+Pah2xXWam0gN7rKPiskR9C72qU1hXEOqyND22iaHKJcKWtfXQ
        mNaxfJfthyE1bR5XI3bxPtMi
X-Google-Smtp-Source: AGRyM1vFNSwJguG7cs+1Zk0RwCfdYKS6okcrqJV4t8klRzuPla2B0px6YEqwWPMHMv8HePVR74iQGw==
X-Received: by 2002:a05:622a:14d0:b0:307:9a54:b0bf with SMTP id u16-20020a05622a14d000b003079a54b0bfmr169982qtx.495.1655845806287;
        Tue, 21 Jun 2022 14:10:06 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:44d7:1b01:4339:1df9? ([2600:1700:e72:80a0:44d7:1b01:4339:1df9])
        by smtp.gmail.com with ESMTPSA id x12-20020ac87a8c000000b00304fce6a137sm12852724qtr.66.2022.06.21.14.10.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 14:10:05 -0700 (PDT)
Message-ID: <17349136-2d99-92fc-a73a-507684f32baa@github.com>
Date:   Tue, 21 Jun 2022 17:10:04 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/6] docs: document bundle URI standard
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, dyroneteng@gmail.com, Johannes.Schindelin@gmx.de
References: <pull.1248.git.1654545325.gitgitgadget@gmail.com>
 <e771b2971d092af5ea8a47eb708d03e34b284a0f.1654545325.git.gitgitgadget@gmail.com>
 <xmqqtu8x1fd4.fsf@gitster.g>
 <48e722dc-f860-f7a6-36d0-b0106087aef4@github.com>
 <d4427adf-e3ef-a5cd-3016-687004dc5ae3@github.com>
 <xmqq8rpphiwn.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqq8rpphiwn.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/21/2022 4:16 PM, Junio C Hamano wrote:
> Derrick Stolee <derrickstolee@github.com> writes:
> 
>>>> The refs/bundles/ appear in the document only here, and it is
>>>> unclear why we even want it (I am assuming this is against gc while
>>>> "git clone" is still running) or how we are going to retire it, if
>>>> ever.  If there are multiple bundle files involved in this "git clone",
>>>> to anchor objects that are necessary against "gc", don't we need to use
>>>> refs/bundles/<i>/* or something like that, where <i> is uniquely assigned
>>>> number locally?
>>>
>>> The real reason to keep them in refs/bundles/ is because then those
>>> refs can be used in the incremental 'git fetch' after downloading the
>>> bundles (in perpetuity) while not stomping refs/heads or refs/remotes/
>>
>> ...I completely ignored your "refs/bundles/<i>/*" suggestion, which is
>> an interesting way to allow dropping refs from this space, allowing GC
>> to clear up space over time.
> 
> FWIW, I wasn't thinking about GC and expiration.  If bundle URI
> thing can say "you need this, that and that other bundle" and cause
> you to fetch three bundles, I thought that there needs a way for you
> to record the tips of these three bundles---these three bundles
> should not have to compete for refs/bundles/master, for example.
 
Not wanting to compete makes sense, but also we should usually
expect the "most recent" bundle to be the most recent version of the
branch. However, that ordering only makes sense when we have the
creationToken (nee timestamp) heuristic, so having distinct ref
spaces makes sense to avoid collisions.

Thanks,
-Stolee
