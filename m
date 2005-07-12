From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Bootstrapping into git, commit gripes at me
Date: Tue, 12 Jul 2005 13:04:01 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0507121240120.2876-100000@iabervon.org>
References: <7voe98g3ws.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>, Marc Singer <elf@buici.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 13 00:07:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsStx-0003JM-N6
	for gcvg-git@gmane.org; Wed, 13 Jul 2005 00:06:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262443AbVGLV72 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jul 2005 17:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262401AbVGLUvh
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jul 2005 16:51:37 -0400
Received: from iabervon.org ([66.92.72.58]:39941 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262394AbVGLUti (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jul 2005 16:49:38 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DsOAr-0003CZ-00; Tue, 12 Jul 2005 13:04:01 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7voe98g3ws.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 11 Jul 2005, Junio C Hamano wrote:

> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > But what about the branch name? Should we just ask the user? Together with 
> > a flag, like
> >
> > 	git checkout -b new-branch v2.6.12
> >
> > for somebody who wants to specify the branch name? Or should we pick a 
> > random name and add a helper function to rename a branch later?
> >
> > Opinions?
> 
> How about treating "master" a temporary thing --- "whatever I
> happen to be working on right now"?

That conflicts with my usage, where I have a single repository for all of
my working directories, with .git/refs and .git/objects being symlinks to 
it, but .git/HEAD being different for each branch. The stuff in objects/
and refs/ really shouldn't depend on what you're currently doing for this
reason.

My way of thinking of "master" is that it's a real branch, which is for
all of the situations where you aren't using a specially-designated
branch. For many people, they only do stuff that's not designated
specially; Jeff only does stuff that is designated specially. But if you
do both, you'll want master to be left alone while you work on the side
branch.

	-Daniel
*This .sig left intentionally blank*
