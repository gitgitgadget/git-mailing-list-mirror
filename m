Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4180F20FCF
	for <e@80x24.org>; Fri,  1 Jul 2016 06:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751932AbcGAGbi (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 02:31:38 -0400
Received: from cloud.peff.net ([50.56.180.127]:38764 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751036AbcGAGbh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 02:31:37 -0400
Received: (qmail 25244 invoked by uid 102); 1 Jul 2016 06:31:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 Jul 2016 02:31:34 -0400
Received: (qmail 13838 invoked by uid 107); 1 Jul 2016 06:31:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 Jul 2016 02:31:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Jul 2016 02:31:29 -0400
Date:	Fri, 1 Jul 2016 02:31:29 -0400
From:	Jeff King <peff@peff.net>
To:	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	git@drmicha.warpmail.net, j.cretel@umail.ucc.ie
Subject: Re: [PATCH] log: decorate HEAD -> branch with the same color for
 branch and HEAD
Message-ID: <20160701063129.GC5358@sigill.intra.peff.net>
References: <20160630163942.8353-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20160630163942.8353-1-pclouds@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jun 30, 2016 at 06:39:42PM +0200, Nguyễn Thái Ngọc Duy wrote:

> Commit 76c61fb (log: decorate HEAD with branch name under
> --decorate=full, too - 2015-05-13) adds "HEAD -> branch" decoration to
> show current branch vs detached HEAD. The sign of whether HEAD is
> detached or not is "->" (vs ", "). It's too subtle for my poor
> eyes. If color is used, we can make the branch name's color the same
> as HEAD to visually emphasize that it's the current branch.

Hmm. I think I like this, as it uses color to make the grouping between
HEAD and its referent more clear.

We do already use colors to indicate "type", though. Which means:

  1. The branch now uses the "symref" color. Probably OK, as that is the
     point of the grouping (I wonder if the "->" in the middle should
     match in color, too).

  2. We used to color based on current_and_HEAD->type, but now that
     information isn't conveyed. However, can this really ever have been
     anything _except_ a branch?

-Peff
