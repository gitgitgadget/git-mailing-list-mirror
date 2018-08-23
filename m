Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 798931F954
	for <e@80x24.org>; Thu, 23 Aug 2018 02:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbeHWFzV (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 01:55:21 -0400
Received: from mail-pg1-f176.google.com ([209.85.215.176]:39763 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbeHWFzV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 01:55:21 -0400
Received: by mail-pg1-f176.google.com with SMTP id m3-v6so883938pgp.6
        for <git@vger.kernel.org>; Wed, 22 Aug 2018 19:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zTu25rvHlXj+4uNqtkiakbVvfLFo4HAwBI3q3Om5yYg=;
        b=WRiXnIGnyQgStPJl6YowjsteykNIAvH/Rl+7rnBfbKC68kJo/9B9+9t0pKartmqBkd
         PrYaubLwAkWpGad/0/BpXAzMleRFvsdAIZ+06W+IKrdmFtyt4YEQPisAGL4VULYzkch3
         HqsiCj61gHUVpRpC/PfAAmOBqjpevcoL95WIAg0x2pDKY4VTtf21511QZVQE7E8vAhg+
         hXuzl03JtmRAWzuwlQJAjLmOaRHzHvFusNs13gZGx5X5i5idfJVD112FsTqAarNUGbzA
         OnMHnoWQyrj6dMeB/S+xl5PvGDWjD5X2AcoFGv2Y/6Kn95brRn1CEk0w6eipiSHevQPA
         CXTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zTu25rvHlXj+4uNqtkiakbVvfLFo4HAwBI3q3Om5yYg=;
        b=WE9Xgh7yX06IidONVzzsTMqDvOKW8dS4hZ2tE9WoOM11StwDUOnLxrlOUaeQFrAKMa
         m5r16IxX4woi0Jwomxs4QcwQtA808hCWLvaBj/o2pgVxtHPtqz6j/O6fKQMKodXNxo1M
         G2Wu1cunARjrVMsEBRJMZIMYzMQciflyCqmzgDIlsOv9uXC7RyyITOrFvynAqUzdEJ+P
         EbGkEg8QonOE8rjX56kNUhTWbdWl0c1a+fNzLkD1blU1bpVE16mobkGZt3sd8OEsmhLq
         2Nx3XFcImaQJ1beZg1UdJkC95J5RD3I1MRviLvubYz/aIpSP/hJklL4z7+ifLGuvVEyP
         7Igg==
X-Gm-Message-State: AOUpUlGeySZpxd510CZtxAkeA/6wmW+UiTmCOirg0PQtTZWYaXPR0VKq
        XI0OI/qcJG3+1GDoDzVOMU4=
X-Google-Smtp-Source: AA+uWPyp64VBKxAh5xODG9/ZeduIpqnQDyLlrrmujBWJJTY59dLyL0qKI8WsXqK9MyLWLFly4VV6ag==
X-Received: by 2002:a63:e841:: with SMTP id a1-v6mr27269654pgk.126.1534991278792;
        Wed, 22 Aug 2018 19:27:58 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id i26-v6sm3807632pfo.107.2018.08.22.19.27.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Aug 2018 19:27:58 -0700 (PDT)
Date:   Wed, 22 Aug 2018 19:27:56 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Paul Smith <paul@mad-scientist.net>, git@vger.kernel.org,
        Derrick Stolee <stolee@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [ANNOUNCE] Git v2.19.0-rc0
Message-ID: <20180823022756.GF92374@aiede.svl.corp.google.com>
References: <xmqqwoskadpe.fsf@gitster-ct.c.googlers.com>
 <1b20b754-987c-a712-2594-235b845bc5d0@gmail.com>
 <20180821212923.GB24431@sigill.intra.peff.net>
 <20180822004815.GA535143@genre.crustytoothpaste.net>
 <20180822030344.GA14684@sigill.intra.peff.net>
 <814549a01074e89a4b26cb0cf13e4dddeb3a040a.camel@mad-scientist.net>
 <20180822152306.GC32630@sigill.intra.peff.net>
 <20180823012343.GB92374@aiede.svl.corp.google.com>
 <20180823021618.GA12052@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180823021618.GA12052@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

> FWIW, it's not 10%. The best I measured was ~4% on a very
> hashcmp-limited operation, and I suspect even that may be highly
> dependent on the compiler. We might be able to improve more by
> sprinkling more asserts around, but there are 75 mentions of
> the_hash_algo->rawsz. I wouldn't want to an assert at each one.
>
> I don't mind doing one or a handful of these asserts as part of v2.19 if
> we want to try to reclaim those few percent. But I suspect the very
> first commit in any further hash-transition work is just going to be to
> rip them all out.

I was thinking just hashcmp and hashcpy.

Ideally such a change would come with a performance test to help the
person writing that very first commit.  Except we already have
performance tests that capture this. ;-)

For further hash-transition work, I agree someone may want to revert
this, and I don't mind such a revert appearing right away in "next".
And it's possible that we might have to do the equivalent of manual
template expansion to recover the performance in some
performance-sensitive areas.  Maybe we can get the compiler to
cooperate with us in that and maybe we can't.  That's okay with me.

Anyway, I'll resend your patch with a commit message added some time
this evening.

Thanks,
Jonathan
