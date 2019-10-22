Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA19C1F4C0
	for <e@80x24.org>; Tue, 22 Oct 2019 20:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731273AbfJVUj1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 16:39:27 -0400
Received: from mail-qt1-f172.google.com ([209.85.160.172]:34958 "EHLO
        mail-qt1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfJVUj0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 16:39:26 -0400
Received: by mail-qt1-f172.google.com with SMTP id m15so28965210qtq.2
        for <git@vger.kernel.org>; Tue, 22 Oct 2019 13:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X5+vJAcXo5AWWvGMPvdC5ZBpuFThkAM1KYBG4i3dse4=;
        b=Qz5qNBvL1tkefypL//gHgO8E4NWAXGPWPNhhUdcbmpGve1+gsBs/ijUExJft2MaAsU
         UshSGFGL7fAiPDJaYtBcr0NDQMBcQQURgnGrFSta7yv7+Yuie2a8Rbg2uWE3OCEe3aiX
         120ZE3JyVu4uvTZXupE9OCzTOKAxHVGD4uYY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=X5+vJAcXo5AWWvGMPvdC5ZBpuFThkAM1KYBG4i3dse4=;
        b=kNvPL0OiAXK/0IYDIvdvvqJtcIwVehw0dOUtDo4Mb1tfUl2Hhi1aUbWan1IdlwKlXm
         YX2x0fY2sseWHog42ROCdqFgANSdKxQf13pd/evaMmCYmVdkcSmpn/oU7BQmz5LKp0m5
         eyGxIVZyozZ5JMqEtmUz7mcVqAsV0Zrpstc5iIxaMUc1DFV06eQNIRr9Ot2x50ahinMO
         7y4bd14mrCC7Y9FgwmhEX1/8HdCnYqZ5AFclOMiYMLZH3D3kXFzFBnXuHYhVib5xecp5
         ZaqMpc5rR/BEgC2n6id8/FqV4DBkJnhERjgpYzI8gDGeGIlWAbiGZFIlT89Ezw6vVfu0
         VZkg==
X-Gm-Message-State: APjAAAUZjcwfvOlAQHbsQzVXqHaTQXeO5FPEOwVs7UP2kuG4SdVSvNQn
        a/Hs7TjxjHC5p2pa/O3SD8VW7H7R/qAjdA==
X-Google-Smtp-Source: APXvYqxUFGof5gmRRXmjtsKx6NEA+w1WQu1gbBEZ1dQFk7HjmCUa6ZYyr5yL64+rsjitxzJGul4jQg==
X-Received: by 2002:ac8:7646:: with SMTP id i6mr5615640qtr.251.1571776765711;
        Tue, 22 Oct 2019 13:39:25 -0700 (PDT)
Received: from chatter.i7.local (192-0-228-88.cpe.teksavvy.com. [192.0.228.88])
        by smtp.gmail.com with ESMTPSA id h23sm9692010qkk.128.2019.10.22.13.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 13:39:25 -0700 (PDT)
Date:   Tue, 22 Oct 2019 16:39:23 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: is commitGraph useful on the server side?
Message-ID: <20191022203923.GA3020@chatter.i7.local>
Mail-Followup-To: Jeff King <peff@peff.net>,
        Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>
References: <20191022165112.GA4960@chatter.i7.local>
 <e0e294a7-bd3c-2174-a922-c5893b0945c2@gmail.com>
 <20191022200615.GA12270@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20191022200615.GA12270@sigill.intra.peff.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 22, 2019 at 04:06:16PM -0400, Jeff King wrote:
>> I'm biased, but I think the commit-graph is generally really good to 
>> have
>> in almost all cases. I actually do not know of a good reason to _not_ have
>> it.
>
>A lot depends on how much you do on the server. If you're serving a web
>interface that runs things like `rev-list`, or `for-each-ref
>--contains`, etc, then you should see a big improvement.

Ah, good to know, so something like cgit would see an improvement if 
there are commit graphs generated for the repos it serves.

>If you're _just_ serving fetches with `upload-pack`, you might see some
>small improvement during fetch negotiation. But I suspect it would be
>dwarfed by the cost of actually generating packs. Likewise, the
>traversal there will be dominated by accessing trees (and if that is
>expensive, then you ought to be using reachability bitmaps).

We do generate bitmaps on a routine basis.

OK, I think I'm convinced that enabling commitgraph and generating them 
regularly is going to be a net win.

Thanks, everyone.

-K

