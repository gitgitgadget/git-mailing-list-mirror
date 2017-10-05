Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4F062036B
	for <e@80x24.org>; Thu,  5 Oct 2017 09:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751429AbdJEJtm (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 05:49:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:33308 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751388AbdJEJtm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 05:49:42 -0400
Received: (qmail 15964 invoked by uid 109); 5 Oct 2017 09:49:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 05 Oct 2017 09:49:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25829 invoked by uid 111); 5 Oct 2017 09:49:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 05 Oct 2017 05:49:41 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Oct 2017 05:49:39 -0400
Date:   Thu, 5 Oct 2017 05:49:39 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, git@jeffhostetler.com,
        sbeller@google.com, gitster@pobox.com
Subject: Re: [PATCH v3 0/5] Improve abbreviation disambituation
Message-ID: <20171005094939.uzizbh6dfhapkqho@sigill.intra.peff.net>
References: <20170925095452.66833-1-dstolee@microsoft.com>
 <20171002145651.204984-1-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171002145651.204984-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 02, 2017 at 10:56:46AM -0400, Derrick Stolee wrote:

> Thanks for the feedback on my previous versions, and for patience
> with my inexperience on the mailing list. I tried to respond to all
> feedback, but decided to not apply one suggestion:

For what it's worth, the optimizations here look sound overall. Like
Junio, I was concerned at the loss of performance from patch 3 at first.
After looking at your numbers, though, I think it really is just the
cost of oid_to_hex() that is then eliminated in patch 4.

I had a few nits to pick on the perf-test setup, but I stupidly sent
them in response to v2 (and so missed cc-ing several folks involved in
review). I think they apply equally to v3, though.

-Peff
