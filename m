From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Git / Subversion Interoperability
Date: Sat, 24 Mar 2007 02:56:32 -0400
Message-ID: <20070324065632.GE25863@spearce.org>
References: <20070322224829.GA7048@c3sl.ufpr.br> <20070323004335.GA17773@spearce.org> <Pine.LNX.4.64.0703230052570.2746@beast.quantumfyre.co.uk> <20070323233036.77325e5a@athlon> <46044DF6.6070902@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Wiese <morfoh@opensde.org>, git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Sat Mar 24 07:57:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HV0BP-0000zy-PX
	for gcvg-git@gmane.org; Sat, 24 Mar 2007 07:57:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753468AbXCXG4n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Mar 2007 02:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753469AbXCXG4m
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Mar 2007 02:56:42 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:36803 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753468AbXCXG4m (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2007 02:56:42 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HV0Az-0005Vi-DB; Sat, 24 Mar 2007 02:56:33 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id F31F420FBAE; Sat, 24 Mar 2007 02:56:32 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <46044DF6.6070902@midwinter.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42986>

Steven Grimm <koreth@midwinter.com> wrote:
> Christian Wiese wrote:
> >I'm currently facing this issue while trying to migrate from svn to git
> >within my local working environment to gather experience while working
> >with git to be able to effectively "sell" git to the other people of
> >our project and provide a smooth migration path for them.
> >  
> 
> Would a git svn server be of interest in such a situation, though? 
> That's exactly the situation I'm in, and git-svn is doing an admirable 
> job of integrating the two environments without disrupting the folks who 
> are happy with svn. It seems like the git svn server would be useful in 
> the opposite environment, where you have a git project that people want 
> to access with svn tools (e.g. because there's no git integration in an 
> IDE or whatever.)
> 
> Maybe I'm just misunderstanding what the server in question would do, 
> but it seems like it's not likely to be that useful in cases where you 
> already have a real svn server running and holding the canonical copy of 
> the project.

Well, it does make it harder to transparently remove the SVN server
and drop in a Git based one.  ;-)

But I think Steven is right; like the git-cvsserver you can't do
everything with git-svnserver that you could have done with SVN or
with Git.  But you can get basic access to the Git repository and
still work with it through SVN based tools.

If that means that we export things according to the suggested
SVN repository layout, so be it.  Its difficult to argue with
us when we've followed the SVN advice.  ;-)

Christian pointed out that some projects may have different "slightly
related" modules stored in the same repository, and have come to
expect this to work in certain ways.  Moving to Git is difficult
for them as git-svnimport and git-svn can have a difficult time
divining the correct layout from the soup that is available in SVN.

But its also hard for Git to export soup back.  That is, even once
we've successfully decoded the soup we don't really have good
submodule support, so we cannot (easily) take two different Git
repositories (one per "slightly related" module) and export them
under a single SVN name/revision-space.

-- 
Shawn.
