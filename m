Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A2511F454
	for <e@80x24.org>; Mon, 11 Nov 2019 03:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbfKKDyW (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Nov 2019 22:54:22 -0500
Received: from cloud.peff.net ([104.130.231.41]:44110 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726749AbfKKDyW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Nov 2019 22:54:22 -0500
Received: (qmail 14826 invoked by uid 109); 11 Nov 2019 03:54:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 11 Nov 2019 03:54:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1393 invoked by uid 111); 11 Nov 2019 03:57:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 10 Nov 2019 22:57:50 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 10 Nov 2019 22:54:20 -0500
From:   Jeff King <peff@peff.net>
To:     "Robin H. Johnson" <robbat2@gentoo.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 1/3] bundle: framework for options before bundle file
Message-ID: <20191111035420.GA6379@sigill.intra.peff.net>
References: <1f7f0aa1e8fae54bf967ae83a160be2b30db634f.1573248640.git.gitgitgadget@gmail.com>
 <20191110204126.30553-1-robbat2@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191110204126.30553-1-robbat2@gentoo.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 10, 2019 at 12:41:24PM -0800, Robin H. Johnson wrote:

> Make it possible for any of the git-bundle subcommands to include
> options:
> - before the sub-command
> - after the sub-command, before the bundle filename

On reading your subject and the start of the commit message, I thought
you mean that you meant to allow both:

  git bundle --foo create

and

  git bundle create --foo

But looking at the patch, this is about creating two separate sets of
options, one for all sub-commands, and one for each individual
sub-command. That makes sense to me. I don't know if it's worth trying
to spell that out more explicitly in the commit message.

-Peff
