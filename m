From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: SSH pull problems
Date: Sun, 5 Jun 2005 13:47:53 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0506051336440.30848-100000@iabervon.org>
References: <42A1A716.9030304@gorzow.mm.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 05 19:46:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DezBl-0004Ab-7J
	for gcvg-git@gmane.org; Sun, 05 Jun 2005 19:45:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbVFERtB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Jun 2005 13:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbVFERtB
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jun 2005 13:49:01 -0400
Received: from iabervon.org ([66.92.72.58]:25094 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261597AbVFERs4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Jun 2005 13:48:56 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DezE2-0008OF-00; Sun, 5 Jun 2005 13:47:54 -0400
To: Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>
In-Reply-To: <42A1A716.9030304@gorzow.mm.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 4 Jun 2005, Radoslaw Szkodzinski wrote:

> I had some problems today with git+ssh protocol.
> First, when using cg-clone, it couldn't execute cg-rpush, although it's
> there in /usr/local.
> Maybe that has something to do with that being added to the path in
> /etc/profile.

I haven't used recent Cogito, so I'm not sure, but it might actually want
git-rpush rather than cg-rpush? Or it might be a permissions issue?

> Second, I don't know how to specify the port number,
> the typical notation of git+ssh://xyz:port/repo didn't work.

I haven't made it understand port numbers yet; it should be pretty easy,
though, if you want to do it. You'd probably have a better chance of
getting it right than I would, if you've got an SSH server on a
non-default port to test against. Just parse out the part of "host" after
the : and make it a "-p" option in the execlp in rsh.c.

	-Daniel
*This .sig left intentionally blank*

