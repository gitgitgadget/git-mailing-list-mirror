From: Petr Baudis <pasky@suse.cz>
Subject: Re: RFC: New diff-delta.c implementation
Date: Mon, 24 Apr 2006 22:37:34 +0200
Message-ID: <20060424203734.GH27689@pasky.or.cz>
References: <602974A9-09A3-46E9-92D6-D30728923C11@adacore.com> <444A2334.3030501@lsrfire.ath.cx> <20060424025741.GA636@adacore.com> <Pine.LNX.4.64.0604232327500.3603@localhost.localdomain> <20060424151901.GA2663@adacore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>,
	Rene Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 24 22:37:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FY7oO-0006EA-V6
	for gcvg-git@gmane.org; Mon, 24 Apr 2006 22:37:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbWDXUhO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Apr 2006 16:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbWDXUhN
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Apr 2006 16:37:13 -0400
Received: from w241.dkm.cz ([62.24.88.241]:31170 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751152AbWDXUhM (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Apr 2006 16:37:12 -0400
Received: (qmail 17095 invoked by uid 2001); 24 Apr 2006 22:37:34 +0200
To: Geert Bosch <bosch@adacore.com>
Content-Disposition: inline
In-Reply-To: <20060424151901.GA2663@adacore.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19108>

Dear diary, on Mon, Apr 24, 2006 at 05:19:01PM CEST, I got a letter
where Geert Bosch <bosch@adacore.com> said that...
> > But here comes the sad part.  Even after simplifying the code as much as 
> > I could, performance is still significantly worse than the current 
> > diff-delta.c code.  Repacking again the same Linux kernel repository 
> > with the current code:
> That's unexpected, but I can see how this could be if most files have
> very few differences and are relatively small. For such cases, almost
> any hash will do, and the more complicated hashing will be more compute
> intensive.
> 
> 
> I have benchmarked my original diff code on a set of large files with
> lots of changes. These are hardest to get right, and hardest to get
> good performance with. Just try diffing any two large (uncompressed)
> tar files, and you'll see. On many of such large files, the new code
> is orders of magnitude faster. On these cases, the resulting deltas
> are also much smaller.
> 
> The comparison is a bit between a O(n^2) sort that is fast on small
> or mostly sorted inputs (but horrible on large ones) and a more
> complex O(nlogn) algorithm that is a bit slower for the simple
> cases, but far faster for more complex cases.

Can't you just switch between different delta algorithms based on some
heuristic like the blob size?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
