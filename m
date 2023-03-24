Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64944C6FD1C
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 19:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbjCXTNF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Mar 2023 15:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjCXTNE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 15:13:04 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66D01CBE9
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 12:13:03 -0700 (PDT)
Received: (qmail 6193 invoked by uid 109); 24 Mar 2023 19:13:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Mar 2023 19:13:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4738 invoked by uid 111); 24 Mar 2023 19:13:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Mar 2023 15:13:02 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Mar 2023 15:13:02 -0400
From:   Jeff King <peff@peff.net>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: limiting git branch --contains
Message-ID: <20230324191302.GB536967@coredump.intra.peff.net>
References: <ZBygZbz5E6jVNp3y@ugly>
 <xmqqpm8z8dab.fsf@gitster.g>
 <ZBy6Ku+znv/wuOix@ugly>
 <594a358e-7bd4-e7a1-ad0f-7e41ca1fe767@github.com>
 <ZB3o0seQJVbtPa+j@ugly>
 <85f81579-5876-a573-6d35-88b35ab0f290@github.com>
 <ZB3z3e5G3Lrv9g3Y@ugly>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZB3z3e5G3Lrv9g3Y@ugly>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 24, 2023 at 08:02:53PM +0100, Oswald Buddenhagen wrote:

> On Fri, Mar 24, 2023 at 02:20:01PM -0400, Derrick Stolee wrote:
> > Hm. The point is that it _should_ improve things by several orders
> > of magnitude [...]
> > 
> well, at that point it would be kinda sufficient. ^^
> but it really doesn't do anything at all (i tried moving away the graph for
> comparison).
> maybe the operation just forgets to load the graph?

That seems weird. I get a 3000x speedup just by using building the
commit-graph. Are you seeing any change at all? What version of Git are
you using?

I'd be curious, too, if you can try the patch I posted elsewhere in the
thread to see if that improves things.

-Peff
