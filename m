From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: "git revert" feature suggestion: revert the last commit to a
 file
Date: Fri, 6 Feb 2009 01:41:54 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902060140170.10279@pacific.mpi-cbg.de>
References: <20090205202104.GA11267@elte.hu> <7vvdrobobc.fsf@gitster.siamese.dyndns.org> <20090205210018.GB21500@elte.hu> <7vhc38a09m.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 06 01:42:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVEnt-0002Fj-Lz
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 01:42:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753424AbZBFAlU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 19:41:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753162AbZBFAlT
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 19:41:19 -0500
Received: from mail.gmx.net ([213.165.64.20]:44661 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752498AbZBFAlT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 19:41:19 -0500
Received: (qmail invoked by alias); 06 Feb 2009 00:41:17 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp002) with SMTP; 06 Feb 2009 01:41:17 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/ohmdWsMbonqcMynGgxuUX3gM5rFUmmAxO/bkCw2
	Cz92xDkiSxQiIk
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vhc38a09m.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108640>

Hi,

On Thu, 5 Feb 2009, Junio C Hamano wrote:

> Ingo Molnar <mingo@elte.hu> writes:
> 
> > * Junio C Hamano <gitster@pobox.com> wrote:
> >
> >> Ingo Molnar <mingo@elte.hu> writes:
> >> 
> >> > So i have to do something like:
> >> >
> >> >    git revert $(git log -1 --pretty=format:"%h" kernel/softlockup.c)
> >> >
> >> > (tucked away in a tip-revert-file helper script.)
> >> >
> >> > But it would be so much nicer if i could do the intuitive:
> >> >
> >> >    git revert kernel/softlockup.c
> >> >
> >> > Or at least, to separate it from revision names cleanly, something like:
> >> >
> >> >    git revert -- kernel/softlockup.c
> >> 
> >> All three shares one issue.  Does the syntax offer you a way to give
> >> enough information so that you can confidently say that it will find the
> >> commit that touched the path most recently?  How is the "most recently"
> >> defined?
> >> 
> >> At least you can restate the first one to:
> >> 
> >>     git revert $(git log -1 --pretty=format:"%h" core/softlockup -- kernel/softlockup.c)
> >> 
> >> to limit to "the one that touched this file _on this topic_".
> >
> > All in the current scope of the integration branch, sure. I.e. the same 
> > scope of commits that "git log kernel/softlockup.c" uses.
> 
> But that is not how ":/syntax" works, at least right now.  It traverses
> from tips of all refs and finds the newest one.  It might make sense to
> make the discovery start from the current branch not from all tips.

Yeah, it was a bad design, probably.

As it is, the syntax is not really useful to me, as my patch to make this 
a regular expression was not accepted.

Maybe it is time to rethink that syntax; I am pretty sure that there is no 
user out there.

Ciao,
Dscho
