Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2991A1F89C
	for <e@80x24.org>; Sat, 21 Jan 2017 14:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750886AbdAUOD2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jan 2017 09:03:28 -0500
Received: from cloud.peff.net ([104.130.231.41]:42583 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750735AbdAUOD1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jan 2017 09:03:27 -0500
Received: (qmail 1335 invoked by uid 109); 21 Jan 2017 14:03:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 21 Jan 2017 14:03:27 +0000
Received: (qmail 31187 invoked by uid 111); 21 Jan 2017 14:04:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 21 Jan 2017 09:04:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 21 Jan 2017 09:03:25 -0500
Date:   Sat, 21 Jan 2017 09:03:25 -0500
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH/TOY] Shortcuts to quickly refer to a commit name with
 keyboard
Message-ID: <20170121140325.uicd2nxtuhn3i5vy@sigill.intra.peff.net>
References: <20170120102249.15572-1-pclouds@gmail.com>
 <20170120160942.srqf4y5w5r6feidw@sigill.intra.peff.net>
 <CA+P7+xoMTX5n_h+5MytZwVqKjqa0wdNKCeDtH29A_+WSfr6gTQ@mail.gmail.com>
 <20170120192539.7jts6xqzx46unn7y@sigill.intra.peff.net>
 <CACsJy8DxCPCXUeEoR1pQBCNqYOHjpgfLy_vgqsK1H=C0Mf=L8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8DxCPCXUeEoR1pQBCNqYOHjpgfLy_vgqsK1H=C0Mf=L8g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 21, 2017 at 07:44:05PM +0700, Duy Nguyen wrote:

> You just gave me a reason to rebuild urxvt with perl support. It
> solves my problem with SHA-1 nicely (and fixes another problem with
> very large counter in my approach, when you scroll git-log further
> down, because I can't know what's on screen or already scrolled past).

Note that even without my module, you can probably use the "matcher"
extension which is included with urxvt to do something similar (it can
handle arbitrary numbers of matching regexps).

The things I like about my module (and why I bothered to write it) are:

  - it does nothing at all until you trigger it, so you don't have to
    worry about the cost of your regexes, or how ugly false positives
    will look when underlined

  - I think the hint mode is much better for keyboard navigation.
    The matcher extension does have a "list" mode where you get an
    overlay with the whole list and select by number. That's what I
    started with in mine, but I found it's really hard to use when there
    are a lot of matches. Especially with sha1s.

> Do you think it should be in contrib for better discoverability (than
> burying it in the mail archive)? A separate git repo is also ok, but I
> guess that's just more burden.

I'm not sure it makes sense in git's contrib. It's really more about
urxvt than it is about git.

-Peff
