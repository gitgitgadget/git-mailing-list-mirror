From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git rebase chokes on directory -> symlink -> directory
Date: Thu, 10 May 2007 18:04:18 -0400
Message-ID: <20070510220418.GK3141@spearce.org>
References: <463FCD7C.4020009@zytor.com> <20070508215009.GA2670@steel.home> <46413565.3090503@zytor.com> <81b0412b0705090050i644a18c2g12c74462ab88163a@mail.gmail.com> <4641FDAF.3090608@zytor.com> <20070509213902.GA2593@steel.home> <46424ECC.6030907@zytor.com> <7vmz0dmb2u.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>, Alex Riesen <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri May 11 00:04:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmGkT-0004l3-HY
	for gcvg-git@gmane.org; Fri, 11 May 2007 00:04:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757527AbXEJWE1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 18:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755656AbXEJWE1
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 18:04:27 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:43526 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755268AbXEJWE0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 18:04:26 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HmGk6-0004Zr-BG; Thu, 10 May 2007 18:04:10 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5D3BF20FBAE; Thu, 10 May 2007 18:04:18 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vmz0dmb2u.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46906>

Junio C Hamano <junkio@cox.net> wrote:
>  * git-rebase with -m is dog slow.  There were people who
>    advocated to make it the default, but they probably are
>    either working in a very small project, or working on a
>    filesystem that even git-apply is slow that the speed
>    difference does not matter to them.

That would have been me saying make -m default.  Because on git.git
I don't really see a huge performance difference on my Mac, and the
bigger projects that I work on are on Cygwin, where *everything*
is slow as hell.

The few places there that I do need rebase, I actually also need
the rename detection that am -3 or rebase -m would do, so I just
wind up paying the penalty anyway.  Or really I just get burned
because I run the op without the magic "do what I really need"
flag, and it dies, and I have to reset and start it again, which
just takes longer than if -3 or -m was the default.

But that's not the situation everyone else has, so its reasonable
that -m ain't the default.  ;-)

-- 
Shawn.
