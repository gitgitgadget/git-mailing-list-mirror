Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 845CB1F462
	for <e@80x24.org>; Tue, 28 May 2019 06:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfE1Gez (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 02:34:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:39478 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727067AbfE1Gez (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 02:34:55 -0400
Received: (qmail 27712 invoked by uid 109); 28 May 2019 06:34:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 28 May 2019 06:34:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10514 invoked by uid 111); 28 May 2019 06:35:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 28 May 2019 02:35:35 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 May 2019 02:34:51 -0400
Date:   Tue, 28 May 2019 02:34:51 -0400
From:   Jeff King <peff@peff.net>
To:     Brendan Boerner <bboerner.biz@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: 'git stash list' => Segmentation fault
Message-ID: <20190528063451.GG7946@sigill.intra.peff.net>
References: <CAKkfZL2p8yFr3ecsQ63HzeZ+u-Jukf7YcYHk_8iBaKcA4WbEfg@mail.gmail.com>
 <nycvar.QRO.7.76.6.1905272046250.47@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1905272046250.47@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 27, 2019 at 08:47:56PM +0200, Johannes Schindelin wrote:

> > bboerner@myhost:~/funproject/Src/bash$ git stash list
> > Segmentation fault (core dumped)
> > Segmentation fault (core dumped)
> > Segmentation fault (core dumped)
> > stash@{0}: On devel: NYFL optimization
> > stash@{1}: On GL285: gl285
> 
> Unfortunately, this leaves *very* little in the way of actionable
> evidence. Would it be possible for you to share a tar'red up copy of the
> .git/ directory? Or do you find that this happens for all of your stashes?
> What is the output when you run this with `GIT_TRACE=1`?

Alternatively, if you cannot share the repo, a backtrace from gdb might
help. There should be a core file either in the working directory, or in
the ".git/" directory. Try "gdb git /path/to/core" and then "bt" to get
the backtrace.

-Peff
