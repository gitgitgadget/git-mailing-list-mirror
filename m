From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Allow fetching from multiple repositories at once
Date: Fri, 28 Jul 2006 16:13:28 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607281608520.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060728054341.15864.35862.stgit@machine>
 <Pine.LNX.4.63.0607281045430.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060728140058.GM13776@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	alp@atoker.com
X-From: git-owner@vger.kernel.org Fri Jul 28 16:13:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6T5q-0003al-Qg
	for gcvg-git@gmane.org; Fri, 28 Jul 2006 16:13:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161167AbWG1ONb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Jul 2006 10:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161170AbWG1ONb
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Jul 2006 10:13:31 -0400
Received: from mail.gmx.de ([213.165.64.21]:54921 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1161167AbWG1ONa (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Jul 2006 10:13:30 -0400
Received: (qmail invoked by alias); 28 Jul 2006 14:13:29 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp023) with SMTP; 28 Jul 2006 16:13:29 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060728140058.GM13776@pasky.or.cz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24388>

Hi,

On Fri, 28 Jul 2006, Petr Baudis wrote:

> Dear diary, on Fri, Jul 28, 2006 at 10:51:56AM CEST, I got a letter
> where Johannes Schindelin <Johannes.Schindelin@gmx.de> said that...
> > So the scenario is: one remote repository (probably shared), and multiple 
> > local repositories, all tracking different branches?
> > 
> > So, why not setup a single local (master) repository, setup all the other 
> > repos with the local master as alternate, and write a simple script which 
> > first fetches all branches into the master, and then pulls into the other 
> > local repos from that master?
> 
>   Nope, the scenario is many remote repositories and any number of local
> repositories.

Ah, that clarifies it for me.

> Look at http://gitweb.freedesktop.org/ - as far as I know, many people 
> have many (most?) of those repositories cloned and fetching updates is 
> just a huge pain. This makes no assumptions about the number of local 
> repositories, you can even fetch into various branch of a single local 
> repository - only if you fetch into multiple repositories, all of them 
> must see the objects you fetched.
> 
>   The alternative of squashing all the remote repositories into a single
> one is probably not very attractive since you get a huge branches tree
> instead, varying hooks will get impractical, it won't look good in
> gitweb, git clone will by default clone all the stuff, you will need to
> impose tag namespaces, permissions might get tricky and so on and so on.

You misunderstood me: I was talking about a (hidden) local multiplexer.

But in the scenario you painted, wouldn't it be practical to have one 
consolidated repo _in addition_ to the small ones? Of course, the refs in 
the consolidated one would have to be prefixed with the name of the repo 
they come from.

> > The beauty of it is: you can still pull/push directly from the remote 
> > repo, if you want.
> 
>   This should let you do that too.

Of course. But the solution I proposed does not need a patch, and _still_ 
lets you do said operations. Just wanted to point that out.

Ciao,
Dscho
