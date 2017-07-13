Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B7DC2035A
	for <e@80x24.org>; Thu, 13 Jul 2017 16:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753359AbdGMQAS (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 12:00:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:39248 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753036AbdGMQAR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 12:00:17 -0400
Received: (qmail 26832 invoked by uid 109); 13 Jul 2017 16:00:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Jul 2017 16:00:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 491 invoked by uid 111); 13 Jul 2017 16:00:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Jul 2017 12:00:29 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Jul 2017 12:00:14 -0400
Date:   Thu, 13 Jul 2017 12:00:14 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        jonathantanmy@google.com
Subject: Re: [PATCH] RFC: Introduce '.gitorderfile'
Message-ID: <20170713160014.laowcywx7pb5we77@sigill.intra.peff.net>
References: <20170711233827.23486-1-sbeller@google.com>
 <xmqqinix1j29.fsf@gitster.mtv.corp.google.com>
 <20170712205734.h77fgbbkavwpkr4h@sigill.intra.peff.net>
 <xmqqa849yzwh.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa849yzwh.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 12, 2017 at 04:54:38PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I could see somebody arguing that format-patch should respect a project
> > preference, since its primary purpose is to communicate your work to the
> > rest of the project.
> >
> > But then you could make a similar argument for other diff options, too.
> 
> Yeah, and that opens a whole can of worms.
> 
> We let projects to ship clean/smudge or textconv filters and also
> mark paths to which these tools may be of help, but we do not let
> projects to automatically enable them in the cloned repository.  The
> projects must _tell_ the user how to run the last step (e.g. "There
> is a tools/setup-my-clone script shipped with the source; running it
> will add necessary configurations to work better with our project").
> 
> I do not think usefulness of diff.orderfile is being questioned, but
> I think it is something we should treat just like any other thing
> that affects repository configuration.  A .gitorderfile that allows
> the project to behave as if we allowed to auto-enable just one thing
> in the clone, while not allowing others, a source of issues and
> unnecessary headaches later.

Thanks for writing this out. That was exactly what I was trying to imply
with my final statement, but you said it much better. :)

> Besides, diff-order is *not* the only order that matters in the use
> of the system, and we _will_ regret the name ".gitorderfile" later,
> as people would start making noises about forcing ls-files and other
> things to also show the list following that order.

I'd also agree with this.

-Peff
