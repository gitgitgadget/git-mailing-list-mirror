From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 8/9] Use git diff instead of diff in t7201
Date: Tue, 5 Feb 2008 23:30:00 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802052306450.13593@iabervon.org>
References: <alpine.LNX.1.00.0802041336030.13593@iabervon.org> <alpine.LSU.1.00.0802050139470.8543@racer.site> <alpine.LNX.1.00.0802042152560.13593@iabervon.org> <7v1w7r7yv0.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0802052011290.13593@iabervon.org>
 <7vr6fq6di0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 05:31:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMbw9-0000s9-3m
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 05:31:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758041AbYBFEaF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 23:30:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757797AbYBFEaF
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 23:30:05 -0500
Received: from iabervon.org ([66.92.72.58]:53751 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757247AbYBFEaC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 23:30:02 -0500
Received: (qmail 30738 invoked by uid 1000); 6 Feb 2008 04:30:00 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 Feb 2008 04:30:00 -0000
In-Reply-To: <7vr6fq6di0.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72753>

On Tue, 5 Feb 2008, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > On Tue, 5 Feb 2008, Junio C Hamano wrote:
> >
> >> Daniel Barkalow <barkalow@iabervon.org> writes:
> >> 
> >> > Well, it's something I tripped over when builtin-checkout wasn't passing 
> >> > the tests and I couldn't figure out what it was doing wrong from the 
> >> > output. Like [3/9], it's relevant to evaluating whether the series works, 
> >> > even if it's not important for whether it actually does work.
> >> 
> >> Yeah, using "diff -u" instead of just "diff" is an improvement
> >> for debuggability which matters a lot in the test scripts.
> >
> > I think I asked before and didn't hear back (or maybe I got distracted 
> > and didn't ask); do you want this to use "diff -u" everywhere or "git 
> > diff" everywhere? This test is currently part "diff" and part "git diff", 
> > and I went for git diff" everywhere, but you seemed to prefer "diff -u".
> 
> Typically the test sequence is "do this with git, do that with
> git, produce the output with git, now what happened?  did we
> produce a correct result?"  And we often compare 'expect' and
> 'actual' to see if there are discrepancies.
> 
> My preference is NEVER using "git diff" when comparing expected
> result and the actual output from git.  When "git diff" has
> breakage, it would break unrelated tests and make debugging
> needlessly harder.

Certainly, although we seem to do a lousy job of ordering tests currently 
such that the tests that fail are the ones for the thing that's broken; it 
took a lot of work to get builtin-checkout to the point to reaching 
t7201-co.sh, and by that point it just about all worked. In any case, I'll 
go for "diff -u" all around in that test, since I'm changing it.

	-Daniel
*This .sig left intentionally blank*
