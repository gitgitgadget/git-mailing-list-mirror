Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C77A81FD99
	for <e@80x24.org>; Tue,  9 Aug 2016 10:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751914AbcHIK5K (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 06:57:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:51883 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750873AbcHIK5J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 06:57:09 -0400
Received: (qmail 19991 invoked by uid 109); 9 Aug 2016 10:57:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Aug 2016 10:57:07 +0000
Received: (qmail 19386 invoked by uid 111); 9 Aug 2016 10:57:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Aug 2016 06:57:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Aug 2016 06:57:05 -0400
Date:	Tue, 9 Aug 2016 06:57:05 -0400
From:	Jeff King <peff@peff.net>
To:	Michael J Gruber <git@drmicha.warpmail.net>
Cc:	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Sixt <j6t@kdbg.org>, Duy Nguyen <pclouds@gmail.com>,
	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	Richard Ipsum <richard.ipsum@codethink.co.uk>,
	Eric Wong <e@80x24.org>, Josh Triplett <josh@joshtriplett.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Philip Oakley <philipoakley@iee.org>
Subject: Re: patch submission process, was Re: [PATCH v6 06/16]
 merge_recursive: abort properly upon errors
Message-ID: <20160809105705.pyzr7be3gvzw2pid@sigill.intra.peff.net>
References: <xmqqy44ec15p.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1608031021050.79248@virtualbox>
 <CAPc5daXJzMsJf5K84XBFuQ5=q_OwtYUW2FikZ2QsZWk8fa9jgg@mail.gmail.com>
 <alpine.DEB.2.20.1608031753431.107993@virtualbox>
 <CAGZ79kYWdZCNW_eBi5aLAacyBZJXQ9xyOWMBmjNsYT5NWjr-Og@mail.gmail.com>
 <alpine.DEB.2.20.1608041730130.5786@virtualbox>
 <6c937f79-2b82-619d-51fe-adccbe09bd66@alum.mit.edu>
 <xmqqshuedh1i.fsf@gitster.mtv.corp.google.com>
 <3055f063-c9c1-0bf5-99bd-08256c253d33@alum.mit.edu>
 <6adc480d-15e3-c0ac-0e05-eb10c767a8ab@drmicha.warpmail.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6adc480d-15e3-c0ac-0e05-eb10c767a8ab@drmicha.warpmail.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 09, 2016 at 10:11:30AM +0200, Michael J Gruber wrote:

> Maybe two more points of input for the discussion:
> 
> off-line capabilities
> =====================
> 
> The current workflow here seems to work best when you are subscribed to
> the git-ml and have your own (local, maybe selective) copy of git-ml in
> your (text-based) MUA (mutt, (al)pine, emacs, ...) that can jump right
> into git-am and such directly. I'm not sure how important the "off-line"
> aspect of that is for some of us, and how that could be replicated on
> GitHub - while PRs and such may be Git based behind the scenes there
> seems to be no way to clone that info and work from a local clone.
> (Don't know if GitLab is more open.)

You can pull it all out via GitHub's HTTP API, but the question is what
format you would use to store it locally (and which tools you would then
use to play with it).

I haven't really tried this lately, though, so I don't know if there is
information that the API would be missing.

I do have a dream of writing a tool that sucks in GitHub PRs to a fake
email thread, lets me make my responses inline in an editor, and then
pushes it back up as PR comments (finding the right positions based on
the quoted context).

> For git-ml, I had to learn early on to answer by e-mail to git-ml rather
> than by nntp-reply because proper nntp-replies somehow didn't meet the
> expectations of the e-mail users (double copies because of the cc-policy
> or such, I don't remember).

At least some people's workflows seem to send two copies to the list.
For instance, Jakub's <2bfd9cf5-a9fa-7650-21e9-9ceb9cc34d8b@gmail.com>
got delivered to me via the list twice. Once directly from gmail with:

  To: Oleg Taranenko <olegtaranenko@gmail.com>,
      Junio C Hamano <gitster@pobox.com>
  Cc: git@vger.kernel.org

and once via gmane with:

  To: git@vger.kernel.org
  Cc: git@vger.kernel.org

It's like this with all of his messages (sorry I can't point to the
duplicates in an archive; they have the same message-id, so public-inbox
treats them as a single unit).

Replying to the second one breaks the usual "cc-everybody" rule. Sending
duplicates means everybody sees it twice (3 times if they're on the cc
list!), and the second copy still has the bogus headers (so people
replying need to pick the right one).

> I use git sendemail even for small throw-in patches because the git-ml
> does not allow attachments but wants patches (files) as in-line text,
> and Thunderbird possibly reformats text (because it's text, you know).

I wonder if this is something we could change. I do not personally have
any problem with attached patches. "git am" knows how to apply them, and
mutt is smart enough to show text/* by default, and to include it in
quoted text on reply. So the output of "git format-patch --attach" works
fine for me. But it may not be as nice in other MUAs, and we have to
care about all of the other reviewers.

> When I want to try out a proposed patch I have to "save message" and run
> git-am because patches don't come as file attachments on the git-ml
> (can't use "save/open attachment"+ git-apply) nor a PR (can't use git
> fetch nor view in browser). If it's a series, I have to do that for each
> invididual patch, which usually means I simply don't (or rely on Junio
> doing it and fetch his xy/topic branch).

So you would like the opposite of my dream tool, I think: something that
takes mailing list conversations and turns them into PRs.

(My real dream is actually to have a bidirectional version of the tool,
so that everybody can use whatever interface they like, and nobody has
to care about somebody else's preferences).

> And more often than not, patches from series do not appear in sequence,
> not threaded on top of the cover letter (in the gmane nntp version of
> git-ml), and it usually happens for the same people again and again,
> which tells me it's a git sendemail config issue and not gmane.

Just a guess, but I suspect this is caused by people who use "rebase -i"
to rearrange patches. When format-patch writes out the patches, it uses
the author date as the "Date" field, which means it may be out of order.
I think send-email will always write out a new, monotonically increasing
date. But I suspect other workflows (e.g., imap-send and then mailing
from a MUA) blindly re-use that date.

> Suggestion
> ==========
> 
> Maybe the current gmane woes are a good reason to try out something
> different for a month or two, with copies to the git-ml, and with the
> default being to revert back to git-ml after that and discuss what we've
> learned. As a result we may improve our workflow here, get GitHub to
> improve, and maybe switch or not. Either way we could profit from that.

I think public-inbox is a nice step forward on the reading side (it's a
lot easier to get raw patches out of it, for example). But it doesn't
help much with sending (and sending is a tricky subject; anytime you
promise to send mail on behalf of somebody, you're going to attract
spammers).

-Peff
