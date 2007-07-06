From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Update local tracking refs when pushing- no way to disable
Date: Fri, 6 Jul 2007 04:42:41 -0400
Message-ID: <20070706084241.GC16319@spearce.org>
References: <449c10960707051722q6650ec7dq6012695acdfba4af@mail.gmail.com> <Pine.LNX.4.64.0707052320090.14638@iabervon.org> <e5bfff550707060126t781587aaxbe2f6eca1c282985@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Dan McGee <dpmcgee@gmail.com>, git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 06 10:42:53 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6jOr-0006gA-EB
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 10:42:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755932AbXGFImr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jul 2007 04:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755829AbXGFImr
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 04:42:47 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:33615 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752522AbXGFImq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2007 04:42:46 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1I6jOj-0003zb-Gz; Fri, 06 Jul 2007 04:42:41 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1B04C20FBAE; Fri,  6 Jul 2007 04:42:42 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <e5bfff550707060126t781587aaxbe2f6eca1c282985@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51735>

Marco Costalba <mcostalba@gmail.com> wrote:
> On 7/6/07, Daniel Barkalow <barkalow@iabervon.org> wrote:
> >
> >(AFAICT, the only additional stuff that -a shows with git branch is the
> >stuff that you're deleting; perhaps qgit should have an option to not show
> >remotes, or not show them by default or only show them if what they point
> >to isn't otherwise marked? Anyway, it shouldn't be necessary to avoid
> >having this information just so that it isn't shown in interfaces you
> >use.)
> >
> 
> Probably an option "show remote branches" from a popup context menu
> (right click) is the more natural and predictable solution.

Recently I was faced with handling a repository that has over
200 local refs/heads and 200+ refs/remotes that the user might
be interested in working on.  Yea, its fun to look at in gitk.
It is not fun to run `git fetch` when on Cygwin.

Anyway, the git-gui `pu` branch now has new UI to handle these
sorts of cases rather nicely.  The revision selection mega-widget
that I recently wrote lets the user select which "class" of ref
(head, tracking branch, tag) they want and then filter them using
a substring glob filter.  The trick works very well to let the user
weed the list of 400+ possible refs down to just a couple that they
can pick from with the keyboard, or the mouse.

The UI will be in 0.8.0.  Which I'm hoping to go into an rc status
later this week.


Minor warning: currently the `pu` branch of git-gui probably
requires git 1.5.3-rc0 or later.  It doesn't test for it and just
assumes your git is new enough.  I do plan on fixing the couple of
spots that might matter to be conditional and fallback gracefully
if 1.5.3 isn't available.  Just haven't done it yet.  Those will
be fixed before they merge to `master`.

-- 
Shawn.
