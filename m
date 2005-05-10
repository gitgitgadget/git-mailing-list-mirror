From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [RFC] Renaming environment variables.
Date: Tue, 10 May 2005 02:44:31 +0200
Message-ID: <20050510004431.GM15712@pasky.ji.cz>
References: <7v7ji8vt5c.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.21.0505092012340.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Sean <seanlkml@sympatico.ca>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue May 10 02:37:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVIkS-0005AT-Ah
	for gcvg-git@gmane.org; Tue, 10 May 2005 02:37:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261466AbVEJAof (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 20:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbVEJAof
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 20:44:35 -0400
Received: from w241.dkm.cz ([62.24.88.241]:63630 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261466AbVEJAoc (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 May 2005 20:44:32 -0400
Received: (qmail 7126 invoked by uid 2001); 10 May 2005 00:44:31 -0000
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0505092012340.30848-100000@iabervon.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, May 10, 2005 at 02:38:53AM CEST, I got a letter
where Daniel Barkalow <barkalow@iabervon.org> told me that...
> On Mon, 9 May 2005, Junio C Hamano wrote:
> 
> > >>>>> "DB" == Daniel Barkalow <barkalow@iabervon.org> writes:
> > 
> > DB> While we're at it, it would be useful to have one for what is normally
> > DB> ".git",...
> > 
> > If you mean the parent directory of ${SHA1_FILE_DIRECTORY}, and
> > your only gripe is about git-init-db creating ".git" in the
> > current working directory regardless of SHA1_FILE_DIRECTORY, I
> > would agree that what git-init-db does is broken.  Not that I
> > have a suggested "right behaviour" for it, though.
> 
> It could just create all missing parents of the object directory, which
> would be better, at least.

What about the index file? Or should git-read-tree take care of that?

> But even if this is up to the wrapping scripts, it would be useful to have
> the same environment variable used by those scripts for whatever they want
> to have in there.

Seconded. That is another good reason for having that.

> > I once advocated GIT_WORKING_TREE to mean the current project
> > top, which is the parent directory of ".git".  The proposal was
> > shot down (see archives [*1*]).  While I still think that
> > configuration (or your ".git" location proposal, which is
> > essentially the equivalent) may sometimes useful, I'd rather not
> > conflate this environment variable renames with that issue.
> > They are pretty much independent issues.
> 
> The reason to tackle them at once is so that there doesn't have to be
> multiple changeovers.

There should be no changeovers, just additions - the object directory
and index file location environment variables should stay too.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
