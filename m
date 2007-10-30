From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 0/4] Build in some more things
Date: Tue, 30 Oct 2007 12:49:13 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0710301237490.7357@iabervon.org>
References: <Pine.LNX.4.64.0710292049450.7357@iabervon.org>
 <4726DC3D.2030202@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Oct 30 17:49:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImuHY-0000Q9-Oq
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 17:49:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752638AbXJ3QtW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 12:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752354AbXJ3QtW
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 12:49:22 -0400
Received: from iabervon.org ([66.92.72.58]:56122 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752448AbXJ3QtV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 12:49:21 -0400
Received: (qmail 28780 invoked by uid 1000); 30 Oct 2007 16:49:13 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 30 Oct 2007 16:49:13 -0000
In-Reply-To: <4726DC3D.2030202@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62668>

On Tue, 30 Oct 2007, Johannes Sixt wrote:

> Daniel Barkalow schrieb:
> > The main effect of this series is removing the fork/exec from pushing via
> > the git protocol (aside from the later fork/exec in connect.c of course).
> > 
> > It also heads off some tempting transport-related fetch bugs, which I will
> > not introduce in a later patch.
> > 
> > * Miscellaneous const changes and utilities
> >   Adds two small utility functions, and marks a bunch of stuff as const; the
> >   const stuff is to keep builtin-fetch from getting messed up without a
> >   warning, because it wants some lists not to change.
> > 
> > * Build-in peek-remote, using transport infrastructure.
> > * Build-in send-pack, with an API for other programs to call.
> > * Use built-in send-pack.
> 
> I assume this goes on top of current master or db/fetch-pack. The patches have
> some conflicts with js/forkexec (nothing serious, though). Maybe it makes
> sense to rebase on top of that.

Current master. As I said to Junio a moment ago (and forgot to cc you, 
oops), I think 1/4 should go before js/forkexec, being trivial, and 2/4 
should also, since it simply removes duplicate code that js/forkexec 
updates; I should redo 3/4 after the code settles down, and 4/4 is trivial 
but depends on 3/4.

	-Daniel
*This .sig left intentionally blank*
