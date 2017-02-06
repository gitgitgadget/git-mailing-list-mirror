Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E74D31FAFC
	for <e@80x24.org>; Mon,  6 Feb 2017 14:41:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753852AbdBFOlZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Feb 2017 09:41:25 -0500
Received: from cloud.peff.net ([104.130.231.41]:49742 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752900AbdBFOlY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2017 09:41:24 -0500
Received: (qmail 6447 invoked by uid 109); 6 Feb 2017 14:41:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 06 Feb 2017 14:41:23 +0000
Received: (qmail 13578 invoked by uid 111); 6 Feb 2017 14:41:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 06 Feb 2017 09:41:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Feb 2017 15:41:21 +0100
Date:   Mon, 6 Feb 2017 15:41:21 +0100
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH] p5302: create repositories for index-pack results
 explicitly
Message-ID: <20170206144121.hrptyubhtjoyohfl@sigill.intra.peff.net>
References: <251bdc20-19a7-9a6c-9f5a-c7e661810c70@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <251bdc20-19a7-9a6c-9f5a-c7e661810c70@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 05, 2017 at 12:43:29PM +0100, René Scharfe wrote:

> Before 7176a314 (index-pack: complain when --stdin is used outside of a
> repo) index-pack silently created a non-existing target directory; now
> the command refuses to work unless it's used against a valid repository.
> That causes p5302 to fail, which relies on the former behavior.  Fix it
> by setting up the destinations for its performance tests using git init.

Ah, right. Thanks for catching this.

I think p5302 was wrong to rely on the old behavior, and your patch is
the right fix.

-Peff
