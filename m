From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: Inconsistencies with git log
Date: Fri, 9 Nov 2007 19:22:48 +0100
Message-ID: <20071109182248.GD28800@xp.machine.xx>
References: <Pine.LNX.4.64.0711072255420.4362@racer.site> <9e4733910711071503va92a653s25fd978989d5917d@mail.gmail.com> <Pine.LNX.4.64.0711072309380.4362@racer.site> <9e4733910711071529m604f3b12v29b3a040074ea4e@mail.gmail.com> <Pine.LNX.4.64.0711080003080.4362@racer.site> <9e4733910711071609t3e5412f1mf02e501b2d820bb3@mail.gmail.com> <alpine.LFD.0.999.0711090747210.15101@woody.linux-foundation.org> <9e4733910711090920m6b0b7704x7c5a3849215f385c@mail.gmail.com> <alpine.LFD.0.999.0711090929130.15101@woody.linux-foundation.org> <alpine.LFD.0.999.0711090943120.15101@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Nov 09 19:23:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqYW7-0004qo-Pj
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 19:23:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755941AbXKISWu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 13:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755903AbXKISWu
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 13:22:50 -0500
Received: from mail.gmx.net ([213.165.64.20]:41380 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751360AbXKISWt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 13:22:49 -0500
Received: (qmail invoked by alias); 09 Nov 2007 18:22:48 -0000
Received: from mason.hofmann.stw.uni-erlangen.de (EHLO localhost) [131.188.24.36]
  by mail.gmx.net (mp030) with SMTP; 09 Nov 2007 19:22:48 +0100
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX19ZuFdqt0VZdDXiY0MmTp3IiijM8vacLTQ/eQE929
	ncKIRDpfpzvtmy
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0711090943120.15101@woody.linux-foundation.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64241>

On Fri, Nov 09, 2007 at 09:53:00AM -0800, Linus Torvalds wrote:
> 
> 
> On Fri, 9 Nov 2007, Linus Torvalds wrote:
> > 
> > In fact, even at the top-of-tree, "git log" and "git log ." are two 
> > totally different things [...]
> 
> Btw, the reason (and really the *only* reason) this is interesting at all 
> is just to show that the notion of "full history" and "relative pathnames" 
> really have nothing to do with each other. They really are in totally 
> different and orthogonal dimensions.
> 
> "Full history" is something that exist *independently* of the pathnames. 
> 
> So the fact is, "git log" on its own is really about the *project*. It is 
> totally pathname-independent, and I'd argue that many people are often 
> just interested in the explanations (even though you obviously can also 
> see the patches and the files changed too!) so I seriously doubt that this 
> is just an implementation issue or my personal hang-up.
> 
> In other words "git log" simply is something *global*. It doesn't matter 
> where in the tree you are, the end result is the same - it's about the 
> project as a whole.
> 
> In contrast, "git log <filename>" is fundamentally different. Now you're 
> explicitly stating that it's not something global any more, and that it's 
> about the *files*. That's also why "git log" and "git log ." are acually 
> different even at the top level.
> 
> Because when you're interested in the files, by implication you're not 
> interested in commits that don't change the files - and there can be such 
> commits even when you give the *total* file list.  
> 

Hm. I tried to run your 'git log' and 'git log .' example and a diff
revealed that the output of those two isn't the same, contrary to what I
thought.

In the 'git-log .' case, there should be done a history simplification,
but then only commits which don't change anything are pruned and AFAIR
'git commit' doesn't allow this. Using core git, one could create commits
with the same tree as their parent, but I don't think that all the commits
which get removed in the '.' case where produced that way. There has to be
another case I can't figure out.

A little confused,
Peter
