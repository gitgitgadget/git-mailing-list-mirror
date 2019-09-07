Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A28A61F461
	for <e@80x24.org>; Sat,  7 Sep 2019 04:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394275AbfIGErT (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Sep 2019 00:47:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:42704 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2392019AbfIGErT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Sep 2019 00:47:19 -0400
Received: (qmail 27957 invoked by uid 109); 7 Sep 2019 04:47:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 07 Sep 2019 04:47:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9434 invoked by uid 111); 7 Sep 2019 04:49:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 07 Sep 2019 00:49:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 7 Sep 2019 00:47:18 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, avarab@gmail.com, garimasigit@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] fetch: add fetch.writeCommitGraph config setting
Message-ID: <20190907044717.GC24463@sigill.intra.peff.net>
References: <49f877c85ca2be5bb76d9082ee4aa26e26111a14.1567477320.git.gitgitgadget@gmail.com>
 <20190904030829.GB28836@sigill.intra.peff.net>
 <xmqqa7bipjil.fsf@gitster-ct.c.googlers.com>
 <a697c4de-e269-c330-ece2-8ac7007e6c55@gmail.com>
 <20190906175628.GH23181@sigill.intra.peff.net>
 <xmqq1rwtnv03.fsf@gitster-ct.c.googlers.com>
 <20190906191622.GA7096@sigill.intra.peff.net>
 <xmqqpnkdma0g.fsf@gitster-ct.c.googlers.com>
 <25ed1562-dc74-1ebc-46ff-d6cd643504a4@gmail.com>
 <xmqqh85pm6jg.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh85pm6jg.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 06, 2019 at 02:57:55PM -0700, Junio C Hamano wrote:

> > I think the "stock git without any other job infrastructure" is
> > a very important scenario. Putting the simplest version of
> > "commit-graph writes in-line with every push" seems to be ripe
> > for failure under load. I'd rather think deeply about what is
> > best for this scenario.
> 
> As to what to do on the push side, I suppose we can afford to let it
> simmer in the back of our heads while moving this topic forward.
> Whether we'd later decide to have receive.writeCommitGraph (in which
> case we would add transfer.writeCommitGraph, too) or not, this
> change on the fetch side can independently be used, right?

Yeah, I'm OK with proceeding without the receive-pack side for now.

-Peff
