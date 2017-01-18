Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D6EE1F89C
	for <e@80x24.org>; Wed, 18 Jan 2017 20:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752958AbdARUdi (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 15:33:38 -0500
Received: from cloud.peff.net ([104.130.231.41]:41085 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751076AbdARUdg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 15:33:36 -0500
Received: (qmail 16050 invoked by uid 109); 18 Jan 2017 20:06:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 Jan 2017 20:06:49 +0000
Received: (qmail 31032 invoked by uid 111); 18 Jan 2017 20:07:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 Jan 2017 15:07:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Jan 2017 15:06:46 -0500
Date:   Wed, 18 Jan 2017 15:06:46 -0500
From:   Jeff King <peff@peff.net>
To:     Ulrich Spoerlein <uqs@FreeBSD.org>
Cc:     git@vger.kernel.org, Ed Maste <emaste@freebsd.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: git fast-import crashing on big imports
Message-ID: <20170118200646.6larm2qu32xm73on@sigill.intra.peff.net>
References: <20170112082138.GJ4426@acme.spoerlein.net>
 <20170118140117.GK4426@acme.spoerlein.net>
 <20170118143814.or34vxxwjwnzg5jz@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170118143814.or34vxxwjwnzg5jz@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 18, 2017 at 09:38:14AM -0500, Jeff King wrote:

> On Wed, Jan 18, 2017 at 03:01:17PM +0100, Ulrich Spoerlein wrote:
> 
> > Yo Jeff, your commit 8261e1f139db3f8aa6f9fd7d98c876cbeb0f927c from Aug
> > 22nd, that changes delta_base_cache to use hashmap.h is the culprit for
> > git fast-import crashing on large imports.
> 
> I actually saw your bug report the other day and tried to download the
> dump file, but got a 404. Can you double check that it is available?

The URL in your original mail was bogus:

> > I have a dump file that you can grab at
> > http://scan.spoerlein.net/pub/freebsd-base.dump.xz (19G, 55G uncompressed)

Via guess-and-check, I found:

  http://www.spoerlein.net/pub/freebsd-base.git.fi.xz

I'll see if I can reproduce the problem.

-Peff
