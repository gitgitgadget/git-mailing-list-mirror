Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3FBC3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 16:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 802BE2053B
	for <git@archiver.kernel.org>; Mon,  4 May 2020 16:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbgEDQNo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 12:13:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:35964 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726578AbgEDQNo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 12:13:44 -0400
Received: (qmail 31759 invoked by uid 109); 4 May 2020 16:13:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 04 May 2020 16:13:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18342 invoked by uid 111); 4 May 2020 16:13:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 04 May 2020 12:13:43 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 4 May 2020 12:13:42 -0400
From:   Jeff King <peff@peff.net>
To:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, jalopezsilva@gmail.com
Subject: Re: [RFC PATCH] credential: minor documentation fixes
Message-ID: <20200504161342.GD12842@coredump.intra.peff.net>
References: <20200503063423.83152-1-carenas@gmail.com>
 <20200503065826.GB1829906@coredump.intra.peff.net>
 <20200504074520.GB86805@Carlos-MBP>
 <20200504144436.GA9893@coredump.intra.peff.net>
 <20200504155837.GD86805@Carlos-MBP>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200504155837.GD86805@Carlos-MBP>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 04, 2020 at 08:58:37AM -0700, Carlo Marcelo Arenas Belón wrote:

> what I meant is that we don't REALLY allow those modification to take place
> since the credential helper suggestions can't really affect what git assumes
> is the right host or protocol (or FWIW path), unlike username/password  and
> so they don't seem worth having IMHO.

I guess it depends on your definition of REALLY.  Sure, we won't access
a different host via curl (or a different protocol!), but I wouldn't
expect that. This is the credential subsystem.

If you're proposing to document it more clearly, I'm fine with that.

And if you want to tighten it up in a major release to ignore such input
from helpers, I'm fine with that, too. But I'd be worried pushing it out
in a maintenance release and finding out that somebody _is_ depending on
it somehow.

-Peff
