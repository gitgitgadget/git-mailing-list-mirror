From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Remove more gcc extension usage.
Date: Sat, 8 Jul 2006 15:03:27 -0400
Message-ID: <20060708190327.GA17763@spearce.org>
References: <20060708183402.GA17644@spearce.org> <7vy7v4orpt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 08 21:03:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzI5f-0006zz-Hr
	for gcvg-git@gmane.org; Sat, 08 Jul 2006 21:03:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030224AbWGHTDl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Jul 2006 15:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030231AbWGHTDl
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Jul 2006 15:03:41 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:29601 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1030224AbWGHTDk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jul 2006 15:03:40 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FzI5O-0003Xp-1b; Sat, 08 Jul 2006 15:03:26 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 907DA20E482; Sat,  8 Jul 2006 15:03:27 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vy7v4orpt.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23499>

Junio C Hamano <junkio@cox.net> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
> 
> > Removing these last remaining extension uses allows GIT to compile
> > with the Sun C compiler rather then gcc.  This can be handy when
> > you are trying to compile GIT on a Solaris system that seems to
> > have a total lack of GNU utilities.
> 
> Two points.
> 
>  - Aren't the constructs you ripped out not GCC extension,
>    rather proper ISO C99?

Hmm.  I'm not sure actually.  I don't do much C hacking these days
so I haven't kept current with what C99 has and doesn't.  I just
know that these small changes made the core plumbing build and run
fine on Solaris with only GNU make being present.  I didn't even
attempt to use the higher level Poreclainish shell script commands.

Monday I'll look to see if there's an option that can be given to
the Solaris compiler to make it accept these constructs.  Maybe a
simple CFLAGS change in my config.mak would resolve what this patch
was trying to do.
 
>  - Our Makefile is pretty GNU already.  I think people have
>    pointed out and ripped out bashisms from our shell scripts,
>    but I would not be surprised if the default Sun /bin/sh does
>    not understand POSIXy features some of them use.

I realize that.  Asking someone to compile GNU make in their home
directory before they build GIT to their home directory isn't a
big deal (took me all of 30 seconds to download the latest and
./configure&&make install it).  Asking someone to download and
compile binutils and gcc because their local site manager won't
install them for you is another matter entirely...

-- 
Shawn.
