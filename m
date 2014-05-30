From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Improve function dir.c:trim_trailing_spaces()
Date: Thu, 29 May 2014 22:04:44 -0400
Message-ID: <20140530020444.GH28683@sigill.intra.peff.net>
References: <1401320757-9360-1-git-send-email-pasha.bolokhov@gmail.com>
 <20140529201334.GA17355@sigill.intra.peff.net>
 <CAKpPgveDfNq+kxWCukULPqvn7H2XsfS8maC0ExzvHzFGiEAPbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>
To: Pasha Bolokhov <pasha.bolokhov@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 30 04:04:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqCBe-0002UQ-5Z
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 04:04:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753584AbaE3CEr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2014 22:04:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:33865 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751304AbaE3CEq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2014 22:04:46 -0400
Received: (qmail 3506 invoked by uid 102); 30 May 2014 02:04:46 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 29 May 2014 21:04:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 May 2014 22:04:44 -0400
Content-Disposition: inline
In-Reply-To: <CAKpPgveDfNq+kxWCukULPqvn7H2XsfS8maC0ExzvHzFGiEAPbg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250430>

On Thu, May 29, 2014 at 02:34:33PM -0700, Pasha Bolokhov wrote:

> > However, I doubt it makes that much of a difference in practice, so
> > unless it's measurable, I would certainly go with the version that is
> > more readable (and correct, of course).
> 
>     Sorry, just to recap, you would go with the existing version
> (which needs correction), or with the one that is being suggested? (I
> agree I can format the style a tiny bit better in the latter one)

I actually think the original left-to-right is a little easier to
follow, but I do not feel strongly. I mainly meant "argue based on
readability and correctness, do not argue based on speed".

>      Tests should not be a big problem, although it's kind of clumsy
> to test an internal function which does not really give any output
> (you can only measure the outcome). Just again to stress, I have
> tested both implementation extensively and the suggested new
> implementation gives the correct answers for all your examples below
> and all others. If I show this with explicit "t/" tests, will it
> suffice then?

Yes. I think specifically that you can extend the tests at the end of
t0008.

>     Basically what I suggest is
> 
> -- either: improve the existing function such that it does correctly
> that "text  \   " case, and also does not use 'strlen' since it anyway
> moves left to right
> 
> -- or: use the new suggested implementation (and just brush the
> formatting a bit), and perhaps borrow 'len' from the calling routine
> 
> And add tests in any case. What is the preference?

I'd be OK with either, though I have a slight preference for the first,
just because I find the "bslash ^= 1" bit of yours, while clever, a bit
hard to follow.

-Peff
