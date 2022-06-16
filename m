Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D95C43334
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 14:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377408AbiFPOAi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 10:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377487AbiFPOAU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 10:00:20 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121F74B867
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 07:00:01 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id z11so966452ilq.6
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 07:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=67D6TtFkg5SIkQb6T9nb1wPFw0kcX/mOmKkDlEhdHJU=;
        b=QMuR23WqtN6f6hfD97x5KcN+6r4X51xiaLx1/T0uv0NYgJ+FaM32rNeZS57IQFIQDG
         2XL5/S7NWwgRtOv2pVo0EguLzzhXRftTIPOJ6yV98DgoQd4AapmoiIxC6ggYVi9lK6UL
         zwI/T3zxFhmuX7ePSz1k+n/8vAL8Sv4jnlVpYXbeYuicT7siJSDT5RdENhiQgj4YaWwr
         KfWz8BMqDG6aIemsi/ZR5GBUmEQHJR8H36sAXxoQzQ+m/vnVRJRfzrmcZhCBHTMhnS/H
         g1LrTZTquBHZM/94I2bYNZ824+cUGY83SADxF7znuXT5uMYL1kDe8MmgR9+olhxPFiRq
         NuBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=67D6TtFkg5SIkQb6T9nb1wPFw0kcX/mOmKkDlEhdHJU=;
        b=Z1J7i0U1WOKledKKHhjMpwvTYJ6Eq3X5Rmu1R1yUAPduQzcHiTD3tNEDQaF9tHKKvU
         H84GQhdbhYxwdOyw35GV5HN3aifsIUeqiN0H0y5/nNdtlpGt+HQ3OBsM0jnYoEL7rfWX
         plFppPwCkadsu9UqfeIuOa4h4JXGu3vQb/jYV2qRWQ5Rtw/aLVPZ9g0P8vH1PQdAMOeq
         vQM5JQwpy5cBSqDqYj52pQcB/4yy0CmytIU21X2ra0cgqHSW7Qm2OXDVDwGzghwZ5Ke/
         lIadtadGooCrfFqHU/XeYlj48HP15wlQS8i79Z+U9WWFwqMwmV1kq5XUdKY4Jji53edu
         NkSA==
X-Gm-Message-State: AJIora+7c+74UyVNj+8eI2aZ01INzRrt3CGX2owzcSTAcusFB4k2AT8K
        eKl8nvNlk4T4Gn9Cb55ObBzy0y8rCOfS
X-Google-Smtp-Source: AGRyM1t7xH4f9Zxt2sm4ISLXFHexYy+l98iJY/xn9ieYbwxSta2Bv2Jq4U8rRt6X3EpO6S6hn/1KKw==
X-Received: by 2002:a05:6e02:1b0c:b0:2d3:bfdf:e3c5 with SMTP id i12-20020a056e021b0c00b002d3bfdfe3c5mr2975436ilv.138.1655388000367;
        Thu, 16 Jun 2022 07:00:00 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:cfb:ad5:8ed2:9eba? ([2600:1700:e72:80a0:cfb:ad5:8ed2:9eba])
        by smtp.gmail.com with ESMTPSA id s70-20020a025149000000b00331f8fff9a3sm908217jaa.64.2022.06.16.06.59.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 07:00:00 -0700 (PDT)
Message-ID: <b559b9a3-b97a-f394-5845-5c810425f8a4@github.com>
Date:   Thu, 16 Jun 2022 09:59:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] mktree: learn about promised objects
Content-Language: en-US
To:     Jeff King <peff@peff.net>
Cc:     Richard Oliver <roliver@roku.com>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org, jonathantanmy@google.com
References: <77035a0f-c42e-5cb3-f422-03fe81093adb@roku.com>
 <0067c46a-7bfd-db9c-5156-16f032814464@github.com>
 <797af8c8-229f-538b-d122-8ea48067cc19@roku.com>
 <574dc4a9-b3c7-1fd3-8c0e-39071117c7f0@github.com>
 <YqkpRE8nykqVv8cn@nand.local> <YqlZb3Ycc71+dPu4@coredump.intra.peff.net>
 <ad9b5ec9-14fd-cd66-be87-2fe1eb24296a@roku.com>
 <1fe6c00a-806c-89de-cb67-d063dc4a5279@github.com>
 <YqrIrYHKUP6b/EtN@coredump.intra.peff.net>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <YqrIrYHKUP6b/EtN@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/16/2022 2:07 AM, Jeff King wrote:
> On Wed, Jun 15, 2022 at 02:17:58PM -0400, Derrick Stolee wrote:
> 
>> On 6/15/2022 1:40 PM, Richard Oliver wrote:
>>> On 15/06/2022 05:00, Jeff King wrote:
>>
>>>> So it is not just lookup, but actual tree walking that is expensive. The
>>>> flip side is that you don't have to store a complete separate list of
>>>> the promised objects. Whether that's a win depends on how many local
>>>> objects you have, versus how many are promised.
>>
>> This is also why blobless (or blob-size filters) are the recommended way
>> to use partial clone. It's just too expensive to have tree misses.
> 
> I agree that tree misses are awful, but I'm actually talking about
> something different: traversing the local trees we _do_ have in order to
> find the set of promised objects. Which is worse for blob:none, because
> it means you have more trees locally. :)

Ah, I misread your email. I agree that walking trees is far too
expensive to do just to find an object type.

> Try this with a big repo like linux.git:
> 
>   git clone --no-local --filter=blob:none linux.git repo
>   cd repo
> 
>   # this is fast; we mark the promisor trees as UNINTERESTING, so we do
>   # not look at them as part of the traversal, and never call
>   # is_promisor_object().
>   time git rev-list --count --objects --all --exclude-promisor-objects
> 
>   # but imagine we had a fixed mktree[1] that did not fault in the blobs
>   # unnecessarily, and we made a new tree that references a promised
>   # blob.
>   tree=$(git ls-tree HEAD~1000 | grep Makefile | git mktree --missing)
>   commit=$(echo foo | git commit-tree -p HEAD $tree)
>   git update-ref refs/heads/foo $commit
> 
>   # this is now slow; even though we only call is_promisor_object()
>   # once, we have to open every single tree in the pack to find it!
>   time git rev-list --count --objects --all --exclude-promisor-objects
> 
> Those rev-lists run in 1.7s and 224s respectively. Ouch!

This is exactly the reason I thought just asking for the objects
directly is faster than scanning all the packs. Thanks for giving
concrete numbers that support that assumption.

Thanks,
-Stolee
