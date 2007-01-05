From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Documentation: update git-pull.txt for clone's new default behavior
Date: Fri, 05 Jan 2007 15:20:52 -0800
Message-ID: <7vvejlcb6z.fsf@assigned-by-dhcp.cox.net>
References: <7vtzz9usyp.fsf@assigned-by-dhcp.cox.net>
	<826.67287.qm@web31809.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 06 00:21:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2yMr-0005pU-71
	for gcvg-git@gmane.org; Sat, 06 Jan 2007 00:20:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864AbXAEXUy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 18:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750867AbXAEXUy
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 18:20:54 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:52827 "EHLO
	fed1rmmtao08.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750864AbXAEXUy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 18:20:54 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070105232053.SUOJ16632.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>;
          Fri, 5 Jan 2007 18:20:53 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 7bL41W00n1kojtg0000000; Fri, 05 Jan 2007 18:20:05 -0500
To: ltuikov@yahoo.com
In-Reply-To: <826.67287.qm@web31809.mail.mud.yahoo.com> (Luben Tuikov's
	message of "Fri, 5 Jan 2007 15:15:18 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36047>

Luben Tuikov <ltuikov@yahoo.com> writes:

> --- Junio C Hamano <junkio@cox.net> wrote:
>> 
>> Because [remote] is NOT about mapping.  It asks the fetch
>> mechanism to fetch from that remote, so the primary thing you
>> should look at is .url, not RHS of colon on .fetch lines.  Use
>> of tracking branches is strictly optional.
>
> Remote
> ------
>
> Please help me understand.  Here is a sample remote from
> an actual repo (actual names changed):
>
> [remote "origin"]
>         url = http://blah/bleah.git
>         fetch = +refs/heads/*:refs/remotes/origin/*
>
> This basically says: "Get it" from such and such url, where
> on the repo at that url, i.e. the remote side, you will
> find stuff in "refs/heads/", and when you get it here, locally,
> put it in refs/remotes/origin/.

        [remote "origin"]
                url = http://blah/blah.git
                fetch = refs/heads/master

is also fine.  The point is that you do not have to use tracking
branches.  ", and when you get it here, ..." part is optional.

> Branch
> ------
>
> Here is an actual example:
>
> [branch "branchA"]
>         remote = origin
>         merge = refs/heads/branchA
>
> Yeah, but by default "refs/heads/branchA" doesn't exist (see
> my previous email).  It doesn't have to, since it specifies
> the "remote part", but that has already been handled by
> "[remote]".

Obviously fetch needs to handle the remote part because that is
the only name it exists at the remote.  branch.*.merge is used
by pull, not fetch, and fetch communicates with pull by using
the remote name, because use of local tracking branches is
optional.
