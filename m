Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D3091F70F
	for <e@80x24.org>; Thu, 26 Jan 2017 14:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752758AbdAZOfi (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 09:35:38 -0500
Received: from cloud.peff.net ([104.130.231.41]:45329 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752581AbdAZOfh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 09:35:37 -0500
Received: (qmail 5009 invoked by uid 109); 26 Jan 2017 14:35:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 Jan 2017 14:35:36 +0000
Received: (qmail 23426 invoked by uid 111); 26 Jan 2017 14:35:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 Jan 2017 09:35:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Jan 2017 09:35:34 -0500
Date:   Thu, 26 Jan 2017 09:35:34 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: Fixing the warning about warning(""); was: Re: [PATCH]
 difftool.c: mark a file-local symbol with static
Message-ID: <20170126143534.mekszrwxnytadwyo@sigill.intra.peff.net>
References: <20170122052608.tpr5pihfgafhoynj@gmail.com>
 <20170124142346.u3d7l6772mtkgpcf@sigill.intra.peff.net>
 <xmqqlgu0ceia.fsf@gitster.mtv.corp.google.com>
 <20170124230500.h3fasbvutjkkke5h@sigill.intra.peff.net>
 <alpine.DEB.2.20.1701251135090.3469@virtualbox>
 <20170125183542.pe5qolexqqx6jhsi@sigill.intra.peff.net>
 <xmqq7f5iakxw.fsf@gitster.mtv.corp.google.com>
 <20170125220101.et67ebkumsqosaku@sigill.intra.peff.net>
 <546179e0-1d6e-86f7-00cf-e13218b76de1@kdbg.org>
 <alpine.DEB.2.20.1701261226220.3469@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1701261226220.3469@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 26, 2017 at 12:37:46PM +0100, Johannes Schindelin wrote:

> > Am 25.01.2017 um 23:01 schrieb Jeff King:
> > > +#pragma GCC diagnostic ignored "-Wformat-zero-length"
> > 
> > Last time I used #pragma GCC in a cross-platform project, it triggered
> > an "unknown pragma" warning for MSVC.
> 
> It is starting to become a little funny how many ways we can discuss the
> resolution of the GCC compiler warning.
> 
> And it starts to show: we try to solve the thing in so many ways, just to
> avoid the obviously most-trivial patch to change warning(""); to
> warning("%s", "") (the change to warning(" "); would change behavior, but
> I would be fine with that, too).

The point is that the trivial patch fixes _this_ case, but does not
prevent the discussion from happening again later. They are two separate
problems. I am OK not solving the latter one and relying on review (as
I've already said), but the solutions do not do the same thing.

-Peff
