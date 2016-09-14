Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29F991FCA9
	for <e@80x24.org>; Wed, 14 Sep 2016 19:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759605AbcINTXq (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Sep 2016 15:23:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:43307 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756040AbcINTXp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2016 15:23:45 -0400
Received: (qmail 7153 invoked by uid 109); 14 Sep 2016 19:23:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Sep 2016 19:23:44 +0000
Received: (qmail 2514 invoked by uid 111); 14 Sep 2016 19:23:55 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Sep 2016 15:23:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Sep 2016 12:23:41 -0700
Date:   Wed, 14 Sep 2016 12:23:41 -0700
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] pathspec: removed unnecessary function prototypes
Message-ID: <20160914192341.mgpcc35kgmjqunbh@sigill.intra.peff.net>
References: <1473785571-60439-1-git-send-email-bmwill@google.com>
 <20160913181552.74bhacoa2q76yv6k@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160913181552.74bhacoa2q76yv6k@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 13, 2016 at 11:15:52AM -0700, Jeff King wrote:

> On Tue, Sep 13, 2016 at 09:52:51AM -0700, Brandon Williams wrote:
> 
> > removed function prototypes from pathspec.h which don't have a
> > corresponding implementation.
> 
> I'm always curious of the "why" in cases like this. Did we forget to add
> them? Did they get renamed? Did they go away?
> 
> Looks like the latter; 5a76aff (add: convert to use parse_pathspec,
> 2013-07-14) just forgot to remove them.

I should have done a better job of not just providing the answer, but
showing how. The easiest tool here is "git log -S":

  git log -1 -p -Scheck_path_for_gitlink

(and then you can see that the whole function went away there).

-Peff
