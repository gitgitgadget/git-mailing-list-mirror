Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44DD62018E
	for <e@80x24.org>; Fri,  5 Aug 2016 09:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759563AbcHEJfv (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 05:35:51 -0400
Received: from cloud.peff.net ([50.56.180.127]:55240 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759483AbcHEJfs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 05:35:48 -0400
Received: (qmail 14591 invoked by uid 102); 5 Aug 2016 09:35:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 05 Aug 2016 05:35:49 -0400
Received: (qmail 25085 invoked by uid 107); 5 Aug 2016 09:36:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 05 Aug 2016 05:36:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Aug 2016 05:35:44 -0400
Date:	Fri, 5 Aug 2016 05:35:44 -0400
From:	Jeff King <peff@peff.net>
To:	Eric Wong <e@80x24.org>
Cc:	git@vger.kernel.org
Subject: Re: [ANNOUNCE] more archives of this list
Message-ID: <20160805093544.scvl4yshkfg2l26p@sigill.intra.peff.net>
References: <20160710004813.GA20210@dcvr.yhbt.net>
 <20160805092805.w3nwv2l6jkbuwlzf@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160805092805.w3nwv2l6jkbuwlzf@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Aug 05, 2016 at 05:28:05AM -0400, Jeff King wrote:

> On Sun, Jul 10, 2016 at 12:48:13AM +0000, Eric Wong wrote:
> 
> > Very much a work-in-progress, but NNTP and HTTP/HTTPS sorta work
> > based on stuff that is on gmane and stuff I'm accumulating by
> > being a subscriber.
> 
> I checked this out when you posted it, and have been using it the past
> few weeks. I really like it. I find the URL structure much easier to
> navigate than gmane.
> 
> I do find it visually a little harder to navigate through threads,
> because there's not much styling there, and the messages seem to run
> into one another. I don't know if a border around the divs or something
> would help. I'm really terrible at that kind of visual design.

I took a peek at doing something simple like:

  pre {
    border-style: solid;
    border-width: 1px;
    background: #dddddd;
  }

but it looks like there's no HTML structure at all to the current
output. It's just one big <pre> tag with various levels of indentation
to represent the messages.

So I guess a potential first step would be actually representing a
thread as:

  <div class="message">
    parent message...
    <div class="message">
      reply...
    </div>
  </div>

and so on.

-Peff
