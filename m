Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 658991F45A
	for <e@80x24.org>; Fri, 16 Aug 2019 18:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfHPSPR (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Aug 2019 14:15:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:46140 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727200AbfHPSPR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Aug 2019 14:15:17 -0400
Received: (qmail 21148 invoked by uid 109); 16 Aug 2019 18:15:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 16 Aug 2019 18:15:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9088 invoked by uid 111); 16 Aug 2019 18:16:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 16 Aug 2019 14:16:30 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 16 Aug 2019 14:15:16 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git Test Coverage Report (Thursday, Aug 15)
Message-ID: <20190816181515.GA15741@sigill.intra.peff.net>
References: <6dd8797a-289d-cabb-d4c3-761b9f9d3ca0@gmail.com>
 <20190816181103.GA13894@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190816181103.GA13894@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 16, 2019 at 02:11:03PM -0400, Jeff King wrote:

>           if (opts->ignore_whitespace) {
>                   struct strbuf buf = STRBUF_INIT;
>   
>                   if (strategy_opts)
>                           strbuf_addstr(&buf, strategy_opts);
>   
>                   strbuf_addstr(&buf, " --ignore-space-change");
>                   free(strategy_opts);
>                   strategy_opts = strbuf_detach(&buf, NULL);
>           }
> [...]
> (As an aside, this code leaks the newly allocated buffer and leaves a
> dangling pointer in opts->strategy_opts, but that's all orthogonal to
> the uncovered line; I'll send a separate message to the original
> author).

In case any of you were on the edge of your seat waiting for more
discussion, it turns out that Phillip already noticed this problem
during review:

  https://public-inbox.org/git/a505fdf3-5926-9765-21ef-b82334a3fba4@gmail.com/

So nothing to see here. :)

-Peff
