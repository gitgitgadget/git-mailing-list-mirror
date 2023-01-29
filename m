Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31706C61D97
	for <git@archiver.kernel.org>; Sun, 29 Jan 2023 06:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjA2GsT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Jan 2023 01:48:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjA2GsS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Jan 2023 01:48:18 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6F115CB4
        for <git@vger.kernel.org>; Sat, 28 Jan 2023 22:48:16 -0800 (PST)
Received: (qmail 24967 invoked by uid 109); 29 Jan 2023 06:48:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 29 Jan 2023 06:48:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18348 invoked by uid 111); 29 Jan 2023 06:48:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 29 Jan 2023 01:48:15 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 29 Jan 2023 01:48:14 -0500
From:   Jeff King <peff@peff.net>
To:     M Hickford via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH v3] Documentation: clarify that cache forgets credentials
 if the system restarts
Message-ID: <Y9YWruI4CdbJ9Rjn@coredump.intra.peff.net>
References: <pull.1447.v2.git.1674936563549.gitgitgadget@gmail.com>
 <pull.1447.v3.git.1674936815117.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1447.v3.git.1674936815117.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 28, 2023 at 08:13:34PM +0000, M Hickford via GitGitGadget wrote:

> diff --git a/Documentation/git-credential-cache.txt b/Documentation/git-credential-cache.txt
> index 432e159d952..f473994a864 100644
> --- a/Documentation/git-credential-cache.txt
> +++ b/Documentation/git-credential-cache.txt
> @@ -14,10 +14,13 @@ git config credential.helper 'cache [<options>]'
>  DESCRIPTION
>  -----------
>  
> -This command caches credentials in memory for use by future Git
> -programs. The stored credentials never touch the disk, and are forgotten
> -after a configurable timeout.  The cache is accessible over a Unix
> -domain socket, restricted to the current user by filesystem permissions.
> +This command caches credentials for use by future Git programs.
> +The stored credentials are kept in memory of the cache-daemon
> +process (instead of written to a file) and are forgotten after a
> +configurable timeout. Credentials are forgotten sooner if the
> +cache-daemon dies, for example if the system restarts. The cache
> +is accessible over a Unix domain socket, restricted to the current
> +user by filesystem permissions.

This version looks good to me.

-Peff
