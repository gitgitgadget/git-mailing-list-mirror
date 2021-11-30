Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2283C433EF
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 20:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343826AbhK3VAq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 16:00:46 -0500
Received: from cloud.peff.net ([104.130.231.41]:40478 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343849AbhK3U7x (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 15:59:53 -0500
Received: (qmail 13973 invoked by uid 109); 30 Nov 2021 20:56:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 30 Nov 2021 20:56:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30171 invoked by uid 111); 30 Nov 2021 20:56:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Nov 2021 15:56:32 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 30 Nov 2021 15:56:30 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Slavica =?utf-8?B?xJB1a2nEhw==?= <slawica92@hotmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/2] Use the built-in implementation of the interactive
 add command by default
Message-ID: <YaaP/g74KA63MCmx@coredump.intra.peff.net>
References: <pull.1087.git.1638281655.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <pull.1087.git.1638281655.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 30, 2021 at 02:14:13PM +0000, Johannes Schindelin via GitGitGadget wrote:

> Over two years ago, Slavica Đukić participated in the Outreachy project,
> starting to implement a built-in version of the interactive git add command.
> A little over a year ago, Git turned on that mode whenever users were
> running with feature.experimental = true.
> 
> It is time to declare this implementation robust, to use it by default, and
> to start deprecating the scripted implementation.

Yay. I agree it is time.

It's still possible there are bugs that feature.experimental folks
missed, but at some point we need to flip this switch to get the
exposure to find those bugs. Doing it early in a cycle makes sense.

The patches themselves look good to me. I look forward to dropping the
perl version entirely, just to reduce the duplicated code, but I think
your approach of leaving it as an escape hatch for now makes sense in
the shorter term.

-Peff
