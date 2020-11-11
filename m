Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B75C388F7
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 02:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D869421D91
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 02:36:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732296AbgKKCgk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 21:36:40 -0500
Received: from cloud.peff.net ([104.130.231.41]:53884 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731810AbgKKCgi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 21:36:38 -0500
Received: (qmail 10325 invoked by uid 109); 11 Nov 2020 02:36:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 11 Nov 2020 02:36:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11780 invoked by uid 111); 11 Nov 2020 02:36:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 10 Nov 2020 21:36:37 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 10 Nov 2020 21:36:36 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/9] Fix color handling in git add -i
Message-ID: <20201111023636.GC806755@coredump.intra.peff.net>
References: <pull.785.git.1605051739.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.785.git.1605051739.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 10, 2020 at 11:42:10PM +0000, Johannes Schindelin via GitGitGadget wrote:

> This patch series started out as a tiny fix for a bug reported in 
> https://lore.kernel.org/git/313B8999-1E99-4695-A20D-E48840C30879@gmail.com/.
> And then I only wanted to add a regression test to make sure that this does
> not regress. And then I just wanted to ensure that it passes both with the
> Perl version of git add -i as well as with the built-in version.
> 
> And in no time I was looking at a real patch series.

OK, I see now why you wanted to roll my work in. There was quite a bit
more here than I expected. :)

> Johannes Schindelin (9):
>   add -i (built-in): do show an error message for incorrect inputs
>   add -i (built-in): send error messages to stderr
>   add -i: use `reset_color` consistently
>   add -i (built-in): prevent the `reset` "color" from being configured
>   add -i (built-in): use correct names to load color.diff.* config
>   add -p (built-in): do not color the progress indicator separately
>   add -i (built-in): use the same indentation as the Perl version
>   add -i (Perl version): include indentation in the colored header
>   add -i: verify in the tests that colors can be overridden

They all look good to me. I left some minor comments on the final patch.

-Peff
