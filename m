Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B22DE1F453
	for <e@80x24.org>; Thu, 21 Feb 2019 13:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbfBUNsA (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 08:48:00 -0500
Received: from cloud.peff.net ([104.130.231.41]:52548 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727553AbfBUNsA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 08:48:00 -0500
Received: (qmail 20340 invoked by uid 109); 21 Feb 2019 13:48:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 21 Feb 2019 13:48:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12465 invoked by uid 111); 21 Feb 2019 13:48:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 21 Feb 2019 08:48:13 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Feb 2019 08:47:58 -0500
Date:   Thu, 21 Feb 2019 08:47:58 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/5] Protocol v2 fix: http and auth
Message-ID: <20190221134758.GB21406@sigill.intra.peff.net>
References: <cover.1550170980.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1550170980.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 14, 2019 at 11:06:34AM -0800, Jonathan Tan wrote:

> Peff noticed an issue with my http auth in protocol v2 patch earlier
> [1], and in the ensuing discussion, I thought that it would be best to
> make v2 use post_rpc() as well (to be the same as v0/v1) instead of
> using its own functions, to fix this issue and try to avoid a similar
> issue in the future. Besides that, there is also a net reduction in
> lines of code.
> 
> So here are the patches. First 4 are refactoring - the last one has the
> actual change. This is on the master branch.

I think this is the right approach. Patches 1-4 look pretty nice. I
didn't see anything wrong with the code in the 5th one, but I did have
some thoughts about how we might be able to do it a bit more cleanly
(though I will not at all be surprised if they turn out to be bad
suggestions).

-Peff
