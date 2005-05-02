From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Just a note: .git/refs/snap/ is not standard
Date: Sun, 1 May 2005 23:13:14 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0505012249460.30848-100000@iabervon.org>
References: <7vacneqtn8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 02 05:07:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSRHO-0007Ws-U0
	for gcvg-git@gmane.org; Mon, 02 May 2005 05:07:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbVEBDN2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 May 2005 23:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261454AbVEBDN2
	(ORCPT <rfc822;git-outgoing>); Sun, 1 May 2005 23:13:28 -0400
Received: from iabervon.org ([66.92.72.58]:24071 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261154AbVEBDNY (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 May 2005 23:13:24 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DSRMw-0006DY-00; Sun, 1 May 2005 23:13:14 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vacneqtn8.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 1 May 2005, Junio C Hamano wrote:

> Linus, 
> 
>     not that there is any "de facto" or any standard there, but
> the name .git/refs/snap/ you lifted from the vicinity thing is
> not something Cogito folks have.  My understanding is of their
> concensus is that .git/refs have single level subdirectories
> like 'heads' and 'tags', and there will be little 41-byte text
> files that look like .git/HEAD.

I was intending this to be a more general concensus (and you seem to have
followed it with your "snap" subdirectory).

> So you probably would want to either (1) readdir in .git/refs (to future
> proof) or (2) drop refs/snap from the vicinity list for now (to not give
> special treatment to JIT, which I myself do not mind ;-)).  Also if you
> go route (2) drop "refs" itself as well.

Actually, my code was intended to take things like "heads/master" or
"tags/linux-2.6.13", which are found under "refs/" (although I also check
that they don't start with "." and have exactly one "/", to enforce the
naming system). Making it "heads/linus" rather than "linus" is important
for writing the files, since you can't guess reliably what subdirectory
the user means; also, it is easier for dealing with HTTP servers, where
you don't know what to ask for.

	-Daniel
*This .sig left intentionally blank*

