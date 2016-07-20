Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CB7C1F744
	for <e@80x24.org>; Wed, 20 Jul 2016 16:15:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753129AbcGTQPx (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 12:15:53 -0400
Received: from cloud.peff.net ([50.56.180.127]:47610 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753022AbcGTQPw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 12:15:52 -0400
Received: (qmail 16945 invoked by uid 102); 20 Jul 2016 16:15:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 Jul 2016 12:15:51 -0400
Received: (qmail 22510 invoked by uid 107); 20 Jul 2016 16:16:14 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 Jul 2016 12:16:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Jul 2016 10:15:43 -0600
Date:	Wed, 20 Jul 2016 10:15:43 -0600
From:	Jeff King <peff@peff.net>
To:	Jeff Hostetler <jeffhost@microsoft.com>
Cc:	git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v1 0/6] Porcelain Status V2
Message-ID: <20160720161543.GD24902@sigill.intra.peff.net>
References: <1468966258-11191-1-git-send-email-jeffhost@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1468966258-11191-1-git-send-email-jeffhost@microsoft.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 19, 2016 at 06:10:52PM -0400, Jeff Hostetler wrote:

> This patch series adds porcelain V2 format to status.
> This provides detailed information about file changes
> and about the current branch.
> 
> The new output is accessed via:
>     git status --porcelain=2 [--branch]
> 
> An earlier draft of this work was submitted under the
> "Add very verbose porcelain output to status" title.
> This new version addresses the concerns about using
> (abusing) "-vv" and simplifies the some of the formatting.

I reviewed the first two, which look good except for a few minor
comments. I don't have time at the moment to dig carefully into the v2
format itself from the later patches (but from a cursory view they look
OK). I'm flying all day today, so probably won't get to a more thorough
review for a day or two (but if there are other reviewers, please don't
feel you have to wait for my input).

One final bit of food for thought.

Just yesterday somebody asked me about renewing the old idea of using a
more standardized format for machine-readable output, like --json.
That's obviously something that would exist alongside the existing
formats for compatibility, and it doesn't fundamentally change anything
about adding a new format as your patches do (it just becomes yet
another format).

However I wanted to mention it in case you are intrigued by the idea,
and would be interested in skipping porcelain-v2 entirely in favor of
moving to something like json.

A totally reasonable response is "haha no. Please stop moving the
goalposts". I just wanted to throw it out there as an option (and in
case you are interested, to let you think about it before any more work
goes into this direction).

-Peff
