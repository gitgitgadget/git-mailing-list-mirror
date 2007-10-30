From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: How to merge git://repo.or.cz/git-gui into git.git
Date: Mon, 29 Oct 2007 20:52:17 -0400
Message-ID: <20071030005217.GT14735@spearce.org>
References: <46dff0320710280357u23927960hd204760b3d664ce2@mail.gmail.com> <46dff0320710280400v523e2130nd3286a88a4920a9c@mail.gmail.com> <20071028111443.GA29183@xp.machine.xx> <46dff0320710282345r2922ac7dj9c7a4eb3e20fd011@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Peter Baumann <waste.manager@gmx.de>, git@vger.kernel.org
To: Yin Ping <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 01:52:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImfLR-0008Dq-1E
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 01:52:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752296AbXJ3AwW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2007 20:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752498AbXJ3AwW
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Oct 2007 20:52:22 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:51190 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752225AbXJ3AwW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2007 20:52:22 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1ImfKy-0002vq-IU; Mon, 29 Oct 2007 20:52:08 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id DB14C20FBAE; Mon, 29 Oct 2007 20:52:17 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <46dff0320710282345r2922ac7dj9c7a4eb3e20fd011@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62637>

Yin Ping <pkufranky@gmail.com> wrote:
> On 10/28/07, Peter Baumann <waste.manager@gmx.de> wrote:
> >
> > Have a look at the subtree merge strategy [1] and at the following
> > explanations how git-gui got initally merged.
> >
> > -Peter
> >
> > [1]: http://www.gelato.unsw.edu.au/archives/git/0702/40139.html
> > [2]: http://www.gelato.unsw.edu.au/archives/git/0702/39661.html
> 
> When i merged git.git into git-gui with subtree strategy, I found all
> histories of git.git merged into histories of git-gui (from 584
> history entries to 11985). Is it possible that only histories related
> to git-gui subdirectory in git.git(i.e. histories displayed by git-log
> git-gui) are  merged into?
> 
> 2. pull with subtree strategy
> ~/git-gui$  git-pull -s subtree git master:master

You are merging in the wrong direction.  You want to merge git-gui
into git.git:

	git clone git://repo.or.cz/alt-git.git mygit
	cd mygit
	git pull -s subtree git://repo.or.cz/git-gui.git master

So you are pulling git-gui into git, not the reverse.  But yes,
when this happens the entire history of the pulled project (in the
above case git-gui) suddenly appears in the history of the parent
project (in this case git).  If you don't want this to happen then
you need to make git-gui into a submodule.  That has been talked
about being done, but hasn't happened yet in the main git repository.
git-gui is currently still being subtree merged in.

-- 
Shawn.
