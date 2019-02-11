Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 052401F453
	for <e@80x24.org>; Mon, 11 Feb 2019 20:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbfBKUaN (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 15:30:13 -0500
Received: from cloud.peff.net ([104.130.231.41]:40438 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726025AbfBKUaN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 15:30:13 -0500
Received: (qmail 7639 invoked by uid 109); 11 Feb 2019 20:30:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 11 Feb 2019 20:30:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17282 invoked by uid 111); 11 Feb 2019 20:30:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 11 Feb 2019 15:30:23 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Feb 2019 15:30:11 -0500
Date:   Mon, 11 Feb 2019 15:30:11 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, steadmon@google.com
Subject: Re: [PATCH 2/8] tests: always test fetch of unreachable with v0
Message-ID: <20190211203011.GB9072@sigill.intra.peff.net>
References: <cover.1549411880.git.jonathantanmy@google.com>
 <9b9061985202ec022cc562637d7f62ea599e7d8c.1549411880.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9b9061985202ec022cc562637d7f62ea599e7d8c.1549411880.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 05, 2019 at 04:21:16PM -0800, Jonathan Tan wrote:

> Some tests check that fetching an unreachable object fails, but protocol
> v2 allows such fetches. Unset GIT_TEST_PROTOCOL_VERSION so that these
> tests are always run using protocol v0.

I think this is reasonable, but just musing on a few things:

  1. Are we sure going forward that we want to retain this behavior? I
     feel like we discussed this on the list recently with no real
     conclusion, but I'm having trouble digging it up in the archive.

  2. If it does change, is there any way we could automatically find
     spots like this that would then need to be undone? I cannot think
     of a good solution, and I don't think it's a show-stopper not to
     have one, but I thought I'd put it forward as a concept.

-Peff
