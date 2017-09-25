Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83973202A5
	for <e@80x24.org>; Mon, 25 Sep 2017 12:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934179AbdIYMWY (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 08:22:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:49116 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932656AbdIYMWX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 08:22:23 -0400
Received: (qmail 11691 invoked by uid 109); 25 Sep 2017 12:22:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 25 Sep 2017 12:22:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24607 invoked by uid 111); 25 Sep 2017 12:23:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 25 Sep 2017 08:23:02 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Sep 2017 08:22:21 -0400
Date:   Mon, 25 Sep 2017 08:22:21 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 00/21] Read `packed-refs` using mmap()
Message-ID: <20170925122221.ntbhwvmyvgm4igxk@sigill.intra.peff.net>
References: <cover.1506325610.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1506325610.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 25, 2017 at 09:59:57AM +0200, Michael Haggerty wrote:

> This is v3 of a patch series that changes the reading and caching of
> the `packed-refs` file to use `mmap()`. Thanks to Stefan, Peff, Dscho,
> and Junio for their comments about v2. I think I have addressed all of
> the feedback from v1 [1] and v2 [2].
> 
> This version has only minor changes relative to v2:
> 
> * Fixed a trivial error in the commit message for patch 08.
> 
> * In patch 13:
> 
>   * In the commit message, explain the appearance of `MMAP_TEMPORARY`
>     even though it is not yet treated differently than `MMAP_NONE`.
> 
>   * In `Makefile`, don't make `USE_WIN32_MMAP` imply
>     `MMAP_PREVENTS_DELETE`.
> 
>   * Correct the type of a local variable from `size_t` to `ssize_t`.

Thanks, this version addresses all my nits.

-Peff
