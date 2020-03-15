Return-Path: <SRS0=FHek=5A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F47FC0044D
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 01:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1582D2071B
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 01:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbgCOBzA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Mar 2020 21:55:00 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:58352 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727317AbgCOBy7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Mar 2020 21:54:59 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id DAEB11F619;
        Sun, 15 Mar 2020 00:36:54 +0000 (UTC)
Date:   Sun, 15 Mar 2020 00:36:54 +0000
From:   Eric Wong <e@yhbt.net>
To:     Jeff King <peff@peff.net>
Cc:     James Ramsay <james@jramsay.com.au>, git@vger.kernel.org,
        meta@public-inbox.org
Subject: inbox indexing wishlist =?utf-8?B?W3dhczog?=
 =?utf-8?B?W1RPUElDIDE2LzE3XSDigJxJIHdhbnQgYSByZXZpZXdlcuKAnV0=?=
Message-ID: <20200315003654.GA711@dcvr>
References: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au>
 <6DAC1E49-9CA0-4074-867E-F22CD26C9FEB@jramsay.com.au>
 <20200313212531.GA22502@dcvr>
 <20200314172715.GA1178875@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200314172715.GA1178875@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> wrote:
> On Fri, Mar 13, 2020 at 09:25:31PM +0000, Eric Wong wrote:
> 
> > > 6. Peff: this is all possible on the mailing list. I see things that look
> > > interesting, and have a to do folder. If someone replies, I’ll take it off
> > > the list. Once a week go through all the items. I like the book club idea,
> > > instead of it being ad hoc, or by me, a group of a few people review the
> > > list in the queue. You might want to use a separate tool, like IRC, but it
> > > would be good to have it bring it back to the mailing list as a summary.
> > > Public inbox could be better, but someone needs to write it. Maybe nerd
> > > snipe Eric?
> > 
> > What now? :o
> > 
> > There's a lot of things it could be better at, but a more
> > concrete idea of what you want would help.
> 
> short answer: searching for threads that only one person participated in

+Cc meta@public-inbox.org

OK, something I've thought of doing anyways in the past...

> The discussion here was around people finding useful things to do on the
> list: triaging or fixing bugs, responding to questions, etc. And I said
> my mechanism for doing that was to hold interesting-looking but
> not-yet-responded-to mails in my git-list inbox, treating it like a todo
> list, and then eventually:
> 
>   1. I sweep through and spend time on each one.
> 
>   2. I see that somebody else responded, and I drop it from my queue.
> 
>   3. It ages out and I figure that it must not have been that important
>      (I do this less individually, and more by occasionally declaring
>      bankruptcy).
> 
> That's easy for me because I use mutt, and I basically keep my own list
> archive anyway. But it would probably be possible to use an existing
> archive and just search for "threads with only one author from the last
> 7 days". And people could sweep through that[1].
> 
> You already allow date-based searches, so it would really just be adding
> the "thread has only one author" search. It's conceptually simple, but
> it might be hard to index (because of course it may change as messages
> are added to the archive, though any updates are bounded to the set of
> threads the new messages are in).

Exactly on being conceptually simple but requiring some deeper
changes to the way indexing works.  I'll have to think about it
a bit, but it should be doable without being too intrusive,
invasive or expensive for existing users.

> But to be clear, I don't think you have any obligation here. I just
> wondered if it might be interesting enough that you would implement it
> for fun. :) As far as I'm concerned, if you never implemented another
> feature for public-inbox, what you've done already has been a great
> service to the community.

Thanks.  I'll keep that index change in mind and it should be
doable if I remain alive and society doesn't collapse...

> [1] The obvious thing this lacks compared to my workflow is a way to
>     mark threads as "seen" or "not interesting". But that implies
>     per-user storage.

Yeah, that would be part of the local tools bit I've been
thinking about (user labels such as "important", "seen",
"replied", "new", "ignore", ... flags).
