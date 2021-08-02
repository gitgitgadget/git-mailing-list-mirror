Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DF9C4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 18:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 293B4610A2
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 18:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbhHBSJG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 14:09:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:35990 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229537AbhHBSJG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 14:09:06 -0400
Received: (qmail 29627 invoked by uid 109); 2 Aug 2021 18:08:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 02 Aug 2021 18:08:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3776 invoked by uid 111); 2 Aug 2021 18:08:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 02 Aug 2021 14:08:56 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 2 Aug 2021 14:08:55 -0400
From:   Jeff King <peff@peff.net>
To:     Joseph Jenne <joseph.jenne15@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: BUG: git log dies to SIGPIPE
Message-ID: <YQg0t2bzqwBJ02yL@coredump.intra.peff.net>
References: <CAB5AetcMK6=yZh4OY-0A6x6vs7X+0_1APfp4cCP_MSK_TO46ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAB5AetcMK6=yZh4OY-0A6x6vs7X+0_1APfp4cCP_MSK_TO46ow@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 02, 2021 at 10:46:53AM -0700, Joseph Jenne wrote:

> What did you do before the bug happened? (Steps to reproduce your issue)
> used `git log`, exiting the viewer (`less`) before reading the entire
> commit history of the project
> What did you expect to happen? (Expected behavior)
> normal exit with status code 0
> What happened instead? (Actual behavior)
> git log dies to SIGPIPE after `less` exits
> What's different between what you expected and what actually happened?
> git does not exit normally as would be expected

FWIW, there was a discussion about this a few months ago:

  https://lore.kernel.org/git/YAG%2FvzctP4JwSp5x@zira.vinc17.org/

-Peff
