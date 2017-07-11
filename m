Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C754320357
	for <e@80x24.org>; Tue, 11 Jul 2017 07:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755528AbdGKHlw (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 03:41:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:36670 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1755424AbdGKHlv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 03:41:51 -0400
Received: (qmail 28469 invoked by uid 109); 11 Jul 2017 07:41:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Jul 2017 07:41:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13729 invoked by uid 111); 11 Jul 2017 07:41:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Jul 2017 03:41:57 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Jul 2017 03:41:43 -0400
Date:   Tue, 11 Jul 2017 03:41:43 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] use DIV_ROUND_UP
Message-ID: <20170711074143.fxedaod3bmsxck2o@sigill.intra.peff.net>
References: <4d2c274a-f6cb-6ea5-304f-51a3152cc436@web.de>
 <20170710072701.cqzztww6mrqr7sli@sigill.intra.peff.net>
 <3f643932-0fe1-26b0-d2bf-a2124a74deca@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3f643932-0fe1-26b0-d2bf-a2124a74deca@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 10, 2017 at 07:08:38PM +0200, René Scharfe wrote:

> > So I think it's a true mechanical conversion, but I have to admit the
> > original is confusing. Without digging I suspect it's correct, though,
> > just because a simple bug here would mean that our ewah bitmaps totally
> > don't work. So it's probably not worth spending time on.
> 
> A few lines below there is "self->bit_size = i + 1", so the code
> calculates how many words the old and the new value are apart (or by how
> many words the bitmap needs to be extended), which becomes easier to see
> with the patch.

Yeah, I'd agree the consistent use of "i + 1" makes the end result after
your patch easier to read.

-Peff
