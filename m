Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E85E61F404
	for <e@80x24.org>; Thu, 30 Aug 2018 19:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbeH3XuW (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 19:50:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:34506 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726959AbeH3XuW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 19:50:22 -0400
Received: (qmail 8143 invoked by uid 109); 30 Aug 2018 19:46:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 30 Aug 2018 19:46:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30803 invoked by uid 111); 30 Aug 2018 19:46:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 30 Aug 2018 15:46:45 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Aug 2018 15:46:34 -0400
Date:   Thu, 30 Aug 2018 15:46:34 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 0/9] worktree: fix bugs and broaden --force applicability
Message-ID: <20180830194634.GE19685@sigill.intra.peff.net>
References: <20180828212026.21989-1-sunshine@sunshineco.com>
 <20180830075431.GF11944@sigill.intra.peff.net>
 <CAPig+cS3-oRzQrZGM_-pXUVFE3HvMdtODurPkmYgw1vFV8zb3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cS3-oRzQrZGM_-pXUVFE3HvMdtODurPkmYgw1vFV8zb3Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 30, 2018 at 05:04:32AM -0400, Eric Sunshine wrote:

> On Thu, Aug 30, 2018 at 3:54 AM Jeff King <peff@peff.net> wrote:
> > Subject: [PATCH] doc-diff: force worktree add
> >
> > We avoid re-creating our temporary worktree if it's already
> > there. But we may run into a situation where the worktree
> > has been deleted, but an entry still exists in
> > $GIT_DIR/worktrees.
> 
> Can "clean" or "distclean" also be augmented to remove this worktree
> (and directory)? I guess that "distclean" would make more sense than
> "clean"(?).

I suppose so. I don't think I've _ever_ used distclean, and I only
rarely use "clean" (a testament to our Makefile's efforts to accurately
track dependencies). I'd usually use "git clean" when I want something
pristine (because I don't want to trust the Makefile at all).

-Peff
