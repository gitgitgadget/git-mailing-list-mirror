Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3787C2BB48
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 13:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACC1324058
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 13:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733088AbgLKNuC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Dec 2020 08:50:02 -0500
Received: from vps.thesusis.net ([34.202.238.73]:40860 "EHLO vps.thesusis.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390607AbgLKNt7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Dec 2020 08:49:59 -0500
Received: from localhost (localhost [127.0.0.1])
        by vps.thesusis.net (Postfix) with ESMTP id 3C808222B8;
        Fri, 11 Dec 2020 08:49:18 -0500 (EST)
Received: from vps.thesusis.net ([IPv6:::1])
        by localhost (vps.thesusis.net [IPv6:::1]) (amavisd-new, port 10024)
        with ESMTP id yhyEdUG_xzKt; Fri, 11 Dec 2020 08:49:18 -0500 (EST)
Received: by vps.thesusis.net (Postfix, from userid 1000)
        id 0BB83222B6; Fri, 11 Dec 2020 08:49:18 -0500 (EST)
References: <ea1e654cec62411884e2c260524fb05a@deshaw.com>
User-agent: mu4e 1.5.7; emacs 26.3
From:   Phillip Susi <phill@thesusis.net>
To:     "Shupak\, Vitaly" <Vitaly.Shupak@deshaw.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Why does "git pull --rebase" require a clean git directory?
Date:   Fri, 11 Dec 2020 08:46:12 -0500
In-reply-to: <ea1e654cec62411884e2c260524fb05a@deshaw.com>
Message-ID: <87a6uk78rl.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Shupak, Vitaly writes:

> "git pull --rebase" requires having NO uncommitted changes, even if
> the locally modified files haven't been updated upstream, or even if
> there are no changes to upstream at all. I know I could use

It isn't just about whether upstream has changed those same files, but
also would fail if any of your commits have.

> --autostash, but that's inefficient and may be undesirable if it would
> create a conflict.

If that creates a conflict, then the pull would definitely fail if it
had been attempted.
