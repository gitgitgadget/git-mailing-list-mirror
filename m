From: Jan Hudec <bulb@ucw.cz>
Subject: Re: Alternate revno proposal (Was: Re: VCS comparison table)
Date: Sat, 21 Oct 2006 15:48:40 +0200
Message-ID: <20061021134840.GD29843@artax.karlin.mff.cuni.cz>
References: <45346290.6050300@utoronto.ca> <200610171120.09747.jnareb@gmail.com> <1161078035.9020.73.camel@localhost.localdomain> <Pine.LNX.4.64.0610170921540.3962@g5.osdl.org> <1161124078.9020.88.camel@localhost.localdomain> <20061017191838.1c36499b.seanlkml@sympatico.ca> <20061017233305.GG20017@pasky.or.cz> <1161149200.3423.34.camel@localhost.localdomain> <20061018214623.GA32725@artax.karlin.mff.cuni.cz> <eh7c5t$gd1$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 21 15:48:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbHDK-00028g-QV
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 15:48:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993024AbWJUNsf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 09:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993028AbWJUNsf
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 09:48:35 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:12726 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S2993024AbWJUNsf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Oct 2006 09:48:35 -0400
Received: by artax.karlin.mff.cuni.cz (Postfix, from userid 17196)
	id 83F2F494F; Sat, 21 Oct 2006 15:48:40 +0200 (CEST)
To: Alexander Belchenko <bialix@ukr.net>
Content-Disposition: inline
In-Reply-To: <eh7c5t$gd1$1@sea.gmane.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29613>

On Thu, Oct 19, 2006 at 11:19:30AM +0300, Alexander Belchenko wrote:
> Jan Hudec ??????????:
> >Reading this thread I came to think, that the revnos should be assigned
> >to _all_ revisions _available_, in order of when they entered the
> >repository (there are some possible variations I will mention below)
> ...
> > - They would be the same as subversion and svk, and IIRC mercurial as
> >   well, use, so:
> >   - They would already be familiar to users comming from those systems.
> >   - They are known to be useful that way. In fact for svk it's the only
> >     way to refer to revisions and seem to work satisfactorily (though
> >     note that svk is not really suitable to ad-hoc topologies).
> 
> I think that SVN model of revision numbers is wrong. And apply it to bzr
> break many UI habits. Per example, when ones use svn and their repo has
> many branches you never could say what revisions belongs to mainline. So
> things like
> bzr diff -rM..N
> (where M and N absolute revisions numbers, and N = M+1(+2) etc.)
> will more complicated, because in this case you first need to run log
> command, remember actual numbers of those revisions.

Well, you need to run log anyway, because you usually want to see a diff
between some particular revisions, so you need to find them anyway.

On the other hand in subversion all revisions actually exist on all
branches, so svn diff -r N-1:N always shows changes introduced by
revision N, while here you would have to use before:N..N.

> And I each time frustrating to see that after mainline svn revision 1000
> might be mainline revision 1020. It's very-very-very confusing. May be
> only for me.

I got used to this pretty quickly when I used svk. And there it actually
happens much more often than in subversion itself, because you have the
mirrored branches and each commit on them also gets a revision number.
But yes, they feel more weird.

> There is 2 things why I don't want to switch to svn (if I can do my own
> choice): their strange tags implementation (their tags is the same as
> branches, so what difference?) and their revisions numbers.
> 
> I also think that dotted revisions is not answer in this case, but it
> looks very logical and nice.
> 
> I think bzr need to have a switch, a flag, probably in .bazaar.conf to
> show revno to user or revid. And user can easily select what model is
> more appropriate for him:
> 
> * decentralized (with revno)
> * or distrubuted (with revid i.e. UUID)

Personally I'd like the ui to make the revision ids more visible since
they are the canonical way for refering to revisions and as shown among
other in this thread people who know something about distributed version
control are actually confused by them not being visible and think they
are not there.

> >Comments?
> 
> -1 to make revno as in svn.

Hm, you are probably right. In any case it's more useful to teach the
users not to get attached to the revnos too much.

--------------------------------------------------------------------------------
                  				- Jan Hudec `Bulb' <bulb@ucw.cz>
