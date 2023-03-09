Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18AB9C678D5
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 03:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjCIDRP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 22:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjCIDRO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 22:17:14 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427629311E
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 19:17:12 -0800 (PST)
Received: (qmail 4575 invoked by uid 109); 9 Mar 2023 03:17:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Mar 2023 03:17:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27131 invoked by uid 111); 9 Mar 2023 03:17:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 08 Mar 2023 22:17:12 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 8 Mar 2023 22:17:11 -0500
From:   Jeff King <peff@peff.net>
To:     Alejandro Colomar <alx.manpages@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Better suggestions when git-am(1) fails
Message-ID: <ZAlPtxZ/0Z28r5tF@coredump.intra.peff.net>
References: <897c200c-afb3-ceb4-bf44-9af651f5feb4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <897c200c-afb3-ceb4-bf44-9af651f5feb4@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 08, 2023 at 09:15:53PM +0100, Alejandro Colomar wrote:

> I had the following error already a few times, when some contributors,
> for some reason unknown to me, remove the leading path components from
> the patch.

The reason is probably that they have set diff.noprefix in their config,
and git-format-patch respects that. Which is arguably a bug. There's a
little discussion in this message, along with references to some
previous discussions:

  https://lore.kernel.org/git/ZAWnDUkgO5clf6qu@coredump.intra.peff.net/

> Now I know that the fix is to use -p0, but the first times it wasn't
> obvious.  And still I forget about -p0 sometimes and it's hard to find
> in the manual pages.  I think it would be good to suggest using it
> when such an error appears.

I agree it may be reasonable to have "git am" be more helpful on the
receiving side. Hopefully if format-patch is changed then you wouldn't
see the situation as often, but it could still happen.

-Peff
