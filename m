From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC] Renaming environment variables.
Date: Mon, 9 May 2005 23:23:19 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0505092311590.30848-100000@iabervon.org>
References: <7vy8anu8po.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Sean <seanlkml@sympatico.ca>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue May 10 05:16:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVLES-00023B-Bq
	for gcvg-git@gmane.org; Tue, 10 May 2005 05:16:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261542AbVEJDXp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 23:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261546AbVEJDXp
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 23:23:45 -0400
Received: from iabervon.org ([66.92.72.58]:32005 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261542AbVEJDXm (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 May 2005 23:23:42 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DVLL5-0004t5-00; Mon, 9 May 2005 23:23:19 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy8anu8po.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 9 May 2005, Junio C Hamano wrote:

> >>>>> "DB" == Daniel Barkalow <barkalow@iabervon.org> writes:
> >>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:
> 
> DB> While we're at it, it would be useful to have one for what is normally
> DB> ".git", rather than just ".git/objects".
> 
> PB> I think it would be nice to have something like GIT_BASEDIR, which would
> PB> default to .git, and the objects directory would then default to
> PB> $GIT_BASEDIR/objects and the index file would default to
> PB> $GIT_BASEDIR/index.
> 
> Although what I pushed out at git-jc repository does not have
> this, it does not mean I forgot this issue you two have raised,
> nor would want to veto it or anything like that.  Just that,
> unlike the one that I already committed, the proposed change
> would touch rather many lines and I have not managed to
> determine the extent of the damage yet.

It *should* only affect the places where the variables that depend on it
get computed; didn't you already centralize the code to figure this out?

> I am currently waiting for community consensus, including the
> final name of the variable.  I think the current consensus is
> that this is a good idea, the semantics for it is to name what
> corresponds to the current "$(pwd)/.git" directory, use it to
> build the default for GIT_INDEX_FILE and SHA1_FILE_DIRECTORY,
> and this directory does _not_ have anything to do with my
> previous "the directory that corresponds to the root of the tree
> structure GIT_INDEX_FILE describes".  I agree to all of the
> above.

I agree to all of that, too. I'd suggest GIT_DIR for the variable, simply
because I can't think of anything else that name could mean.

	-Daniel
*This .sig left intentionally blank*

