Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3215C1F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 15:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbeGLP73 (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 11:59:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:56906 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726836AbeGLP73 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 11:59:29 -0400
Received: (qmail 1122 invoked by uid 109); 12 Jul 2018 15:49:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 12 Jul 2018 15:49:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23370 invoked by uid 111); 12 Jul 2018 15:49:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 12 Jul 2018 11:49:24 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Jul 2018 11:49:20 -0400
Date:   Thu, 12 Jul 2018 11:49:20 -0400
From:   Jeff King <peff@peff.net>
To:     William Chargin <wchargin@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2] sha1-name.c: for ":/", find detached HEAD commits
Message-ID: <20180712154920.GA6380@sigill.intra.peff.net>
References: <CAFW+GMD62V=o4hoEYKVteBZHzqBtquzLzTv2WXiSPZf3ZhOpeg@mail.gmail.com>
 <20180712054909.29077-1-wchargin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180712054909.29077-1-wchargin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 11, 2018 at 10:49:09PM -0700, William Chargin wrote:

> This patch broadens the set of commits matched by ":/" pathspecs to
> include commits reachable from HEAD but not any named ref. This avoids
> surprising behavior when working with a detached HEAD and trying to
> refer to a commit that was recently created and only exists within the
> detached state.
> 
> If multiple worktrees exist, only the current worktree's HEAD is
> considered reachable. This is consistent with the existing behavior for
> other per-worktree refs: e.g., bisect refs are considered reachable, but
> only within the relevant worktree.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> Signed-off-by: William Chargin <wchargin@gmail.com>
> Based-on-patch-by: Jeff King <peff@peff.net>
> ---
>  Documentation/revisions.txt   |  2 +-
>  sha1-name.c                   |  1 +
>  t/t4208-log-magic-pathspec.sh | 26 ++++++++++++++++++++++++++
>  3 files changed, 28 insertions(+), 1 deletion(-)

This one looks good to me. Thanks.

-Peff
