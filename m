From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] add--interactive: ignore mode change in 'p'atch
	command
Date: Thu, 27 Mar 2008 15:31:47 -0400
Message-ID: <20080327193147.GA10034@sigill.intra.peff.net>
References: <cover.1206602393.git.peff@peff.net> <20080327073043.GB22444@coredump.intra.peff.net> <7v7ifob0et.fsf@gitster.siamese.dyndns.org> <20080327171022.GA27189@coredump.intra.peff.net> <7vprtg9g0p.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	=?utf-8?B?SsO2cmc=?= Sommer <joerg@alea.gnuu.de>,
	Wincent Colaiuta <win@wincent.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 27 20:32:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jexpy-0005UD-2g
	for gcvg-git-2@gmane.org; Thu, 27 Mar 2008 20:32:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755995AbYC0Tbw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2008 15:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756708AbYC0Tbv
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Mar 2008 15:31:51 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4046 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755776AbYC0Tbv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2008 15:31:51 -0400
Received: (qmail 29178 invoked by uid 111); 27 Mar 2008 19:31:49 -0000
Received: from lawn-128-61-25-125.lawn.gatech.edu (HELO sigill.intra.peff.net) (128.61.25.125)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 27 Mar 2008 15:31:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Mar 2008 15:31:47 -0400
Content-Disposition: inline
In-Reply-To: <7vprtg9g0p.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78362>

On Thu, Mar 27, 2008 at 11:29:58AM -0700, Junio C Hamano wrote:

> Yeah, but the user is really into microcommits, like "separate mode
> change" thing really matters, maybe the user would want to make three
> commits (1) chmod +x, (2) pure rename, and (3) content changes.
> 
> I personally think that is not worth it, so I am agreeing with you on the
> "rename" one.

My feeling on the rename microcommit is that it is reasonable (though I
am not such a microcommitter), but that "git add -p" is probably not the
right tool for doing it. My view is that mode change and hunks are
_actual_ changes to the file, and you can pick and choose the changes
you have made. "rename" is not a change you made, but rather something
we infer from the changes that are available.

But I can also see how one has the opposite view. I dunno. It's hard to
speculate since I don't actually want to _use_ rename. ;)

> Even though your two patches make perfect sense at the philosophical level
> and I very much like it, I doubt "separating mode change" is so useful
> from the practical point of view for that matter.
> [...]
> ...then a patch came to make it the current "not asking
> about mode change separately and if the user chooses to add anything from
> the patch hunks, stage the mode change along with it" behaviour, people
> might even think that such a patch is an improvement in usability by
> asking one less question.  I dunno.

I don't think I would probably use mode change very often, but I found
the current behavior quite non-intuitive, and I think I would prefer if
it were explicit (and in 99% of cases, it won't come up at all, since
you haven't changed the mode!).

But this is all clearly post-1.5.5, so hopefully we can let it stew and
get some more comments from the list on what makes sense to people.

-Peff
