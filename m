Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A512A2021E
	for <e@80x24.org>; Thu,  3 Nov 2016 15:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754975AbcKCPis (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Nov 2016 11:38:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:38050 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754218AbcKCPir (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2016 11:38:47 -0400
Received: (qmail 28907 invoked by uid 109); 3 Nov 2016 15:38:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 03 Nov 2016 15:38:47 +0000
Received: (qmail 13357 invoked by uid 111); 3 Nov 2016 15:39:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 03 Nov 2016 11:39:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Nov 2016 11:38:45 -0400
Date:   Thu, 3 Nov 2016 11:38:45 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: Help with vger's rules, was Re: [ANNOUNCE] Git for Windows 2.10.2
Message-ID: <20161103153845.nhquuoko4utecit2@sigill.intra.peff.net>
References: <alpine.DEB.2.20.1611022158140.3108@virtualbox>
 <alpine.DEB.2.20.1611031554100.3108@virtualbox>
 <20161103153453.4aipi5lxkmkt3kco@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161103153453.4aipi5lxkmkt3kco@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 03, 2016 at 11:34:53AM -0400, Jeff King wrote:

> This is missing a Content-Transfer-Encoding. I think the default is the
> traditional 7-bit ascii encoding, but your body has characters with the
> high-bit set (your UTF-8 bullet).
> 
> Try adding:
> 
>   Content-Transfer-Encoding: 8bit
> 
> I haven't seen this before, but I do recall that vger's MTA is very
> picky about this and wants to rewrite transfer-encodings, so it seems
> plausible.

Technically, I think you'd also need a:

  MIME-Version: 1.0

header. That being said, I just peeked at the send-email code and it
looks like we try to add in these headers as necessary. It's possible
there's a bug, though. What does "git send-email --dry-run" say is in
the headers it sends out?

-Peff
