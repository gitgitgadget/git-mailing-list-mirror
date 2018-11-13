Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10FF71F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 14:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387749AbeKNAsC (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 19:48:02 -0500
Received: from cloud.peff.net ([104.130.231.41]:37144 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2387720AbeKNAsC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 19:48:02 -0500
Received: (qmail 18600 invoked by uid 109); 13 Nov 2018 14:49:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 13 Nov 2018 14:49:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19862 invoked by uid 111); 13 Nov 2018 14:48:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 13 Nov 2018 09:48:53 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Nov 2018 09:49:31 -0500
Date:   Tue, 13 Nov 2018 09:49:31 -0500
From:   Jeff King <peff@peff.net>
To:     Rafael =?utf-8?B?QXNjZW5zw6Nv?= <rafa.almas@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, nbelakovski@gmail.com,
        avarab@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] branch: Mark and colorize a branch differently if
 it is checked out in a linked worktree
Message-ID: <20181113144931.GC17454@sigill.intra.peff.net>
References: <20180927204049.GA2628@rigel>
 <20181111235831.44824-1-nbelakovski@gmail.com>
 <20181111235831.44824-3-nbelakovski@gmail.com>
 <xmqqo9au1tsj.fsf@gitster-ct.c.googlers.com>
 <20181112121423.GA3956@sigill.intra.peff.net>
 <20181112180549.ojt3twhsfm5xkako@rigel>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181112180549.ojt3twhsfm5xkako@rigel>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 12, 2018 at 06:07:18PM +0000, Rafael Ascensão wrote:

> On Mon, Nov 12, 2018 at 07:14:23AM -0500, Jeff King wrote:
> > just adding a bunch of color variants. It would be nice if we could just
> > do this with a run-time parse_color("bold red") or whatever, but we use
> > these as static initializers.
> 
> I suggested those colors, but now, I think this needs to be
> configurable.

I think they are configurable in that patch, since it provides
"worktree" as a n entry in color_branch_slots. But yeah, every color we
add needs to be configurable, and this is really just about defaults.

> I suggested using green and dim green as the obvious theoretical choice
> but after using it for a while I found out that both shades are way too
> similar, making it really hard to tell by glancing at the output,
> especially when they're not side by side.
> 
> If we continue with two dual green approach, current branch needs to be
> at least bold. But I'm not sure if it's enough.
> 
> I've been trying some other colors, and cyan feels neutral-ish.

Yeah, cyan seems pretty reasonable to me.

-Peff
