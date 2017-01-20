Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A620B20C2E
	for <e@80x24.org>; Fri, 20 Jan 2017 16:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752835AbdATQJ4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jan 2017 11:09:56 -0500
Received: from cloud.peff.net ([104.130.231.41]:42181 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752373AbdATQJz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2017 11:09:55 -0500
Received: (qmail 26312 invoked by uid 109); 20 Jan 2017 16:09:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Jan 2017 16:09:45 +0000
Received: (qmail 16612 invoked by uid 111); 20 Jan 2017 16:10:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Jan 2017 11:10:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Jan 2017 11:09:43 -0500
Date:   Fri, 20 Jan 2017 11:09:43 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH/TOY] Shortcuts to quickly refer to a commit name with
 keyboard
Message-ID: <20170120160942.srqf4y5w5r6feidw@sigill.intra.peff.net>
References: <20170120102249.15572-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170120102249.15572-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 20, 2017 at 05:22:49PM +0700, Nguyễn Thái Ngọc Duy wrote:

> OK This patch is horrible. Though the idea is cool and I've found it
> very useful. So here it is. Perhaps the idea may be revised a bit
> that's more suitable for more than one user.
> 
> The problem is old, SHA-1 name is not keyboard-friendly, even in
> abbreviated form. And recent change has made abbrev form longer,
> harder to type. Most of the time I just go with copy/paste with the
> mouse, which I don't like. name-rev helps a bit, but it's still long
> to type (especially with all the ^ and ~ that requires holding shift
> down).

Not really a comment on your patch itself, but I think a lot of people
solve this at a higher level, either in their terminal or via a tool
like tmux.

I recently taught urxvt to recognize sha1s and grab them via keyboard
hints, and I'm finding it quite useful. Here's what it looks like if
you're interested:

  http://peff.net/git-hints.gif

The hints technique is taken from pentadactyl (which I also use), but
the urxvt port is mine. I'm happy to share the code.

Which isn't to say solving it inside Git is wrong, but I've found it
really convenient for two reasons:

  1. It works whenever you see a sha1, not just in git commands (so
     emails, inside commit messages, etc).

  2. It doesn't take any screen space until you're ready to select.

The big downside is that it's scraping the screen, so you're guessing at
what is a sha1. False positives are a little annoying, but usually not
that big a deal because you're already looking at what you want to
select, and the hint pops up right there.

-Peff
