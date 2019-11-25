Return-Path: <SRS0=39iz=ZR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60001C432C0
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 13:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B82C20740
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 13:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbfKYNTw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 08:19:52 -0500
Received: from cloud.peff.net ([104.130.231.41]:59826 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725823AbfKYNTw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 08:19:52 -0500
Received: (qmail 26114 invoked by uid 109); 25 Nov 2019 13:19:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 25 Nov 2019 13:19:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18348 invoked by uid 111); 25 Nov 2019 13:23:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 25 Nov 2019 08:23:52 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 25 Nov 2019 08:19:51 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] test-lib-functions: suppress a 'git rev-parse' error in
 'test_commit_bulk'
Message-ID: <20191125131951.GA494@sigill.intra.peff.net>
References: <20191125125907.28967-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191125125907.28967-1-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 25, 2019 at 01:59:07PM +0100, SZEDER Gábor wrote:

> When 'test_commit_bulk' is invoked in an empty test repository, it
> prints a "fatal: Needed a single revision" error, but still does what
> it's supposed to do.  A test helper function displaying a fatal error
> and still succeeding is always suspect to be buggy, but luckily that's
> not the case here: that error comes from a 'git rev-parse --verify
> HEAD' command invoked in a condition, which doesn't have anything to
> verify in an empty repository.
> 
> Use the '--quiet' option to suppress that error message.

Yep, makes perfect sense. Thanks.

-Peff
