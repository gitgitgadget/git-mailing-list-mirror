Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31B2F1F731
	for <e@80x24.org>; Wed, 31 Jul 2019 23:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729987AbfGaXSt (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 19:18:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:57764 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729885AbfGaXSt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 19:18:49 -0400
Received: (qmail 21825 invoked by uid 109); 31 Jul 2019 23:18:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 31 Jul 2019 23:18:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22992 invoked by uid 111); 31 Jul 2019 23:20:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 31 Jul 2019 19:20:38 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 31 Jul 2019 19:18:48 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Subject: Re: Git for Windows v2.23.0-rc0, was Re: [ANNOUNCE] Git v2.23.0-rc0
Message-ID: <20190731231848.GC1933@sigill.intra.peff.net>
References: <xmqqh874tssp.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1907311440130.21907@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1907311440130.21907@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 31, 2019 at 02:43:10PM +0200, Johannes Schindelin wrote:

> And a corresponding Git for Windows v2.23.0-rc0 can be found here:
> 
> https://github.com/git-for-windows/git/releases/tag/v2.23.0-rc0.windows.1
> 
> Please test!
> 
> One (slightly annoying) issue I found already is that a `git log` will
> print out a blurb about `log.mailmap`, but most of the time, you cannot
> see it because the actual output of `git log` is shown in the pager.
> 
> I plan on working around this by setting `log.mailmap = true` in Git for
> Windows' system config.

I too was annoyed recently by that warning (I set the config to squelch
it, but I'm sure it will pop up again for me in some other context where
I don't have my usual config).

Setting log.mailmap=true in the distributed system seems to defeat the
purpose, though, doesn't it? The point is for users to see the warning
and adjust their expectations, but with your plan they would never see
it.

I think part of what my annoyance is responding to (and your willingness
to just squelch this for everybody) is that switching this particular
default isn't really that big a deal, that it requires annoying people
on every single "git log" invocation. Perhaps we would be better
squelching it entirely and just putting a mention in the release notes.

I know that having been burned by the dashed-form deprecation long ago,
Junio is hesitant to rely on release notes. But it really seems like
this is a pretty minor change, and the solution is worse than the
problem.

-Peff
