Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3D411F744
	for <e@80x24.org>; Tue, 12 Jul 2016 00:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320AbcGLAQa (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 20:16:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:43180 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932088AbcGLAQa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2016 20:16:30 -0400
Received: (qmail 31796 invoked by uid 102); 12 Jul 2016 00:16:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 11 Jul 2016 20:16:30 -0400
Received: (qmail 3344 invoked by uid 107); 12 Jul 2016 00:16:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 11 Jul 2016 20:16:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Jul 2016 20:16:26 -0400
Date:	Mon, 11 Jul 2016 20:16:26 -0400
From:	Jeff King <peff@peff.net>
To:	Theodore Ts'o <tytso@mit.edu>
Cc:	Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 4/5] date: document and test "raw-local" mode
Message-ID: <20160712001626.GC26163@sigill.intra.peff.net>
References: <20160711050201.GA18031@sigill.intra.peff.net>
 <20160711050617.GD32514@sigill.intra.peff.net>
 <20160711165000.GD3890@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160711165000.GD3890@thunk.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jul 11, 2016 at 12:50:00PM -0400, Theodore Ts'o wrote:

> On Mon, Jul 11, 2016 at 01:06:17AM -0400, Jeff King wrote:
> > 
> > The documentation claims that "raw-local" does not work. It
> > does, but the end result is rather subtle. Let's describe it
> > in better detail, and test to make sure it works (namely,
> > the epoch time doesn't change, but the zone does).
> 
> Maybe add an editorial statement that in most cases this isn't
> particularly useful?  Documenting raw-local implies that someone might
> want to consider using it, and it's not clear to me folks should ever
> try --- they're more likely to confuse themselves more than anything
> else.

I waffled on making such a statement. I agree it's unlikely to be that
useful in practice. The most plausible scenario I could come up with is
a program or script that asks for "--date=raw" because it's going to
format the date later. Somebody using that program may prefer their
local timestamps. Normally you'd just say "--date=iso-local" or whatever
format you prefer, but because this is transiting through the other
program which only understands --date=raw, you have to keep using that
format.

I hoped that the explanation I added would prevent confusion, or at
least be an improvement over the existing documentation of "doesn't
work".

-Peff
