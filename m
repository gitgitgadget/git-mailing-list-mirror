From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: "git pull . <branch>" versus "git merge <branch>"
Date: Wed, 11 Jun 2008 15:46:31 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0806111513380.19665@iabervon.org>
References: <484F2174.9020508@keyaccess.nl> <alpine.LNX.1.00.0806111340570.19665@iabervon.org> <XZoDb2arIiMts-bX6jjK15wC9cOn5lPGgCOQYbY9YIyNm_nfcDf5gQ@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Rene Herman <rene.herman@keyaccess.nl>, git <git@vger.kernel.org>,
	Miklos Vajna <vmiklos@frugalware.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Jun 11 21:48:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6WI7-000563-Q9
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 21:47:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752083AbYFKTqg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 15:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751981AbYFKTqg
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 15:46:36 -0400
Received: from iabervon.org ([66.92.72.58]:47507 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751527AbYFKTqd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 15:46:33 -0400
Received: (qmail 11676 invoked by uid 1000); 11 Jun 2008 19:46:31 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 11 Jun 2008 19:46:31 -0000
In-Reply-To: <XZoDb2arIiMts-bX6jjK15wC9cOn5lPGgCOQYbY9YIyNm_nfcDf5gQ@cipher.nrlssc.navy.mil>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84644>

On Wed, 11 Jun 2008, Brandon Casey wrote:

> Daniel Barkalow wrote:
> > On Wed, 11 Jun 2008, Rene Herman wrote:
> > 
> >> Good day.
> >>
> >> The manpages seem to be making somewhat of a point of mentioning "git pull .
> >> <branch>" as the way to merge a local branch into the current one but a simple
> >> "git merge <branch>" seems to work well. Is there a difference?
> > 
> > Those manpage sections predate the existance of "git merge <branch>". If 
> > you're not planning to use git before November 2006, there's no reason to 
> > use the "git pull ." form. They should probably be replaced with more 
> > helpful examples at this point.
> 
> Was there some past discussion of the ui merits of a separate 'merge' command
> for dealing with local merges and a 'pull' command for remote merges? I
> understand merge is the backend. The question has to do with the high-level
> user interface: one command or two? Why wasn't git-pull enough?

"git pull . <branch>" does "git fetch . <branch>" and then merges it. Of 
course, "git fetch . <branch>" does nothing at all, and it's weird as a 
user interface to have the only (simple) way of selecting something to 
merge be to fetch it as if from a remote repository, but from the local 
repository. After all, no other purely local operation requires you to 
first fetch the thing you're interesting in from yourself.

> I ask because elsewhere in this thread Miklos suggests that git-merge should
> be preferred over git-pull when dealing with a local repostory and you suggest
> here that the documentation should be updated to use the 'git merge' method
> instead of 'git pull'. I had the impression that git-merge was only used by
> those who had not yet gotten their mind around the pull methodology. So it
> was more of an 'ease the transition from other SCMs' rather than the recommended
> way of doing things.

I think everybody uses "git merge" instead of "git pull ." these days. 
It's shorter and less fiddly to type, and doesn't polute your bash reverse 
search for "git pull<tab>" with local things. And, if you've got a bunch 
of local branches, which is not uncommon and very much native to git, the 
intuitive thing is to merge them with "git merge" instead of treating them 
as if they weren't local.

It's also now pretty common to want to do "git fetch <remote>", inspect 
it, decide whether this is something you want to merge (and depend on), 
and do "git merge <tracking>" to include it in your branch if you want it. 
(And being able to fetch stuff from a remote location, and later do a 
merge without any non-local information is also very git-style.)

Of course, if you're pulling from a remote repository, you generally want 
to use "git pull", but you wouldn't be using "git pull ."

	-Daniel
*This .sig left intentionally blank*
