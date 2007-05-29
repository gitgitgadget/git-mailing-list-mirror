From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: What's new in git-gui.git
Date: Tue, 29 May 2007 00:11:08 -0400
Message-ID: <20070529041108.GG7044@spearce.org>
References: <20070528224949.GC7044@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 29 06:12:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hst3X-0003Yy-Ru
	for gcvg-git@gmane.org; Tue, 29 May 2007 06:11:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbXE2ELM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 May 2007 00:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751010AbXE2ELM
	(ORCPT <rfc822;git-outgoing>); Tue, 29 May 2007 00:11:12 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:37819 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750708AbXE2ELL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2007 00:11:11 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1Hst2v-0001wf-6O
	for git@vger.kernel.org; Tue, 29 May 2007 00:10:57 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 81B5720FBAE; Tue, 29 May 2007 00:11:08 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070528224949.GC7044@spearce.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48666>

"Shawn O. Pearce" <spearce@spearce.org> wrote:
> --- Roadmap ---
> 
> Looking ahead, I'd like to see some improvement in the following
> areas.  It would be nice if some Tcl/Tk-minded individuals were
> willing to dive and help.  ;-)

I also want to get file change notification integrated into git-gui.
Basic idea is, if you edit a file in your editor of choice, git-gui
should notice it right away, without waiting for you to press the
damn Rescan button.

On Windows the only thing that actually works there (aside from
drawing lots and lots of blue pixels) is a fancy little file
monitoring API.  That actually works quite well.  Nothing else on
that OS works of course, but it will tell you when a file changes.
NT 4.0 and later only... ;-)

Apparently the Linux folks have this new fangled inotify thing
that is also good at telling applications about changed files.
It seems the hg folks are using it to speed up "hg status" by
having a background daemon keep track of which files are dirty,
and which aren't.

So I'm likely to want to try to implement something like this for
core Git and for git-gui, but my primary development system is Mac
OS X, where the BSD gods have only given us kqueue() and all its
warts... (it is basically useless for this task of monitoring a
"huge" tree like git.git, Mozilla.git need not apply).

-- 
Shawn.
