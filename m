Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24D9220357
	for <e@80x24.org>; Mon, 10 Jul 2017 16:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754540AbdGJQEf (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 12:04:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:35648 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754534AbdGJQEe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 12:04:34 -0400
Received: (qmail 23974 invoked by uid 109); 10 Jul 2017 16:04:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 10 Jul 2017 16:04:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6609 invoked by uid 111); 10 Jul 2017 16:04:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 10 Jul 2017 12:04:46 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Jul 2017 12:04:32 -0400
Date:   Mon, 10 Jul 2017 12:04:32 -0400
From:   Jeff King <peff@peff.net>
To:     Ben Peart <peartben@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] strbuf: use designated initializers in STRBUF_INIT
Message-ID: <20170710160432.4mmcoqh7yi5cqdhy@sigill.intra.peff.net>
References: <20170710070342.txmlwwq6gvjkwtw7@sigill.intra.peff.net>
 <4d4f2af7-60b9-5866-50bc-ecf002f74cba@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4d4f2af7-60b9-5866-50bc-ecf002f74cba@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 10, 2017 at 10:57:57AM -0400, Ben Peart wrote:

> > If this patch can survive a few releases without complaint,
> > then we can feel more confident that designated initializers
> > are widely supported by our user base.  It also is an
> > indication that other C99 features may be supported, but not
> > a guarantee (e.g., gcc had designated initializers before
> > C99 existed).
> 
> Correct.  MSVC also supports designated initializers but does not fully
> support C99.

Out of curiosity, does MSVC define __STDC_VERSION__, and if so, to what?

> > And obviously before releasing this or anything similar, it would be
> > nice to see results from people building pu. I'm especially curious
> > whether MSVC would work with this (or if people even still use it, since
> > Git for Windows is pretty mature?).
> 
> We do use MSVC internally as that gives us access to the great debuggers and
> profilers on the Windows platform.  Fortunately, this particular C99
> construct _is_ supported by MSVC.  I applied the patch below and complied it
> with both MSVC and gcc for Windows and both builds succeeded.

Thanks. This kind of prompt testing and response is very appreciated. It
is unfortunate if we have to pick and choose C99-isms rather than using
the whole thing as a base. But that's probably just reality.

-Peff
