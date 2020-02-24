Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2A4C3567B
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 06:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88C0920661
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 06:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgBXGku (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Feb 2020 01:40:50 -0500
Received: from cloud.peff.net ([104.130.231.41]:52472 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726452AbgBXGku (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Feb 2020 01:40:50 -0500
Received: (qmail 5822 invoked by uid 109); 24 Feb 2020 06:40:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 24 Feb 2020 06:40:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7613 invoked by uid 111); 24 Feb 2020 06:49:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 24 Feb 2020 01:49:55 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 24 Feb 2020 01:40:49 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] worktree: drop unused code from get_main_worktree()
Message-ID: <20200224064049.GD1015967@coredump.intra.peff.net>
References: <20200224015935.19190-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200224015935.19190-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 23, 2020 at 08:59:35PM -0500, Eric Sunshine wrote:

> This code has been unused since fa099d2322 (worktree.c: kill parse_ref()
> in favor of refs_resolve_ref_unsafe(), 2017-04-24), so drop it.

Looks obviously correct, unless we are depending on some side effect of
get_git_common_dir(). And if we are, then that should be fixed. ;)

-Peff
