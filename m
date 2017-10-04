Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE88B20281
	for <e@80x24.org>; Wed,  4 Oct 2017 08:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751755AbdJDIbP (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 04:31:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:60240 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751702AbdJDIbN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 04:31:13 -0400
Received: (qmail 16911 invoked by uid 109); 4 Oct 2017 08:31:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 04 Oct 2017 08:31:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15966 invoked by uid 111); 4 Oct 2017 08:31:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 04 Oct 2017 04:31:13 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Oct 2017 04:31:11 -0400
Date:   Wed, 4 Oct 2017 04:31:11 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2017, #01; Wed, 4)
Message-ID: <20171004083111.5y7su63scydg2yzk@sigill.intra.peff.net>
References: <xmqqy3orbcrr.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy3orbcrr.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 04, 2017 at 04:19:52PM +0900, Junio C Hamano wrote:

> I wanted to do v2.15-rc0 today but it seems that this has to slip,
> with too many topics still in flight in 'next' among which many are
> fixes, one is even a fix for a recent regression.

You probably already figured this out, but I want to be explicit just in
case:

> * tb/show-trailers-in-ref-filter (2017-10-02) 7 commits
>  - ref-filter.c: parse trailers arguments with %(contents) atom
>  - ref-filter.c: use trailer_opts to format trailers
>  - t6300: refactor %(trailers) tests
>  - doc: use "`<literal>`"-style quoting for literal strings
>  - doc: 'trailers' is the preferred way to format trailers
>  - t4205: unfold across multiple lines
>  - pretty.c: delimit "%(trailers)" arguments with ","
> 
>  "git for-each-ref --format=..." learned a new format element,
>  %(trailers), to show only the commit log trailer part of the log
>  message.
> 
>  Will merge to 'next'.

I think we want the first patch of this series to graduate before v2.15,
even if the rest doesn't make it. It tweaks a new syntax introduced
earlier in this cycle by jk/trailers-parse. If we ship without the
tweak, then we'll have to support the colon-delimiter to remain
backwards-compatible.

-Peff
