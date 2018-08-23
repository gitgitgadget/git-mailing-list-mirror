Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0FDA1F954
	for <e@80x24.org>; Thu, 23 Aug 2018 05:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbeHWIiV (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 04:38:21 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37379 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbeHWIiV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 04:38:21 -0400
Received: by mail-pg1-f196.google.com with SMTP id h8-v6so1977549pgs.4
        for <git@vger.kernel.org>; Wed, 22 Aug 2018 22:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Qq6FZAFyCEP04eRm6GObIlhXqbwYjal6WsRRdBuc9h8=;
        b=cVkYYbbghWxBuGJIGz8VHRF1CAuExGVm2w63d+QZQm0s+y21AoqgiQ3zX8B0AMbqU+
         K2pT8+Wx0V5+wFlUZRjHqxrEDNcTQ/fNtkIRLJOA7wd3zuhxw4l0a5DaouiQgPyAGAT8
         bkI6jekibMsAjcrx3YKwk8YKSQ33sr85lXjnR40gWVrcvPS71+0G+puu8y989DV7Ru/Y
         wfpsZ4Z3nXHq+24i0C96PfJYlOREXSm608RB4R3x4v4RYkwcjmX9yNZ2Ou+0vVnsvjzi
         BnCZtzdUTV4G/K7G6JgBaPld0hQdlDylCVCxxv0KmnJN/DjmzJJfzxSM/s68Jgl5rrba
         c+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qq6FZAFyCEP04eRm6GObIlhXqbwYjal6WsRRdBuc9h8=;
        b=fzfCCvXXxmabOuBK0TZOHD2jAXtId5s/5F8laXteP7d4iX+wu1bbbHBjwOGO3GXGbk
         hc1wupAikXU/Nakx7rLXOCvX6FlQV1STMpXzhM/6pQS5BKHINDQBIIbRX9laogVHlUfA
         cEvtbGbIjvoQ1Fn9tRpe4FTn9408h5KIBJ+uB+5UL3Gg+FOaMBaT1nD+Y6CHWA/tWJg/
         AJdWa7YCQOi8sjz31cLFF0PEvOi5m1rd1L6JNV1cbwKCs1G1bfR1cle9jmqIS6CJbw66
         RtnfBydMPj6VI0ZsFrUBUNVsWVsGq9pRnFVc1FKwWMukBw+1crRXVqLojuUkaKuIO8VK
         uV6A==
X-Gm-Message-State: APzg51CaJhN7j+6jzB9pCait2kyWv380PTxvY3G4ThGFUO937VlF0IG2
        8KLFPh7//ghtvJrFq20RDjkvIBZG
X-Google-Smtp-Source: ANB0Vda/RRBw/6nC70S3um4Qo9Vcyz9+9Cl22RZEtNCP+50hL/FCi62utKfMPRcamBrByoBTtvHnCg==
X-Received: by 2002:a63:df4e:: with SMTP id h14-v6mr1894697pgj.300.1535001029238;
        Wed, 22 Aug 2018 22:10:29 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id l27-v6sm6467666pfi.180.2018.08.22.22.10.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Aug 2018 22:10:28 -0700 (PDT)
Date:   Wed, 22 Aug 2018 22:10:27 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Paul Smith <paul@mad-scientist.net>, git@vger.kernel.org,
        Derrick Stolee <stolee@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [ANNOUNCE] Git v2.19.0-rc0
Message-ID: <20180823051027.GA160081@aiede.svl.corp.google.com>
References: <1b20b754-987c-a712-2594-235b845bc5d0@gmail.com>
 <20180821212923.GB24431@sigill.intra.peff.net>
 <20180822004815.GA535143@genre.crustytoothpaste.net>
 <20180822030344.GA14684@sigill.intra.peff.net>
 <814549a01074e89a4b26cb0cf13e4dddeb3a040a.camel@mad-scientist.net>
 <20180822152306.GC32630@sigill.intra.peff.net>
 <20180823012343.GB92374@aiede.svl.corp.google.com>
 <20180823021618.GA12052@sigill.intra.peff.net>
 <20180823022756.GF92374@aiede.svl.corp.google.com>
 <20180823050224.GA318@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180823050224.GA318@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

> Here's the patch. For some reason my numbers aren't quite as large as
> they were yesterday (I was very careful to keep the system unloaded
> today, whereas yesterday I was doing a few other things, so perhaps that
> is the difference).
>
> -- >8 --
> Subject: [PATCH] hashcmp: assert constant hash size
>
> Prior to 509f6f62a4 (cache: update object ID functions for
> the_hash_algo, 2018-07-16), hashcmp() called memcmp() with a
> constant size of 20 bytes. Some compilers were able to turn
> that into a few quad-word comparisons, which is faster than
> actually calling memcmp().
>
> In 509f6f62a4, we started using the_hash_algo->rawsz
> instead. Even though this will always be 20, the compiler
> doesn't know that while inlining hashcmp() and ends up just
> generating a call to memcmp().
>
> Eventually we'll have to deal with multiple hash sizes, but
> for the upcoming v2.19, we can restore some of the original
> performance by asserting on the size. That gives the
> compiler enough information to know that the memcmp will
> always be called with a length of 20, and it performs the
> same optimization.
>
> Here are numbers for p0001.2 run against linux.git on a few
> versions. This is using -O2 with gcc 8.2.0.
>
>   Test     v2.18.0             v2.19.0-rc0               HEAD
>   ------------------------------------------------------------------------------
>   0001.2:  34.24(33.81+0.43)   34.83(34.42+0.40) +1.7%   33.90(33.47+0.42) -1.0%
>
> You can see that v2.19 is a little slower than v2.18. This
> commit ended up slightly faster than v2.18, but there's a
> fair bit of run-to-run noise (the generated code in the two
> cases is basically the same). This patch does seem to be
> consistently 1-2% faster than v2.19.
>
> I tried changing hashcpy(), which was also touched by
> 509f6f62a4, in the same way, but couldn't measure any
> speedup. Which makes sense, at least for this workload. A
> traversal of the whole commit graph requires looking up
> every entry of every tree via lookup_object(). That's many
> multiples of the numbers of objects in the repository (most
> of the lookups just return "yes, we already saw that
> object").
>
> Reported-by: Derrick Stolee <stolee@gmail.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  cache.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Verified using "make object.s" that the memcmp call goes away.  Thank
you.
