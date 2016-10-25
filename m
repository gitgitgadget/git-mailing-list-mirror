Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E12612035F
	for <e@80x24.org>; Tue, 25 Oct 2016 13:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934152AbcJYM77 (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Oct 2016 08:59:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:33886 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754077AbcJYM75 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2016 08:59:57 -0400
Received: (qmail 25673 invoked by uid 109); 25 Oct 2016 12:58:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 25 Oct 2016 12:58:58 +0000
Received: (qmail 32492 invoked by uid 111); 25 Oct 2016 12:59:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 25 Oct 2016 08:59:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Oct 2016 08:58:56 -0400
Date:   Tue, 25 Oct 2016 08:58:56 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Tom Hale <tom@hale.ee>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: %C(auto) not working as expected
Message-ID: <20161025125856.p2paxt7erl2szptv@sigill.intra.peff.net>
References: <cb81631e-9623-9020-f955-ec215b493a50@hale.ee>
 <f35965e9-2901-b9b5-92e5-9bc7fe673637@web.de>
 <65d8def3-df62-6c45-7d8f-79b6a8769bf5@hale.ee>
 <25c17e16-2456-7da3-ae22-2dc812a3aa0d@web.de>
 <20161009234617.y6xfjyv6xjkf2afi@sigill.intra.peff.net>
 <CACsJy8CroyynVMctbPhuVr2VVQB7YyfcxDaMT25BikQ4R4We0Q@mail.gmail.com>
 <20161010142818.lglwrxpks6l6aqrm@sigill.intra.peff.net>
 <CACsJy8B_AQxm1=vF8i4FPtinq0id1QZPrqp9vvAmAgUns_kgGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8B_AQxm1=vF8i4FPtinq0id1QZPrqp9vvAmAgUns_kgGg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 25, 2016 at 07:52:21PM +0700, Duy Nguyen wrote:

> > Yeah, adding a "%C(enable-auto-color)" or something would be backwards
> > compatible and less painful than using "%C(auto)" everywhere. I do
> > wonder if anybody actually _wants_ the "always show color, even if
> > --no-color" behavior. I'm having trouble thinking of a good use for it.
> >
> > IOW, I'm wondering if anyone would disagree that the current behavior is
> > simply buggy.
> 
> Silence in two weeks. I vote (*) making %(<color-name>) honor --color
> and turning the %(auto, no-op, for both log family and for-each-ref.
> We could keep old behavior behind some environment variable if it's
> not much work so it keeps working while people come here and tell us
> about their use cases.

Yeah, sorry. I was blocked on making %(color:) in ref-filter work, which
required a bunch of refactoring in ref-filter, which conflicted heavily
with the kn/ref-filter-branch-list (which wants to do a lot of the same
things), and then I got blocked on reviewing that series (which overall
looks pretty sane, but I wanted to really dig in because I think it
hasn't gotten very careful review, or at least not recently).

So I'm still hoping to shave that yak at some point. Maybe this week.

-Peff
