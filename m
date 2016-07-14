Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCCB4203C1
	for <e@80x24.org>; Thu, 14 Jul 2016 22:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751503AbcGNWqV (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 18:46:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:45093 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751347AbcGNWqV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 18:46:21 -0400
Received: (qmail 20178 invoked by uid 102); 14 Jul 2016 22:46:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Jul 2016 18:46:21 -0400
Received: (qmail 10763 invoked by uid 107); 14 Jul 2016 22:46:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Jul 2016 18:46:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Jul 2016 18:46:18 -0400
Date:	Thu, 14 Jul 2016 18:46:17 -0400
From:	Jeff King <peff@peff.net>
To:	Stefan Beller <sbeller@google.com>
Cc:	git@vger.kernel.org, gitster@pobox.com, dwwang@google.com,
	e@80x24.org, dennis@kaarsemaker.net, jrnieder@gmail.com
Subject: Re: [PATCH 1/4] push options: {pre,post}-receive hook learns about
 push options
Message-ID: <20160714224617.GA22386@sigill.intra.peff.net>
References: <20160714214948.27432-1-sbeller@google.com>
 <20160714214948.27432-2-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160714214948.27432-2-sbeller@google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 14, 2016 at 02:49:45PM -0700, Stefan Beller wrote:

> We limit the push options for now
> * to not exceed an arbitrary count, and
> * to not exceed an arbitrary size.
> 
> This serves two purposes:
> * DoS protection (i.e. one connection can add no more than 32kB
>   now)
> * We need to figure out how to handle large (>64kB). Jeff wrote:
>   > Yes, but people are also happy when they can use a flexible and
>   > standardized tool to do a thing. I'd be more frustrated when I found out
>   > that Git's data-pushing protocol has arbitrary limitations (like, say, I
>   > can't push a data item larger than a single 64K pkt-line), which would
>   > easily just work with something like HTTP POSTs.
>   So to keep a way open in the future to deal with large pay loads,
>   the size is restricted for now.

Should this bit get dropped from the commit message?

-Peff
