Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06B161FD99
	for <e@80x24.org>; Sun,  7 Aug 2016 23:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751816AbcHGXOP (ORCPT <rfc822;e@80x24.org>);
	Sun, 7 Aug 2016 19:14:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:36537 "HELO cloud.peff.net"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with SMTP
	id S1751593AbcHGXOO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Aug 2016 19:14:14 -0400
Received: (qmail 2270 invoked by uid 102); 7 Aug 2016 23:14:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 07 Aug 2016 19:14:14 -0400
Received: (qmail 24162 invoked by uid 111); 7 Aug 2016 23:14:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 07 Aug 2016 19:14:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 07 Aug 2016 19:14:11 -0400
Date:	Sun, 7 Aug 2016 19:14:11 -0400
From:	Jeff King <peff@peff.net>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] use strbuf_add_unique_abbrev() for adding short hashes
Message-ID: <20160807231410.7cwclya7yykcg2cy@sigill.intra.peff.net>
References: <57A6050D.50200@web.de>
 <alpine.DEB.2.20.1608071051540.5786@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.20.1608071051540.5786@virtualbox>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Aug 07, 2016 at 10:53:34AM +0200, Johannes Schindelin wrote:

> On Sat, 6 Aug 2016, René Scharfe wrote:
> 
> > Call strbuf_add_unique_abbrev() to add abbreviated hashes to strbufs
> > instead of taking detours through find_unique_abbrev() and its static
> > buffer.  This is shorter and a bit more efficient.
> 
> And less error-prone.
> 
> It is also a thing I need to change in my upcoming rebase--helper patches:
> I had not known about this function.

Great. I added it several months ago to avoid some hairy allocation
code, so I am glad to see it finding new uses (both this patch and
potential new ones).

-Peff
