From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Notes on Using Git with Subprojects
Date: Wed, 27 Sep 2006 23:58:55 -0400
Message-ID: <20060928035855.GD22897@spearce.org>
References: <45196628.9010107@gmail.com> <Pine.LNX.4.64.0609261629160.9789@iabervon.org> <20060926213003.GA8177@spearce.org> <4519AACD.7020508@gmail.com> <20060927080652.GA8056@admingilde.org> <451AADC3.40201@gmail.com> <20060927173335.GC2807@coredump.intra.peff.net> <451B45D6.1010006@gmail.com> <20060928035225.GA22006@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: A Large Angry SCM <gitzilla@gmail.com>,
	Martin Waitz <tali@admingilde.org>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 28 05:59:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSn3E-0007hZ-UR
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 05:59:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbWI1D7F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 23:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbWI1D7F
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 23:59:05 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:25318 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751281AbWI1D7D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 23:59:03 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GSn2r-00036F-Ij; Wed, 27 Sep 2006 23:58:45 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C9AFF20FB28; Wed, 27 Sep 2006 23:58:55 -0400 (EDT)
To: Jeff King <peff@peff.net>
Content-Disposition: inline
In-Reply-To: <20060928035225.GA22006@coredump.intra.peff.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27980>

Jeff King <peff@peff.net> wrote:
> On Wed, Sep 27, 2006 at 08:47:34PM -0700, A Large Angry SCM wrote:
> 
> > >A first step to this would be an argument to git-clone to allow cloning
> > >only a subset of refs.
> > Something like this?
> > 
> > 	git-init-db
> > 	git-fetch <repository> <refspecs>
> 
> Exactly, but I was suggesting something more user-friendly (e.g., it's
> nice to use git-clone because it creates the remotes file). I was going
> to hack up a quick change to git-clone, but I think some thought needs
> to be given to semantics, especially with respect to tags (should it
> imply no tags? Only tags which point to refs we're already fetching?).

If you are fetching a set of commits from a repository you probably
should be fetching any tags that point at the commits you've fetched.
They tend to be few compared to the commits, they tend to be small,
and they tend to be important milestones in the tracked project.

I think that's why the native Git protocol sends tags for any
commits that were also sent.  :)

-- 
Shawn.
