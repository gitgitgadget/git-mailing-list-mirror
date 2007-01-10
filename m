From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Detached HEAD (experimental)
Date: Tue, 9 Jan 2007 19:34:33 -0500
Message-ID: <20070110003433.GH30023@spearce.org>
References: <87odphgfzz.wl%cworth@cworth.org> <7vbql9ydd7.fsf@assigned-by-dhcp.cox.net> <20070108131735.GA2647@coredump.intra.peff.net> <7vzm8tt5kf.fsf@assigned-by-dhcp.cox.net> <20070109142130.GA10633@coredump.intra.peff.net> <7virffkick.fsf@assigned-by-dhcp.cox.net> <20070109213117.GB25012@fieldses.org> <87zm8ryiyz.wl%cworth@cworth.org> <20070109234421.GD30023@spearce.org> <eo1bqu$hji$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 10 01:34:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4RQR-00027c-6y
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 01:34:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932599AbXAJAej (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 19:34:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932600AbXAJAej
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 19:34:39 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:36967 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932599AbXAJAei (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 19:34:38 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H4RQA-0003bm-An; Tue, 09 Jan 2007 19:34:26 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A143020FBAE; Tue,  9 Jan 2007 19:34:34 -0500 (EST)
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <eo1bqu$hji$1@sea.gmane.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36443>

Jakub Narebski <jnareb@gmail.com> wrote:
> Shawn O. Pearce wrote:
> 
> > In my mind that is a small price to pay for making sure the
> > commit currently in a detached HEAD doesn't get orphaned off
> > into never-never land.
> 
> By the way, would detached HEAD be reflogged, and if it would
> (and certainly it would be nice to have, because protection or
> not sh*t happens) how it would be implemented?

Ohhhhh.  It should reflog if .git/logs/HEAD exists, so long as
changes to HEAD are done via update-ref and not just by echo (as
one of Junio's versions of the feature had done).

Unfortunately .git/logs/HEAD wouldn't be created by default as its
not under refs/heads or refs/remotes.  Though it could be made to be
on by default, in which case it would only log changes while HEAD
is detached.  If HEAD is attached to a branch then .git/logs/HEAD
wouldn't be appended to (or even created), while the branch's own
log is still appended to.

-- 
Shawn.
