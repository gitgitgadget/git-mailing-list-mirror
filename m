Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 663221F955
	for <e@80x24.org>; Mon,  1 Aug 2016 17:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754485AbcHARQQ (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 13:16:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:52564 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754482AbcHARQO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 13:16:14 -0400
Received: (qmail 5872 invoked by uid 102); 1 Aug 2016 16:49:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Aug 2016 12:49:32 -0400
Received: (qmail 14595 invoked by uid 107); 1 Aug 2016 16:49:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Aug 2016 12:49:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Aug 2016 12:49:29 -0400
Date:	Mon, 1 Aug 2016 12:49:29 -0400
From:	Jeff King <peff@peff.net>
To:	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:	Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] use strbuf_addstr() for adding constant strings to a
 strbuf
Message-ID: <20160801164929.ezalmutcrc3erc22@sigill.intra.peff.net>
References: <579CE597.4060009@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <579CE597.4060009@web.de>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Jul 30, 2016 at 07:36:23PM +0200, René Scharfe wrote:

> Replace uses of strbuf_addf() for adding strings with more lightweight
> strbuf_addstr() calls.
> 
> In http-push.c it becomes easier to see what's going on without having
> to verfiy that the definition of PROPFIND_ALL_REQUEST doesn't contain
> any format specifiers.

Nice. I care a lot less about whether "addf" or "addstr" is more
efficient. But the second point, that it makes the intent clearer, is a
big win.

-Peff
