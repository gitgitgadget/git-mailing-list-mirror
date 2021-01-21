Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D696C433DB
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 21:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57F0023A22
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 21:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbhAUVK2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jan 2021 16:10:28 -0500
Received: from cloud.peff.net ([104.130.231.41]:34546 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727673AbhAUVJ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jan 2021 16:09:27 -0500
Received: (qmail 6919 invoked by uid 109); 21 Jan 2021 21:08:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 21 Jan 2021 21:08:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6061 invoked by uid 111); 21 Jan 2021 21:08:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 21 Jan 2021 16:08:31 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 21 Jan 2021 16:08:29 -0500
From:   Jeff King <peff@peff.net>
To:     Martin von Zweigbergk <martinvonz@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        "B. Stebler" <bono.stebler@gmail.com>, git <git@vger.kernel.org>
Subject: Re: Improving merge of tricky conflicts
Message-ID: <YAntTS6UQIUWZngD@coredump.intra.peff.net>
References: <a0418859-c62e-c207-a1b0-1b1aaf178527@gmail.com>
 <4df975f0-e4b1-afa1-cac1-f38e6d31a0d8@kdbg.org>
 <20200722074530.GB3306468@coredump.intra.peff.net>
 <xmqqmu3r5umr.fsf@gitster.c.googlers.com>
 <20200723182549.GB3975154@coredump.intra.peff.net>
 <CANiSa6iV3WbS9VQdUQ-eF=dcz-mmQXvyckGJL8ZhpgFYc7U_TQ@mail.gmail.com>
 <YAmPnfb/KMlqimhH@coredump.intra.peff.net>
 <CANiSa6jsjrm-i+T1zSBMFqpUqy-PJpai39JtH47m=v1TO_fi4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANiSa6jsjrm-i+T1zSBMFqpUqy-PJpai39JtH47m=v1TO_fi4A@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 21, 2021 at 10:30:36AM -1000, Martin von Zweigbergk wrote:

> > I think rather than thinking of these as expanded conflict markers, it
> > would probably be a more useful workflow to just look at the diff in a
> > separate command (so just show the conflicts, not everything else, and
> > just show the diff). I suspect it could be made pretty nice with some
> > simple editor support (e.g., open a new buffer in the editor showing the
> > diff for just the current hunk, or even the current _half_ of the hunk
> > you're on).
> 
> At some point it seems better to delegate to a proper merge tool. You
> said that you use vim, so I'm a little surprised that you use conflict
> markers instead of using vimdiff. I don't use vim and I've never
> really used vimdiff. I still use conflict markers, mostly out of
> habit, but also because I usually run in a tmux session on a remote
> machine. I feel like I should try to switch to meld.

Yeah, I think your first sentence might be the most important takeaway. ;)

I have tried using vimdiff in the past, but didn't really like it. My
recollection is that it was clunky to navigate, and I could fix most
conflicts much faster just by looking at them. But I have never been a
heavy user of the multi-window multi-buffer stuff in vim. My "open a new
buffer in the editor" is probably a lie; for me it is more like "open a
new terminal and run a command at the shell". :)

-Peff
