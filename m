Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBD4C433F5
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 21:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C836B611B0
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 21:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbhJSVEH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:04:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:41942 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230190AbhJSVEG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Oct 2021 17:04:06 -0400
Received: (qmail 7399 invoked by uid 109); 19 Oct 2021 21:01:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 19 Oct 2021 21:01:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15189 invoked by uid 111); 19 Oct 2021 21:01:52 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 19 Oct 2021 17:01:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 19 Oct 2021 17:01:51 -0400
From:   Jeff King <peff@peff.net>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/2] some leak fixes on fs/ssh-signing-fix
Message-ID: <YW8yP0mb7j15y6Yy@coredump.intra.peff.net>
References: <YW2qpuosxr9PNwVa@coredump.intra.peff.net>
 <af0cf842-a16c-6cc3-fb61-b61422b24b17@gigacodes.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <af0cf842-a16c-6cc3-fb61-b61422b24b17@gigacodes.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 19, 2021 at 10:16:41AM +0200, Fabian Stelzer wrote:

> Is coverity included in the ci/gh actions? Where would these notices
> show up?

Not currently. I've been playing with running it in an action, and may
submit something to make it more official. There's some discussion here:

  https://lore.kernel.org/git/YV5dmkkuCqAY2qqG@coredump.intra.peff.net/

There's also some on-going work to make the test suite run without
leak-checkers (I didn't dig them up, but you can find recent topics and
commits from Ævar). But we've got a ways to go, so you'd likely find a
bunch of existing leaks if you tried it.

So no, for now there was nothing obvious you could have seen that would
have alerted you.

-Peff
