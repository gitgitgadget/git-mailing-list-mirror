From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC] Renaming environment variables.
Date: Mon, 9 May 2005 20:53:19 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0505092047190.30848-100000@iabervon.org>
References: <20050510004431.GM15712@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Sean <seanlkml@sympatico.ca>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue May 10 02:46:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVItO-00065y-9O
	for gcvg-git@gmane.org; Tue, 10 May 2005 02:46:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261469AbVEJAxr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 20:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261470AbVEJAxr
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 20:53:47 -0400
Received: from iabervon.org ([66.92.72.58]:22532 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261469AbVEJAxo (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 May 2005 20:53:44 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DVIzv-0007i5-00; Mon, 9 May 2005 20:53:19 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050510004431.GM15712@pasky.ji.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 10 May 2005, Petr Baudis wrote:

> Dear diary, on Tue, May 10, 2005 at 02:38:53AM CEST, I got a letter
> where Daniel Barkalow <barkalow@iabervon.org> told me that...
> > On Mon, 9 May 2005, Junio C Hamano wrote:
> > 
> > > >>>>> "DB" == Daniel Barkalow <barkalow@iabervon.org> writes:
> > > 
> > > DB> While we're at it, it would be useful to have one for what is normally
> > > DB> ".git",...
> > > 
> > > If you mean the parent directory of ${SHA1_FILE_DIRECTORY}, and
> > > your only gripe is about git-init-db creating ".git" in the
> > > current working directory regardless of SHA1_FILE_DIRECTORY, I
> > > would agree that what git-init-db does is broken.  Not that I
> > > have a suggested "right behaviour" for it, though.
> > 
> > It could just create all missing parents of the object directory, which
> > would be better, at least.
> 
> What about the index file? Or should git-read-tree take care of that?

Probably whatever writes the index file should take care of making sure it
can be written (if possible).

> > > I once advocated GIT_WORKING_TREE to mean the current project
> > > top, which is the parent directory of ".git".  The proposal was
> > > shot down (see archives [*1*]).  While I still think that
> > > configuration (or your ".git" location proposal, which is
> > > essentially the equivalent) may sometimes useful, I'd rather not
> > > conflate this environment variable renames with that issue.
> > > They are pretty much independent issues.
> > 
> > The reason to tackle them at once is so that there doesn't have to be
> > multiple changeovers.
> 
> There should be no changeovers, just additions - the object directory
> and index file location environment variables should stay too.

Definitely true of the index file, since people actually write different
ones. I'm not sure if there's a real use for specifying something
different for the objects directory than BASE + objects, though.

	-Daniel
*This .sig left intentionally blank*

