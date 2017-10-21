Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 145B3202A2
	for <e@80x24.org>; Sat, 21 Oct 2017 03:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752776AbdJUDZI (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Oct 2017 23:25:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:59668 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752605AbdJUDZH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Oct 2017 23:25:07 -0400
Received: (qmail 3965 invoked by uid 109); 21 Oct 2017 03:25:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 21 Oct 2017 03:25:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21783 invoked by uid 111); 21 Oct 2017 03:25:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 20 Oct 2017 23:25:12 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Oct 2017 23:25:05 -0400
Date:   Fri, 20 Oct 2017 23:25:05 -0400
From:   Jeff King <peff@peff.net>
To:     David Lang <david@lang.hm>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: hot to get file sizes in git log output
Message-ID: <20171021032505.e6vysjteesr4r5pj@sigill.intra.peff.net>
References: <nycvar.QRO.7.76.6.1710201105351.5973@qynat-yncgbc>
 <CA+P7+xpdWJbxtxAggRpYR3eE8qjH6TfbYQS_=20aZM7d2RbC0Q@mail.gmail.com>
 <20171020214312.3kb3ncz2ks7mfxw4@sigill.intra.peff.net>
 <CAPig+cQ56ZNaEOkV+ZCq2KsL-2nTockTrEbqvj=j_wO0YtCx6g@mail.gmail.com>
 <nycvar.QRO.7.76.6.1710201929210.5973@qynat-yncgbc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1710201929210.5973@qynat-yncgbc>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 20, 2017 at 07:38:00PM -0700, David Lang wrote:

> git whatchanged shows commits like:
> 
> commit fb7e54c12ddc7c87c4862806d583f5c6abf3e731
> Author: David Lang <david@lang.hm>
> Date:   Fri Oct 20 11:00:01 2017 -0700
> 
>     update
> 
> :100644 100644 1a842ca... 290e9dd... M  Default/Bookmarks
> :100644 100644 1cd745c... 388a455... M  Default/Current Session
> :100644 100644 51074ad... c4dce40... M  Default/Current Tabs
> 
> If there was a way to add file size to this output, it would be perfect for
> what I'm needing.

There isn't. You'll have to process the output to pass the post-image
hashes to cat-file to get the size (i.e., what I showed before, though
of course you could make the output prettier if you wanted to).

-Peff
