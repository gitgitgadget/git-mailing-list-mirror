From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: What's new in git-gui.git
Date: Tue, 29 May 2007 22:34:19 -0400
Message-ID: <20070530023419.GK7044@spearce.org>
References: <20070528224949.GC7044@spearce.org> <20070529041108.GG7044@spearce.org> <20070529111836.GW4489@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed May 30 04:34:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtE18-00045p-S4
	for gcvg-git@gmane.org; Wed, 30 May 2007 04:34:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbXE3CeY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 May 2007 22:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbXE3CeY
	(ORCPT <rfc822;git-outgoing>); Tue, 29 May 2007 22:34:24 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:41907 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803AbXE3CeY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2007 22:34:24 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HtE0o-0003dP-SS; Tue, 29 May 2007 22:34:10 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 74B6020FBAE; Tue, 29 May 2007 22:34:20 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070529111836.GW4489@pasky.or.cz>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48723>

Petr Baudis <pasky@suse.cz> wrote:
> On Tue, May 29, 2007 at 06:11:08AM CEST, Shawn O. Pearce wrote:
> > Apparently the Linux folks have this new fangled inotify thing
> > that is also good at telling applications about changed files.
> > It seems the hg folks are using it to speed up "hg status" by
> > having a background daemon keep track of which files are dirty,
> > and which aren't.
> 
> How well does this play with NFS? I'm working at two places and at both
> have my ~ on NFS and sometimes touch the working tree from various
> machines. Would the inotify-based approach silently fail here? Or does
> inotify just refuse to work on NFS? Quick google search suggests the
> former, which is more than ok for informative purposes but big problem
> if you actually _rely_ on the inotify to keep your index up-to-date.

>From what I've read on it thus far (which isn't much) inotify
doesn't work over NFS.

I would *never* suggest relying on inotify for everything.
But making it an option for folks who can use it may be nice.
A lot of us do work on a local filesystem.  Being able to get
faster status output in those cases could be nice, especially on
a big tree and slow VFS systems like Windows.

-- 
Shawn.
