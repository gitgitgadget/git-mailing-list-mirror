Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94EA8C43334
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 18:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350066AbiFJSLR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jun 2022 14:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244325AbiFJSLP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jun 2022 14:11:15 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244D23B3CC
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 11:11:13 -0700 (PDT)
Received: (qmail 14840 invoked by uid 109); 10 Jun 2022 18:11:13 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.0.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Jun 2022 18:11:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Date:   Fri, 10 Jun 2022 14:11:12 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Volker =?utf-8?B?V2Vpw59tYW5u?= <volker.weissmann@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        git@vger.kernel.org
Subject: Re: git bisect outputs list of commits in the wrong order
Message-ID: <YqOJQKSH4eTo4cGn@coredump.intra.peff.net>
References: <3352fbbd-d555-fc51-1eac-692fdb5e4ae0@gmx.de>
 <xmqqsfoce8d7.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsfoce8d7.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 10, 2022 at 10:28:04AM -0700, Junio C Hamano wrote:

> I looked at an "scripted" version in the ancient past and it seems
> to have computed by iterating over
> 
> 	git rev-list bisect/bad --not $good_revs
> 
> which would have given these intermediate ones roughly in the
> reverse chronological order.  It could be that the behaviour
> regressed when the scripted version was rewritten in C, but I dunno.
> 
> Christian (as an "area" expert for bisect), do you have any
> comments?

It would probably be nice to show them as --oneline, as well. I'd guess
that a human reading the subjects of a handful of commits could quickly
make a good guess as to the actual culprit.

-Peff
