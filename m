Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2B161F428
	for <e@80x24.org>; Sun, 12 Aug 2018 01:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbeHLDwT (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Aug 2018 23:52:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:51502 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727549AbeHLDwT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Aug 2018 23:52:19 -0400
Received: (qmail 19481 invoked by uid 109); 12 Aug 2018 01:16:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 12 Aug 2018 01:16:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30513 invoked by uid 111); 12 Aug 2018 01:16:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 11 Aug 2018 21:16:17 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 11 Aug 2018 21:16:12 -0400
Date:   Sat, 11 Aug 2018 21:16:12 -0400
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: function get_delta_base() is a file-local symbol
Message-ID: <20180812011612.GA10782@sigill.intra.peff.net>
References: <b5b25177-38de-14ba-5d83-c8909ce0addd@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b5b25177-38de-14ba-5d83-c8909ce0addd@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 12, 2018 at 01:30:02AM +0100, Ramsay Jones wrote:

> Hi Christian,
> 
> My static-check.pl script has pinged me about the get_delta_base()
> symbol from packfile.[co]. The first patch from your 'cc/delta-islands'
> branch exports this symbol, saying that it will soon be called from
> outside packfile.c. As far as I can tell, no other patch in that series
> adds any such call.
> 
> Do you have plans to extend that series with additional patches which
> will add such calls?

Hmm, I think this is just my error. I had to untangle the delta island
code from a few other topics, and I think I mistakenly attributed the
need for get_delta_base() to the wrong topic. It can just be left alone
for this series.

-Peff
