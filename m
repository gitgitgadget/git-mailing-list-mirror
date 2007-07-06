From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Deprecate git-cherry
Date: Fri, 6 Jul 2007 22:21:42 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707062212280.4093@racer.site>
References: <Pine.LNX.4.64.0707061722020.4093@racer.site>
 <7vmyy9dzrr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 06 23:28:56 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6vMF-0003bP-E8
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 23:28:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762794AbXGFV2x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jul 2007 17:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762692AbXGFV2w
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 17:28:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:35133 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1762672AbXGFV2w (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2007 17:28:52 -0400
Received: (qmail invoked by alias); 06 Jul 2007 21:28:50 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp039) with SMTP; 06 Jul 2007 23:28:50 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/wasBYmbDwQsjAZq8I7d148nmnAerhL5VzozHaSA
	kEaAK+ulnjTfB5
X-X-Sender: gene099@racer.site
In-Reply-To: <7vmyy9dzrr.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51789>

Hi,

On Fri, 6 Jul 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > A cleaner alternative was introduced in v1.5.2~185^2~1, which not only
> > allows you to list the commits, but to inspect them, too:
> >
> > 	git log --cherry-pick <upstream>...[<head>]
> >
> > There is a functional difference, though: git cherry shows both 
> > directions, <upstream>...<head> and <head>...<upstream>, and prefixes
> > the commits with '+' and '-', respectively.
> >
> > 'git rev-list --cherry-pick <upstream>...[<head>]' only shows one 
> > direction, and does not prefix the commits.
> 
> Eh, --left-right anybody?
> 
> git-cherry is used by people's scripts, and I do not think
> deprecating is an option at least in the short term.

Okay, I should have been more precise.

Maybe there are some interesting scripts that use "git cherry". I'd like 
to see them (which does not mean that I vote for git-cherry removal). 
Personally, I use "git rev-list --cherry-pick", because it spares me one 
call to sed.

However, I do not think that there is much value in advertising it any 
more. There is much more value in "git log --cherry-pick", since you can 
get the commit messages and the patches by just adding one more flag (and 
absent any path parameter, that can be even _at the end_ of the command 
line, making it even more convenient).

So what I meat was: advertise "git log --cherry-pick" instead of "git 
cherry", since it is vastly more useful.

There is one real consequence on my common usage, though: It annoys me 
whenever I want to cherry pick a commit, which happens quite often, that 
the bash completion completes on this (for me) useless command. I would 
like to see that gone (but only after a grace period, evidently).

Ciao,
Dscho
