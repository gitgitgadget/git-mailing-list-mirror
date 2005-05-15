From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: speeding up cg-log -u
Date: Sun, 15 May 2005 12:09:55 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0505151158300.30848-100000@iabervon.org>
References: <7vk6m212g7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, Zack Brown <zbrown@tumblerings.org>,
	git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sun May 15 18:10:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXLhT-0003xt-VJ
	for gcvg-git@gmane.org; Sun, 15 May 2005 18:10:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261683AbVEOQKi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 May 2005 12:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbVEOQKi
	(ORCPT <rfc822;git-outgoing>); Sun, 15 May 2005 12:10:38 -0400
Received: from iabervon.org ([66.92.72.58]:24326 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261683AbVEOQKc (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 May 2005 12:10:32 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DXLgh-0003fA-00; Sun, 15 May 2005 12:09:55 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk6m212g7.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 14 May 2005, Junio C Hamano wrote:

> Whenever I work with those "struct object" derivatives, I get
> very frustrated by the fact that they are designed to cater only
> to the need of very narrow immediate users. 

They aren't designed for the immediate users; they're implemented for the
immediate users. Feel free to add more fields as you need them. The
current selection is based on only adding things when there's a user for
them.

> The first round of tree objects did not even have names for each entry
> because the only thing it cared about was connectivity checking, and for
> that purpose callers would not care about what each blob or
> subtree was referred as.  Now when I want to use commit objects
> I find that it only records the commit date (other than
> connectivity information).  It really appears that connectivity
> is the primary thing and everything else is bolted on top.

Existance is the primary thing, and everything else was added as
needed. (Pure connectivity is a bit special, because it's a property of
generic objects so that fsck-cache doesn't need to know about particular
types of objects unless there are particular things to check about them)

If you need more fields, let me know, and I'll figure out how to include
them.

	-Daniel
*This .sig left intentionally blank*

