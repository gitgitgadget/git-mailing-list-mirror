Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D802D202A5
	for <e@80x24.org>; Mon, 25 Sep 2017 17:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934160AbdIYRAP (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 13:00:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:49350 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S934032AbdIYRAP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 13:00:15 -0400
Received: (qmail 24596 invoked by uid 109); 25 Sep 2017 17:00:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 25 Sep 2017 17:00:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26755 invoked by uid 111); 25 Sep 2017 17:00:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 25 Sep 2017 13:00:53 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Sep 2017 13:00:13 -0400
Date:   Mon, 25 Sep 2017 13:00:13 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] git: add --no-optional-locks option
Message-ID: <20170925170012.ik7lk35hhsp66tvh@sigill.intra.peff.net>
References: <20170921043214.pyhdsrpy4omy54rm@sigill.intra.peff.net>
 <alpine.DEB.2.21.1.1709251808350.40514@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1709251808350.40514@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 25, 2017 at 06:10:12PM +0200, Johannes Schindelin wrote:

> On Thu, 21 Sep 2017, Jeff King wrote:
> 
> > Johannes, this is an adaptation of your 67e5ce7f63 (status: offer *not*
> > to lock the index and update it, 2016-08-12). Folks working on GitHub
> > Desktop complained to me that it's only available on Windows. :)
> 
> Okay, so this is trying to help me by upstreaming a patch from Git for
> Windows?
> 
> If so: thanks!

Yes, in a round-about way. :)

> The changes, in particular the different semantics, will guarantee that I
> have to work on the consumer's side here, though, leaving me even less
> time for the Git mailing list, so I will need a lot more help with
> upstreaming patches.

I think you can get away with doing nothing for the time being. The two
patches can co-exist in the GfW codebase[1], and people using the
existing option can switch over at their leisure. Eventually you may
decide to revert 67e5ce7f63.

-Peff

[1] Modulo some trivial conflict resolution when the two are merged.
