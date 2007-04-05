From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/4] Fix drop-down menus in the git-gui dialogs.
Date: Thu, 5 Apr 2007 11:32:26 -0400
Message-ID: <20070405153226.GH5436@spearce.org>
References: <20070327103005.GP14837@codelabs.ru> <20070404163709.GA5167@spearce.org> <20070405124920.GV26348@codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eygene Ryabinkin <rea-git@codelabs.ru>
X-From: git-owner@vger.kernel.org Thu Apr 05 17:32:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZTwx-0006Vw-I0
	for gcvg-git@gmane.org; Thu, 05 Apr 2007 17:32:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767050AbXDEPcc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 11:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767058AbXDEPcc
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 11:32:32 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:38758 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767050AbXDEPcb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 11:32:31 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HZTwk-0004Kk-2J; Thu, 05 Apr 2007 11:32:22 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 27C9820FBAE; Thu,  5 Apr 2007 11:32:26 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070405124920.GV26348@codelabs.ru>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43834>

Eygene Ryabinkin <rea-git@codelabs.ru> wrote:
> Wed, Apr 04, 2007 at 12:37:09PM -0400, Shawn O. Pearce wrote:
> > git-gui patches should be addressed to me, not Paul.
> 
> Yep, I just messed with the mail addresses, since I was doing patches
> both for gitk and git-gui. Sorry for it!

Not a problem, I just wanted to make sure you were aware that they
should come to me, so that you can leave poor paulus' inbox alone.
;-)
 
> > So anyway, I cannot apply this patch as-is, because it breaks
> > my main development system.  I understand and feel your pain,
> > but you either need to make this binding apply only on your OS,
> > or find another way to workaround that Tk bug...
> 
> OK, I will try to find the other workaround, but I have no Mac OS
> X at hand (they are a bit expensive to me), so I hope you will find
> some time to test the new approaches, if I will come up with any.

That's fine.  I'd be happy to retest something.  If I understood your
problem description right, this bug doesn't appear on either Cygwin's
Tcl/Tk implementation or my Mac OS X implementation.  Maybe this
is one of those things that we just have to do conditionally per OS.

If that's the case, maybe we should also consider making our own
local variant of tk_optionMenu (a wrapper of sorts) that sets our
font_ui, and does this grab fix on your platform.

-- 
Shawn.
