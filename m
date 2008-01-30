From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: simple cvs-like git wrapper
Date: Wed, 30 Jan 2008 14:49:53 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0801301439070.13593@iabervon.org>
References: <20080129204048.GA9612@venus> <m3hcgw8dz7.fsf@localhost.localdomain> <20080130021050.GB9612@venus>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: "Ed S. Peschko" <esp5@pge.com>
X-From: git-owner@vger.kernel.org Wed Jan 30 20:50:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKIxA-0007UH-IX
	for gcvg-git-2@gmane.org; Wed, 30 Jan 2008 20:50:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761995AbYA3Tt6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2008 14:49:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761938AbYA3Tt6
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jan 2008 14:49:58 -0500
Received: from iabervon.org ([66.92.72.58]:39884 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761748AbYA3Tt4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2008 14:49:56 -0500
Received: (qmail 1479 invoked by uid 1000); 30 Jan 2008 19:49:53 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 30 Jan 2008 19:49:53 -0000
In-Reply-To: <20080130021050.GB9612@venus>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72062>

On Tue, 29 Jan 2008, Ed S. Peschko wrote:

> > One thing (besides horrible branching and even worse merging)  which I
> > hated in multi-user CVS is the "cvs update", namely the fact that if
> > you want to commit changes, you _have_ to rebase them on top of
> > current work. So when you are ready to commit, when you have tested
> > everything, you are sometimes forced to resolve a merge to be able to
> > commit... and have to test resolved merge... and perhaps again, and
> > again.
> 
> Yeah, I realize that it's not exactly the best solution for every
> project, but for projects tied to a piece of hardware (ie: a database, a
> particular box, etc), its much more important to be in sync, to have 
> 'one true view' of the world rather than to have the freedom to have 
> multiple views.

Actually, it's a simpler concern: with CVS (and most version control 
systems), you can't make a permanent record of your state without 
resolving conflicts. With git, you make the permanent record first, and 
then resolve conflicts in order to get a state that includes your changes 
and can be pushed to the shared location. With git, you can still have 
"one true view" of the world; it's just that git really really doesn't 
want to lose your work, so it refuses to overwrite your files unless 
you've put them in its storage, where it can give them back if it does 
something wrong with your working tree.

Of course, your "gvs update" could do a local git commit of the current 
state, fetch the remote changes, and rebase the local commit onto them, so 
it's not necessarily a workflow change. But note that, if the user fails 
to do a manual merge, the user can try again, or try working on a 
different branch, or fork at that point, depending on how hopeless the 
situation is.

	-Daniel
*This .sig left intentionally blank*
