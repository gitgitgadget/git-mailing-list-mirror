Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCC8D207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 17:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423518AbcIZRVV (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 13:21:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:48172 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423371AbcIZRVP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 13:21:15 -0400
Received: (qmail 5162 invoked by uid 109); 26 Sep 2016 17:21:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 26 Sep 2016 17:21:14 +0000
Received: (qmail 6397 invoked by uid 111); 26 Sep 2016 17:21:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 26 Sep 2016 13:21:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Sep 2016 13:21:12 -0400
Date:   Mon, 26 Sep 2016 13:21:12 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 01/10] get_sha1: detect buggy calls with multiple
 disambiguators
Message-ID: <20160926172111.sve6tsse2figcved@sigill.intra.peff.net>
References: <20160926115720.p2yb22lcq37gboon@sigill.intra.peff.net>
 <20160926115901.txmbr4e6xzwyfpmo@sigill.intra.peff.net>
 <xmqqbmzavcqx.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbmzavcqx.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 26, 2016 at 09:37:10AM -0700, Junio C Hamano wrote:

> > We can do the check easily with some bit-twiddling, and as a
> > bonus, the bit-mask of disambiguators will come in handy in
> > a future patch.
> >
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> 
> Other than your reinvention of HAS_MULTI_BITS(), which has been with
> us since db7244bd ("parse-options new features.", 2007-11-07), this
> looks like a reasonable thing to do.

Heh, I _thought_ we had something like that but couldn't find it. I
grepped for "[^&]& .*-", which does match it, but stupidly did it only
in '*.c'. Definitely it should use the existing macro instead.

-Peff
