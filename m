From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: More precise tag following
Date: Fri, 9 Feb 2007 02:41:14 -0500
Message-ID: <20070209074113.GA2344@spearce.org>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net> <20070127080126.GC9966@spearce.org> <Pine.LNX.4.64.0701270837170.25027@woody.linux-foundation.org> <Pine.LNX.4.64.0701270945260.25027@woody.linux-foundation.org> <7vzm84gmei.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0701271439340.25027@woody.linux-foundation.org> <7vps8zfqlx.fsf@assigned-by-dhcp.cox.net> <20070129061807.GA4634@spearce.org> <Pine.LNX.4.64.0701290759570.3611@woody.linux-foundation.org> <20070129192911.GA12903@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Fri Feb 09 08:41:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFQNt-0000ij-BU
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 08:41:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946187AbXBIHlX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Feb 2007 02:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946185AbXBIHlX
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Feb 2007 02:41:23 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:54143 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946187AbXBIHlW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Feb 2007 02:41:22 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HFQNf-0003U6-3A; Fri, 09 Feb 2007 02:41:15 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8403120FBAE; Fri,  9 Feb 2007 02:41:14 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20070129192911.GA12903@thunk.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39157>

Theodore Tso <tytso@mit.edu> wrote:
> On Mon, Jan 29, 2007 at 08:24:52AM -0800, Linus Torvalds wrote:
> > Anyway, all of these issues makes me suspect that the proper blame 
> > interface is to basically *hide* the blame almost entirely, in order to 
> > make the important parts much more visible, and in order to encourage 
> > people to start looking for the piece of code that they are actually 
> > interested in.
> 
> One approach which might work is where you hover your mouse over a
> line, and it pops up a tiny window with the blame information if the
> mouse remains stationary for more than a second or two.
> 
> Another thing which would be really useful is where the lines that
> have been changed in the last n commits (where n is probably between
> 3-5) are highlighted using different colors.  That way you can see
> what was changed recently, which is often what you are most interested
> in.  (As in, what changed recently that might have caused this file to
> get all screwed up?)

In case you are interested, I've tweaked the display of annotation
data in git-gui.  The latest version lets you run blame right from
the command line:

	git-gui blame master revision.c

Clicking on a line colors that line and all lines which are blamed
on the same commit as yellow; the commit before it (ancestor)
is colored blue and the commit after it (descendant) is colored red.

The bottom part of the window is used to show the commit SHA-1,
author, committer and complete log message.  I have not yet added
navigating to the prior commit, or support for the new --contents
flag.

Because the data is now in the bottom pane (and not in columns),
the display is about 90 characters wide, instead of 180 or whatever
insane value it was.

-- 
Shawn.
