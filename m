From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Any news on an Eclipse plugin?
Date: Sun, 12 Mar 2006 23:09:24 -0500
Message-ID: <20060313040924.GB17901@spearce.org>
References: <20060306173229.GA27965@spearce.org> <440D2F4E.9090009@peralex.com> <44147B8B.4050503@cc.jyu.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 13 05:09:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FIeNJ-0005ei-95
	for gcvg-git@gmane.org; Mon, 13 Mar 2006 05:09:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWCMEJ2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Mar 2006 23:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbWCMEJ2
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Mar 2006 23:09:28 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:34493 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1750712AbWCMEJ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Mar 2006 23:09:27 -0500
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FIeMs-0000FZ-PL; Sun, 12 Mar 2006 23:09:15 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5B4C020FBAC; Sun, 12 Mar 2006 23:09:24 -0500 (EST)
To: lamikr <lamikr@cc.jyu.fi>
Content-Disposition: inline
In-Reply-To: <44147B8B.4050503@cc.jyu.fi>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17542>

lamikr <lamikr@cc.jyu.fi> wrote:
> Have you yet made any kind of planning of the features that would be
> available or put up the repository?
> I use novadays Eclipse basically for all of my editing and something
> like CVS/Subclipse plug-ins for git would be cool.
> (cdt cross-indexing is still a little bit slow with the amount of files
> in kernel so with kernel I have turned that off)

Right now I'm just trying to get the basic Eclipse team plugin
plumbing into place.  For my first `release' however I am planning
on implementing the following:

1) read the HEAD tree-ish into an in-memory index within Eclipse from
   loose objects only
2) add files/subtrees to that tree
3) delete files/subtrees from that tree
4) commit the modified tree as a single parent commit
5) update HEAD with the new commit

But that's actually a lot of work.  :-)

There's a lot of really critical stuff not in that list:

6) reading objects from packs
7) pulling or pushing from a remote
8) merges and multi-parent commits
9) synchronization of the workspace with the native git 'index' file
... plus lots of other useful things ...

I'm working on that first list (1-5) this week and will post
a complete repository as soon as I have that working such that
another Eclipse developer might be able to do something with it.
Then I'll likely start in on 6 and 7 and be forced to deal with
8 when 7 is doing pulls in an interesting way.  That's certainly
weeks away from being remotely useful.
 
> Noel Grandin wrote:
> >The subversion plugin (subclipse.tigris.org) might be a good starting
> >point since it delegates a lot of it's low-level work through an
> >interface called svnClientAdapter. Re-implementing that to talk to git
> >should get you something useful in a reasonable time-frame.
> >
> >Note that an eclipse team plugin is a pretty complicated beast.
>
>
> Yes, but very powerfull for the people like me who have who just have
> never bothered to learn VI/Emacs/sed properly
> and feel with them like having 5 thumps, code finders, search tools,
> refactoring tools, etc. available in Eclipse are very cool.
> 
> So if the repository for git plug-ins goes up somewhere I could try to
> help a little bit.

The more the merrier.  As has been pointed out an Eclipse team
plugin is not a trivial chunk of code.

As a side effect of this effort I'd also like to see a set of
Ant tasks written.  I'm building a non-Eclipse specific GIT API
in pure Java to provide implementation to the Eclipse plugins.
Some functions are likely going to just fork/exec the core GIT
tools as I'm not planning on implementing pack deltification or
rename tracking in Java.

Anyhoo - if you are still interested in this project look for
an email from me later this week.  I should have a repository
available then.

-- 
Shawn.
