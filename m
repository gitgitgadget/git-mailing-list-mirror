Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0293420FD0
	for <e@80x24.org>; Thu, 30 Jun 2016 06:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751565AbcF3Gd0 (ORCPT <rfc822;e@80x24.org>);
	Thu, 30 Jun 2016 02:33:26 -0400
Received: from cloud.peff.net ([50.56.180.127]:38166 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751034AbcF3GdZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2016 02:33:25 -0400
Received: (qmail 23177 invoked by uid 102); 30 Jun 2016 06:26:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Jun 2016 02:26:45 -0400
Received: (qmail 5809 invoked by uid 107); 30 Jun 2016 06:26:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Jun 2016 02:26:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Jun 2016 02:26:39 -0400
Date:	Thu, 30 Jun 2016 02:26:39 -0400
From:	Jeff King <peff@peff.net>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: preview: What's cooking in git.git (Jun 2016, #10; Tue, 28)
Message-ID: <20160630062638.GB15380@sigill.intra.peff.net>
References: <xmqq4m8c7uo6.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1606291345440.12947@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1606291345440.12947@virtualbox>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jun 29, 2016 at 01:47:31PM +0200, Johannes Schindelin wrote:

> On Tue, 28 Jun 2016, Junio C Hamano wrote:
> 
> > * jk/ansi-color (2016-06-23) 7 commits
> >   (merged to 'next' on 2016-06-28 at 354989c)
> >  + color: support strike-through attribute
> >  + color: support "italic" attribute
> >  + color: allow "no-" for negating attributes
> >  + color: refactor parse_attr
> >  + add skip_prefix_mem helper
> >  + doc: refactor description of color format
> >  + color: fix max-size comment
> > 
> >  The output coloring scheme learned two new attributes, italic and
> >  strike, in addition to existing bold, reverse, etc.
> > 
> >  Will merge to 'master'.
> 
> Please note that those "colors" do not work on Windows, at least as far as
> I know, I only skimmed the code in set_attr():
> 
> 	https://github.com/git/git/blob/v2.9.0/compat/winansi.c#L175-L314
> 
> ... and it looks as if italic is plainly unsupported, and strike-through
> is not handled.

I suspect winansi doesn't handle 256-color or 24-bit color modes either,
and those are also not supported on all terminals. All of the color
output is subject to the user's terminal supporting it.  It might be
that we should make a more clear disclaimer in the documentation.

-Peff
