From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: How to restore the original head after `git-reset --hard master^`
Date: Tue, 11 Oct 2005 12:58:03 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0510111240410.23242@iabervon.org>
References: <434BD65A.9000108@ust.hk> <Pine.LNX.4.64.0510110856520.14597@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ben Lau <benlau@ust.hk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 11 18:57:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPNOF-0002NS-R9
	for gcvg-git@gmane.org; Tue, 11 Oct 2005 18:54:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbVJKQxK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Oct 2005 12:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbVJKQxK
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Oct 2005 12:53:10 -0400
Received: from iabervon.org ([66.92.72.58]:22280 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751457AbVJKQxJ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Oct 2005 12:53:09 -0400
Received: (qmail 3395 invoked by uid 1000); 11 Oct 2005 12:58:03 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 11 Oct 2005 12:58:03 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510110856520.14597@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9974>

On Tue, 11 Oct 2005, Linus Torvalds wrote:

> On Tue, 11 Oct 2005, Ben Lau wrote:
> > 
> >   After involves the command `git-reset --hard master^` in a repository, 
> > the working tree , current head and index are restored to the parent of 
> > master. That includes the content of '.git/refs/head/master'. Although 
> > the original commit object is still existed , I couldn't find it back.
> > 
> >  Is there anyway to recover the original master branch ?
> 
> Just run "git-fsck-objects" and look at any dangling commits. The commit 
> and related objects are still there (unless you've run "git prune"), so 
> once you find the name of it, you're all done.

That reminds me: if you lose all of your refs, it's hard to get them back, 
because git-fsck-objects aborts if you don't specify any heads or have any 
refs. Is there some reason for this check?

	-Daniel
*This .sig left intentionally blank*
