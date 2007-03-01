From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Memory overrun in http-push.c
Date: Thu, 1 Mar 2007 16:54:55 -0500
Message-ID: <20070301215455.GC9254@spearce.org>
References: <200703011040.35971.andyparkins@gmail.com> <20070228151516.GC57456@codelabs.ru> <200702281541.41164.andyparkins@gmail.com> <20070301051323.GG57456@codelabs.ru> <81b0412b0703010015l5c91c68pd4748ae379db98bb@mail.gmail.com> <7vslcpux62.fsf@assigned-by-dhcp.cox.net> <20070301120042.GD63606@codelabs.ru> <Pine.LNX.4.63.0703011802130.22628@wbgn013.biozentrum.uni-wuerzburg.de> <81b0412b0703011343je4de3b6ra5c1d577da041dcf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eygene Ryabinkin <rea-git@codelabs.ru>,
	Junio C Hamano <junkio@cox.net>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 22:55:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMtF2-0005KY-JH
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 22:55:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030358AbXCAVzI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 16:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030362AbXCAVzI
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 16:55:08 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:49846 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030358AbXCAVzH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 16:55:07 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HMtEg-0007ul-Qt; Thu, 01 Mar 2007 16:54:50 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7D6A720FBAE; Thu,  1 Mar 2007 16:54:55 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <81b0412b0703011343je4de3b6ra5c1d577da041dcf@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41134>

Alex Riesen <raa.lkml@gmail.com> wrote:
> Wont work. The ids in question are really strings embedded into object.
> Something like:
> 
>  $Id 1.2 user filename.c$
> 
> They can be found, extracted from the binary and sent to developer
> with a bug report. It's more of a build signature.
> IOW, the colleague in question has to have the source, which,
> I suspect, he wont.
> 
> Of course, it's very simple to embed the HEAD into build and
> tell the tester to send the SHA-1 in case of bug report.

Yes.  Either the commit SHA-1 or the output of git-describe does
the trick.  Even better when your program prints this value on
demand, like say `git version`.  ;-)

Before programmers got smart and wrote switches to dump the
version (aka -v/-V/--version) users were expected to use
`strings frob | grep '$Id' | mail baddev@example.com` to
send in bug reports.  What a world we live in!  ;-)

-- 
Shawn.
