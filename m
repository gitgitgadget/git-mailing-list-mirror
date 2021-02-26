Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F74C433DB
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 20:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3D1A64F1B
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 20:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhBZUvD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Feb 2021 15:51:03 -0500
Received: from cloud.peff.net ([104.130.231.41]:46536 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229849AbhBZUvC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Feb 2021 15:51:02 -0500
Received: (qmail 19045 invoked by uid 109); 26 Feb 2021 20:50:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 26 Feb 2021 20:50:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25178 invoked by uid 111); 26 Feb 2021 20:50:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 26 Feb 2021 15:50:21 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 26 Feb 2021 15:50:21 -0500
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v4 00/12] Simple IPC Mechanism
Message-ID: <YDlfDZcMkcfJ8N7e@coredump.intra.peff.net>
References: <pull.766.v3.git.1613174954.gitgitgadget@gmail.com>
 <pull.766.v4.git.1613598529.gitgitgadget@gmail.com>
 <xmqq8s7cuebo.fsf@gitster.g>
 <YDiqeaNX/BeROFGf@coredump.intra.peff.net>
 <ff2eb93c-9b96-6fec-961b-adbe0fbda6fb@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ff2eb93c-9b96-6fec-961b-adbe0fbda6fb@jeffhostetler.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 26, 2021 at 03:18:26PM -0500, Jeff Hostetler wrote:

> > Sorry, I hadn't gotten around to looking at the latest version. I left
> > another round of comments. Some of them are arguably bikeshedding, but
> > there's at least one I think we'd want to address (the big stack buffer
> > in patch 1).
> > 
> > I also haven't carefully looked at the simple-ipc design at all; my
> > focus has just been on the details of socket and pktline code being
> > touched. Since there are no simple-ipc users yet, and since it's
> > internal and would be easy to change later, I'm mostly content for Jeff
> > to proceed as he sees fit and iterate on it as necessary.
> 
> We can wait until next week on moving this 'next' if you want.
> I'll attend to the buffer alloc in patch 1.  I'm still reading the
> other comments and will see where that takes me.

I could have been a bit more clear here: modulo any response you have to
my latest round of comments, I'm mostly happy to let this proceed to
next. So I was thinking you'd have one more re-roll dealing with the
patch 1 problems plus anything else you think worth addressing from my
batch of comments, and then that result would probably be ready for
'next'.

> I'm about ready to push an RFC for my fsmonitor--daemon series that
> sits on top of this simple-ipc series, so you can see an actual use
> case if that would help understand (my madness).

I may have dug my own grave here. ;) I'm actually not incredibly
interested in the overall topic. So I wasn't saying so much "I'll
reserve judgement on simple-ipc until I see callers" so much as "I
expect you'll find any shortcomings in its design yourself as you build
on top of it".

And by "not interested" I don't mean that I think the topic is without
value. Far from it; I think this is an important area to be working in.
But it's complex and time-consuming to review. So I was hoping somebody
with more expertise and interest in the problem space would do that part
of the review, and I could continue to focus on other stuff. That may be
wishful thinking, though. :)

-Peff
