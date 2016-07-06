Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2853B20705
	for <e@80x24.org>; Wed,  6 Jul 2016 10:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753238AbcGFKsI (ORCPT <rfc822;e@80x24.org>);
	Wed, 6 Jul 2016 06:48:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:40831 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751007AbcGFKsG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2016 06:48:06 -0400
Received: (qmail 17802 invoked by uid 102); 6 Jul 2016 10:48:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 06 Jul 2016 06:48:05 -0400
Received: (qmail 22120 invoked by uid 107); 6 Jul 2016 10:48:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 06 Jul 2016 06:48:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Jul 2016 06:48:00 -0400
Date:	Wed, 6 Jul 2016 06:48:00 -0400
From:	Jeff King <peff@peff.net>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] revert: clarify seemingly bogus OPT_END repetition
Message-ID: <20160706104800.GA28798@sigill.intra.peff.net>
References: <5b424bad41ca027b39eea4b1fa9d87df0a489e0f.1467719888.git.johannes.schindelin@gmx.de>
 <20160705202820.GA14496@sigill.intra.peff.net>
 <alpine.DEB.2.20.1607060901430.6426@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1607060901430.6426@virtualbox>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 06, 2016 at 09:03:44AM +0200, Johannes Schindelin wrote:

> > By the way, I notice that the error message when concat fails is just:
> > 
> >   if (parse_options_concat(options, ARRAY_SIZE(options), cp_extra))
> > 	die(_("program error"));
> > 
> > Should this become:
> > 
> >         die("BUG: not enough room to concatenate options");
> > 
> > as part of your BUG cleanups elsewhere?
> 
> Not really. I do not have time for a crusade through all of the die()
> statements to determine whether they're really bug reports. You refer to
> my clean-up of merge-recursive.c, right? That was a necessary prerequisite
> for the patch to stop die()ing in case of errors.

Yeah. I didn't look at it all that closely, but it looked like you hit
places outside of merge-recursive, too. I agree it is not worth
including unless you are crusading, though (and anyway, my patch gets
rid of the message entirely).

-Peff
