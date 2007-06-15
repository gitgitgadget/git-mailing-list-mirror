From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [CORRECTED PATCH] Introduce file with the common default build-time items.
Date: Thu, 14 Jun 2007 23:22:04 -0400
Message-ID: <20070615032204.GC18491@spearce.org>
References: <20070613054316.GN86872@void.codelabs.ru> <20070614043633.GV6073@spearce.org> <20070614095654.GT86872@void.codelabs.ru> <20070614150929.GA18491@spearce.org> <20070614190739.GA3779@void.codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eygene Ryabinkin <rea-git@codelabs.ru>
X-From: git-owner@vger.kernel.org Fri Jun 15 05:22:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hz2O6-0004eL-2U
	for gcvg-git@gmane.org; Fri, 15 Jun 2007 05:22:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753666AbXFODWM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jun 2007 23:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752271AbXFODWM
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 23:22:12 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:33035 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752035AbXFODWL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2007 23:22:11 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1Hz2No-0000st-8Y; Thu, 14 Jun 2007 23:21:56 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E6FCE20FBAE; Thu, 14 Jun 2007 23:22:04 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070614190739.GA3779@void.codelabs.ru>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50234>

Eygene Ryabinkin <rea-git@codelabs.ru> wrote:
> Thu, Jun 14, 2007 at 11:09:29AM -0400, Shawn O. Pearce wrote:
> > Eygene Ryabinkin <rea-git@codelabs.ru> wrote:
> > No, because Junio has already stated a desire to remove git-gui.git
> > from git.git and convert it to a proper subproject by the time of
> > Git 1.6.  That means the git-gui/ subdirectory will become optional,
> > though I imagine most git-gui users will still have it.  But not
> > all Git users are git-gui users.  ;-)
> 
> OK, it means that git-gui will be totally separated from the
> git.git?  And one will download it as the separate tarball?

That's one option.  But Junio and I are also considering keeping
it inside the git tarball as well, as many users have gotten used
to it being in the core Git distribution.  I think it all depends
on if myself (or someone else) adds subproject recursion support
into git-archive.  ;-)

No subproject recusion in git-archive will probably mean git-gui
would get dropped from the core git tarball.  Given we're talking
about 1.6 timeframe I think we might be able to get that feature
working by then.

> > The best we can do is let the user pick their TCL_PATH and
> > TCLTK_PATH up in git's own Makefile, and have it pass down into
> > git-gui's Makefile when git-gui is being built from within git.
> > That is the arrangement we currently have.
> 
> OK, fine, thanks for the explanations.  The corrected patch follows.
 
...
>  Makefile             |   17 +++++++++++------
>  common-make-vars.def |   11 +++++++++++
>  configure.ac         |    4 +++-
>  3 files changed, 25 insertions(+), 7 deletions(-)
>  create mode 100644 common-make-vars.def
...

I dunno.  25 insertions and 7 deletions to reduce two uses of 'wish'
into one use of 'wish'?  That hardly seems worth the additional
18 lines of code.  Feels like code churn to me.  And I rarely feel
code churn.  I'm usually a lot more caviler about changing things
than Junio, Dscho, Nico, Linus, ...

-- 
Shawn.
