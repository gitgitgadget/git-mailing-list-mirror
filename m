Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F34FE1FD09
	for <e@80x24.org>; Wed, 31 May 2017 16:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751246AbdEaQHb (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 12:07:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:60619 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751146AbdEaQH3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 12:07:29 -0400
Received: (qmail 27286 invoked by uid 109); 31 May 2017 16:07:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 31 May 2017 16:07:21 +0000
Received: (qmail 5966 invoked by uid 111); 31 May 2017 16:08:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 31 May 2017 12:08:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 31 May 2017 12:07:21 -0400
Date:   Wed, 31 May 2017 12:07:21 -0400
From:   Jeff King <peff@peff.net>
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] docs: fix literal quoted spaces
Message-ID: <20170531160721.4yimitnyy6pdxkq5@sigill.intra.peff.net>
References: <20170531150624.GC18266@dinwoodie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170531150624.GC18266@dinwoodie.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 31, 2017 at 04:06:24PM +0100, Adam Dinwoodie wrote:

> When compiling the documentation, asciidoc thinks a backtick surrounded
> by whitespace shouldn't be interpreted as marking the start or end of a
> literal.  In most cases, that's useful behaviour, but in the git-pull
> documentation the space is clearly intended to be part of the monospace
> formatted text.

Good catch.

> Instead, use + to avoid asciidoc's literal passthrough, and encode the
> space as {sp}.  In particular, this means asciidoc will correctly detect
> the end of the monospace formatting, rather than having it continue past
> the backtick.

In these particular cases, is the space adding anything? Would a simpler
fix be to just use:

  ...the value on `URL:` line

We've had such headaches with other entities like {sp} between different
asciidoc versions (not to mention asciidoctor) that I tend to reach for
the simplest solution.

(I'd also suggest the minor English correct of saying "_the_ URL line";
that's orthogonal to what you're trying to fix, but may make sense on
top while we're here).

-Peff
