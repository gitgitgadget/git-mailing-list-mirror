From: Shawn Pearce <spearce@spearce.org>
Subject: Re: core-git and porcelains
Date: Wed, 11 Oct 2006 12:54:03 -0400
Message-ID: <20061011165403.GC31298@spearce.org>
References: <egivn8$5mf$1@sea.gmane.org> <20061011150842.GA31298@spearce.org> <egj73t$80e$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 11 18:54:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXhLR-00009s-N5
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 18:54:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161114AbWJKQyK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Oct 2006 12:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161144AbWJKQyJ
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Oct 2006 12:54:09 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:46277 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1161114AbWJKQyI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Oct 2006 12:54:08 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GXhLC-0006ET-4L; Wed, 11 Oct 2006 12:53:58 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 164F320FB00; Wed, 11 Oct 2006 12:54:03 -0400 (EDT)
To: Pazu <pazu@pazu.com.br>
Content-Disposition: inline
In-Reply-To: <egj73t$80e$1@sea.gmane.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28725>

Pazu <pazu@pazu.com.br> wrote:
> Shawn Pearce wrote:
> 
> >I would just stick with core Git.  I haven't used Cogito in almost
> >a year so I can't say what I'm missing there, but core Git works
> >very well for all of my needs.  I use it in a lot of different
> >projects, some which require git-svn, others which require some
> >bastard git-svn-workalike for non-SVN systems, and others which
> >are just Git projects and don't have to cooperate with others.
> 
> Thanks for the advice, Shawn. Would you mind expanding on how you work 
> with git-svn, however? Specially, how's your everyday work, and how do 
> you deal with multiple upstream branches.

I don't use multiple upstream branches in SVN fortunately, but the
git-svn documentation suggests there is a way to change the Git
branch name from 'refs/remotes/git-svn' to another name such that
you can create one Git branch for each remote SVN branch.  Of course
you need to set that environment variable before invoking git-svn.

As for my daily work with git-svn, I run "git svn fetch" to fetch any
changes that had occurred in SVN along the branch I follow, then if
any changes did exist I merge them into my Git working branch with
"git pull . refs/remotes/git-svn".  When I'm ready to send stuff
back up to SVN I do "git svn dcommit refs/remotes/git-svn..master",
where master is the name of the Git branch I want to send.

-- 
Shawn.
