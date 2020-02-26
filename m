Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8E1C4BA24
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 20:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16B8C21556
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 20:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbgBZULX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 15:11:23 -0500
Received: from cloud.peff.net ([104.130.231.41]:55406 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727240AbgBZULX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 15:11:23 -0500
Received: (qmail 21458 invoked by uid 109); 26 Feb 2020 20:11:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 26 Feb 2020 20:11:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28902 invoked by uid 111); 26 Feb 2020 20:20:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 26 Feb 2020 15:20:29 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 26 Feb 2020 15:11:21 -0500
From:   Jeff King <peff@peff.net>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     Greg Anders <greg@gpanders.com>, git@vger.kernel.org
Subject: Re: git-shell default working directory
Message-ID: <20200226201121.GA287048@coredump.intra.peff.net>
References: <20200226004830.oxd5562v7qqspnkk@Kepler>
 <241ea912-44b2-96fa-6f9a-3f04d5386b05@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <241ea912-44b2-96fa-6f9a-3f04d5386b05@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 26, 2020 at 10:10:05AM +0100, Andrei Rybak wrote:

> > I've not yet found a way to get this to work without keeping the
> > repositories in the git user's home folder.
> 
> Disclaimer: I'm not at all familiar with git server setup. Would it make sense
> to change git user home directory to be the required dedicated directory?

Yeah, that's what I would suggest. git-shell does explicitly cd to
$HOME, so any chdir you do before then will be lost (though you could
perhaps just set $HOME in ~/.ssh/rc).

-Peff
