Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A487C433EF
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 17:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51201610A2
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 17:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbhINRIK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 13:08:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:47172 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229562AbhINRII (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 13:08:08 -0400
Received: (qmail 24574 invoked by uid 109); 14 Sep 2021 17:06:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Sep 2021 17:06:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25441 invoked by uid 111); 14 Sep 2021 17:06:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Sep 2021 13:06:42 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 14 Sep 2021 13:06:42 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 5/9] serve: provide "receive" function for session-id
 capability
Message-ID: <YUDWoiN7wczfNwU8@coredump.intra.peff.net>
References: <YUC/6n1hhUbMJiLw@coredump.intra.peff.net>
 <YUDAtbHcbv6zNFxe@coredump.intra.peff.net>
 <YUDT5bnnMNtkc3KK@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUDT5bnnMNtkc3KK@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 14, 2021 at 12:55:01PM -0400, Taylor Blau wrote:

> On Tue, Sep 14, 2021 at 11:33:09AM -0400, Jeff King wrote:
> > I had originally dropped has_capability() in a separate patch, to keep
> > this one more readable. That breaks bisectability, but only with
> > -Werror. I'm not sure where we should fall on that spectrum (I generally
> > bisect with -Wno-error just because warnings may come and go when
> > working with different compilers than what was normal at the time).
> 
> I tend to fall the same way, especially when bisecting things in ancient
> (to me) versions of Git where my current compiler complains. So I think
> the approach that you took here is just fine.

To be clear, the approach here is conservative: it will bisect even with
-Werror. I think what you're saying is I _could_ have done the other
approach, and put the removal into its own commit?

-Peff
