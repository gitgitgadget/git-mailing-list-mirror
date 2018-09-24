Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 354B41F453
	for <e@80x24.org>; Mon, 24 Sep 2018 20:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbeIYCy0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Sep 2018 22:54:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:57762 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727055AbeIYCy0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Sep 2018 22:54:26 -0400
Received: (qmail 10875 invoked by uid 109); 24 Sep 2018 20:50:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 24 Sep 2018 20:50:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30432 invoked by uid 111); 24 Sep 2018 20:50:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 24 Sep 2018 16:50:08 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Sep 2018 16:50:22 -0400
Date:   Mon, 24 Sep 2018 16:50:22 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        sunshine@sunshineco.com, sbeller@google.com
Subject: Re: [PATCH v2 3/3] transport.c: introduce core.alternateRefsPrefixes
Message-ID: <20180924205022.GA26936@sigill.intra.peff.net>
References: <cover.1537466087.git.me@ttaylorr.com>
 <cover.1537555544.git.me@ttaylorr.com>
 <6e8f65a16dc0be84234d2be93bb4a5c9a585dd57.1537555544.git.me@ttaylorr.com>
 <xmqqbm8qv9hy.fsf@gitster-ct.c.googlers.com>
 <20180921213753.GA11177@sigill.intra.peff.net>
 <xmqqtvmitsi4.fsf@gitster-ct.c.googlers.com>
 <20180921221832.GC11177@sigill.intra.peff.net>
 <xmqqftxzsz5x.fsf@gitster-ct.c.googlers.com>
 <20180924181011.GA24781@sigill.intra.peff.net>
 <xmqqa7o6skkl.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa7o6skkl.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 24, 2018 at 01:32:26PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > So I think it's conceptually consistent to always show a subset.
> 
> OK.  Then I agree with you that it is a good approach to first adopt
> core.* knobs that universally apply, and add specialized ones as
> they are needed later.

Thanks. There's one other major decision for this series, I think.

Do you have an opinion on whether for_each_alternate_refs() interface
should stop passing back refnames? By the "they may not even exist"
rationale in this sub-thread, I think it's probably foolish for any
caller to actually depend on the names being meaningful.

We need to decide now because the idea of which data is relevant is
getting baked into the documented alternateRefsCmd output format.

-Peff
