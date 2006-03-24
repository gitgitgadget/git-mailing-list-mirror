From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: Errors GITtifying GCC and Binutils
Date: Fri, 24 Mar 2006 12:32:38 +0000
Message-ID: <20060324123238.GA3070@linux-mips.org>
References: <20060322133337.GU20746@lug-owl.de> <Pine.LNX.4.64.0603221517210.26286@g5.osdl.org> <Pine.LNX.4.64.0603221607580.26286@g5.osdl.org> <44223B90.3040500@zytor.com> <1143128751.6850.35.camel@neko.keithp.com> <Pine.LNX.4.64.0603230758260.26286@g5.osdl.org> <BAYC1-PASMTP0912D2287AB923F3338969AEDE0@CEZ.ICE> <Pine.LNX.4.64.0603231134160.26286@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sean <seanlkml@sympatico.ca>, keithp@keithp.com, hpa@zytor.com,
	jbglaw@lug-owl.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 24 13:33:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMlTI-0006dP-CA
	for gcvg-git@gmane.org; Fri, 24 Mar 2006 13:32:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932474AbWCXMct (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Mar 2006 07:32:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932607AbWCXMct
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Mar 2006 07:32:49 -0500
Received: from ftp.linux-mips.org ([194.74.144.162]:60065 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S932474AbWCXMcs
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Mar 2006 07:32:48 -0500
Received: from localhost.localdomain ([127.0.0.1]:38600 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133903AbWCXMWk (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Mar 2006 12:22:40 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k2OCWgIe005528;
	Fri, 24 Mar 2006 12:32:42 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k2OCWcvN005527;
	Fri, 24 Mar 2006 12:32:38 GMT
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0603231134160.26286@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17915>

On Thu, Mar 23, 2006 at 12:38:33PM -0800, Linus Torvalds wrote:

> > lol, that sounds like a really good plan.  Perhaps as a two pronged effort
> > its worth changing the notion that git is primarily "plumbing".   Adding
> > some of the nice features of cogito and other "porcelains" into the core
> > git might go a ways toward converting the few naysayers we don't kill.
> 
> Actually, as far as I can tell, git already has a hell of a lot more 
> porcelain than pretty much any non-IDE type traditional SCM. Certainly 
> more than CVS.
> 
> Yeah, I'm not counting things like Eclipse etc. I'm talking about "plain 
> SCM" environments, ie just basic SVN or CVS. What are we missing in that 
> department? (The only thing I can think of is a diff colorizer, which some 
> prople seem to really want).

I'd like sunglasses with that diff colouriser, please ;-)

For my various hacking projects and archiving needs git has done me alot
of good and it's pretty close to the answer to the question for life,
universe and everything.  But a few rough areas (I'm currently using git
1.2.4 btw.)  remain:

 o During the debugging phase before a new kernel release I put anything
   that isn't appropriate for the master branch on a queue branch which
   I am rebasing frequently to ensure things will work right in the
   "patch bombing" phase before the next -rc1 when I'm sending everything
   on the queue branch upstream.
   The problem: users pull such a branch, create their own branch starting
   somewhere on my queue branch.  So eventually when they pull again
   after I rebased the branch things blow up spectactularly.  This needs a
   simple solution.
 o git rebase had no reasonable handling of conflicts last I ran into a
   rebase conflict.
 o If a file is modified in a user's tree and a non-conflicting patch is
   being pull users seem to expect the old CVS behaviour which is trying
   to merge into the checked out tree, worst case adding conflict markers.
   Git just refuses the operation.
 o I had people piling up over 2GB in their $GIT_DIR/objects/pack/
   directory because they were using the rsync method for updating.
 o Git is a dramatically more powerful and for most operations better
   performing SCM than CVS - but CVS is what people know, it's easy to
   learn and handling special cases like conflicts is sort of obvious
   because CVS expects the user to cleanup the mess and does not try to
   compete with the users in that.
 o A Git for Dummies book would be helpful.
 o When users have problems with git I found it useful to explain them
   how git internally works so they get a better understanding of what
   actually is going on.  Dominic Sweetman which is an excellent
   technical writer has made a similar experience and started writing
   a bit about git in the wiki at http://www.linux-mips.org/wiki/WhatIsGit
   May somebody wants to extend this?
   (Dominic unfortunately is currently deeply burried in writing the
   2nd issue of See MIPS Run, so can't really contribute ...)

  Ralf
