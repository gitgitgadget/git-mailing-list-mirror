Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F2C5201B0
	for <e@80x24.org>; Thu, 23 Feb 2017 06:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752160AbdBWGSA (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 01:18:00 -0500
Received: from cloud.peff.net ([104.130.231.41]:60454 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751391AbdBWGR5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 01:17:57 -0500
Received: (qmail 24716 invoked by uid 109); 23 Feb 2017 06:17:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Feb 2017 06:17:05 +0000
Received: (qmail 19360 invoked by uid 111); 23 Feb 2017 06:17:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Feb 2017 01:17:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Feb 2017 01:17:02 -0500
Date:   Thu, 23 Feb 2017 01:17:02 -0500
From:   Jeff King <peff@peff.net>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Simon =?utf-8?Q?Sandstr=C3=B6m?= <simon@nikanor.nu>,
        Andrew Morton <akpm@linux-foundation.org>, git@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Driver Project <devel@linuxdriverproject.org>
Subject: Re: git email From: parsing (was Re: [GIT PULL] Staging/IIO driver
 patches for 4.11-rc1)
Message-ID: <20170223061702.bzzgrntotppvwdw6@sigill.intra.peff.net>
References: <20170222145613.GA17333@kroah.com>
 <CA+55aFy1JpXmo_PpC7f0zZa0YAP6rz+bztJ+fpDUoWgCz0_FMw@mail.gmail.com>
 <20170223060444.GA26196@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170223060444.GA26196@kroah.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 23, 2017 at 07:04:44AM +0100, Greg KH wrote:

> > Poor Simon Sandström.
> > 
> > Funnily enough, this only exists for one commit. You've got several
> > other commits from Simon that get his name right.
> > 
> > What happened?
> 
> I don't know what happened, I used git for this, I don't use quilt for
> "normal" patches accepted into my trees anymore, only for stable kernel
> work.
> 
> So either the mail is malformed, or git couldn't figure it out, I've
> attached the original message below, and cc:ed the git mailing list.
> 
> Also, Simon emailed me after this was committed saying something went
> wrong, but I couldn't go back and rebase my tree.  Simon, did you ever
> figure out if something was odd on your end?
> 
> Git developers, any ideas?

The problem isn't on the applying end, but rather on the generating end.
The From header in the attached mbox is:

  From: =?us-ascii?B?PT9VVEYtOD9xP1NpbW9uPTIwU2FuZHN0cj1DMz1CNm0/PQ==?= <simon@nikanor.nu>

If you de-base64 that, you get:

  =?UTF-8?q?Simon=20Sandstr=C3=B6m?=

So something double-encoded it before it got to your mbox.

-Peff
