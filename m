From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: How is working on arbitrary remote heads supposed to work in
 Cogito (+ PATCH)?
Date: Thu, 28 Jul 2005 22:14:35 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0507282201110.3005@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.58.0507281931180.30371@wgmdd8.biozentrum.uni-wuerzburg.de>
 <200507271458.43063.Josef.Weidendorfer@gmx.de> <7vll3rlnqm.fsf@assigned-by-dhcp.cox.net>
 <200507271458.43063.Josef.Weidendorfer@gmx.de> <20050728120806.GA2391@pasky.ji.cz>
 <Pine.LNX.4.58.0507281504100.25402@wgmdd8.biozentrum.uni-wuerzburg.de>
 <20050728153506.GL14229@pasky.ji.cz> <Pine.LNX.4.58.0507281747320.29968@wgmdd8.biozentrum.uni-wuerzburg.de>
 <20050728161815.GC17952@pasky.ji.cz> <7v1x5ic1pe.fsf@assigned-by-dhcp.cox.net>
 <20050728183904.GA24948@pasky.ji.cz> <Pine.LNX.4.58.0507282047360.30638@wgmdd8.biozentrum.uni-wuerzburg.de>
 <pan.2005.07.28.19.47.38.753705@smurf.noris.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 28 22:20:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyErO-0002gg-RW
	for gcvg-git@gmane.org; Thu, 28 Jul 2005 22:20:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261493AbVG1UTZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jul 2005 16:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261781AbVG1URP
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jul 2005 16:17:15 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:22243 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S261630AbVG1UOi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2005 16:14:38 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 7E0A3E24C0; Thu, 28 Jul 2005 22:14:35 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 5FBFF913E1; Thu, 28 Jul 2005 22:14:35 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 4AC17913DB; Thu, 28 Jul 2005 22:14:35 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 3453DE24C0; Thu, 28 Jul 2005 22:14:35 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Matthias Urlichs <smurf@smurf.noris.de>
In-Reply-To: <pan.2005.07.28.19.47.38.753705@smurf.noris.de>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 28 Jul 2005, Matthias Urlichs wrote:

> Hi, Johannes Schindelin wrote:
>
> Since git is better than all of these, we should be able to easily write a
> SVN-like porcelain, so ... ;-)

Sorry, you're correct.

> > IMHO, if you need a central repository, you should also have
> > one central HEAD.
>
> I disagree. Larger projects have multiple HEADs (stable, oldstable,
> development, ...). I don't like putting those in different repositories,
> you end up with a heap of housekeeping effort to hardlink duplicate
> objects, all of which is going to be wasted when different people run
> "git repack".

Sorry again. I should have been clearer: If you have a larger project
which does have production releases which have to be patched for a while,
and thus need several branches, then there is still a *very good* reason
not to play games with the names of those branches or the tags.

Naming the remote HEAD differently than the local HEAD is just *wrong*
when you want to push back to them. I agree that it is a fine intellectual
challenge to keep juggling a few remote HEADs, and throw in a few local
HEADs, but all that is *complicated*. And complicated things lead to
complications.

BTW I am a Jeff, I use git branches extensively in two projects.

The only sane way if you have to have different local and remote HEADs
that I can think of, would be to allow only the current local active HEAD
to be pushed to a certain remote HEAD (preferably identified by a file in
.git/branches).

Ciao,
Dscho
