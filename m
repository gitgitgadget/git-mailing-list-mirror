From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached
 HEAD  was
Date: Wed, 14 Oct 2009 15:15:26 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0910141509200.32515@iabervon.org>
References: <alpine.LNX.2.00.0910140037570.32515@iabervon.org> <76718490910141156g440ee455t2e1db72ad72b7049@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1547844168-243469604-1255547726=:32515"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 14 21:25:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1My9Sw-0008F6-73
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 21:24:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbZJNTQZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 15:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758280AbZJNTQY
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 15:16:24 -0400
Received: from iabervon.org ([66.92.72.58]:54487 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755651AbZJNTQY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 15:16:24 -0400
Received: (qmail 2158 invoked by uid 1000); 14 Oct 2009 19:15:26 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 14 Oct 2009 19:15:26 -0000
In-Reply-To: <76718490910141156g440ee455t2e1db72ad72b7049@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130326>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1547844168-243469604-1255547726=:32515
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 14 Oct 2009, Jay Soffian wrote:

> On Wed, Oct 14, 2009 at 12:44 AM, Daniel Barkalow <barkalow@iabervon.org> wrote:
> >  $ git commit
> >  You've been sightseeing "origin/master". The commit can't change that
> >  value, so your commit isn't held in any branch. If you want to create
> >  a branch to hold it, here's how.
> >
> > "git checkout origin/master" should be similar in complexity to
> > "svn checkout -r 8655"; the difference is that svn won't let you
> > commit then and git will but you'll need to understand the
> > implications if you do so. If you don't commit (because you don't want
> > to make any changes, because you don't think it would be possible, or
> > because you don't want to worry about what would happen), there's no
> > meaningful difference, and you don't need to be told.
> 
> Huh, I hadn't seen this message before I wrote in a reply to
> "builtin-checkout: suggest creating local branch" that we do the
> following at commit, which I think is what you're suggesting:
> 
> $ git commit -m "blah"
> Cannot commit while not on any branch. Please use git commit -b <branch> to
> specify the name of a new branch to commit to, or use git commit -f to
> force a detached commit.

The difference is that some experienced users depend on being able to 
commit while not on a branch, and want to not get a warning for every 
commit while not on a branch.

> I'm not sure that requires the complexity of remembering how the user
> got detached though?

What matters there is actually whether we got to the present state by 
committing or not. It's also relevant to telling the user what they've got 
checked out that isn't a branch.

	-Daniel
*This .sif left intentionally blank*
--1547844168-243469604-1255547726=:32515--
