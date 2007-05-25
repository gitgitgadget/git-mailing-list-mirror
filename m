From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 11/22] entry.c: optionally checkout submodules
Date: Thu, 24 May 2007 20:49:22 -0400
Message-ID: <20070525004921.GQ28023@spearce.org>
References: <11799589913153-git-send-email-skimo@liacs.nl> <11799589922243-git-send-email-skimo@liacs.nl> <81b0412b0705232359g34321bb9hda50c3e29d7d3473@mail.gmail.com> <20070524071819.GN28023@spearce.org> <20070524162106.GN5412@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>,
	"skimo@liacs.nl" <skimo@liacs.nl>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Fri May 25 02:49:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrNzu-0007Ps-89
	for gcvg-git@gmane.org; Fri, 25 May 2007 02:49:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbXEYAtg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 20:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbXEYAtg
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 20:49:36 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:57596 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709AbXEYAtg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 20:49:36 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HrNzV-0004GW-Gq; Thu, 24 May 2007 20:49:13 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 79CB920FBAE; Thu, 24 May 2007 20:49:22 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070524162106.GN5412@admingilde.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48319>

Martin Waitz <tali@admingilde.org> wrote:
> 
> On Thu, May 24, 2007 at 03:18:19AM -0400, Shawn O. Pearce wrote:
> > I'm actually really unhappy with our !istty(2) means disable
> > progress thing.  git-gui knows how to read and show the progress
> > meters, but nobody prints them anymore as 2 is a pipe.  I have the
> > same problem with a Java build tool that sometimes starts up an
> > expensive Git operation (like a clone over SSH of a 60+ MiB project).
> > 
> > I've been considering adding a GIT_ISTTY environment variable to
> > forcefully override the istty result, just to get the progress
> > meters turned back on...
> 
> or perhaps introduce GIT_PROGRESS to name a filedescriptor which then
> _only_ gets all the progress information, in a format easily parseable
> by other tools?

Unfortunately that isn't Tcl friendly, and its *really* not Tcl
on Windows friendly as there we have a difficult time passing
environment variables from Tcl down into Cygwin forked processes.
That problem appears to be a glitch in how Cygwin's Tcl happens to be
implemented on Windows; its actually more a native Tcl than a Cygwin
process, especially when it comes to the builtin Tcl "exec" command.

But its a good idea.  Its just hard for me to take advantage of
it up in git-gui.  ;-)

-- 
Shawn.
