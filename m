Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F295AC433DF
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 15:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C415220791
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 15:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgHMPI3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 11:08:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:57762 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726142AbgHMPI3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 11:08:29 -0400
Received: (qmail 19974 invoked by uid 109); 13 Aug 2020 15:08:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 13 Aug 2020 15:08:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14470 invoked by uid 111); 13 Aug 2020 15:08:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 13 Aug 2020 11:08:28 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 13 Aug 2020 11:08:28 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 1/5] Makefile: drop builtins from MSVC pdb list
Message-ID: <20200813150828.GA891963@coredump.intra.peff.net>
References: <20200813145515.GA891139@coredump.intra.peff.net>
 <20200813145719.GA891370@coredump.intra.peff.net>
 <20200813150428.GA2244@syl.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200813150428.GA2244@syl.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 13, 2020 at 11:04:28AM -0400, Taylor Blau wrote:

> On Thu, Aug 13, 2020 at 10:57:19AM -0400, Jeff King wrote:
> > Over the years some more programs have become builtins, but nobody
> > updated this MSVC-specific section of the file (which specifically says
> > that it should not include builtins). Let's bring it up to date.
> >
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> > Given that nobody has mentioned this, it makes me wonder if anybody is
> > even using this part of the Makefile at all these days. Or maybe having
> > extra lines here isn't a problem (though it's also missing some entries,
> > like one for git-bugreport).
> 
> If having extra entries didn't cause a problem, I would suspect that it
> was just that. But that missing entries *also* doesn't cause a problem,
> I'd suspect that this section of the Makefile just isn't being used.
> 
> Of course, I'm not using it since I'm not on Windows, but maybe dscho or
> Stolee would know if there are legitimate uses. Of course, if there
> aren't, I'm favor of getting rid of this section entirely.

I cc'd Jeff Hostetler, who added it. :)

I'm also pretty not-knowledgeable about Windows, but I think that
anybody using MSVC would do so through Visual Studio these days. And
that's being covered with recent cmake stuff. Or maybe I'm just
clueless. We'll see.

-Peff
