Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53250202DD
	for <e@80x24.org>; Mon,  2 Oct 2017 06:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750852AbdJBGWz (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 02:22:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:57268 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750763AbdJBGWy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 02:22:54 -0400
Received: (qmail 8977 invoked by uid 109); 2 Oct 2017 06:22:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Oct 2017 06:22:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26147 invoked by uid 111); 2 Oct 2017 06:23:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Oct 2017 02:23:35 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Oct 2017 02:22:52 -0400
Date:   Mon, 2 Oct 2017 02:22:52 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Paul Tan <pyokagan@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 00/11] various lockfile-leaks and -fixes
Message-ID: <20171002062252.didw7guppl4nvxry@sigill.intra.peff.net>
References: <cover.1506862824.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1506862824.git.martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 01, 2017 at 04:56:01PM +0200, Martin Ågren wrote:

> A recent series allowed `struct lock_file`s to be freed [1], so I wanted
> to get rid of the "simple" leaks of this kind. I found a couple of
> lock-related cleanups along the way and it resulted in this series. It
> feels a bit scary at eleven patches -- especially as this is about
> locking -- but I hope I've managed to put this into understandable and
> reviewable patches. Reviews, thoughts, opinions welcome, as always.

Thanks for working on this (and cleaning up several messes that I left).

I've read through each and with the exception of patches 10 and 11, they
all look good to me.

For 10 and 11, I think you've convinced me that the current behavior is
buggy. I do wonder if the subtleties might be easier to understand as a
single patch, but I'm OK either way.

-Peff
