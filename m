From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Bizarre missing changes (git bug?)
Date: Tue, 29 Jul 2008 19:05:08 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807291851120.3334@nehalem.linux-foundation.org>
References: <alpine.LFD.1.10.0807261249430.4188@nehalem.linux-foundation.org> <Pine.LNX.4.64.0807270049290.6791@localhost.localdomain> <alpine.LFD.1.10.0807271144520.3486@nehalem.linux-foundation.org> <Pine.LNX.4.64.0807272101470.6791@localhost.localdomain>
 <alpine.LFD.1.10.0807271613440.3486@nehalem.linux-foundation.org> <Pine.LNX.4.64.0807280141140.6791@localhost.localdomain> <alpine.LFD.1.10.0807272148030.3486@nehalem.linux-foundation.org> <Pine.LNX.4.64.0807281241180.6791@localhost.localdomain>
 <20080729053108.GH26997@sigill.intra.peff.net> <Pine.LNX.4.64.0807291339580.6791@localhost.localdomain> <20080729125247.GC12069@sigill.intra.peff.net> <alpine.LFD.1.10.0807291006070.3334@nehalem.linux-foundation.org>
 <Pine.LNX.4.64.0807300315280.6791@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Tim Harper <timcharper@gmail.com>,
	git@vger.kernel.org
To: Roman Zippel <zippel@linux-m68k.org>
X-From: git-owner@vger.kernel.org Wed Jul 30 04:10:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KO18d-0001Xi-5E
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 04:10:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753489AbYG3CJD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 22:09:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753370AbYG3CJC
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 22:09:02 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:39954 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753483AbYG3CJB (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Jul 2008 22:09:01 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6U287eP012616
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 29 Jul 2008 19:08:08 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6U286BV001633;
	Tue, 29 Jul 2008 19:08:06 -0700
In-Reply-To: <Pine.LNX.4.64.0807300315280.6791@localhost.localdomain>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.406 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90727>



On Wed, 30 Jul 2008, Roman Zippel wrote:
> > 
> > The "gitk file" history is the simplest one BY FAR, because it has very 
> > aggressively simplified history to the point where it tried to find the 
> > _simplest_ history that explains the current contents of 'file'[*]
> 
> It's "aggressively simplified" by not even bothering to look for more.

Yes and no.

It's aggressively simplified because that's the right output with the 
minimal unnecessary irrelevant information. It explains how the file came 
to a particular state, with the simplest possible self-consistent history.

(Again, the caveat about "simplest possible" always beign a local 
minimization, not a global one).

The fact that it also obviously involved less work (so git can do it 
faster, and with fewer disk and memory accesses) is a huge bonus, of 
course.

Are you complaining about the fact that I'm smart, and I get the right 
result I want with less work and with a simpler algorithm?

What's your point?

> "simplified" implies there is something more complex beforehand, but all 
> it does is simple scan through the history as fast possible without 
> bothering looking left or right.

You're just being stupid.

It's not that it's not "bothering" looking left or right. It very much 
*does* bother to look left or right. But once it finds that one or the 
other explains the situation entirely, it then says "screw left, I already 
know that rigth gives me the information I want".

In other words, it's doing the _smart_ thing. 

I don't understand why you complain about intelligence.

It's *not* just looking at one single history. Look at

	gitk kernel/sched.c

and notice that the simplified history is not linear. It tries to make it 
AS LINEAR AS POSSIBLE, BUT NO MORE.

    "Make everything as simple as possible, but not simpler."
			- Albert Einstein

You seem to complain about the fact that it's doing that. That's stupid of 
you.

> "simplified" implies to me it's something intentional, but this is more of 
> an accidental optimization which happens to work in most situations and in 
> the special cases it just picks a random change and hopes for the best.

You're just crazy. There is nothing accidental there what-so-ever.

> "git-log --full-history file" at least produces the full change history, 
> but it has an performance impact and it doesn't produce a complete graph 
> usable for graphical front ends.

Umm. You have to add "--parents" if you want a full graph. Without that, 
you can never re-generate the graph anyway.

And when you do that, it _does_ give all the commits needed to complete 
the picture.

In other words, git (once again) is actually smarter than you, and does 
the right thing, and (once again) you complain about something that you 
just don't understand.

> I gave more general examples. Tracking upstream source can produce this 
> problem frequently. Another example are stable/unstable branches where the 
> stable branch is occasionally merged into the unstable branch can produce 
> this problem.

You call it a "problem", but you don't actually give any reason for 
calling it that. IT IS NOT A PROBLEM. It's very much by design, and it's 
because what you want.

Use --full-history if you want the full history. 

> This is your _subjective_ interpretion of this problem, because it's not a 
> problem for you, nobody else can possibly have this problem (or they just 
> crazy).

No, Roman. You're not crazy because you have some issue that I cannot 
understand. You're crazy because you make the same mistake over and over, 
and don't listen when people tell you what the mistake was.

	"Insanity is doing the same thing over and over again and 
	 expecting different results."
			- Various

Please. People have told you where you go wrong. Many times. So why do you 
keep repeating it?

Take the time to slow down, listen, and realize that you're on the wrong 
track, and that others really _have_ spent time and thought on this.

		Linus
