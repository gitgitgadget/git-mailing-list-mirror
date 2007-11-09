From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: Inconsistencies with git log
Date: Fri, 9 Nov 2007 19:39:43 +0100
Message-ID: <20071109183943.GE28800@xp.machine.xx>
References: <Pine.LNX.4.64.0711072309380.4362@racer.site> <9e4733910711071529m604f3b12v29b3a040074ea4e@mail.gmail.com> <Pine.LNX.4.64.0711080003080.4362@racer.site> <9e4733910711071609t3e5412f1mf02e501b2d820bb3@mail.gmail.com> <alpine.LFD.0.999.0711090747210.15101@woody.linux-foundation.org> <9e4733910711090920m6b0b7704x7c5a3849215f385c@mail.gmail.com> <alpine.LFD.0.999.0711090929130.15101@woody.linux-foundation.org> <alpine.LFD.0.999.0711090943120.15101@woody.linux-foundation.org> <20071109182248.GD28800@xp.machine.xx> <7vd4ujtgh7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jon Smirl <jonsmirl@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 19:40:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqYlu-0002dI-AG
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 19:40:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754627AbXKISjr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 13:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754288AbXKISjr
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 13:39:47 -0500
Received: from mail.gmx.net ([213.165.64.20]:58468 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751360AbXKISjq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 13:39:46 -0500
Received: (qmail invoked by alias); 09 Nov 2007 18:39:45 -0000
Received: from mason.hofmann.stw.uni-erlangen.de (EHLO localhost) [131.188.24.36]
  by mail.gmx.net (mp016) with SMTP; 09 Nov 2007 19:39:45 +0100
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX1/blyc3xPDb544tAr3MQX6xjiqGqHIdAvxJY+znR3
	1oiIqhGKyAiRC0
Content-Disposition: inline
In-Reply-To: <7vd4ujtgh7.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64247>

On Fri, Nov 09, 2007 at 10:35:00AM -0800, Junio C Hamano wrote:
> Peter Baumann <waste.manager@gmx.de> writes:
> 
> > Hm. I tried to run your 'git log' and 'git log .' example and a diff
> > revealed that the output of those two isn't the same, contrary to what I
> > thought.
> >
> > In the 'git-log .' case, there should be done a history simplification,
> > but then only commits which don't change anything are pruned and AFAIR
> > 'git commit' doesn't allow this. Using core git, one could create commits
> > with the same tree as their parent, but I don't think that all the commits
> > which get removed in the '.' case where produced that way. There has to be
> > another case I can't figure out.
> 
> The answer is "merges".
> 
> If a merge does not change the tree from one of the ancestors,
> the side branches are pruned out, to give you _one_ explanation
> of how you got there.  And by pruning such side branches, you
> get the simpler explanation.
> 
> Linus gave the example of "log origin/pu ."; there is at least
> one merge I am aware of that did not change any path (it is the
> one that merges "jc/maint-format-patch-encoding" topic).  With
> the path limiter, the merge commit and the two commits that
> leads to it on the side branch are hidden away.

Doh. Could have figured this out myself. But thank your for the explanation.

-Peter
