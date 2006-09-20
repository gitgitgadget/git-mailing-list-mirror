From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git pull for update of netdev fails.
Date: Wed, 20 Sep 2006 17:53:18 -0400
Message-ID: <20060920215318.GG24415@spearce.org>
References: <20060920155431.GO8259@pasky.or.cz> <Pine.LNX.4.63.0609201801110.19042@wbgn013.biozentrum.uni-wuerzburg.de> <20060920160756.GP8259@pasky.or.cz> <Pine.LNX.4.64.0609200915550.4388@g5.osdl.org> <Pine.LNX.4.64.0609200920290.4388@g5.osdl.org> <20060920163437.GC23260@spearce.org> <Pine.LNX.4.63.0609202321390.19042@wbgn013.biozentrum.uni-wuerzburg.de> <20060920212747.GB24415@spearce.org> <Pine.LNX.4.63.0609202333320.19042@wbgn013.biozentrum.uni-wuerzburg.de> <7vodtafc4g.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 23:53:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQA0V-0004oN-GQ
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 23:53:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbWITVxX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 17:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932214AbWITVxX
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 17:53:23 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:22490 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S932212AbWITVxW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Sep 2006 17:53:22 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GQA0E-0000d4-OA; Wed, 20 Sep 2006 17:53:10 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 67C5120E48E; Wed, 20 Sep 2006 17:53:18 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vodtafc4g.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27417>

Junio C Hamano <junkio@cox.net> wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > I'd rather set another config variable with --shared, which tells git to 
> > refuse receiving non-fast-forwards. This could be a sensible setting in 
> > other setups than shared ones after all. Thoughts?
> 
> If this option is meant to forbid fixing up an screw-up by doing
> "git-push --force", I do not quite like it.

Yes, it is meant for stopping exactly that.

As the repository owner with direct access to the repository I
don't want anyone to be able to use --force to reset a branch.
If a branch reset needs to happen I want to do it directly on
the repository.  Its a rather destructive operation, as we have
been saying.  I don't want a user slamming in "--force" just because.

On the other hand you can also configure the option to allow
`git push --force` and craft a smart update hook which looks at
who is doing the push and if that is permissible to the ref in
question; exit'ing non-zero if not.

Basically I don't see why an update hook should be necessary to
disallow all non-fast forward pushes.

> It sounds as if arguing that "rm -fr" is dangerous so presence
> of -f and -r at the same time should imply -i option.  I think
> the right answer is not making -i implied, but train the user to
> understand what -fr means before using it.

Some people cannot be trained.  No matter how hard you may try.

-- 
Shawn.
