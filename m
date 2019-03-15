Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3931202BB
	for <e@80x24.org>; Fri, 15 Mar 2019 18:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbfCOSga (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 14:36:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:52840 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725778AbfCOSga (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 14:36:30 -0400
Received: (qmail 1236 invoked by uid 109); 15 Mar 2019 18:36:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 15 Mar 2019 18:36:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2363 invoked by uid 111); 15 Mar 2019 18:36:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 15 Mar 2019 14:36:50 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Mar 2019 14:36:28 -0400
Date:   Fri, 15 Mar 2019 14:36:28 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Eric Wong <e@80x24.org>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 1/2] t5310: correctly remove bitmaps for jgit test
Message-ID: <20190315183627.GA4941@sigill.intra.peff.net>
References: <20190315062133.GA13385@sigill.intra.peff.net>
 <20190315062243.GA13466@sigill.intra.peff.net>
 <20190315132545.GA24175@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190315132545.GA24175@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 15, 2019 at 02:25:45PM +0100, SZEDER Gábor wrote:

> > Our reader implementation will ignore one of the bitmap files, but it's
> > likely non-deterministic which one we will use. We'd prefer the one with
> > the more recent timestamp (just because of the way the packed_git list
> > is sorted), but in most test runs they'd have identical timestamps.
> > 
> > So this was probably actually testing something useful about 50% of the
> > time, and other half just testing that we could read our own bitmaps
> > (which is covered elsewhere).
> 
> At least it was testing the right thing up until 87a6bb701a
> (t5310-pack-bitmaps: make JGit tests work with GIT_TEST_SPLIT_INDEX,
> 2018-05-10) came along.

Heh, indeed. I didn't even dig into the history, and just assumed I had
botched it in 2013. :)

-Peff
