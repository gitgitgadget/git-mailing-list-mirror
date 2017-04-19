Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40497207BC
	for <e@80x24.org>; Wed, 19 Apr 2017 01:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758851AbdDSBZe (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 21:25:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:35659 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758823AbdDSBZc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 21:25:32 -0400
Received: (qmail 24278 invoked by uid 109); 19 Apr 2017 01:25:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 19 Apr 2017 01:25:30 +0000
Received: (qmail 17706 invoked by uid 111); 19 Apr 2017 01:25:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 18 Apr 2017 21:25:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Apr 2017 21:25:28 -0400
Date:   Tue, 18 Apr 2017 21:25:28 -0400
From:   Jeff King <peff@peff.net>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@jeffhostetler.com, git@vger.kernel.org, gitster@pobox.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v11 2/5] p0006-read-tree-checkout: perf test to time
 read-tree
Message-ID: <20170419012528.2xjnwrpgvlsgzszj@sigill.intra.peff.net>
References: <20170417213734.55373-1-git@jeffhostetler.com>
 <20170417213734.55373-3-git@jeffhostetler.com>
 <20170418214025.GA4989@hank>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170418214025.GA4989@hank>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 18, 2017 at 10:40:25PM +0100, Thomas Gummerer wrote:

> > +test_perf_default_repo
> 
> I like that it's possible to use a real world repository now instead
> of forcing the use of a synthetic repository :)
> 
> Is there a reason for this being test_perf_default_repo instead of
> test_perf_large_repo?  It seems like generating a large repo is what
> you are doing with repos/many-files.sh.

I'm actually of the opinion that the default/large repo thing should go
away. I think the original premise was that you could pick a
default/large pair and run the whole suite against them. But in reality,
I have always been confused about which one I should use when writing a
perf test, and what I should use when running the suite.

I think it would be more useful for the perf tests to just respect a
single repo parameter. Then you could run the whole suite against each
repo in turn. And we could get results for git.git, linux.git, some
synthetic cases, the gigantic Windows repo, etc.

-Peff
