From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Allow aliases to expand to shell commands
Date: Mon, 12 Feb 2007 01:53:19 -0500
Message-ID: <20070212065319.GF699@spearce.org>
References: <1171123504783-git-send-email-tytso@mit.edu> <11711235041527-git-send-email-tytso@mit.edu> <11711235042388-git-send-email-tytso@mit.edu> <20070210181357.GE25607@thunk.org> <Pine.LNX.4.63.0702102129110.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070211001346.GA19656@thunk.org> <Pine.LNX.4.63.0702111701160.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070211162136.GA26461@thunk.org> <7vy7n4cqti.fsf@assigned-by-dhcp.cox.net> <20070212035613.GA18010@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Mon Feb 12 07:53:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGV4H-0001qA-Dz
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 07:53:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933049AbXBLGx1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 01:53:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933050AbXBLGx0
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 01:53:26 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:36373 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933049AbXBLGxZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 01:53:25 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HGV3w-00050Q-Pt; Mon, 12 Feb 2007 01:53:20 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 85D6320FBAE; Mon, 12 Feb 2007 01:53:19 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20070212035613.GA18010@thunk.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39380>

Theodore Tso <tytso@mit.edu> wrote:
> On Sun, Feb 11, 2007 at 01:44:25PM -0800, Junio C Hamano wrote:
> > Theodore Tso <tytso@mit.edu> writes:
> > 
> > > ..., I think we're
> > > still safe, since aliases can't override commands.  
> > 
> > I feel a bit uneasy to hear safety argument based on that
> > current restriction, since we might want to loosen it later.
> 
> Loosen which restriction?
> 
> 1) The ability for aliases to shadow existing git commands?

This one.

> 2) The ability for untrusted users to make arbitrary changes to the 
>       config file?
> 3) The ability for untrusted users to execute arbitrary git commands via 
>       git-shell?
> 
> You hjave to loosen at least 2 of the 3 current restrictions before
> the ability to execute shell commands out of aliases becomes a problem
> --- and I would argue that either (2) or (3) are things that we would
> be insane to loosen at least to the point of allowing untrusted users
> to make arbitrary changes to the config or execute arbitrary git
> commands, since even today, they could do a huge amount of damage
> already.

I agree, 2 and 3 are the real issue here, not 1.  1 is only an
issue for scripts which expect the plumbing to behave a certain
way, but doesn't, as the user has aliased the plumbing command.

-- 
Shawn.
