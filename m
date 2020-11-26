Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572E1C56202
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 07:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F03DF206C0
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 07:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730641AbgKZHhz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Nov 2020 02:37:55 -0500
Received: from cloud.peff.net ([104.130.231.41]:43470 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729906AbgKZHhz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Nov 2020 02:37:55 -0500
Received: (qmail 14932 invoked by uid 109); 26 Nov 2020 07:37:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 26 Nov 2020 07:37:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14434 invoked by uid 111); 26 Nov 2020 07:37:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Nov 2020 02:37:54 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 26 Nov 2020 02:37:54 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?U2ltw6Nv?= Afonso <simao.afonso@powertools-tech.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v3] crendential-store: use timeout when locking file
Message-ID: <X79bUrreRkpiiorU@coredump.intra.peff.net>
References: <xmqq4kleif26.fsf@gitster.c.googlers.com>
 <20201125183123.47praa6hcgrgrib4@safonso-t430>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201125183123.47praa6hcgrgrib4@safonso-t430>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 25, 2020 at 06:31:23PM +0000, Simão Afonso wrote:

> When holding the lock for rewriting the credential file, use a timeout
> to avoid race conditions when the credentials file needs to be updated
> in parallel.
> 
> An example would be doing `fetch --all` on a repository with several
> remotes that need credentials, using parallel fetching.
> 
> The timeout can be configured using "credentialStore.lockTimeoutMS",
> defaulting to 1 second.
> 
> Signed-off-by: Simão Afonso <simao.afonso@powertools-tech.com>
> ---
> 
> lockTimeoutMS sounds like the consensual name, implemented.

Thanks, this version looks good to me.

-Peff
