From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: GIT v1.5.1-rc1
Date: Mon, 19 Mar 2007 22:55:39 -0400
Message-ID: <20070320025539.GA28922@spearce.org>
References: <20070306063501.GA24355@spearce.org> <7v1wk2ua55.fsf@assigned-by-dhcp.cox.net> <20070306071630.GB24004@spearce.org> <7vtzwyprr7.fsf_-_@assigned-by-dhcp.cox.net> <7v8xdth5c4.fsf_-_@assigned-by-dhcp.cox.net> <17918.36447.419632.224014@lisa.zopyra.com> <7v7itcd8mk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Mar 20 03:55:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTUVr-0005oP-O1
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 03:55:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966076AbXCTCzn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 22:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966075AbXCTCzn
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 22:55:43 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:34283 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966076AbXCTCzn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 22:55:43 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HTUVV-0007IC-Dy; Mon, 19 Mar 2007 22:55:29 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 64FC320FBAE; Mon, 19 Mar 2007 22:55:39 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7v7itcd8mk.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42694>

Junio C Hamano <junkio@cox.net> wrote:
> Bill Lear <rael@zopyra.com> writes:
> 
> > On Monday, March 19, 2007 at 03:53:47 (-0700) Junio C Hamano writes:
> >>...
> >>* Hooks
> >>
> >>  - The sample update hook to show how to send out notification
> >>    e-mail was updated to show only new commits that appeared in
> >>    the repository.  Earlier, it showed new commits that appeared
> >>    on the branch.
> >
> > I did not see Shawn's changes to the update hooks in here, and can't
> > recall where these stand at the moment --- will these be forthcoming?
> 
> Do you mean "[PATCH] Split sample update hook into post-receive
> hook"?  My impression was that the discussion that followed made
> its interface obsolete with later 8-patch series from Shawn.

I think that's what Bill means, and you are correct Junio, that patch
is not valid anymore now that post-receive takes its data on stdin.

I was hoping Andy or one of the other folks who have worked on
that hook would pick up the ball and update the hook, but I
think they are stuck on the fact that you cannot use:

	git log $new --not --all

in the post-receive hook to see what commits are "new to this
repository", as $new is already in --all.  ;-)

That almost needs a --all-except="refs/heads/a refs/heads/b" option
to rev-list.  Grrrr.

-- 
Shawn.
