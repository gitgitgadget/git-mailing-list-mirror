From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Merge git-gui into 1.5.0 ?
Date: Sun, 11 Feb 2007 17:41:58 -0500
Message-ID: <20070211224158.GA31488@spearce.org>
References: <20070211084030.GE2082@spearce.org> <7vwt2oba8s.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 11 23:42:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGNOd-0001D3-J3
	for gcvg-git@gmane.org; Sun, 11 Feb 2007 23:42:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932604AbXBKWmF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 17:42:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932601AbXBKWmE
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 17:42:04 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:51410 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932604AbXBKWmC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 17:42:02 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HGNOJ-00021D-Cp; Sun, 11 Feb 2007 17:41:51 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E2F1C20FBAE; Sun, 11 Feb 2007 17:41:58 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vwt2oba8s.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39318>

Junio C Hamano <junkio@cox.net> wrote:
> I do not have objection per-se, but I have two choices on the
> procedure, and I hate having choices this close to the final
> release ;-).
...
> I was actually hoping I can do so with Kay, but from his point
> of view merging gitweb to git.git was so that he does not have
> to worry about it anymore, so it did not work well.

I'm OK with either approach here.

Originally I had intended to wipe out everything except git-gui.sh,
then do an ancestor-less merge into git.git's top level directory,
and finally tweak git.git's master Makefile to add git-gui.sh to
the list of known shell scripts.  Then I was going to ask you to
pull that resulting tree.

But it may make a *lot* more sense to treat is a true subproject in
its own directory.  Unlike Kay, I'm not looking to merge git-gui
into git.git to abandon it.  I just think we should offer a GUI
out of the box, git-gui has the same dependencies as gitk, and I
happen to like git-gui.  ;-)

git-gui development is going to continue past 1.5.0's release.
There are still a lot of operations it should support that it
currently does not do, and there are certainly user interface
improvements that can still be made.

It may be saner for all involved if that development happens in
the git-gui.git repository, with drops made to git.git by way of
merging the "subproject" every so often.

It may make patching slightly more interesting though, as some
users new to git-gui development may generate a patch in git.git
(using a/git-gui/git-gui.sh as the path) which then would not apply
as-is to the master git-gui development tree.

Entirely your call Junio.

-- 
Shawn.
