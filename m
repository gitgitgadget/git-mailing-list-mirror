From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Users of git-check-files?
Date: Wed, 3 Aug 2005 09:17:22 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508030913060.3341@g5.osdl.org>
References: <Pine.LNX.4.63.0508030109210.21304@wgmdd8.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.58.0508021942500.3341@g5.osdl.org> <7vvf2nk0h7.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0508030808530.3341@g5.osdl.org> <7vr7dbhvci.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 03 18:18:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0LwA-0005se-94
	for gcvg-git@gmane.org; Wed, 03 Aug 2005 18:17:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262322AbVHCQRj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Aug 2005 12:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262324AbVHCQRj
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Aug 2005 12:17:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39149 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262322AbVHCQRi (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Aug 2005 12:17:38 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j73GHMjA001156
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 3 Aug 2005 09:17:23 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j73GHMFo025914;
	Wed, 3 Aug 2005 09:17:22 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr7dbhvci.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 3 Aug 2005, Junio C Hamano wrote:
>
> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > Yeah, probably not. git-rev-list does so much more than git-rev-tree ever 
> > did.
> 
> Does rev-list do --edges ;-)?

No, but does anybody use it? It _may_ be interesting as a git-merge-base
thing, but then we should probably add it to git-merge-base (which
actually _does_ do edges these days, but it just only shows the most
recent one..)

> BTW, I have two known bugs/problems that I haven't resolved,
> which is bothering me quite a bit.  Yes, it is my fault (lack of
> time and concentration).  One is the EINTR from the daemon.c,

I actually think the new code is totally broken. If you want to listen to 
several sockets, you should just run several daemons. Yeah, yeah, it won't 
give you "global child control" etc, but I doubt we care.

But I don't think it's a huge issue, since most serious users are likely 
to use the "--inetd" flag and use inetd as the real daemon anyway (ie the 
built-in daemon code is most useful for normal users just setting up 
their own quick thing).

> and another is receive-pack failing with "unpack should have
> generated but I cannot find it" when pushing.  The latter is
> something "I am aware of, I know it needs to be diagnosed, but I
> have not looked into yet".

I've lost that state. Can you explain a bit mroe..

		Linus
