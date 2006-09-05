From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 3/5] autoconf: Preliminary check for working mmap
Date: Mon, 4 Sep 2006 23:09:29 -0400
Message-ID: <20060905030929.GA29865@spearce.org>
References: <200609050054.24279.jnareb@gmail.com> <200609050056.52590.jnareb@gmail.com> <7vy7szjjal.fsf@assigned-by-dhcp.cox.net> <edidlp$d3d$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 05 09:25:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKVJI-0003lN-G7
	for gcvg-git@gmane.org; Tue, 05 Sep 2006 09:25:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494AbWIEHZZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Sep 2006 03:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751449AbWIEHZZ
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Sep 2006 03:25:25 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:39345 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S965150AbWIEE1L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Sep 2006 00:27:11 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GKSTw-00068f-Cp; Tue, 05 Sep 2006 00:27:09 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 41EBE212693; Mon,  4 Sep 2006 23:09:30 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <edidlp$d3d$1@sea.gmane.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26461>

Jakub Narebski <jnareb@gmail.com> wrote:
> Junio C Hamano wrote:
> 
> > Jakub Narebski <jnareb@gmail.com> writes:
> > 
> >> This patch sent earlier in other patch series and dropped,
> >> as git uses private mapping, not private fixed. I think
> >> that this check is better than no check at all...
> > 
> > I think the next major change that is needed fairly soon is to
> > be able to mmap parts of a large pack file (even with 32-bit
> > offset).  I haven't loooked into it deeply enough but it may or
> > may not turn out to be beneficial if we map at fixed location so
> > the requirements of "working mmap()" might change.  I'd be
> > happier if you held onto this part of the patch before that
> > happens.
> 
> Well, this patch perhaps not always would set NO_MMAP when it should 
> (some broken mmap that does private+fixed but not private), but I guess that
> if it would set NO_MMAP then mmap is broken (or doesn't exist at all).
> 
> I have noticed AC_FUNC_MMAP test, and thought why not to use it?
> The simplest check if mmap exist would be to check libc for mmap function.

Are there really mmap implementations that will only do
private+fixed?  Sick.

I'm maybe only 1/3 of the way through the sliding window mmap
implementation.  I've got a good chunk of sha1_file.c converted but I
still have to deal with the copying in pack-objects.c and the verify
code in verify-pack.c.  I'm hoping I can send a preliminary patch
series tomorrow as I'm going to work on it more tonight and tomorrow.

-- 
Shawn.
