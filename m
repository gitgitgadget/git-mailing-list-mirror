Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0EE2C433E1
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 15:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2C4820829
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 15:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgHMPOT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 11:14:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:57824 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726249AbgHMPON (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 11:14:13 -0400
Received: (qmail 20051 invoked by uid 109); 13 Aug 2020 15:14:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 13 Aug 2020 15:14:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14749 invoked by uid 111); 13 Aug 2020 15:14:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 13 Aug 2020 11:14:10 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 13 Aug 2020 11:14:10 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/5] make credential helpers builtins
Message-ID: <20200813151410.GA892741@coredump.intra.peff.net>
References: <20200813145515.GA891139@coredump.intra.peff.net>
 <20200813145855.GB891370@coredump.intra.peff.net>
 <20200813150839.GB2244@syl.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200813150839.GB2244@syl.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 13, 2020 at 11:08:39AM -0400, Taylor Blau wrote:

> On Thu, Aug 13, 2020 at 10:58:55AM -0400, Jeff King wrote:
> > There's no real reason for credential helpers to be separate binaries. I
> > did them this way originally under the notion that helper don't _need_
> > to be part of Git, and so can be built totally separately (and indeed,
> > the ones in contrib/credential are). But the ones in our main Makefile
> > build on libgit.a, and the resulting binaries are reasonably large.
> 
> Could you clarify which helpers you mean here? Git's own
> credential-cache and store make sense to convert, but the helpers in
> contrib definitely don't.
> 
> For what it's worth, I'm almost positive that you mean the in-tree
> helpers (where in-tree means "in git.git but not in contrib"), in which
> case I'm in favor of this direcftion.

Yes, I mean the helpers in the Makefile that we build and install by
default with a regular "make".

-Peff
