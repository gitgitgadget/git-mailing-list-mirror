Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E70251F597
	for <e@80x24.org>; Thu,  2 Aug 2018 18:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387679AbeHBUhh (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 16:37:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:40682 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729733AbeHBUhh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 16:37:37 -0400
Received: (qmail 22054 invoked by uid 109); 2 Aug 2018 18:45:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 02 Aug 2018 18:45:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26420 invoked by uid 111); 2 Aug 2018 18:45:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 02 Aug 2018 14:45:16 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Aug 2018 14:45:15 -0400
Date:   Thu, 2 Aug 2018 14:45:15 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        George Shammas <georgyo@gmail.com>, git@vger.kernel.org
Subject: Re: git merge -s subtree seems to be broken.
Message-ID: <20180802184515.GC23690@sigill.intra.peff.net>
References: <CAF1Ko+FBP5UmETmh071dvn9iv8-N-3YgaP61q-4jQvxFdN0GTA@mail.gmail.com>
 <CAF1Ko+FNfjWMteccfKDBjPEW76rGBLQkGb1icUHmzEZ0fKQJBA@mail.gmail.com>
 <xmqqtvofcsgc.fsf@gitster-ct.c.googlers.com>
 <20180731161559.GB16910@sigill.intra.peff.net>
 <xmqqh8kfcokk.fsf@gitster-ct.c.googlers.com>
 <20180731172304.GA16977@sigill.intra.peff.net>
 <20180731190459.GA3372@sigill.intra.peff.net>
 <xmqqeffj9ku3.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqeffj9ku3.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 31, 2018 at 02:06:12PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Tue, Jul 31, 2018 at 01:23:04PM -0400, Jeff King wrote:
> > ...
> > So here it is fixed, and with a commit message. I'm not happy to omit a
> > regression test, but I actually couldn't come up with a minimal one that
> > tickled the problem, because we're playing around with heuristics. So I
> > compensated by probably over-explaining in the commit message. But
> 
> Have you tried to apply the message yourself?  I'll fix it up but
> the hint to answer that question is in two extra pair of scissors.

Heh, thank you for noticing. I actually wondered about that while
writing it and meant to test, but then got distracted.

I wonder "am --scissors" should actually look for the _first_ scissors.
I guess that has the opposite problem, which is that we might include
too much cruft in an email that uses scissors. Perhaps "too much" is a
better failure mode than "too little", though.

-Peff
