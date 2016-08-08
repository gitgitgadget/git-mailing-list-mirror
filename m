Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 776C92018E
	for <e@80x24.org>; Mon,  8 Aug 2016 13:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752140AbcHHNvt (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 09:51:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:51132 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752077AbcHHNvs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 09:51:48 -0400
Received: (qmail 5664 invoked by uid 109); 8 Aug 2016 13:51:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Aug 2016 13:51:47 +0000
Received: (qmail 5055 invoked by uid 111); 8 Aug 2016 13:51:46 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Aug 2016 09:51:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Aug 2016 09:51:45 -0400
Date:	Mon, 8 Aug 2016 09:51:45 -0400
From:	Jeff King <peff@peff.net>
To:	Kirill Smelkov <kirr@nexedi.com>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Vicent Marti <tanoku@gmail.com>,
	=?utf-8?Q?J=C3=A9rome?= Perrin <jerome@nexedi.com>,
	Isabelle Vallet <isabelle.vallet@nexedi.com>,
	Kazuhiko Shiozaki <kazuhiko@nexedi.com>,
	Julien Muchembled <jm@nexedi.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] pack-objects: Teach --use-bitmap-index codepath to
 respect --local, --honor-pack-keep and --incremental
Message-ID: <20160808135145.7tsigbmbsoar372y@sigill.intra.peff.net>
References: <20160729074051.GA5987@teco.navytux.spb.ru>
 <20160729074656.23813-1-kirr@nexedi.com>
 <xmqqy44gjqv9.fsf@gitster.mtv.corp.google.com>
 <20160808123734.GA3995@teco.navytux.spb.ru>
 <20160808135020.yggthtfekdiwq3lz@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160808135020.yggthtfekdiwq3lz@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 08, 2016 at 09:50:20AM -0400, Jeff King wrote:

> > +	git pack-objects --local --stdout --revs >1.pack &&
> > +	git index-pack 1.pack &&
> 
> I'd have expected you to use the non-stdout version here. Is this meant
> to be independent of your other patch (I think that's OK).

Oh, nevermind, I forgot this was meant to be a preparatory patch. So it
makes sense to use --stdout in the tests.

-Peff
