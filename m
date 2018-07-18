Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5157C1F597
	for <e@80x24.org>; Wed, 18 Jul 2018 19:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730211AbeGRU2M (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 16:28:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:51576 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728929AbeGRU2M (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 16:28:12 -0400
Received: (qmail 15639 invoked by uid 109); 18 Jul 2018 19:48:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 18 Jul 2018 19:48:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2698 invoked by uid 111); 18 Jul 2018 19:48:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 18 Jul 2018 15:48:52 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Jul 2018 15:48:47 -0400
Date:   Wed, 18 Jul 2018 15:48:47 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jnareb@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 5/8] commit-graph: not compatible with replace objects
Message-ID: <20180718194846.GD7778@sigill.intra.peff.net>
References: <pull.11.git.gitgitgadget@gmail.com>
 <7f596c1718d35539f02828edbf933c8e660f123b.1531926932.git.gitgitgadget@gmail.com>
 <20180718194657.GC7778@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180718194657.GC7778@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 18, 2018 at 03:46:57PM -0400, Jeff King wrote:

> On Wed, Jul 18, 2018 at 08:15:41AM -0700, Derrick Stolee via GitGitGadget wrote:
> 
> > From: Derrick Stolee <dstolee@microsoft.com>
> > 
> > Create new method commit_graph_compatible(r) to check if a given
> > repository r is compatible with the commit-graph feature. Fill the
> > method with a check to see if replace-objects exist. Test this
> > interaction succeeds, including ignoring an existing commit-graph and
> > failing to write a new commit-graph.
> 
> I think this approach is sensible. These are optimizations, and it's not
> a big deal to just punt no cases we can't handle.

Er, this should be "punt _on_ cases we can't handle". Sorry for my
belated proof-reading.

-Peff
