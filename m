Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BA2E1F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 14:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756897AbcHXORI (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 10:17:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:60409 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1756300AbcHXORG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 10:17:06 -0400
Received: (qmail 751 invoked by uid 109); 24 Aug 2016 14:17:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Aug 2016 14:17:05 +0000
Received: (qmail 2770 invoked by uid 111); 24 Aug 2016 14:17:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Aug 2016 10:17:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Aug 2016 10:17:02 -0400
Date:   Wed, 24 Aug 2016 10:17:02 -0400
From:   Jeff King <peff@peff.net>
To:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH v4] config: add conditional include
Message-ID: <20160824141702.rszccucv62rqrcxs@sigill.intra.peff.net>
References: <20160819135408.ckyw6ruseicvg2jt@sigill.intra.peff.net>
 <5c131421-ae7f-8a37-76ab-0fd05cbe3530@gmail.com>
 <CACsJy8C30=-LGMYQJ6MO17L8Vv1q=iQGC=R8TDhC5qM1f5Lh5A@mail.gmail.com>
 <vpqr39harit.fsf@anie.imag.fr>
 <CACsJy8BNP8GDRxDGTQwcYWTovN9o11TCkUJ28=5zav3QnGv9nQ@mail.gmail.com>
 <vpqlgzp9bw1.fsf@anie.imag.fr>
 <CACsJy8BokiiDbheN1_CqWWgK3xRn8YP30t7ojjVeDnok5_M4Ow@mail.gmail.com>
 <alpine.DEB.2.20.1608231541420.4924@virtualbox>
 <CACsJy8CY1HqSTtmPw+H1yGXV_tBPt3GVU162ZTVecXFhPTnaYA@mail.gmail.com>
 <febf6605-70e7-4653-1e3e-cddc1882e037@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <febf6605-70e7-4653-1e3e-cddc1882e037@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 24, 2016 at 02:44:29PM +0200, Jakub Narębski wrote:

> W dniu 24.08.2016 o 11:37, Duy Nguyen pisze:
> 
> > It works for me either way. So I'm going to assume we want
> > "[include-if "gitdir-is:..."]", unless people think it needs more
> > discussion (then just write something, anything, so I can put it back
> > in my backlog)
> 
> A final note: [include "if-gitdir:..."] is inclusive by default
> (I think), that is old Git would include it unconditionally,
> while [include-if "gitdir-is:..."] is exclusive by default, that
> is old Git would ignore it.
> 
> But I might be mistaken.

I don't think this is the case. Conditionals were considered when
the include feature was added, and anything except "include.path" is
explicitly ignored. So either syntax will behave the same.

-Peff
