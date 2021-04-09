Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710FCC433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 15:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C8C2610D1
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 15:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbhDIP6W (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 11:58:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:46366 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231946AbhDIP6W (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 11:58:22 -0400
Received: (qmail 31927 invoked by uid 109); 9 Apr 2021 15:58:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 09 Apr 2021 15:58:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12664 invoked by uid 111); 9 Apr 2021 15:58:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 09 Apr 2021 11:58:08 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 9 Apr 2021 11:58:07 -0400
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 8/8] rev-list: allow filtering of provided items
Message-ID: <YHB5j1rnC1mRjlqn@coredump.intra.peff.net>
References: <cover.1614600555.git.ps@pks.im>
 <cover.1615813673.git.ps@pks.im>
 <0e26fee8b31e46e87fb9fa1ac599506502a9d622.1615813673.git.ps@pks.im>
 <YGyinyL2UU421hoX@coredump.intra.peff.net>
 <YHAznTddwG/ej4aS@ncase>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YHAznTddwG/ej4aS@ncase>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 09, 2021 at 12:59:41PM +0200, Patrick Steinhardt wrote:

> > The name seems a little confusing to me, as I can read is as both
> > "please filter the provided objects" and "a filter has been provided".
> > I guess "--filter-print-provided" would be more clear. And also the
> > default, so you'd want "--no-filter-print-provided". That's kind of
> > clunky, though. Maybe "--filter-omit-provided"?
> 
> Hum, "--filter-omit-provided" doesn't sound good to me, either. Omit to
> me sounds like it'd omit filtering provided items, but we're doing
> the reverse thing.

Yeah, I can see that.

> How about "--filter-provided-revisions"? Verbose, but at least it cannot
> be confused with a filter being provided.

Yes, that works for me. Maybe "--filter-provided-objects", since you
could also provide a non-revision on the command line (though I think
other parts of the docs are happy to refer to "revisions" or "commits"
on the command line, even though you can clearly provide non-commits
when used with --objects).

-Peff
