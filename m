Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6AEE1F461
	for <e@80x24.org>; Thu,  5 Sep 2019 22:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731109AbfIEW6D (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 18:58:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:41522 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730065AbfIEW6D (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 18:58:03 -0400
Received: (qmail 10502 invoked by uid 109); 5 Sep 2019 22:58:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 05 Sep 2019 22:58:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32645 invoked by uid 111); 5 Sep 2019 22:59:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Sep 2019 18:59:47 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 5 Sep 2019 18:58:02 -0400
From:   Jeff King <peff@peff.net>
To:     Stephan Beyer <s-beyer@gmx.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Paul Tan <pyokagan@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] Fix maybe-uninitialized warnings found by gcc 9 -flto
Message-ID: <20190905225802.GA19526@sigill.intra.peff.net>
References: <20190905082459.26816-1-s-beyer@gmx.net>
 <20190905224859.GA28660@sigill.intra.peff.net>
 <963e5249-82ca-8961-917a-f45c20b1affe@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <963e5249-82ca-8961-917a-f45c20b1affe@gmx.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 06, 2019 at 12:53:49AM +0200, Stephan Beyer wrote:

> On 9/6/19 12:48 AM, Jeff King wrote:
> > On Thu, Sep 05, 2019 at 10:24:59AM +0200, Stephan Beyer wrote:
> >
> >> Compiler heuristics for detection of potentially uninitialized variables
> >> may change between compiler versions and enabling link-time optimization
> >> may find new warnings.  Indeed, compiling with gcc 9.2.1 and enabled
> >> link-time optimization feature resulted in a few hits that are fixed by
> >> this patch in the most naïve way.  This allows to compile git using the
> >> DEVELOPER=1 switch (which sets -Werror) and using the -flto flag.
> >
> > Lots of discussion in this thread. Let's try to turn it into some
> > patches. :)
> 
> I thought the same and just sent my version of it. :D

Yeah, I see that our mails crossed. :) I like some of my versions
better, but I'm OK with either (or a mix-and-match).

-Peff
