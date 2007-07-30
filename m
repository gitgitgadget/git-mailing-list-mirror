From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-gui blame: show previous commit
Date: Sun, 29 Jul 2007 23:43:14 -0400
Message-ID: <20070730034314.GQ20052@spearce.org>
References: <87myxfzhk6.fsf@mid.deneb.enyo.de> <Pine.LNX.4.64.0707291238230.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Florian Weimer <fw@deneb.enyo.de>
X-From: git-owner@vger.kernel.org Mon Jul 30 05:43:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFMAG-0005l3-Q0
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 05:43:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937253AbXG3DnW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 23:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937206AbXG3DnW
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 23:43:22 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:60058 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936908AbXG3DnV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2007 23:43:21 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IFM9w-0008QQ-A6; Sun, 29 Jul 2007 23:43:04 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 373AC20FBAE; Sun, 29 Jul 2007 23:43:15 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707291238230.14781@racer.site>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54176>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Sun, 29 Jul 2007, Florian Weimer wrote:
> 
> > How can I view the previous commit touching a specific line, so that I
> > can see what was there before?  For instance, the change could be
> > whitespace-only, so that I want to dig deeper.
> 
> If you want to ignore whitespace changes, try the option "-w" to "git 
> blame".  I have no idea if "git-gui blame" can use that option, but it 
> should not be hard for you to find out, and provide a patch if it does 
> not yet.

gitgui-0.7.4-35-ga840566 is a change from Junio to enable the
-w flag to git-blame if the underlying git is 1.5.3 or later.
So you'd need a pretty recent git-gui and a 1.5.3-rc0 or later
git binary underneath of it to get -w enabled in blame.  But it is
there for the original line annotation pass (the second blame pass
but first column displayed).

I keep meaning to add a "Show parent commit" in the context menu
of the blame viewer, but I haven't gotten around to it yet.
It has been requested a few times, just hasn't been done yet.
Maybe someone who wants it will submit a patch.  ;-)

In really recent git-gui (gitgui-0.7.5-76-g8e891fa and later) you
can browse any revision you want, so you could copy the commit SHA-1
from the lower pane and paste it in as "$sha1^" into the revision
expression field of the browse dialog, navigate to the file and
open the blame viewer.  That is really annoying, and doesn't jump
you to the correct lines automatically.  But it is possible to view
the parent.

-- 
Shawn.
