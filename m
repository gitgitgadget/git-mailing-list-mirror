Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD5B31F453
	for <e@80x24.org>; Thu, 31 Jan 2019 23:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbfAaXVD (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Jan 2019 18:21:03 -0500
Received: from cloud.peff.net ([104.130.231.41]:57198 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726284AbfAaXVD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 18:21:03 -0500
Received: (qmail 25734 invoked by uid 109); 31 Jan 2019 23:21:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 31 Jan 2019 23:21:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30541 invoked by uid 111); 31 Jan 2019 23:21:09 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 31 Jan 2019 18:21:09 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Feb 2019 00:20:58 +0100
Date:   Fri, 1 Feb 2019 00:20:58 +0100
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Nickolai Belakovski <nbelakovski@gmail.com>, git@vger.kernel.org,
        Rafael =?utf-8?B?QXNjZW5zw6Nv?= <rafa.almas@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v6 1/3] ref-filter: add worktreepath atom
Message-ID: <20190131232057.GA3843@sigill.intra.peff.net>
References: <20190122232301.95971-1-nbelakovski@gmail.com>
 <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
 <20190122232301.95971-2-nbelakovski@gmail.com>
 <xmqq36pjcicw.fsf@gitster-ct.c.googlers.com>
 <CAC05384+KjC=4_ZF9BrxweMUjwpkaGXNqRNSnwif6yci6TxMMw@mail.gmail.com>
 <xmqq5zud52ut.fsf@gitster-ct.c.googlers.com>
 <20190124183235.GA16580@sigill.intra.peff.net>
 <xmqqd0olj1kj.fsf@gitster-ct.c.googlers.com>
 <20190124212608.GD16114@sigill.intra.peff.net>
 <xmqqef8s1p3d.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqef8s1p3d.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 31, 2019 at 01:42:14PM -0800, Junio C Hamano wrote:

> > So I'd much rather see us parse the format into a real tree of nodes,
> > and figure out (once) which properties of each object are required to
> > fulfill that. Then for each object, we grab those properties, and then
> > walk the tree to generate the output string.
> 
> That sounds like a sensible longer-term strategy.  Let's however
> leave it outside the scope of this change.

Yeah, sorry if I got us too far afield. It's definitely out of scope for
this series. The takeaway I was trying to get at is that storing the
worktree map as a static global is actually pretty reasonable given the
current design.

-Peff
