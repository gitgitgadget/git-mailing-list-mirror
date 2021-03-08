Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F98C433E0
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 18:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B82F0651A0
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 18:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbhCHSac (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 13:30:32 -0500
Received: from cloud.peff.net ([104.130.231.41]:55778 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230517AbhCHSaB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 13:30:01 -0500
Received: (qmail 26438 invoked by uid 109); 8 Mar 2021 18:30:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 08 Mar 2021 18:30:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19505 invoked by uid 111); 8 Mar 2021 18:30:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 08 Mar 2021 13:30:01 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 8 Mar 2021 13:30:00 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <ttaylorr@github.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        HG King via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, HG King <hgmaxwellking@gmail.com>
Subject: Re: [PATCH] fix: added new BANNED_EXPL macro for better error
 messages, new parameter
Message-ID: <YEZtKHS7c19N967O@coredump.intra.peff.net>
References: <pull.896.git.1614991897210.gitgitgadget@gmail.com>
 <xmqq7dmi8zym.fsf@gitster.c.googlers.com>
 <YEZnaeJVt8Rk6duv@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YEZnaeJVt8Rk6duv@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 08, 2021 at 01:05:46PM -0500, Taylor Blau wrote:

> > Adding a comment around each of these definition may be OK.  Upon
> > seeing foo_is_a_banned_function, somebody new to the codebase would
> > look for where it is banned, and find the above, so that is a good
> > place to give guidance.
> 
> Perhaps, but all of this information is already covered accurately in
> the patches that introduced each banned function. So I'm not sure that I
> even agree that this information is difficult to discover to begin with,
> but I may be biased.

Yeah, certainly my intent when I introduced banned.h was that people
would get the full reasoning from the commit log. I figured Git
developers could run "git log -S" or "git blame".

I'm not opposed to comments if somebody wants to write them, but it's
not clear to whether people who are actively writing patches for Git
have actually run into this situation and been confused, or if this is
bikeshedding from the recent posting of banned.h on Hacker News. (Even
if it is the latter, I am OK taking a patch that adds comments; I just
doubt that it's a good use of anybody's time).

-Peff
