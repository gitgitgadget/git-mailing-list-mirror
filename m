Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C49B61F597
	for <e@80x24.org>; Thu, 26 Jul 2018 20:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730474AbeGZWFG (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jul 2018 18:05:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:60456 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730392AbeGZWFF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jul 2018 18:05:05 -0400
Received: (qmail 18350 invoked by uid 109); 26 Jul 2018 20:46:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 26 Jul 2018 20:46:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19358 invoked by uid 111); 26 Jul 2018 20:46:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 26 Jul 2018 16:46:34 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Jul 2018 16:46:32 -0400
Date:   Thu, 26 Jul 2018 16:46:32 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2018, #03; Wed, 25)
Message-ID: <20180726204632.GB28420@sigill.intra.peff.net>
References: <xmqqd0vbt14e.fsf@gitster-ct.c.googlers.com>
 <20180726072429.GA7625@sigill.intra.peff.net>
 <xmqqlg9yq6ih.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlg9yq6ih.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 26, 2018 at 09:57:42AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Wed, Jul 25, 2018 at 03:13:37PM -0700, Junio C Hamano wrote:
> >
> >> * jk/banned-function (2018-07-24) 5 commits
> >>  - banned.h: mark strncpy() as banned
> >>  - banned.h: mark sprintf() as banned
> >>  - banned.h: mark strcat() as banned
> >>  - automatically ban strcpy()
> >>  - Merge branch 'sb/blame-color' into jk/banned-function
> >> 
> >>  It is too easy to misuse system API functions such as strcat();
> >>  these selected functions are now forbidden in this codebase and
> >>  will cause a compilation failure.
> >> 
> >>  Will merge to 'next'.
> >
> > Eric nudged me over the fence to use a slightly different mechanism to
> > generate the error. See:
> >
> >   https://public-inbox.org/git/20180726072105.GA6057@sigill.intra.peff.net/
> >
> > It looks like sb/blame-color graduated, so this could also just be
> > applied directly on master now to avoid the funky merge.
> 
> OK.  Is it that "you cannot call a variable" thing?

We don't try to call it, but rather just mention it. It's just that the
compiler is more strict about undeclared variables than it is about
undeclared functions.

-Peff
