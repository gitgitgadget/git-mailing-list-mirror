From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Attempt to improve git-rebase lead-in description.
Date: Sun, 18 Feb 2007 01:31:24 -0500
Message-ID: <20070218063124.GA31350@spearce.org>
References: <20070217093150.GA25871@spearce.org> <er8d34$ssm$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 18 07:31:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIfaF-0002FB-4G
	for gcvg-git@gmane.org; Sun, 18 Feb 2007 07:31:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030351AbXBRGbb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Feb 2007 01:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030352AbXBRGbb
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Feb 2007 01:31:31 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:38639 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030354AbXBRGb3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Feb 2007 01:31:29 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HIfa2-00017i-Ro; Sun, 18 Feb 2007 01:31:27 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0D6BA20FBAE; Sun, 18 Feb 2007 01:31:24 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <er8d34$ssm$1@sea.gmane.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40057>

Jakub Narebski <jnareb@gmail.com> wrote:
> Shawn O. Pearce wrote:
> > +
> > +The commits that were previously saved into the temporary area are
> > +then reapplied to the current branch, one by one, in order.
> 
> Which is true for git-format-patch/git-am --3way driven "git rebase",
> but not for git-merge driven "git rebase --merge".
> 
> The description is certainly more user-friendly, but I'd rather it avoid
> mentioning saving to temporary area.

[note: Jakub broke this thread and sent the message twice, once
 to me privately and again to the list.  I originally accidentally
 replied to Jakub's privately sent copy.]

Uhhh...  go read the source for `git-rebase -m`.  We still put the
commits into a temporary area (.git/.dotest-merge), except we store
just their SHA-1 and message rather than the patch.  Its still a
temporary area.

Even if we did not store the commits in a temporary area, they
still are conceptually, as the ODB is storing them, and they aren't
connected to a ref anymore, as the ref was reset.

My description is accurate, in either mode.

-- 
Shawn.
