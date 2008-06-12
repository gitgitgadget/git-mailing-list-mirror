From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add test-tr: poor-man tr
Date: Thu, 12 Jun 2008 02:23:09 -0400
Message-ID: <20080612062309.GA31816@sigill.intra.peff.net>
References: <20080611182501.GA3344@steel.home> <20080611225448.GC19474@sigill.intra.peff.net> <20080612060152.GA3798@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 12 08:24:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6gE9-0000W1-Ei
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 08:24:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752075AbYFLGXM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 02:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751882AbYFLGXM
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 02:23:12 -0400
Received: from peff.net ([208.65.91.99]:3127 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751509AbYFLGXL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 02:23:11 -0400
Received: (qmail 10055 invoked by uid 111); 12 Jun 2008 06:23:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 12 Jun 2008 02:23:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Jun 2008 02:23:09 -0400
Content-Disposition: inline
In-Reply-To: <20080612060152.GA3798@steel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84720>

On Thu, Jun 12, 2008 at 08:01:52AM +0200, Alex Riesen wrote:

> Frankly, it started because I wanted to minimize use of Perl on
> Windows (because I can't get around ActiveState Perl at work, and it
> breaks almost everything it touches). Accidentally, it is also faster
> there (maybe just because it's smaller).

Ah, right. Well, I am not opposed to getting rid of perl in the test
scripts (there is core functionality provided by perl, so one can easily
run git on a system with no perl at all).

However, even with your patch, there is still some perl left, so I am
not sure that it has really bought us very much.

> But, as was already noted, tr does not behave the same for all
> platforms (there were even differences in output, BSD or Solaris put
> out a stray LF?).

I think those were all resolved by using perl, and your patch replaces
them with test-tr.

> > Or is your rationale "this will prevent people from screwing up the test
> > scripts accidentally in the future"?
> We just can't have that. Nothing can prevent people from screwing up
> anything in any given point of time :)

Heh. At least we can yell at them after the fact for not using the
available tool. :)

> In any case, I wont push this change too hard. I must admit, that
> there is no real good reason besides one "screwed" company using
> obsoleted tools in a weird way. And it is a maintenance effort (and
> people will forget to use test-tr instead of perl and tr).

There is maintenance effort either way; people need to know not to do
unportable things with tr (and other tools), and the solution to that is
to run the test scripts on each platform (something we are starting to
do).

So I am not opposed to test-tr, I just wanted you to explain it better
in the commit log. ;)

-Peff
