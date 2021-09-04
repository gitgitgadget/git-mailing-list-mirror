Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB131C433EF
	for <git@archiver.kernel.org>; Sat,  4 Sep 2021 15:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3B6F60F91
	for <git@archiver.kernel.org>; Sat,  4 Sep 2021 15:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237078AbhIDP4U (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Sep 2021 11:56:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:39448 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237063AbhIDP4O (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Sep 2021 11:56:14 -0400
Received: (qmail 593 invoked by uid 109); 4 Sep 2021 15:55:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 04 Sep 2021 15:55:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13089 invoked by uid 111); 4 Sep 2021 15:55:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 04 Sep 2021 11:55:12 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 4 Sep 2021 11:55:11 -0400
From:   Jeff King <peff@peff.net>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH] Docs: web server must setenv GIT_PROTOCOL for v2
Message-ID: <YTOW352xtsbvJcKy@coredump.intra.peff.net>
References: <20210904151721.445117-1-konstantin@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210904151721.445117-1-konstantin@linuxfoundation.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 04, 2021 at 11:17:21AM -0400, Konstantin Ryabitsev wrote:

> For the server-side to properly respond to v2 protocol requests, the
> webserver must set the GIT_PROTOCOL environment variable to the value of
> the Git-Protocol: request header.

Thanks for assembling these examples.

I don't mind having these in the technical documentation, but I think
most users won't find them there (nor would they even know they need to
be looking). Maybe the manpage for git-http-backend would be a better
spot. We can mention v2 in the "description" section, and then there's
some example config near the end that could include it.

Unfortunately there isn't any nginx example config there at all yet. If
you have kernel.org config you could share, that would be great. But
even starting with just the "here's how you do v2" part would be
welcome.

-Peff
