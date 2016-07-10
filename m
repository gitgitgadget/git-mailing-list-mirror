Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3D132018F
	for <e@80x24.org>; Sun, 10 Jul 2016 04:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbcGJEpd (ORCPT <rfc822;e@80x24.org>);
	Sun, 10 Jul 2016 00:45:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:42460 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750740AbcGJEpd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jul 2016 00:45:33 -0400
Received: (qmail 17155 invoked by uid 102); 10 Jul 2016 04:45:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 10 Jul 2016 00:45:34 -0400
Received: (qmail 23458 invoked by uid 107); 10 Jul 2016 04:45:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 10 Jul 2016 00:45:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 10 Jul 2016 00:45:29 -0400
Date:	Sun, 10 Jul 2016 00:45:29 -0400
From:	Jeff King <peff@peff.net>
To:	Eric Wong <e@80x24.org>
Cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2016, #03; Fri, 8)
Message-ID: <20160710044529.GA10777@sigill.intra.peff.net>
References: <xmqq37njlora.fsf@gitster.mtv.corp.google.com>
 <20160709234518.GA3702@dcvr.yhbt.net>
 <20160710025232.GA4666@sigill.intra.peff.net>
 <20160710034736.GA19151@dcvr.yhbt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160710034736.GA19151@dcvr.yhbt.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Jul 10, 2016 at 03:47:36AM +0000, Eric Wong wrote:

> > There was one minor improvement I suggested[1] (and which you seemed to
> > like), which is to push the errno check into the function. That wasn't
> > expressed in patch form, though, so I've included below a version of
> > your patch with my suggestion squashed in.
> 
> Yes, I'm fine with either, but I'm slightly thrown off by
> a function relying on errno being set by the caller, even if it
> is errno.  So maybe localizing it is better (see below)

Yeah, I had a similar reservation, but didn't want to clutter the
interface. However, just passing errno isn't too bad (as you showed
below), and is much less magical.

Do you want to squash that and re-send the whole patch to make Junio's
life easier?

> > Since both conditionals just call "continue", you could actually fold
> > them into a single if() in each caller, but I think it's easier to
> > follow as two separate ones.
> > 
> > You could actually fold the t
> 
> Copy-paste error?

Nope, just typing error while revising. :)

-Peff
