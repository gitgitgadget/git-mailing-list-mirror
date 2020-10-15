Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A5EC433DF
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 01:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1222F22254
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 01:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbgJOB0h (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 21:26:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:60556 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727165AbgJOB0h (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 21:26:37 -0400
Received: (qmail 19292 invoked by uid 109); 15 Oct 2020 01:26:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 Oct 2020 01:26:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23730 invoked by uid 111); 15 Oct 2020 01:26:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Oct 2020 21:26:37 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 14 Oct 2020 21:26:36 -0400
From:   Jeff King <peff@peff.net>
To:     serg.brester@gmx.net
Cc:     git@vger.kernel.org
Subject: Re: git fast-import leaks memory drastically, so crashes with out of
 memory by attempt to import 22MB export dump
Message-ID: <20201015012636.GA387901@coredump.intra.peff.net>
References: <1eeb49305cb7c712e141dcae2c434d96@sebres.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1eeb49305cb7c712e141dcae2c434d96@sebres.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 14, 2020 at 11:22:03AM +0200, Dipl. Ing. Sergey Brester wrote:

> I did not see any issues with (even much larger) imports, before I upgraded
> git to 2.28.0 (from 2.25.1, I guess).

I wasn't able to reproduce, but it sounds like there's something special
about this repo (since the dump is not that big, and you said much
larger dumps have succeeded).

Is it possible to make either the fossil repo, or the fast-import input
file available?

If not, since you said it works with 2.14.4, is it possible to bisect in
Git to see when it stopped working? You'll need to be able to build Git
from source.

-Peff
