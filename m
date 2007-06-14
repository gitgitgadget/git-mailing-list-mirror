From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Introduce file with the common default build-time items.
Date: Thu, 14 Jun 2007 11:09:29 -0400
Message-ID: <20070614150929.GA18491@spearce.org>
References: <20070613054316.GN86872@void.codelabs.ru> <20070614043633.GV6073@spearce.org> <20070614095654.GT86872@void.codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eygene Ryabinkin <rea-git@codelabs.ru>
X-From: git-owner@vger.kernel.org Thu Jun 14 17:10:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hyqxy-0004ni-Nv
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 17:10:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751852AbXFNPK0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jun 2007 11:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751924AbXFNPK0
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 11:10:26 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:39985 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967AbXFNPKZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2007 11:10:25 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1Hyqxl-0000nO-H5
	for git@vger.kernel.org; Thu, 14 Jun 2007 11:10:17 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C846920FBAE; Thu, 14 Jun 2007 11:09:29 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070614095654.GT86872@void.codelabs.ru>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50203>

Eygene Ryabinkin <rea-git@codelabs.ru> wrote:
> 
> Thu, Jun 14, 2007 at 12:36:33AM -0400, Shawn O. Pearce wrote:
> > Eygene Ryabinkin <rea-git@codelabs.ru> wrote:
> > > Words 'wish' and 'tclsh' are scattered across at least three files,
> > > but they are tied to the same entities.  To ease the maintenance
> > > and remove errors, these configuration items were gathered into the
> > > separate file named 'common-make-vars.def'.
...
> > A good idea to try and make these all common, but you cannot do this,
> > or at least this part of the patch.
> 
> OK, but then may be it will be logical to put Tcl/Tk-related variables
> to the git-gui/common-make-vars.def?  I am a little worried about
> this, because gitk is the part of the git.git and it should get the
> variables too.  The drawback here is if you will update your git-gui
> repo, then git.git will need to wait for your import to get the
> changes in the variables.  And this will seriously couple git.git
> and git-gui, though I don't know if it is good or bad.

No, because Junio has already stated a desire to remove git-gui.git
from git.git and convert it to a proper subproject by the time of
Git 1.6.  That means the git-gui/ subdirectory will become optional,
though I imagine most git-gui users will still have it.  But not
all Git users are git-gui users.  ;-)

The best we can do is let the user pick their TCL_PATH and
TCLTK_PATH up in git's own Makefile, and have it pass down into
git-gui's Makefile when git-gui is being built from within git.
That is the arrangement we currently have.

-- 
Shawn.
