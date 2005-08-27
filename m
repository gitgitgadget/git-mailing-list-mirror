From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: [RFC, PATCH] A new merge algorithm (EXPERIMENTAL)
Date: Sat, 27 Aug 2005 03:40:09 +0200
Message-ID: <20050827014009.GB18880@c165.ib.student.liu.se>
References: <20050826184731.GA13629@c165.ib.student.liu.se> <Pine.LNX.4.58.0508261730480.3317@g5.osdl.org> <7vk6i89ofi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 27 03:41:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8pgN-0007gL-Dg
	for gcvg-git@gmane.org; Sat, 27 Aug 2005 03:40:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965201AbVH0BkR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Aug 2005 21:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965202AbVH0BkR
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Aug 2005 21:40:17 -0400
Received: from [85.8.31.11] ([85.8.31.11]:50093 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S965201AbVH0BkQ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Aug 2005 21:40:16 -0400
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 33C8840FF; Sat, 27 Aug 2005 03:44:11 +0200 (CEST)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1E8pg1-0007Uz-00; Sat, 27 Aug 2005 03:40:09 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vk6i89ofi.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7838>

On Fri, Aug 26, 2005 at 06:08:33PM -0700, Junio C Hamano wrote:
> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > On Fri, 26 Aug 2005, Fredrik Kuivinen wrote:
> >>
> >> In real numbers it is as follows: In Linus' kernel tree there are
> >> 5996 commits. 400 of those have more than one parent. Of those 400
> >> merge commits 4 have more than one shared head.
> >
> > Ok, that's already interesting in itself. I was wanting to re-run all the 
> > merges with the new "git-merge-base -a" to see which merges might have had 
> > different merge bases, and you've actually done that. Interesting to see 
> > the numbers.
> 
> Fredrik, mind giving us the commit ID of those four for us to
> take a look at them?

Sure, they are:
467ca22d3371f132ee225a5591a1ed0cd518cb3d which has two shared heads
7e2987503dda95a5f80290bb8c06279009c2419e and
eff910a91ac04ab1d9e210d4f721484af3b39c8d

0e396ee43e445cb7c215a98da4e76d0ce354d9d7 with the heads
462cee296476278acaa54c41925b3273e0e4dd40 and
8be3de3fd8469154a2b3e18a4712032dac5b4a53

3190186362466658f01b2e354e639378ce07e1a9 with
38d84c3bd6dd22bdb1f797c87006931133d71aea and
46906c4415f88cebfad530917bada0835d651824

and finally

da28c12089dfcfb8695b6b555cdb8e03dda2b690 with
9e566d8bd61f939b7f5d7d969f5b178571471cf9 and
18190cc08d70a6ec8ef69f0f6ede021f7cb3f9b8

(The script which finds those commits also prints out the commit id of
any octopus commits. There is one commit with more than two parents in
the kernel repository,
13e652800d1644dfedcd0d59ac95ef0beb7f3165. However, it only looks like
that commit has three parents, two of them are actually identical.)

> > I am of two minds on this. I hate the notion of a more complex merge. But
> > at the same time, it clearly is a very interesting case when we do have
> > multiple possible shared parents, and I think that at the very least we
> > should warn the user. And using a more complex merge algorithm when it
> > happens seems to be a very valid thing to do.
> 
> I agree.  GIT is lightening fast for trivial cases and we can
> afford to spend more time to handle more complex ones carefully,
> at the same time telling the user what we are doing is a good thing.
> 
> > Using python, which people have less exposure to, sounds like an 
> > additional thorny issue..
> 
> Not too big a problem for me to follow the patch ;-).
> 

Good to know :)

I mainly wanted to try the idea with the new algorithm, so some kind
of high level language seemed like a good choice.

- Fredrik
