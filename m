Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CBAC1FD99
	for <e@80x24.org>; Sun, 14 Aug 2016 12:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752958AbcHNMTZ (ORCPT <rfc822;e@80x24.org>);
	Sun, 14 Aug 2016 08:19:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:55004 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752337AbcHNMTY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2016 08:19:24 -0400
Received: (qmail 28062 invoked by uid 109); 14 Aug 2016 12:19:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 14 Aug 2016 12:19:23 +0000
Received: (qmail 7393 invoked by uid 111); 14 Aug 2016 12:19:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 14 Aug 2016 08:19:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 14 Aug 2016 08:19:20 -0400
Date:	Sun, 14 Aug 2016 08:19:20 -0400
From:	Jeff King <peff@peff.net>
To:	Eric Wong <e@80x24.org>
Cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: A note from the maintainer
Message-ID: <20160814121920.r7uxpepcz6spjcy4@sigill.intra.peff.net>
References: <xmqq1t1twymf.fsf@gitster.mtv.corp.google.com>
 <20160812224255.GA16250@dcvr>
 <20160813081012.p46i4jcvkkfqch7m@sigill.intra.peff.net>
 <20160813090432.GA25565@starla>
 <20160813111449.vkoo3fmlfd65loh5@sigill.intra.peff.net>
 <20160814012706.GA18784@starla>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160814012706.GA18784@starla>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Aug 14, 2016 at 01:27:06AM +0000, Eric Wong wrote:

> What's also interesting about the thread you highlighed is the
> extra '<>' when you started that thread; and I have a bug where
> I strip off an extra '>' which needs to be fixed...

Oh, that's interesting. It's not in the message that started the thread;
the bug is in the in-reply-to headers of the patches themselves. I don't
remember what I was using to send patches back then. It might have been
send-email, and I suspect I did:

  git send-email --in-reply-to='<whatever>'

after cutting-and-pasting '<whatever>' from the cover letter.

> I wonder if I should make "editorial" changes to fixup user bugs,
> but then there's also bunch of messages which are replies to <y>
> because git-send-email had usability problems back in the day...

I wouldn't go too far in editorial changes. I made a few when skimming
the messages I just sent for spam, and dropped some empty messages, or
"unsubscribe me" ones. But it's not worth the human effort to go back
and scrub list archives from 10 years ago.

Fixing up an extra "<>" is easily done once in your parsing scripts,
though, and I'd be surprised if I'm the only one to have made that
mistake.

> The one which started the thread belonging to
> <loom.20100716T103549-783@post.gmane.org> was really iffy,

I think I exercised editorial control over similar "your software is now
listed in our archive!" messages in what I sent. But yeah, there's going
to be some spam and some cruft in the archive. It's just a fact of life.
The solution is good searching and organizing tools to find the signal
you're looking for, not to make sure the noise hits zero.

>   git cat-file blob HEAD:b7/5bb577d76487bc9aebf0656d4e03eff22049f4
> 
> is totally legit, but doesn't seem to show up properly,

Heh, yeah, I saw that one (and I think it broke some of my initial
scripting, which foolishly assumed nobody had message-ids with spaces in
them).

-Peff
