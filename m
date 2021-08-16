Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A8BC4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 16:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74FA960F58
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 16:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbhHPQTk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 12:19:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:48508 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231286AbhHPQTe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 12:19:34 -0400
Received: (qmail 20045 invoked by uid 109); 16 Aug 2021 16:18:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 16 Aug 2021 16:18:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15669 invoked by uid 111); 16 Aug 2021 16:18:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 16 Aug 2021 12:18:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 16 Aug 2021 12:18:52 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] ci: add job for gcc-4.8 to GitHub Actions
Message-ID: <YRqP7J7Gu0VmB6q2@coredump.intra.peff.net>
References: <20210816045750.36499-1-carenas@gmail.com>
 <444e7410-c9c9-1b90-da5f-d6862a35c1fc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <444e7410-c9c9-1b90-da5f-d6862a35c1fc@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 16, 2021 at 12:06:46PM -0400, Derrick Stolee wrote:

> Forgive me, I probably missed a discussion about this
> somewhere else on the list, but...
> 
> Could you describe why we want GCC 4.8 in our CI? Is that a
> compiler version that we officially support? What kind of
> syntax triggers a problem on 4.8 versus latest?

Try fb9d7431cf (travis-ci: build with GCC 4.8 as well, 2019-07-18).
(found with "git log -Sgcc-4.8 ci"). The gist of it is to find variable
declarations in for-loops.

IMHO it may be more trouble than it's worth. If we can't find a compiler
that complains on this construct, then maybe it is not a construct worth
worrying too much about.

-Peff
