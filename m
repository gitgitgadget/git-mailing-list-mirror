Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE281200B9
	for <e@80x24.org>; Tue,  8 May 2018 00:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753786AbeEHAoi (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 20:44:38 -0400
Received: from mail-yw0-f180.google.com ([209.85.161.180]:34221 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751647AbeEHAoh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 20:44:37 -0400
Received: by mail-yw0-f180.google.com with SMTP id x27-v6so6588886ywj.1
        for <git@vger.kernel.org>; Mon, 07 May 2018 17:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tehrAFkdz1t+FmtRnivwqyg8k8477BBOAalHl1iaq8o=;
        b=GZDL64k/XjclyKOyLsnh5XwR52YP79ojZdwTo7Ke9nkm/JVWW28eDkzrGiXfGWeaJO
         efFjgQHwrQE+1Yjj+B0lXU8Caaz576jsqzI6d17P9bh057WZAOoX2OAal8ngogZrGSxt
         +/PymEWjQK3oq9duNaV1Q3hdFqNDKVMbIODtQq0FagTPn3S8Xha9/Dn9G79GdCUmuiB5
         DhnO7W051LYOj3OQaCocg5+szRN1rYbrXz1dbFhPWpuRd1cDSe/5k+gdDRct2Fg0mmek
         TwJ7o+FlEbqnGH2x+EAqfBjwrv9uAuwFWdvaNFdDGI1GAt+9Ux1QhLcw3/2BEx6R2vvN
         RYHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tehrAFkdz1t+FmtRnivwqyg8k8477BBOAalHl1iaq8o=;
        b=B1wy7uedGn0yde/m17Oa+JsTusymM0eW5ds2HrOSjB8OI8M8KPQ+E3F7bRpMMUM827
         qo8Lqw60XiDLh152XBwtz649UHXgkiGviJnBwnzLXauexizStn2Qfj7HgFYPOUZwzYYL
         YIDCZFhS1gk3c7aubVPiEgThCNX0UivAzliVpou2LaqzD4kPHbTIgrU41LijZEbYelQL
         CJdFV6x3+OFaZp9bK43BLmHAec3QVmOCfgjuDB7eHgTWdHR5mifi/0w9PWd+BDNlFrzq
         YAiWy2TeQWTatjhQhHmdVK4JChKT3Me2rOwZQyAN/5D/ZeYDylqC5Xd+Ra2uaFn2c0vC
         RZYA==
X-Gm-Message-State: ALQs6tDv/g2oisURIIDOEJlbhFzsv6gmpgBHPrTKXic32UhYGkF+MmYM
        40bcQRXNzPbyDJ1K6GzmwrAxCOECsZP7PbjMhEZMGg==
X-Google-Smtp-Source: AB8JxZpanOMOkvVn6G/ON/Z+KjHTMkEeJYtYE4CUAIVvNhMhqMUFDjreIq7zwV4p5GtS/HgC5SWA0oWfJHgiFiDHy+s=
X-Received: by 2002:a81:4ec9:: with SMTP id c192-v6mr22243826ywb.421.1525740276620;
 Mon, 07 May 2018 17:44:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Mon, 7 May 2018 17:44:36 -0700 (PDT)
In-Reply-To: <xmqqsh73nfta.fsf@gitster-ct.c.googlers.com>
References: <BL0PR2101MB1106BA184260609DA69988A6CE870@BL0PR2101MB1106.namprd21.prod.outlook.com>
 <20180503221802.61110-1-sbeller@google.com> <CACsJy8De2SUGj9hgq3h7pODm=9Wn+TkCKfJjrm1c=UxS9BZvTA@mail.gmail.com>
 <xmqqsh73nfta.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 7 May 2018 17:44:36 -0700
Message-ID: <CAGZ79kbC1f856Pbf-Uucdr-FnNemjTTb07RiECBMDW2ZTA2xDA@mail.gmail.com>
Subject: Re: [PATCH] alloc.c: replace alloc by mempool
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Jameson Miller <jamill@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 7, 2018 at 5:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>>> So I think we could just replace it for now and optimize again later, if it
>>> turns out to be a problem. I think the easiest optimisation is to increase
>>> the allocation size of having a lot more objects per mp_block.
>>
>> Yeah. I also tested this from a different angle: memory overhead. For
>> 2M objects with one mp_block containing 1024 objects (same setting as
>> alloc.c), the overhead (not counting malloc() internal overhead) is
>> 46KB and we don't have any extra overhead due to padding between
>> objects. This is true for all struct blob, commit, tree and tag. This
>> is really good. alloc.c has zero overhead when measured this way but
>> 46KB is practically zero to me.
>
> Thanks.
>
> The above in short sounds like arguing "replacing alloc.c internal
> with mempool incurs negligible memory overhead and performance
> degradation, but that can be optimized later".  It was unclear to me
> why such a replacement needs to happen in the first place, though.

The replacement with mem-pool might be easier than making sure
that alloc.c has no globals and handles allocations per repository
correctly. It would make the sb/object-store-alloc series shorter than
it currently is, and maybe easier to review the code.

However now that sb/object-store-alloc is rerolled with keeping
the logic of alloc.c and not replacing it with mem-pool, the only
reason would be ease of maintainability by less code
On the other hand we have different implementations of
lists, vectors and hashmaps, so having different memory
allocators doesn't hurt.

> Without such a code churn, there won't be extra overhead or need to
> fix it up later, no?

The original motivation is to get the object store on a per-repository
basis. It might be cheaper to use an existing 'objectified' code instead
of doing that again.
