From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: FFmpeg considering GIT
Date: Tue, 8 May 2007 00:19:39 -0400
Message-ID: <20070508041939.GK11311@spearce.org>
References: <57600.59393.qm@web38909.mail.mud.yahoo.com> <17983.63329.314321.305860@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brett Schwarz <brett_schwarz@yahoo.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Karl Hasselstr?m <kha@treskal.com>,
	Junio C Hamano <junkio@cox.net>,
	Carl Worth <cworth@cworth.org>,
	Michael Niedermayer <michaelni@gmx.at>,
	Git Mailing List <git@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue May 08 06:19:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlHB5-0006oP-25
	for gcvg-git@gmane.org; Tue, 08 May 2007 06:19:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967723AbXEHETt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 00:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967732AbXEHETt
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 00:19:49 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:54143 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967723AbXEHETs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 00:19:48 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HlHAs-0001Kw-1E; Tue, 08 May 2007 00:19:42 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id DB84220FBAE; Tue,  8 May 2007 00:19:39 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <17983.63329.314321.305860@cargo.ozlabs.ibm.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46534>

Paul Mackerras <paulus@samba.org> wrote:
> Brett Schwarz writes:
> > As Shawn mentions below, he started using namespaces for git-gui. I
> > think gitk could benefit from that as well, along with a few other
> > changes.
> 
> Gitk ends up handling pretty significant amounts of data.  In
> particular the per-commit data can get to gigabytes, and processing it
> is pretty cpu-intensive.  I did try using namespaces for the
> per-commit data but I found that the performance hit to be more than I
> was willing to tolerate.

If that is the case then an obvious direction is to start using C
for the actual Git operations/datastore and Tcl/Tk for the basic
UI layout and event handlers.

If we go down that path for gitk then I may wind up doing the
same for git-gui.  Because gitk would require the tcl/tk heders
and libraries at that point, so also requiring them for git-gui
wouldn't be too unreasonable.

But fortunately git-gui doesn't have to deal with gigabytes
of data; I'm only really looking at the "dirty" stuff, or
at worst, the blame for an entire file.

-- 
Shawn.
