From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [BUG] imap-send.c fails to build on OSX
Date: Mon, 13 Mar 2006 00:03:38 -0500
Message-ID: <20060313050338.GA18154@spearce.org>
References: <863bhnlo3r.fsf@blue.stonehenge.com> <20060313042552.GA18136@spearce.org> <86zmjvhsru.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 13 06:03:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FIfDh-0007Du-2D
	for gcvg-git@gmane.org; Mon, 13 Mar 2006 06:03:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbWCMFDq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Mar 2006 00:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbWCMFDq
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Mar 2006 00:03:46 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:35523 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S932315AbWCMFDq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Mar 2006 00:03:46 -0500
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FIfDM-0001L6-Dv; Mon, 13 Mar 2006 00:03:28 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6FB3320FBAC; Mon, 13 Mar 2006 00:03:38 -0500 (EST)
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
Content-Disposition: inline
In-Reply-To: <86zmjvhsru.fsf@blue.stonehenge.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17548>

"Randal L. Schwartz" <merlyn@stonehenge.com> wrote:
> >>>>> "Shawn" == Shawn Pearce <spearce@spearce.org> writes:
> 
> Shawn> Workarounds for compiling on MacOS X.
> Shawn> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> 
> Shawn>  This should fix the build issues on Mac OS X.  Not tested on other
> Shawn>  (possibly) more important platforms, like Linux.  :-)
> 
> My C is a bit rusty, but wouldn't that provide a definition for vasprintf when
> the libc is *also* providing a definition?  Might that not also break other
> apps that want to link with this?
> 
> Maybe the right solution is to rename this local implementation so that it
> can't conflict, like "git_vasprintf", or to include it only when the libc
> doesn't provide it.

Your right.  But I figured it wasn't a big deal since this is just
an application and not library code.  Nobody should be linking
against it.

Perhaps the better solution is to rename the provided implementation
to git_; maybe even better to move it off to the compat library
area where other should-have-been-provided-by-the-OS definitions are.

-- 
Shawn.
