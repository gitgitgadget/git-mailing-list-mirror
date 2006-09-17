From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Setting up Password protected repositories?
Date: Sat, 16 Sep 2006 22:20:14 -0400
Message-ID: <20060917022013.GA7512@spearce.org>
References: <E1GOktx-0005JY-ER@jdl.com> <7virjn8eua.fsf@assigned-by-dhcp.cox.net> <E1GOm3h-0005jq-5u@jdl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 17 04:20:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOmGe-00070A-Mj
	for gcvg-git@gmane.org; Sun, 17 Sep 2006 04:20:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964919AbWIQCUW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Sep 2006 22:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964918AbWIQCUW
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Sep 2006 22:20:22 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:12741 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S964917AbWIQCUV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Sep 2006 22:20:21 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GOmGK-0007RL-DC; Sat, 16 Sep 2006 22:20:04 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4A85020FB1F; Sat, 16 Sep 2006 22:20:14 -0400 (EDT)
To: Jon Loeliger <jdl@jdl.com>
Content-Disposition: inline
In-Reply-To: <E1GOm3h-0005jq-5u@jdl.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27154>

Jon Loeliger <jdl@jdl.com> wrote:
> So, like, the other day Junio C Hamano mumbled:
> > 
> > It all depends on how you start git-daemon, but the last
> > parameters to git-daemon are path whitelist so presumably
> > placing the private repository outside of it should be enough.
> > 
> > Or am I missing something deeper?
> 
> I want git-daemon to serve up the repository.
> I just want to have it served to people who can
> supply a password or have an ssh key in place.

Don't use git-daemon.

Instead create UNIX accounts for the people who need access and if
you don't want them to actually be able to login set their shell
to be `git-sh`.  This is a special shell-like thing that only lets
the user push or fetch to any repository they have access to.

The URL is a 'git+ssh' style URL and they will use SSH to connect.

Access is controlled by standard UNIX user/group read/write access
and ACLs if your OS/filesystem support them.  You can also control
pushing with an update hook.

-- 
Shawn.
