From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-gui: Handle git versions of the form n.n.n.GIT
Date: Tue, 17 Jul 2007 21:51:38 -0400
Message-ID: <20070718015138.GR32566@spearce.org>
References: <Pine.LNX.4.64.0707171244080.13359@reaper.quantumfyre.co.uk> <20070717212103.11950.10363.julian@quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Wed Jul 18 03:51:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAyhd-000616-Cn
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 03:51:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756450AbXGRBvn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 21:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756426AbXGRBvm
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 21:51:42 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:48135 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756104AbXGRBvm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2007 21:51:42 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IAyhN-0004SW-AX; Tue, 17 Jul 2007 21:51:29 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id DB5B520FBAE; Tue, 17 Jul 2007 21:51:38 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070717212103.11950.10363.julian@quantumfyre.co.uk>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52817>

Julian Phillips <julian@quantumfyre.co.uk> wrote:
> > 'Error in startup script: expected version number but got "1.5.3.GIT"'
> > 
> > followed by what I assume is a code snippet where it failed (I wouldn't 
> > know tcl if it hit me with a large brick).
> > 
> > Is this expected? driver error? or maybe a bug?

Bug in git-gui.  *sigh*
 
> Well, whichever it is, this seems to fix it for me ... with the proviso that I
> still no nothing about tcl.  I am also not sure if it is correct to do the
> patch against the git repo?
> 
>  git-gui/git-gui.sh |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)

Many thanks for the fix.  I was about to do this myself but found
your message in my inbox instead.  Happy days.

Fortunately git-am -3 does wonders, and it didn't matter:

  $ git am -s -3 jp
  
  Applying git-gui: Handle git versions of the form n.n.n.GIT
  
  error: git-gui/git-gui.sh: does not exist in index
  Using index info to reconstruct a base tree...
  Falling back to patching base and 3-way merge...
  Renamed git-gui/git-gui.sh => git-gui.sh
  Wrote tree 1909733645c3bd167b1b28a98ee66c0a95f357f1
  Committed: 91464dfb102d6143182d8f312b68486e9dceb103

I've extolled the virtues of -3 and merge-recursive's rename detector
before on the mailing list, for exactly this reason.  Despite the
patch coming in with the wrong path it still applies just fine.

-- 
Shawn.
