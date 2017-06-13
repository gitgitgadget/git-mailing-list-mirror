Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC81420282
	for <e@80x24.org>; Tue, 13 Jun 2017 11:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752294AbdFMLm6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 07:42:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:39013 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752033AbdFMLm5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 07:42:57 -0400
Received: (qmail 30522 invoked by uid 109); 13 Jun 2017 11:42:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Jun 2017 11:42:56 +0000
Received: (qmail 23749 invoked by uid 111); 13 Jun 2017 11:42:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Jun 2017 07:42:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Jun 2017 07:42:54 -0400
Date:   Tue, 13 Jun 2017 07:42:54 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 7/8] alias_lookup(): optionally return top-level
 directory
Message-ID: <20170613114254.oo6r6oqwtchvjuim@sigill.intra.peff.net>
References: <cover.1496951503.git.johannes.schindelin@gmx.de>
 <aa6601bbfa50c728b7820e0a2991da76288509a5.1496951503.git.johannes.schindelin@gmx.de>
 <20170610101813.n26wmxcueicecptz@sigill.intra.peff.net>
 <alpine.DEB.2.21.1.1706131319130.171564@virtualbox>
 <alpine.DEB.2.21.1.1706131339320.171564@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1706131339320.171564@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 13, 2017 at 01:42:02PM +0200, Johannes Schindelin wrote:

> > As you probably guessed, I had tried that first and then figured that if
> > I needed to keep the config_key_is_valid() test anyway, I could just as
> > well keep the strbuf around for later use.
> > 
> > Will change the code,
> 
> Alas, I won't change the code after all.
> 
> It is really tempting to avoid the extra strbuf, but then the error
> message would change from
> 
> 	error: missing value for 'alias.br'
> 
> to
> 
> 	error: missing value for 'br'
> 
> which is of course no good at all.
> 
> And since I already have to keep that strbuf, I'll simply keep the
> config_key_is_valid() guard, too (because why not).

Oof, yeah, that is definitely worse. I'm fine with keeping both parts.

-Peff
