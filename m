Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A0391F454
	for <e@80x24.org>; Fri,  8 Nov 2019 22:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbfKHWUt (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Nov 2019 17:20:49 -0500
Received: from cloud.peff.net ([104.130.231.41]:43346 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727672AbfKHWUt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Nov 2019 17:20:49 -0500
Received: (qmail 23312 invoked by uid 109); 8 Nov 2019 22:20:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Nov 2019 22:20:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15607 invoked by uid 111); 8 Nov 2019 22:24:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 08 Nov 2019 17:24:13 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 8 Nov 2019 17:20:48 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] utf8: use skip_iprefix() in same_utf_encoding()
Message-ID: <20191108222048.GA18554@sigill.intra.peff.net>
References: <b27cc95d-8cb8-db49-c2d1-3eb591624000@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b27cc95d-8cb8-db49-c2d1-3eb591624000@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 08, 2019 at 09:25:21PM +0100, René Scharfe wrote:

> Get rid of magic numbers by using skip_iprefix() and skip_prefix() for
> parsing the leading "[uU][tT][fF]-?" of both strings instead of checking
> with istarts_with() and an explicit comparison.

Yeah, I think the result is much easier to understand. I didn't look
closely at it, but the generated asm seems to be slightly shorter, too.

-Peff
