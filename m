Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC8D61F453
	for <e@80x24.org>; Wed, 17 Oct 2018 18:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbeJRCUe (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 22:20:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:43748 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727610AbeJRCUd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 22:20:33 -0400
Received: (qmail 7381 invoked by uid 109); 17 Oct 2018 18:23:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 17 Oct 2018 18:23:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21796 invoked by uid 111); 17 Oct 2018 18:22:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 17 Oct 2018 14:22:51 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Oct 2018 14:23:38 -0400
Date:   Wed, 17 Oct 2018 14:23:38 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Ben Peart <peartben@gmail.com>, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>
Subject: Re: [PATCH v1 2/2] reset: add new reset.quietDefault config setting
Message-ID: <20181017182337.GD28326@sigill.intra.peff.net>
References: <20181017164021.15204-1-peartben@gmail.com>
 <20181017164021.15204-3-peartben@gmail.com>
 <CAPig+cQ3ia78pLtnHSq8tM3B-XnFgWhwowJxwacYEEzXosJ16g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cQ3ia78pLtnHSq8tM3B-XnFgWhwowJxwacYEEzXosJ16g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 17, 2018 at 02:19:59PM -0400, Eric Sunshine wrote:

> On Wed, Oct 17, 2018 at 12:40 PM Ben Peart <peartben@gmail.com> wrote:
> > Add a reset.quietDefault config setting that sets the default value of the
> > --quiet flag when running the reset command.  This enables users to change
> > the default behavior to take advantage of the performance advantages of
> > avoiding the scan for unstaged changes after reset.  Defaults to false.
> 
> As with the previous patch, my knee-jerk reaction is that this really
> feels wrong being tied to --quiet. It's particularly unintuitive.
> 
> What I _could_ see, and what would feel more natural is if you add a
> new option (say, --optimize) which is more general, incorporating
> whatever optimizations become available in the future, not just this
> one special-case. A side-effect of --optimize is that it implies
> --quiet, and that is something which can and should be documented.

Heh, I just wrote something very similar elsewhere in the thread. I'm
still not sure if it's a dumb idea, but at least we can be dumb
together.

-Peff
