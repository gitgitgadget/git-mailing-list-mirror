Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405D9C43331
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 09:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D228206F2
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 09:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgC0JNi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Mar 2020 05:13:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:53346 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726165AbgC0JNi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Mar 2020 05:13:38 -0400
Received: (qmail 10073 invoked by uid 109); 27 Mar 2020 09:13:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 27 Mar 2020 09:13:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23374 invoked by uid 111); 27 Mar 2020 09:23:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 27 Mar 2020 05:23:33 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 27 Mar 2020 05:13:36 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        martin.agren@gmail.com, szeder.dev@gmail.com
Subject: Re: [PATCH v4] builtin/commit-graph.c: support '--input=graphed'
Message-ID: <20200327091336.GC610157@coredump.intra.peff.net>
References: <7c47f37122ff2b03f0bccc48cb6ca022904f6353.1583278022.git.me@ttaylorr.com>
 <e0f42a2f3c0162a5d43bb2bce0f69264b59f92e9.1584994172.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e0f42a2f3c0162a5d43bb2bce0f69264b59f92e9.1584994172.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 23, 2020 at 02:12:19PM -0600, Taylor Blau wrote:

> Hi,
> 
> In response to some discussion in [1], here is another idea instead of
> '--input=none' that may make things a little clearer. Since it had been
> a long time, I reminded myself that '--input=none' means
> "--input=append, but don't look at packs as is usually the default".
> 
> In [1], Gabor suggested that we could call this '--input=exists' or
> '--input=existing', but I think that 'graphed' may be clearer, since
> it is closer to "only _graphed_ commits".

Yeah, this name is much more clear to me than "none" (and would have
prevented some mild confusion I had when experimenting the other day).

> Another option would be to call this '--input=only-graphed', but I think
> that may be overly verbose for what we're going for here.

Agreed.

-Peff
