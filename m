From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-log: detect dup and fdopen failure
Date: Thu, 28 Jun 2007 01:02:25 -0400
Message-ID: <20070628050225.GI32223@spearce.org>
References: <87wsxpobf0.fsf@rho.meyering.net> <81b0412b0706270548p6f694fd6x5f47cbefa16c08ac@mail.gmail.com> <87r6nxo8iq.fsf_-_@rho.meyering.net> <EF53B249-8430-4700-81AE-B97FD49FB955@adacore.com> <87odj1mpy2.fsf@rho.meyering.net> <alpine.LFD.0.98.0706270935340.8675@woody.linux-foundation.org> <4683211E.2010704@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jim Meyering <jim@meyering.net>,
	Geert Bosch <bosch@adacore.com>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
X-From: git-owner@vger.kernel.org Thu Jun 28 07:02:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3m9M-00075M-HW
	for gcvg-git@gmane.org; Thu, 28 Jun 2007 07:02:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753366AbXF1FCf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jun 2007 01:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753652AbXF1FCe
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jun 2007 01:02:34 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:55329 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752413AbXF1FCe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jun 2007 01:02:34 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1I3m9E-0007yK-Vy; Thu, 28 Jun 2007 01:02:29 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6BAD320FBAE; Thu, 28 Jun 2007 01:02:26 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <4683211E.2010704@freedesktop.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51081>

Josh Triplett <josh@freedesktop.org> wrote:
> Linus Torvalds wrote:
> > That said, the whole "prepend 'x' to the function name" thing is obviously 
> > how git does things, but maybe it would be more readable in the long term 
> > to make the prefix be 'safe_' instead of 'x', or something like that?
> 
> If you want a more verbose name than xfoo, I personally like the foo_or_die
> convention, which reminds you explicitly that the function might kill the
> program.  safe_ might convey exactly the opposite impression.

I think the _gently suffix is already preferred for the
non-die()'ing variant of a function within Git.  For example see
setup_git_directory_gently() or lookup_commit_reference_gently().

Of course pkt-line.c goes and defines safe_read/safe_write.
And lets not forget about safe_create_dir() and
safe_create_leading_directories().

I guess we're about half-way in both directions.  Next function
declared with safe_ prefix or _gently suffix will tip the scale in
one direction or the other.  ;-)

-- 
Shawn.
