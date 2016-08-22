Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A4881F859
	for <e@80x24.org>; Mon, 22 Aug 2016 18:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754404AbcHVS5N (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Aug 2016 14:57:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:59181 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751736AbcHVS5M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2016 14:57:12 -0400
Received: (qmail 18606 invoked by uid 109); 22 Aug 2016 18:57:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Aug 2016 18:57:12 +0000
Received: (qmail 15762 invoked by uid 111); 22 Aug 2016 18:57:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Aug 2016 14:57:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Aug 2016 14:57:09 -0400
Date:   Mon, 22 Aug 2016 14:57:09 -0400
From:   Jeff King <peff@peff.net>
To:     David Glasser <glasser@davidglasser.net>
Cc:     git@vger.kernel.org
Subject: Re: git-config(1) should mention `git -c`
Message-ID: <20160822185709.izdfbkbsmeip5u7c@sigill.intra.peff.net>
References: <CAN7QDoJ-gQ9XUkCrTT6YDN+aUjNrAJWaG+WxbUvu32DJG-OZDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN7QDoJ-gQ9XUkCrTT6YDN+aUjNrAJWaG+WxbUvu32DJG-OZDg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 22, 2016 at 11:42:52AM -0700, David Glasser wrote:

> In addition to describing the `git config` command, git-config(1) also
> appears to be where the algorithm for determining the active
> configuration values is documented, in the FILES and ENVIRONMENT
> sections.  (There is minimal documentation of these files and
> environment variables in git(1).)
> 
> However, `git -c name=value` is not documented in this manpage. So to
> understand the full set of ways to affect the configuration of a git
> command, you need to know to read both git(1) and git-config(1).

Yeah, I agree it is probably worth mentioning in git-config(1).

> I'd like to add a reference to `git -c` to git-config(1). I would
> happily send a patch but I'm not sure of the best place to put it —
> maybe in the FILES section?

That seems like the most sensible place, as that is where we should
cover the order of reading and precedence. Perhaps FILES should be
renamed to SOURCES or something (though I do not recall if we are
restricted to "usual" manpage section names or not).

Arguably this is not about git-config the program at all, but the
general concept of "configuration for git", because the precedence rules
apply equally to all of the git programs that read config. So it _could_
be pulled out into its own gitconfig(7) page. That's a lot more work,
though, and I don't blame you if you want to start with a more minor
update.

(I also think that having both git-config(1) and gitconfig(7) may be
confusing; "git help revisions" knows to find gitrevisions(7), but "git
help config" would always end up in git-config(1), I think).

-Peff
