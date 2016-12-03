Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B43151FBB0
	for <e@80x24.org>; Sat,  3 Dec 2016 07:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751411AbcLCG76 (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Dec 2016 01:59:58 -0500
Received: from continuum.iocl.org ([217.140.74.2]:50999 "EHLO
        continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750900AbcLCG76 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Dec 2016 01:59:58 -0500
Received: (from krey@localhost)
        by continuum.iocl.org (8.11.3/8.9.3) id uB36xnV23558;
        Sat, 3 Dec 2016 07:59:49 +0100
Date:   Sat, 3 Dec 2016 07:59:49 +0100
From:   Andreas Krey <a.krey@gmx.de>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: make --only --allow-empty work without paths
Message-ID: <20161203065949.GG19570@inner.h.apk.li>
References: <20161202221513.GA5370@inner.h.apk.li> <20161203043254.7ozjyucfn6uivnsh@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161203043254.7ozjyucfn6uivnsh@sigill.intra.peff.net>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 02 Dec 2016 23:32:55 +0000, Jeff King wrote:
> On Fri, Dec 02, 2016 at 11:15:13PM +0100, Andreas Krey wrote:
> 
> > --only is implied when paths are present, and required
> > them unless --amend. But with --allow-empty it should
> > be allowed as well - it is the only way to create an
> > empty commit in the presence of staged changes.
> 
> OK. I'm not sure why you would want to create an empty commit in such a
> case.

User: Ok tool, make me a pullreq.

Tool: But you haven't mentioned any issue
      in your commit messages. Which are they?

User: Ok, that would be A-123.

Tool: git commit --allow-empty -m 'FIX: A-123'

Originally we checked that the status output was
empty, and later added an option for 'yes, I know
that there are uncommitted changes; I don't want
them included'.

And then someone had staged changes, which lead me here,
because there is no way now to create an empty commit
(just for the commit message) in that situation.
Amending the previous commit wouldn't fly with us
because of a local ban on non-fast-forward pushes.

...
> > (The interdepence of the tests is a strange thing;
> > making --run=N somewhat pointless.)
> 
> Yes, I think --run is a misfeature (I actually had to look it up, as I
...
> implicit. If a single test script is annoyingly long to run, I'd argue

It wasn't about runtime but about output. I would have
liked to see only the output of my still-failing test;
a 'stop after test X' would be helpful there.

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
