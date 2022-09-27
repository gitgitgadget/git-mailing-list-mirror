Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04341C07E9D
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 14:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbiI0OTD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 10:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiI0OTB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 10:19:01 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30388EF082
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 07:19:00 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id z6so15277570wrq.1
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 07:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date;
        bh=/Tf/TSkBvyUSJPHBIexYrArrrHHkTnHX9V7hIsBAzLQ=;
        b=cQR8O8l7TD/4t5iuBBE5g/XOU5437KuFXQhn35b7Cs59DIJVMbrb4xaHBqBnxijJZk
         k0wake0y21LMQh8hkSnJVEqzaRVf530NhcEKzXbe0nfUm6BlnzG/Sn9N3OMZD8xBVDce
         zINJO4z0nV7+ojDVb1+UlLjLBxR2OkedxACUvyB4DSb9XaR7Gd5fIvA3YLsdzPYkCAQp
         un+roUjzCfLspAdzeTXocIexBDnnFOQro3iEBKDUqOM+qvpke1MgSa4LTtnhQfIxhFh/
         gAMmOqyJyHUevF5HgCqljYgRuUJy44pGYQcWTPC2gAths4EhJtg6L8jn9psLjMoBigFc
         agyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date;
        bh=/Tf/TSkBvyUSJPHBIexYrArrrHHkTnHX9V7hIsBAzLQ=;
        b=H04N9ZtPQsGHQVkgFXNpffFIvSWhald0HhApTz/jPfTUp3cBwEOZNLRyNuJ6abpAfu
         qlfrNcogtOrz9FuJABddjSzCJn51qRU+67lMaScoJOROezX0dCUE4OjKC5i1v6eckQdq
         Zci3CoeUxfbMNqny4SFbsMHg23wfc253N995+t305jr06CAQHkxvcr+uNJtycIlBa3Z9
         faN1gD88akcxE/+JDT+a62Spop2PtrykuqmZqUjdIfLuAHrsQ6bQ2Yj7ZVsgf4st4rB0
         qVUR7iGeATMgEvL45Sr/jnf7+NuRcroszj7xBwEpSkCXMjFVx7wnlCv+a9SsBvE6lnYY
         tSvA==
X-Gm-Message-State: ACrzQf1p/1SghvovaghXC3/V35LtnONmABlFTGQAsQK3QGNVpTVeVuKE
        7Li2+jQkh43aYIvqrwGlv5ZWajrrLB5HqA==
X-Google-Smtp-Source: AMsMyM6QQMjBAlI0BPjemMsouSdidabDi+wI2SY2qqx18RnXap5lyXVo3pDQx1eB+mRWTK/sY1dZew==
X-Received: by 2002:a05:6000:144a:b0:229:b76f:86f9 with SMTP id v10-20020a056000144a00b00229b76f86f9mr17421410wrx.613.1664288338645;
        Tue, 27 Sep 2022 07:18:58 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id p16-20020adfe610000000b00225239d9265sm2029164wrm.74.2022.09.27.07.18.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 07:18:58 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <7c310e1a-1011-c426-fe64-7be21b69052c@dunelm.org.uk>
Date:   Tue, 27 Sep 2022 15:18:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 05/10] evolve: add the change-table structure
Content-Language: en-US
To:     Stefan Xenos via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Christophe Poucet <christophe.poucet@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <pull.1356.git.1663959324.gitgitgadget@gmail.com>
 <2b3a00a6702eb8fb12e45b833ca74155939588ef.1663959325.git.gitgitgadget@gmail.com>
 <3c61e0b3-5526-f42e-48a7-c4465d06ccb3@dunelm.org.uk>
In-Reply-To: <3c61e0b3-5526-f42e-48a7-c4465d06ccb3@dunelm.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/09/2022 14:27, Phillip Wood wrote:
>> +    /**
>> +     * Determine the object id for the latest content commit for each 
>> change.
>> +     * Fetch the commit at the head of each change ref. If it's a 
>> normal commit,
>> +     * that's the commit we want. If it's a metacommit, locate its 
>> content parent
>> +     * and use that.
>> +     */
>> +
>> +    for (i = 0; i < matching_refs.nr; i++) {
>> +        struct ref_array_item *item = matching_refs.items[i];
>> +        struct commit *commit = item->commit;
>> +
>> +        commit = lookup_commit_reference_gently(repo, 
>> &item->objectname, 1);
> 
> We're assigning commit twice - why do we need to look it up if 
> filter_refs returns it?

I think we want to look it up to check that item->objectname is a 
commit. item->commit is not filled unless we specify the verbose flag 
and I'm not sure what the implications of setting that are. If we get an 
objectname that does not name a commit we should call BUG() as suggested 
below.

> There are a number of places where we call 
> lookup_commit_reference_gently(..., 1) to silence the warning if the 
> objectname does not dereference to a commit. It is not clear to me that 
> we want to hide those errors. Indeed I think we should be doing
> 
>          commit = lookup_commit_reference(repo, oid)
>          if (!commit)
>              BUG("commit missing ...")
> 
> unless there is a good reason that the lookup can fail.
