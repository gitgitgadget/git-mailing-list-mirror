Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7820E1F461
	for <e@80x24.org>; Sun,  8 Sep 2019 10:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbfIHKbU (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Sep 2019 06:31:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:43320 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727231AbfIHKbU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Sep 2019 06:31:20 -0400
Received: (qmail 17640 invoked by uid 109); 8 Sep 2019 10:31:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 08 Sep 2019 10:31:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 359 invoked by uid 111); 8 Sep 2019 10:33:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 08 Sep 2019 06:33:09 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 8 Sep 2019 06:31:19 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 2/2] commit-graph: turn off save_commit_buffer
Message-ID: <20190908103118.GD15641@sigill.intra.peff.net>
References: <20190907045848.GA24515@sigill.intra.peff.net>
 <20190907050439.GB23904@sigill.intra.peff.net>
 <20190907185636.GB32028@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190907185636.GB32028@syl.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 07, 2019 at 02:56:36PM -0400, Taylor Blau wrote:

> So, the patch here looks obviously correct, and I don't think it needs a
> test or anything like that... besides: what is there to test? :).

There's no functional change, so as long as this has coverage in the
regular suite (and I think it does), there's no point in adding a new
functional test.

However, it may make sense to get some coverage of commit graphs in the
perf suite, so that we could detect regressions there. I think that
would make sense as a separate series, though, not attached to this
particular fix. (It would also be cool if the perf suite could record
peak memory usage, but that would take a fair bit of refactoring).

-Peff
