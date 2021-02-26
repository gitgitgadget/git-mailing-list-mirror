Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5F5C433DB
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 07:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9451A64ED3
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 07:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbhBZH0a (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Feb 2021 02:26:30 -0500
Received: from cloud.peff.net ([104.130.231.41]:45644 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230037AbhBZH00 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Feb 2021 02:26:26 -0500
Received: (qmail 12311 invoked by uid 109); 26 Feb 2021 07:25:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 26 Feb 2021 07:25:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16932 invoked by uid 111); 26 Feb 2021 07:25:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 26 Feb 2021 02:25:38 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 26 Feb 2021 02:25:38 -0500
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v4 07/12] unix-socket: elimiate static
 unix_stream_socket() helper function
Message-ID: <YDiicvQEE9L7m3T9@coredump.intra.peff.net>
References: <pull.766.v3.git.1613174954.gitgitgadget@gmail.com>
 <pull.766.v4.git.1613598529.gitgitgadget@gmail.com>
 <b368318e6a23f8c4e60f77a8b81b558c523d5b03.1613598529.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b368318e6a23f8c4e60f77a8b81b558c523d5b03.1613598529.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 17, 2021 at 09:48:43PM +0000, Jeff Hostetler via GitGitGadget wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> The static helper function `unix_stream_socket()` calls `die()`.  This
> is not appropriate for all callers.  Eliminate the wrapper function
> and make the callers propagate the error.

Thanks for breaking it up this way. It's (IMHO) much easier to see the
motivation and impact of the changes now.

There's a small typo in the subject:

> Subject: unix-socket: elimiate static unix_stream_socket() helper function

-Peff
