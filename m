Return-Path: <SRS0=f6GY=4Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B0AC3F2D2
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 17:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61B1C2469F
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 17:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgB1RGn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Feb 2020 12:06:43 -0500
Received: from cloud.peff.net ([104.130.231.41]:57224 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725827AbgB1RGn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Feb 2020 12:06:43 -0500
Received: (qmail 4208 invoked by uid 109); 28 Feb 2020 17:06:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 28 Feb 2020 17:06:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16938 invoked by uid 111); 28 Feb 2020 17:15:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 28 Feb 2020 12:15:51 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 28 Feb 2020 12:06:41 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ralf Thielow via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Alban Gruin <alban.gruin@gmail.com>,
        Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH] config.mak.dev: re-enable -Wformat-zero-length
Message-ID: <20200228170641.GA1405401@coredump.intra.peff.net>
References: <pull.567.git.1582835130592.gitgitgadget@gmail.com>
 <20200227235445.GA1371170@coredump.intra.peff.net>
 <xmqqtv3aek8o.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtv3aek8o.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 28, 2020 at 08:42:47AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > The short of it is that we probably can't just disable the warning for
> > everybody because of portability issues. And ignoring it for developers
> > puts us in the situation we're in now, where non-dev builds are annoyed.
> 
> "git blame" unfortunately is very bad at poing at a commit that
> removed something, so I do not offhand know how much it would help
> readers who later wonder "oh, I am sure we had thing to disable
> format-zero-length warning, and I want to learn the reason why we
> dropped it", but thanks for writing this down.

I often turn to "git log -Sformat-zero" for this (and in fact that was
very useful for the research I did yesterday). But of course you have to
first _know_ about the warning and wonder "hey, didn't used ignore it?"
for that to be useful.

-Peff
