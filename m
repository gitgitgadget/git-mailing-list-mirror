Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C295E1F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 23:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755127AbcHCXE0 (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 19:04:26 -0400
Received: from cloud.peff.net ([50.56.180.127]:54431 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751183AbcHCXE0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 19:04:26 -0400
Received: (qmail 23007 invoked by uid 102); 3 Aug 2016 23:04:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Aug 2016 19:04:26 -0400
Received: (qmail 8103 invoked by uid 107); 3 Aug 2016 23:04:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Aug 2016 19:04:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Aug 2016 19:04:23 -0400
Date:	Wed, 3 Aug 2016 19:04:23 -0400
From:	Jeff King <peff@peff.net>
To:	larsxschneider@gmail.com
Cc:	git@vger.kernel.org
Subject: Re: [PATCH 0/7] minor trace fixes and cosmetic improvements
Message-ID: <20160803230422.vec7mhjo6jfzbpap@sigill.intra.peff.net>
References: <20160729233801.82844-1-larsxschneider@gmail.com>
 <20160803164225.46355-1-larsxschneider@gmail.com>
 <20160803164225.46355-4-larsxschneider@gmail.com>
 <20160803213920.jg3eshy57bsldqjh@sigill.intra.peff.net>
 <20160803225600.fgm23bdacunmrw44@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160803225600.fgm23bdacunmrw44@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 03, 2016 at 06:56:00PM -0400, Jeff King wrote:

> On Wed, Aug 03, 2016 at 05:39:20PM -0400, Jeff King wrote:
> 
> > Thinking about (2), I'd go so far as to say that the trace actually
> > should just be using:
> > 
> >   if (write_in_full(...) < 0)
> > 	warning("unable to write trace to ...: %s", strerror(errno));
> > 
> > and we should get rid of write_or_whine_pipe entirely.
> 
> I started to write a patch to do that, but it turns out the trace code
> is full of bugs (and opportunities for cosmetic improvements).
> 
> Here's what I came up with.
> 
>   [1/7]: trace: handle NULL argument in trace_disable()
>   [2/7]: trace: stop using write_or_whine_pipe()
>   [3/7]: trace: use warning() for printing trace errors
>   [4/7]: trace: cosmetic fixes for error messages
>   [5/7]: trace: correct variable name in write() error message
>   [6/7]: trace: disable key after write error
>   [7/7]: write_or_die: drop write_or_whine_pipe()

Oops, I meant to detach this from the parent thread, but apparently I am
incompetent at editing email headers.

This really is totally orthogonal to your series (except that you should
obviously not use write_or_whine_pipe(), but that is the case whether I
rip it out or not :) ).

-Peff
