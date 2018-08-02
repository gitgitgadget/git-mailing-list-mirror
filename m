Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E5561F597
	for <e@80x24.org>; Thu,  2 Aug 2018 21:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732405AbeHBXWa (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 19:22:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:41040 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727260AbeHBXW3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 19:22:29 -0400
Received: (qmail 29009 invoked by uid 109); 2 Aug 2018 21:29:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 02 Aug 2018 21:29:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28284 invoked by uid 111); 2 Aug 2018 21:29:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 02 Aug 2018 17:29:32 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Aug 2018 17:29:31 -0400
Date:   Thu, 2 Aug 2018 17:29:31 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PoC] coccinelle: make Coccinelle-related make targets more
 fine-grained
Message-ID: <20180802212930.GB32538@sigill.intra.peff.net>
References: <20180723135100.24288-1-szeder.dev@gmail.com>
 <20180802115522.16107-1-szeder.dev@gmail.com>
 <20180802180155.GD15984@sigill.intra.peff.net>
 <CAPig+cQSg=MBB7zp5bx5Z6tep89FaqNfTXV0tATRRG3WAPn2MQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cQSg=MBB7zp5bx5Z6tep89FaqNfTXV0tATRRG3WAPn2MQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 02, 2018 at 03:46:08PM -0400, Eric Sunshine wrote:

> On Thu, Aug 2, 2018 at 2:02 PM Jeff King <peff@peff.net> wrote:
> > On Thu, Aug 02, 2018 at 01:55:22PM +0200, SZEDER Gábor wrote:
> > >     This approach uses $(eval), which we haven't used in any of our
> > >     Makefiles yet.  I wonder whether it's portable enough.  And it's
> > >     ugly and complicated.
> >
> > I looked into this a long time ago for another set of Makefile patches I
> > was considering. $(eval) was added to GNU make in 3.80, released in
> > 2002. Which is probably fine by now.
> 
> For the record, MacOS developer tools are stuck at GNU make 3.81 (from 2006).

Thanks, that's interesting to know. Fortunately from my past research
that means that it should have both $(eval) and $(call).

If we follow my suggestions here, we don't need to care for now, but I
won't be surprised if it comes up again at some point.

-Peff
