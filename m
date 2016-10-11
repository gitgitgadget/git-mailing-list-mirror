Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EA581F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 15:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753083AbcJKPID (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 11:08:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:55794 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752516AbcJKPIC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 11:08:02 -0400
Received: (qmail 18422 invoked by uid 109); 11 Oct 2016 15:01:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Oct 2016 15:01:20 +0000
Received: (qmail 8963 invoked by uid 111); 11 Oct 2016 15:01:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Oct 2016 11:01:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Oct 2016 11:01:19 -0400
Date:   Tue, 11 Oct 2016 11:01:19 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Duy Nguyen <pclouds@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH/RFC] git.c: support "!!" aliases that do not move cwd
Message-ID: <20161011150118.7eb474yg5c3oe5mn@sigill.intra.peff.net>
References: <xmqq60p5l3om.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1610071319520.35196@virtualbox>
 <CACsJy8ASc7Fxm5XDHFiX9E+bQ8s1MtmEHfc7bZY4C-_GEQr0og@mail.gmail.com>
 <0347de20-72a7-b384-389f-4b2ad5789973@kdbg.org>
 <20161007175052.sxyk7y2ytjh36phr@sigill.intra.peff.net>
 <alpine.DEB.2.20.1610081034430.35196@virtualbox>
 <20161009060149.voqjoiltqi6jub7g@sigill.intra.peff.net>
 <CACsJy8BpYYJmBm32YsQyuP58uhLE+sn8WdhiHyY6xzcqPVjMVQ@mail.gmail.com>
 <20161009205854.byq2wqgemtmwudfb@sigill.intra.peff.net>
 <alpine.DEB.2.20.1610111142490.35196@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1610111142490.35196@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 11, 2016 at 11:44:50AM +0200, Johannes Schindelin wrote:

> > Yeah, that's reasonable, too. So:
> > 
> >   [alias]
> >     d2u = "!dos2unix"
> > 
> > acts exactly as if:
> > 
> >   [alias "d2u"]
> >     command = dos2unix
> >     type = shell
> > 
> > was specified at that point, which is easy to understand.
> 
> It is easy to understand, and even easier to get wrong or out of sync. I
> really liked the ease of *one* `git config` call to add new aliases. Not
> sure that I like the need for more such calls just to add *one* alias (one
> config call for "shell", one for "don't cd up", etc).

Could we simply support alias.d2u indefinitely, and you could use
whichever format you felt like (the shorter, more limited one if you
wanted, or the more verbose but flexible one)?

-Peff
