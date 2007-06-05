From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Improved git-gui blame viewer
Date: Tue, 5 Jun 2007 00:38:24 -0400
Message-ID: <20070605043824.GB9513@spearce.org>
References: <20070602041723.GD7044@spearce.org> <81b0412b0706040910w1894770bm593e0e54fbb3c44@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 05 06:38:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvQok-0003oe-0F
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 06:38:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753993AbXFEEi3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 00:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754612AbXFEEi2
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 00:38:28 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:55280 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753993AbXFEEi2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2007 00:38:28 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HvQoM-0005QS-6x; Tue, 05 Jun 2007 00:38:26 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C6AF320FBAE; Tue,  5 Jun 2007 00:38:24 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <81b0412b0706040910w1894770bm593e0e54fbb3c44@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49158>

Alex Riesen <raa.lkml@gmail.com> wrote:
> On 6/2/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> >
> >I finally got the git-gui code to the point where cleaning up the
> >user interface was possible without sending myself to the nut house.
> >
> 
> Very-very nice :) 

Thanks.  I'm not done yet.  There's a lot of interesting navigation
I still want to get in, like visting the parent of a changed line,
instead of the commit that changed that line.  I also want to let
you open commits in a new window, rather than the current one.

> Does not seem to save sizes and positions of
> blame and file browser windows, though. It did before, I believe
> in .git/config.

Actually we have never saved the window sizes/positions of the 
blame and browser windows, only the main commit window.  Though
you may have been seeing a bug where we restored the main commit
window's saved geometry on a browser or blame window if the latter
was started from the command line...

> BTW, saving windows positions in .git/config was scary: I
> considered it user domain (yes, I _am_ afraid of using
> git-config too).
> Maybe it could be something like either ~/.git-gui or .git/guiconfig?

I'm apparently not afraid of git-config editing file(s).  I have
yet to see a failure from it.  I guess I'm lucky, but will now
suffer a failure tomorrow when I'm least expecting it.  ;-)

Don't we use git-config to edit the config file in git-branch?
In git-remote?  git-gui has *always* used git-config to store
its data.  You are sort of asking me to replace a working config
system with a new one that hasn't been tested...

Now moving the git-gui config to say ~/.gitgui-config and
.git/gitgui-config may have a good argument, as then git-gui
is editing its own files.  Unless the user changes user.name
or user.email through git-gui, in which case we have to edit
.git/config or ~/.gitconfig anyway...

-- 
Shawn.
