From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: Removal of "--merge-order"?
Date: Fri, 24 Feb 2006 08:53:00 -0800 (PST)
Message-ID: <Pine.LNX.4.58.0602240840520.7894@shark.he.net>
References: <Pine.LNX.4.64.0602240824110.3771@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 24 17:53:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCgC1-0000i5-B3
	for gcvg-git@gmane.org; Fri, 24 Feb 2006 17:53:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbWBXQxE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Feb 2006 11:53:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbWBXQxD
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Feb 2006 11:53:03 -0500
Received: from xenotime.net ([66.160.160.81]:53164 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932383AbWBXQxC (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Feb 2006 11:53:02 -0500
Received: from shark.he.net ([66.160.160.2]) by xenotime.net for <git@vger.kernel.org>; Fri, 24 Feb 2006 08:53:00 -0800
X-X-Sender: rddunlap@shark.he.net
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602240824110.3771@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16715>

On Fri, 24 Feb 2006, Linus Torvalds wrote:

>
> I just tested it again, and
>
> 	git-rev-list --merge-order HEAD
>
> takes an inordinate amount of time:
>
> 	real    5m1.139s
> 	user    4m59.504s
> 	sys     0m1.220s

That's too bad.

> and that's on a reasonably fast machine (not my fastest, but no slouch by
> any measure - my fastest machine I'm not allowed to really benchmark
> publicly ;)
>
> It may be a cool algorithm, but it's essentially useless on any bigger
> tree. And nobody uses it, since "--topo-order" gives the guarantees that
> people really care about, and finishes in 0.537 seconds on the same
> machine with the same tree.
>
> It also depends on the openssh "bignum" stuff, which means that any
> machine where we just rely on our own SHA1 implementation and don't use
> openssh doesn't have the flag anyway.
>
> In other words, I'd really prefer if it was gone. Some of the things I
> might do to git-rev-list would be much simpler if I didn't have to worry
> about merge-order, and the way it interfaces with the rest of
> git-rev-list.
>
> Comments?

I'm just a lowly user, but I see people trying to export git
trees to other SCMs, and they seem to prefer merge-order.
This is your chance to correct me about:
(a) how I am wrong; (b) how they are wrong.  8;)

I've heard/seen you say that merge-order is not interesting,
but I still believe that *your* merge order of the Linux kernel
tree is almost all that people really care about.
Apparently I needed to go to LCA to hear you discuss git.

-- 
~Randy
