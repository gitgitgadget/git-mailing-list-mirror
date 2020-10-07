Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DB0C41604
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 12:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD0642083B
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 12:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbgJGMt7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 08:49:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:51788 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727927AbgJGMt7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 08:49:59 -0400
Received: (qmail 19416 invoked by uid 109); 7 Oct 2020 12:49:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 07 Oct 2020 12:49:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10275 invoked by uid 111); 7 Oct 2020 12:49:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 07 Oct 2020 08:49:58 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 7 Oct 2020 08:49:57 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] GitHub workflow: automatically follow minor updates of
 setup-msbuild
Message-ID: <20201007124957.GA123549@coredump.intra.peff.net>
References: <pull.744.git.1602058669919.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.744.git.1602058669919.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 07, 2020 at 08:17:49AM +0000, Johannes Schindelin via GitGitGadget wrote:

> It is the custom to follow minor updates of GitHub Actions
> automatically, by using the suffix `@v1`. Actions' maintainers will then
> update that `v1` ref to point to the newest.
> 
> However, for `microsoft/setup-msbuild`, 889cacb6897 (ci: configure
> GitHub Actions for CI/PR, 2020-04-11) uses a very specific `@v1.0.0`
> suffix.
> 
> In this instance, that is a problem: should `setup-msbuild` release a
> new version that intends to fix a critical bug, we won't know it, and we
> won't use it.
> 
> Such a scenario is not theoretical. It is happening right now:
> https://github.blog/changelog/2020-10-01-github-actions-deprecating-set-env-and-add-path-commands
> 
> Let's simplify our setup, allowing us to benefit from automatically
> using the newest v1.x.

Thanks, that explanation makes perfect sense and the patch looks
obviously correct.

-Peff
