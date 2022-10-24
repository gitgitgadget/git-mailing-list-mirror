Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3806C67871
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 00:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbiJYAz1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Oct 2022 20:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbiJYAzB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2022 20:55:01 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9530F1E09BB
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 16:40:00 -0700 (PDT)
Received: (qmail 4522 invoked by uid 109); 24 Oct 2022 23:40:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 24 Oct 2022 23:40:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11985 invoked by uid 111); 24 Oct 2022 23:40:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 24 Oct 2022 19:40:00 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 24 Oct 2022 19:39:59 -0400
From:   Jeff King <peff@peff.net>
To:     John Cai <johncai86@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/2] fsck: remove the unused BAD_TAG_OBJECT
Message-ID: <Y1ciT5zuFiZgavIN@coredump.intra.peff.net>
References: <pull.1369.git.git.1666623639.gitgitgadget@gmail.com>
 <f32ff5dc4eed5bffe8bb0759c408c3d0861ddb50.1666623639.git.gitgitgadget@gmail.com>
 <xmqqwn8ptb0p.fsf@gitster.g>
 <xmqq4jvtt7cd.fsf@gitster.g>
 <4FFF6EB5-B9A3-4E32-840C-3FD6E893F5BF@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4FFF6EB5-B9A3-4E32-840C-3FD6E893F5BF@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 24, 2022 at 02:33:39PM -0400, John Cai wrote:

> >>> From: John Cai <johncai86@gmail.com>
> >>>
> >>> The BAD_TAG_OBJECT msg-id is not being used anymore, so we can remove
> >>> it.
> >>
> >> Do you have a ready reference to the change that made it no longer
> >> needed (or stopped detecting the error the message was meant to be
> >> issued against)?
> >
> > 2175a0c6 (fsck: stop checking tag->tagged, 2019-10-18) stopped
> > checking the tagged object referred to by a tag object, which the
> > error message BAD_TAG_OBJECT was about.  Since then the
> > BAD_TAG_OBJECT message is no longer used.
> 
> Thanks for doing my work for me :)

Thanks for finding this. That commit is mine, and I should have removed
it then. :)

For future reference, I did the same search via:

  git log -SBAD_TAG_OBJECT fsck.c

I find "-S" is great for these kind of "when did this stop getting used"
queries.

-Peff
