Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1ED8200B9
	for <e@80x24.org>; Thu,  3 May 2018 20:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751108AbeECU6l (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 16:58:41 -0400
Received: from mail-yb0-f173.google.com ([209.85.213.173]:41287 "EHLO
        mail-yb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750822AbeECU6k (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 16:58:40 -0400
Received: by mail-yb0-f173.google.com with SMTP id l9-v6so6990690ybm.8
        for <git@vger.kernel.org>; Thu, 03 May 2018 13:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hQZoT+ychztGrguJlE6Q0yYqn23+jswhjk/PMaBjcUU=;
        b=aXIWiGzOTPi4hfR5mAFJFlltOnNPk9+HecPISA+AWQ7ItsF2Ng0O+DplZ7qAPmksfT
         rluFSWLQkLEHfMyVrkoyJNLjk6x5EQNkTj4fgCsp9vWeaVV27fzNZZZpHnWLnePvcBT9
         gv+cb1aFnPjS6NDx+1xLWNgoKNAliNGzN6PoTzcmBm/S8hqgPoPEk5jjTRz3ka8VscXC
         l7HuE8Jfkx9N1431qwhSV7KaZ3kD5Kjo3axHGko9hR018LVDTj8/f1MignWZPY4btTME
         LPx4YrzD4xGjzcCxfnN88rGtE3NJwttituCw3Zxa4fU8dJL61Jp+zXuCkXGHbRAj99U6
         cAXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hQZoT+ychztGrguJlE6Q0yYqn23+jswhjk/PMaBjcUU=;
        b=j18P1ByMtUzIP7m9Dn4ifmlngCebHeE7u2yK+6PBZZ+szA5W+qtYgrBmiJfZgaL7+m
         KvLGjEkUZ1mfyhEASOu1SMLXNQujNT2nx1SLLF2JqEcYIvJ+aE7VJnkAZJoTNADydX4R
         fZndyDVVZPh+0LLYtyWamh3EbOLQp9jiTTQzmaVDcAScnnLJiRyWVQTv+WTOE39hHi82
         jcgeogBCdCDS3b83tA1OHurq67IOYBB2FjeMAPolajO4jD1sAlD+Tl7VgOw9dx5ePM2u
         8FF/rreLZmPUYcXIuUT1DvVAZzUzrlkbYnOpnMKKQTii3++4ZuHUFwXs8GayRd1OY/VN
         6M1g==
X-Gm-Message-State: ALQs6tCBN8Rej82/y7BljN5uGGeWSxdnLfJpj6slFRtC7AAG+f2AJ9dH
        EUnlyLPdQQy9B8cb1VCpxVpgCkAH3sAd8nXAt5+s4w==
X-Google-Smtp-Source: AB8JxZqUicPpD8udsyHn8FT93//Q+tMxZHP8SdrTxiFh3+F6BepXIcRzaeqgXdN+ThMOJJuCzuT4zcA1VoUTOUtJVBw=
X-Received: by 2002:a25:3bc5:: with SMTP id i188-v6mr13427593yba.352.1525381119614;
 Thu, 03 May 2018 13:58:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Thu, 3 May 2018 13:58:38 -0700 (PDT)
In-Reply-To: <CACsJy8DF40o3gesuNbHACK+NiE=iZuXxLacyEQjECYewDy_icw@mail.gmail.com>
References: <20180417163400.3875-1-jamill@microsoft.com> <20180430153122.243976-1-jamill@microsoft.com>
 <CACsJy8C3yZ6bSZGw1d5DjwcPgHMDE7iGGUOn9SvyLmshzs9DvQ@mail.gmail.com>
 <CAGZ79kbyPya0igC9v5JwNTsi0TSp-sj6v5SB4MOt625+yVB-Gg@mail.gmail.com> <CACsJy8DF40o3gesuNbHACK+NiE=iZuXxLacyEQjECYewDy_icw@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 3 May 2018 13:58:38 -0700
Message-ID: <CAGZ79kb1K9iysibzmn2SUfyTayXOn97wTsoL4s557j+_ievkBA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Allocate cache entries from memory pool
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jameson Miller <jamill@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 3, 2018 at 12:17 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>
>> To me it is also a clear yes when it comes to combining these
>> two memory pools.
>
> I also did not notice that jm/mem-pool already landed in master.

Oh, thanks for telling! Now that I look at it, I am doubting it;

The reason for my doubt is the potential quadratic behavior for
new allocations, in mem_pool_alloc() we walk all mp_blocks to
see if we can fit the requested allocation in one of the later blocks.
So if we call mem_pool_alloc a million times, we get a O(n)
mp_blocks which we'd have to walk in each call.

However in alloc.c we do know that a slab is full as soon as we
look take the next slab. That is the beauty of knowing 'len' at
construction time of the allocator.

So I guess I'll just re-use the mp_block and introduce another
struct fixed_sized_mem_pool, which will not look into other mp_blocks
but the current.


> Have
> you tried measure (both memory usage and allocation speed) of it and
> alloc.c?

No, I was about to, but then started reading the code in an attempt to replace
alloc.c by a mempool and saw the quadratic behavior.

> Just take some big repo as an example and do count-objects -v
> to see how many blobs/trees/commits it has, then allocate the same
> amount with both alloc.c and mem-pool.c and measure both speed/mem.
> I'm pretty sure you're right that mem-pool.c is a clear yes. I was
> just being more conservative because we do (slightly) change
> allocator's behavior when we make the switch. But it's also very
> likely that any performance difference will be insignificant.
>
> I'm asking this because if mem-pool.c is a clear winner, you can start
> to update you series to use it now and kill alloc.c in the process.

I'll implement the fixed_sized_mem_pool and take some measurements.

>
> PS. Is Jeff back yet?

His last email on the public list is Apr 10th, stating that he'll be offline for
"a few weeks", in <20180406175349.GB32228@sigill.intra.peff.net> he
said the vacation part is 3 weeks. So I think he is done with vacation and
is just hiding to figure out a nice comeback. ;-)

> I'm sure Junio is listening and all but I'm
> afraid he's too busy being a maintainer so Jeff's opinion in this area
> is really valuable. He has all the fun and weird use cases to play
> with at github.

ok. I'll cc him for these patches.

Thanks,
Stefan
