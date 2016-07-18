Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B0B22018B
	for <e@80x24.org>; Mon, 18 Jul 2016 13:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbcGRNQ7 (ORCPT <rfc822;e@80x24.org>);
	Mon, 18 Jul 2016 09:16:59 -0400
Received: from cloud.peff.net ([50.56.180.127]:46386 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751370AbcGRNQ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2016 09:16:58 -0400
Received: (qmail 12507 invoked by uid 102); 18 Jul 2016 13:16:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 18 Jul 2016 09:16:57 -0400
Received: (qmail 3642 invoked by uid 107); 18 Jul 2016 13:17:19 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 18 Jul 2016 09:17:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Jul 2016 07:16:53 -0600
Date:	Mon, 18 Jul 2016 07:16:53 -0600
From:	Jeff King <peff@peff.net>
To:	Eric Wong <e@80x24.org>
Cc:	norm@dad.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	l.s.r@web.de, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pager: disable color when pager is "more"
Message-ID: <20160718131653.GC19751@sigill.intra.peff.net>
References: <201607171726.u6HHQShO005227@shell1.rawbw.com>
 <alpine.DEB.2.20.1607180922580.28832@virtualbox>
 <20160718091907.GA13588@starla>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160718091907.GA13588@starla>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jul 18, 2016 at 09:19:07AM +0000, Eric Wong wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > On Sun, 17 Jul 2016, norm@dad.org wrote:
> > > 'git diff' outputs escape characters which clutter my terminal. Yes, I
> > > can sed them out, but then why are they there?
> > 
> > Those are most likely the ANSI sequences to add color. Can you call Git
> > with the --no-color option and see whether the escape characters go away?
> 
> Norm: do you have PAGER=more set by any chance?
> Perhaps changing it to "less" will allow you to preserve colors.
> 
> I saw a similar or identical problem during my vacation in
> FreeBSD-land.  Perhaps the out-of-the-box experience can be
> improved:
> 
> -----8<-----
> Subject: [PATCH] pager: disable color when pager is "more"

This is the tip of a smaller iceberg. See

  http://public-inbox.org/git/52D87A79.6060600%40rawbw.com/t/#u

for more discussion, and some patches that fix more cases (like "LESS"
without "R", or "more" that _does_ understand "R"). I think it was
discarded as being a little too intimate with the details of pagers, but
it does suck that the out-of-the-box experience on FreeBSD is not good.
Maybe we should revisit it.

-Peff
