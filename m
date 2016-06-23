Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD35D1FF40
	for <e@80x24.org>; Thu, 23 Jun 2016 18:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751990AbcFWSgI (ORCPT <rfc822;e@80x24.org>);
	Thu, 23 Jun 2016 14:36:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:59245 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751564AbcFWSgG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2016 14:36:06 -0400
Received: (qmail 32581 invoked by uid 102); 23 Jun 2016 18:36:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Jun 2016 14:36:05 -0400
Received: (qmail 13491 invoked by uid 107); 23 Jun 2016 18:36:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Jun 2016 14:36:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Jun 2016 14:36:03 -0400
Date:	Thu, 23 Jun 2016 14:36:03 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org, Simon Courtois <scourtois@cubyx.fr>
Subject: Re: [PATCH v2 6/7] color: support "italic" attribute
Message-ID: <20160623183603.GA32320@sigill.intra.peff.net>
References: <20160623173048.GA19923@sigill.intra.peff.net>
 <20160623173907.GF15774@sigill.intra.peff.net>
 <xmqqtwgjiwkn.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtwgjiwkn.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jun 23, 2016 at 11:34:00AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > We already support bold, underline, and similar attributes.
> > Let's add italic to the mix.  According to the Wikipedia
> > page on ANSI colors, this attribute is "not widely
> > supported", but it does seem to work on my xterm.
> > ...
> > @@ -133,6 +133,7 @@ static int parse_attr(const char *name, size_t len)
> >  #define ATTR(x, val, neg) { (x), strlen(x), (val), (neg) }
> 
> I see this one was from an earlier reroll that did not use sizeof(x)-1;
> easy to fixup, though ;-)

Heh, whoops, yeah.

Gcc was actually happy with the `strlen` there, but I suspect that other
compilers might not be.

-Peff
