Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 366F51F405
	for <e@80x24.org>; Wed, 19 Dec 2018 15:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbeLSPvK (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Dec 2018 10:51:10 -0500
Received: from cloud.peff.net ([104.130.231.41]:45822 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727310AbeLSPvJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Dec 2018 10:51:09 -0500
Received: (qmail 24334 invoked by uid 109); 19 Dec 2018 15:51:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 19 Dec 2018 15:51:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22221 invoked by uid 111); 19 Dec 2018 15:50:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 19 Dec 2018 10:50:42 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Dec 2018 10:51:07 -0500
Date:   Wed, 19 Dec 2018 10:51:07 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org, gitster@pobox.com, stolee@gmail.com,
        avarab@gmail.com, szeder.dev@gmail.com
Subject: Re: [PATCH v4 0/3] Add commit-graph fuzzer and fix buffer overflow
Message-ID: <20181219155107.GD14802@sigill.intra.peff.net>
References: <cover.1544048946.git.steadmon@google.com>
 <cover.1544729841.git.steadmon@google.com>
 <20181218173539.GA31070@sigill.intra.peff.net>
 <20181218210551.GG37614@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181218210551.GG37614@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 18, 2018 at 01:05:51PM -0800, Josh Steadmon wrote:

> On 2018.12.18 12:35, Jeff King wrote:
> > On Thu, Dec 13, 2018 at 11:43:55AM -0800, Josh Steadmon wrote:
> > 
> > > Add a new fuzz test for the commit graph and fix a buffer read-overflow
> > > that it discovered. Additionally, fix the Makefile instructions for
> > > building fuzzers.
> > > 
> > > Changes since V3:
> > >   * Improve portability of the new test functionality.
> > 
> > I thought there was some question about /dev/zero, which I think is
> > in this version (I don't actually know whether there are portability
> > issues or not, but somebody did mention it).
> > 
> > -Peff
> 
> I've only found one reference [1] (from 1999) of OS X Server not having
> a /dev/zero. It appears to be present as of 2010 though [2].

Thanks for digging. That seems like enough to assume we should try it
and see if any macOS people complain.

I do wonder if we'll run into problems on Windows, though.

-Peff
