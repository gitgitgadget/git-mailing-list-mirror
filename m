Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D208202A0
	for <e@80x24.org>; Wed,  1 Nov 2017 18:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751663AbdKASic (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 14:38:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:42948 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751428AbdKASic (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 14:38:32 -0400
Received: (qmail 22060 invoked by uid 109); 1 Nov 2017 18:38:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 01 Nov 2017 18:38:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14277 invoked by uid 111); 1 Nov 2017 18:38:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 01 Nov 2017 14:38:40 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Nov 2017 14:38:29 -0400
Date:   Wed, 1 Nov 2017 14:38:29 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Contribution licensing question(s)
Message-ID: <20171101183829.mwoi7urka3hze3pm@sigill.intra.peff.net>
References: <CABPp-BF5Aitu05X83Lbm+8rWKojOnNNec_4bf5PRy+hKZGPPHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BF5Aitu05X83Lbm+8rWKojOnNNec_4bf5PRy+hKZGPPHw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 01, 2017 at 08:50:00AM -0700, Elijah Newren wrote:

> Background: git's README.md file points out that some parts of git are
> under a license other than GPLv2 (while still GPLv2-compatible),
> though it doesn't state which one(s)

I think this note is mostly about code we've imported from elsewhere.
For example, libxdiff seems to be under LGPL.

> or what a contributor might want
> to do if they want to grant permission under one of those more
> permissive license(s).

If it's a whole file or subsystem that can be used standalone, I think
it would make sense to mark the copyright at the top of the file (like
xdiff does).

For smaller bits or changes to GPL'd code, it's not clear to me if you
can meaningfully dual-license them. I.e., I think you hit a question of
whether small changes are copyrightable in themselves or if they're
simply a derived work of Git. I'll leave that one to people more clueful
about legal issues.

> Also, I seem to recall that years ago there
> were requests to make code available under a slightly more permissive
> license to allow re-usage in jgit and perhaps other projects, though I
> can't find any trace of this in the codebase.

This was mostly done for the libgit2 project, which uses GPL with a
linking exception:

  https://github.com/libgit2/libgit2/blob/master/COPYING

When that project started, they asked for dual-license permission from
various git.git contributors, which is documented in that repo:

  https://github.com/libgit2/libgit2/blob/master/git.git-authors

> I'm not sure whether my specific git contributions would matter to
> jgit (which we also use internally, both directly and indirectly), but
> generally, is contributing under a more permissive GPLv2-compatible
> license to permit re-usage in other projects like jgit (or for easing
> future license switches) still relevant?  If so, which license(s) have
> folks gravitated towards for these contributions, and how would one
> mark their submitted patches?

Hopefully the above answers most of these questions. But I think in
general the approach is not "license it differently in git.git", but
"grant those other projects a different license to use your code, too".

-Peff
