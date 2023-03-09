Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5532C64EC4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 03:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjCIDKF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 22:10:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCIDKE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 22:10:04 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC33E769F9
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 19:10:00 -0800 (PST)
Received: (qmail 4515 invoked by uid 109); 9 Mar 2023 03:10:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Mar 2023 03:10:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27054 invoked by uid 111); 9 Mar 2023 03:09:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 08 Mar 2023 22:09:59 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 8 Mar 2023 22:09:59 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fetch: pass --no-write-fetch-head to subprocesses
Message-ID: <ZAlOB0XZaGPUJMS7@coredump.intra.peff.net>
References: <20230308100438.908471-1-e@80x24.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230308100438.908471-1-e@80x24.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 08, 2023 at 10:04:38AM +0000, Eric Wong wrote:

> It seems a user would expect this option would work regardless
> of whether it's fetching from a single remote or many.
> 
> Signed-off-by: Eric Wong <e@80x24.org>
> ---
>  I haven't checked if there's other suitable options which could
>  go into add_options_to_argv(); hopefully someone else can check :>

There's at least one that came up before:

  https://lore.kernel.org/git/DM5PR1701MB1724CCBB1AC5CF342BA9ADD5898E9@DM5PR1701MB1724.namprd17.prod.outlook.com/

but it never got turned into a real patch.

This is obviously an error-prone mechanism.  It would be nice if there
was a way to avoid it, but after some discussion in this thread, we
didn't come up with anything clever:

  https://lore.kernel.org/git/20200914121906.GD4705@pflmari/

-Peff
