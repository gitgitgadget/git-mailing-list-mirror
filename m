From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Tracking of local branches
Date: Fri, 20 Mar 2009 14:10:46 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0903201358440.19665@iabervon.org>
References: <49C3A6AE.7020104@drmicha.warpmail.net> <7viqm4i1md.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 19:12:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkjCd-0004wU-5C
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 19:12:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756344AbZCTSKt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 14:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753878AbZCTSKt
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 14:10:49 -0400
Received: from iabervon.org ([66.92.72.58]:58669 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752000AbZCTSKs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 14:10:48 -0400
Received: (qmail 25664 invoked by uid 1000); 20 Mar 2009 18:10:46 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 20 Mar 2009 18:10:46 -0000
In-Reply-To: <7viqm4i1md.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113988>

On Fri, 20 Mar 2009, Junio C Hamano wrote:

> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
> > I semi-successfully messed around in remote.c (format_tracking_info(),
> > stat_tracking_info()) to make it use branch->merge_name rather than
> > branch->merge. This makes "git status" work as expected ("Your branch
> > is... severely screwed.") for tracked local branches. (It's messed up
> > for remote ones but hey it was a first shot; merge[0]->dst is really
> > needed here I guess.)
> >
> > Now I could go after sha1_name.c and do the same,
> >
> > OR
> >
> > make it so that all branches have their merge member set up, uhm. Any
> > possible side effects?
> 
> My gut feeling is that the latter if works should be preferable for
> consistency if nothing else.
> 
> The "struct branch" hasn't changed ever since it was introduced by cf81834
> (Report information on branches from remote.h, 2007-09-10) and Daniel
> might know about some corner cases that rely on branch.merge not being set
> up for local ones, but honestly, I would think it would be a bug in the
> existing code if there were such cases.

As long as the semantics for tracking local branches are the same as for 
tracking remote ones, I'm pretty sure there's nothing that relies on 
branch.merge not being something local.

	-Daniel
*This .sig left intentionally blank*
