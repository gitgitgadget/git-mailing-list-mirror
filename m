From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: FFmpeg considering GIT
Date: Mon, 7 May 2007 22:03:38 -0400
Message-ID: <20070508020338.GF11311@spearce.org>
References: <loom.20070502T111026-882@post.gmane.org> <20070503180016.GB21333@informatik.uni-freiburg.de> <20070503200013.GG4489@pasky.or.cz> <loom.20070504T143538-533@post.gmane.org> <87y7k4lahq.wl%cworth@cworth.org> <20070505133543.GC3379@diana.vm.bytemark.co.uk> <alpine.LFD.0.98.0705051019580.3819@woody.linux-foundation.org> <alpine.LFD.0.98.0705051511020.17381@woody.linux-foundation.org> <alpine.LFD.0.98.0705051524300.17381@woody.linux-foundation.org> <17983.6136.147062.346626@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Karl Hasselstr?m <kha@treskal.com>,
	Junio C Hamano <junkio@cox.net>,
	Carl Worth <cworth@cworth.org>,
	Michael Niedermayer <michaelni@gmx.at>,
	Git Mailing List <git@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue May 08 04:04:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlF3Y-0006mi-BQ
	for gcvg-git@gmane.org; Tue, 08 May 2007 04:04:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966602AbXEHCDz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 22:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966829AbXEHCDz
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 22:03:55 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:51645 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966602AbXEHCDy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 22:03:54 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HlF33-0002oD-Nw; Mon, 07 May 2007 22:03:30 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3A94E20FBAE; Mon,  7 May 2007 22:03:39 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <17983.6136.147062.346626@cargo.ozlabs.ibm.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46515>

Paul Mackerras <paulus@samba.org> wrote:
> I have thought about rewriting it in a different language, but I
> haven't found anything that really appeals.  I don't want to go to
> C/GTK or C/Qt since that would make it hard to port to Windows and
> MacOS AFAIK.  Python/Tk would be a possibility, but I have never
> learnt python and I'm actually not all that comfortable with having to
> do things the object-oriented way.
> 
> Any suggestions?

Funny that you mention this.  Lately I have been hacking on git-gui,
trying to improve it and clean up some of the code.

I've thought about wxWindows but didn't really dig into it to see
how usuable it would be - primary reason is not everyone has it
installed on their system.  The same for GTK and Qt.  Actually I
don't even have GTK installed on my Mac but I did install Qt3
(took half a day!)  so I could build qgit at one point in time.

But almost everyone already has a wish installed.

I've thought about writing git-gui in C, but linking to the Tk
library for the "portable UI".  But not everyone has the Tcl/Tk
development headers and libraries installed, but they probably do
have the wish executable installed.

I want to limit the barrier to entry for git, and that means limiting
the barrier of entry for git-gui.  Keeping our requirements to a
minimum helps.

So I think I've settled on sticking to Tcl and its Tk extensions,
but making more use of newer Tcl constructs like namespaces.  If you
look at my `pu` branch of git-gui I have actually split the program
down into many files, and have started to organize the code in each
into different namespaces, depending on function.

-- 
Shawn.
