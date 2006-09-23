From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC][RESEND][PATCH] Allow fetching from multiple repositories
 at once
Date: Sat, 23 Sep 2006 20:14:28 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0609232007550.25853@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060923164308.16334.49252.stgit@machine.or.cz> <45156780.6070801@gmail.com>
 <20060923170439.GQ8259@pasky.or.cz> <Pine.LNX.4.63.0609231921110.25853@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060923173943.GA20017@pasky.or.cz> <Pine.LNX.4.63.0609231947340.25853@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060923180539.GC20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: A Large Angry SCM <gitzilla@gmail.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 23 20:14:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRC1P-0002qB-4g
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 20:14:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbWIWSOb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Sep 2006 14:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbWIWSOb
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 14:14:31 -0400
Received: from mail.gmx.de ([213.165.64.20]:46225 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751390AbWIWSOa (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Sep 2006 14:14:30 -0400
Received: (qmail invoked by alias); 23 Sep 2006 18:14:28 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp032) with SMTP; 23 Sep 2006 20:14:28 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060923180539.GC20017@pasky.or.cz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27611>

Hi,

On Sat, 23 Sep 2006, Petr Baudis wrote:

>   Hi!
> 
> Dear diary, on Sat, Sep 23, 2006 at 07:54:10PM CEST, I got a letter
> where Johannes Schindelin <Johannes.Schindelin@gmx.de> said that...
> > On Sat, 23 Sep 2006, Petr Baudis wrote:
> > 
> > > Dear diary, on Sat, Sep 23, 2006 at 07:23:01PM CEST, I got a letter
> > > where Johannes Schindelin <Johannes.Schindelin@gmx.de> said that...
> > > > I still firmly believe that it would be way more efficient to fetch all 
> > > > those branches into _one_ proxy repository. Especially since you can reuse 
> > > > the objects with an alternate, which has an additional benefit over your 
> > > > approach.
> > > 
> > >   Huh? You can reuse the objects with my approach as well. Actually, it
> > > is automagically done so.
> > > 
> > >   With proxy repository, you would still need a server-side setup to
> > > maintain that repository, and specialized client-side porcelain to fetch
> > > from it. My approach initially requires some core changes (which aren't
> > > very pretty as it is but are not very fundamental or logically intrusive
> > > either) but in the longer run it pays off since you don't need a
> > > convoluted server-side setup for that.
> > 
> > No, you do not need _any_ server-side setup. And you do not need any 
> > specialized client-side porcelain other than a script, which just does 
> > the job.
> 
>   So how should the proxy repository be set up at the server side? I can
> just imagine a cronjob periodically sweeping the repositories and
> populate the proxy repository with new stuff (refs and objects) from
> those.
> 
>   Looking at what you wrote again, you talk about fetching all those
> branches _into_ one proxy repository. Perhaps we misunderstand each
> other. This patch is not about the "into" part, it is about being able
> to fetch _FROM_ _multiple_ repositories.

Indeed, I misunderstood.

Hmmm. Did you test if this makes things better? If so, could you test with 
one proxy repo on the server? I bet that this would be even more 
efficient.

And the proxy repo would be updated best by a hook, not a cronjob.

The thing is, your patch optimizes for a very special case, which special 
case IMHO should be handled differently to begin with.

Ciao,
Dscho
