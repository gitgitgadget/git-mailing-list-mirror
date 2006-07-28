From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Allow fetching from multiple repositories at once
Date: Fri, 28 Jul 2006 16:00:58 +0200
Message-ID: <20060728140058.GM13776@pasky.or.cz>
References: <20060728054341.15864.35862.stgit@machine> <Pine.LNX.4.63.0607281045430.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	alp@atoker.com
X-From: git-owner@vger.kernel.org Fri Jul 28 16:01:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6Stm-00010H-Rm
	for gcvg-git@gmane.org; Fri, 28 Jul 2006 16:01:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161157AbWG1OBD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Jul 2006 10:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161158AbWG1OBD
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Jul 2006 10:01:03 -0400
Received: from w241.dkm.cz ([62.24.88.241]:37851 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1161157AbWG1OBB (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Jul 2006 10:01:01 -0400
Received: (qmail 24055 invoked by uid 2001); 28 Jul 2006 16:00:58 +0200
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0607281045430.29667@wbgn013.biozentrum.uni-wuerzburg.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24386>

  Hi,

Dear diary, on Fri, Jul 28, 2006 at 10:51:56AM CEST, I got a letter
where Johannes Schindelin <Johannes.Schindelin@gmx.de> said that...
> So the scenario is: one remote repository (probably shared), and multiple 
> local repositories, all tracking different branches?
> 
> So, why not setup a single local (master) repository, setup all the other 
> repos with the local master as alternate, and write a simple script which 
> first fetches all branches into the master, and then pulls into the other 
> local repos from that master?

  Nope, the scenario is many remote repositories and any number of local
repositories. Look at http://gitweb.freedesktop.org/ - as far as I know,
many people have many (most?) of those repositories cloned and fetching
updates is just a huge pain. This makes no assumptions about the number
of local repositories, you can even fetch into various branch of a
single local repository - only if you fetch into multiple repositories,
all of them must see the objects you fetched.

  The alternative of squashing all the remote repositories into a single
one is probably not very attractive since you get a huge branches tree
instead, varying hooks will get impractical, it won't look good in
gitweb, git clone will by default clone all the stuff, you will need to
impose tag namespaces, permissions might get tricky and so on and so on.

> The beauty of it is: you can still pull/push directly from the remote 
> repo, if you want.

  This should let you do that too.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
