Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2712203F3
	for <e@80x24.org>; Mon, 24 Jul 2017 20:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753856AbdGXUc0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 16:32:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:47534 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751579AbdGXUcR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 16:32:17 -0400
Received: (qmail 14461 invoked by uid 109); 24 Jul 2017 20:32:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 24 Jul 2017 20:32:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12649 invoked by uid 111); 24 Jul 2017 20:32:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 24 Jul 2017 16:32:34 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Jul 2017 16:32:15 -0400
Date:   Mon, 24 Jul 2017 16:32:15 -0400
From:   Jeff King <peff@peff.net>
To:     "tonka3100@gmail.com" <tonka3100@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: change the filetype from binary to text after the file is
 commited to a git repo
Message-ID: <20170724203215.nnktj55xyvqfmcvj@sigill.intra.peff.net>
References: <CAEor4NHDNL4CQP_FpCuJ_3F86-A3P8i=yvp1AZr-NKt0i1=cXw@mail.gmail.com>
 <20170724181835.zo3lcv7pxmkif2jr@sigill.intra.peff.net>
 <7DE91669-D603-4C83-9151-78F2D5676E36@gmail.com>
 <20170724192357.y3oj5urfuie7ffjr@sigill.intra.peff.net>
 <DBBA7352-5276-4972-A437-F27F5F4C2641@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DBBA7352-5276-4972-A437-F27F5F4C2641@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 24, 2017 at 10:26:22PM +0200, tonka3100@gmail.com wrote:

> > I'm not sure exactly what you're trying to accomplish. If you're unhappy
> > with the file as utf-16, then you should probably convert to utf-8 as a
> > single commit (since the diff will otherwise be unreadable) and then
> > make further changes in utf-8.

> That was exactly what i'm searching for. The utf-16 back in the days
> was by accident (thx to visual studio). So if the last commit and the
> acutal change are both utf-8 the diff should work again.  Just for my
> understanding. Git just take the bytes of the whole file on every
> commit, so there is no general problem with that, the size of the
> utf-16 is just twice as big as the utf-8 one, is that correct?

Right. The diff switching the encodings will be listed as "binary" (and
you should write a good commit message explaining what's going on!), but
then after that the changes to the utf-8 version will display as normal
text.  Git only looks at the actual bytes being diffed, not older
versions of the file.

-Peff
