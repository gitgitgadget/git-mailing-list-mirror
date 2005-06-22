From: Darrin Thompson <darrint@progeny.com>
Subject: Re: Patch (apply) vs. Pull
Date: Wed, 22 Jun 2005 11:23:23 -0500
Message-ID: <1119457403.4128.18.camel@localhost.localdomain>
References: <1119284365.3926.15.camel@localhost.localdomain>
	 <7vbr61j631.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.58.0506211452110.2353@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 22 18:22:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dl7ye-0003yc-Ao
	for gcvg-git@gmane.org; Wed, 22 Jun 2005 18:21:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261570AbVFVQ0a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Jun 2005 12:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261653AbVFVQ0a
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jun 2005 12:26:30 -0400
Received: from zealot.progeny.com ([216.37.46.162]:54438 "EHLO
	morimoto.progeny.com") by vger.kernel.org with ESMTP
	id S261570AbVFVQXY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2005 12:23:24 -0400
Received: from dhcp-2-246.progeny.com (dhcp-2-246.progeny.com [192.168.2.246])
	by morimoto.progeny.com (Postfix) with ESMTP
	id E003E63782; Wed, 22 Jun 2005 11:23:23 -0500 (EST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506211452110.2353@ppc970.osdl.org>
X-Mailer: Evolution 2.0.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 2005-06-21 at 15:09 -0700, Linus Torvalds wrote:
> However, as you point out, it's not necessarily the best kind of merge for
> the "individual developer" standpoint. Most individual developers don't
> necessarily want to merge their work, rather they want to "bring it
> forward" to the current tip. And I think git could help with that too.
> 

That's a good way to put it.

> and here the "git-cherry-pick" thing is just a script that basically takes
> an old commit ID, and tries to re-apply it as a patch (with author data
> and commit messages, of course) on top of the current head. It would 
> basically be nothing more than a "git-diff-tree $1" followed by tryign to 
> figure out whether it had already been applied or whether it can be 
> applied now.
> 
> What do you think?

Here are two desirable things the might be tough to reconcile:

- The merging mechanism might benefit from knowing that your commit was
really originally my commit _if_ my history is relevant to the merge and
present.

- The rest of the world does _not_ want to have to keep my commits on
hand just to follow the mainline.

I imagine if those could be reconciled you'd hit a sweet spot.

A mechanism where those two were true might also provide better hooks
for knowing other things. For instance, which of these particular
commits of mine are not in the mainline tree? 

Perhaps your mainline commit might refer to my humble commit as some
kind of sibling. You don't need to have it to follow the mainline, but
the data is there if it helps anybody.

--
Darrin


