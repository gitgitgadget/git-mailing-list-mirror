From: Junio C Hamano <junkio@cox.net>
Subject: Re: New release?
Date: Tue, 06 Jun 2006 10:15:14 -0700
Message-ID: <7v3beitdct.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0606052002530.5498@g5.osdl.org>
	<7vodx6zus2.fsf@assigned-by-dhcp.cox.net>
	<1149610100.23938.75.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue Jun 06 19:15:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fnf9F-0007lj-MQ
	for gcvg-git@gmane.org; Tue, 06 Jun 2006 19:15:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750915AbWFFRPR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Jun 2006 13:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750927AbWFFRPR
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jun 2006 13:15:17 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:1713 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1750915AbWFFRPP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jun 2006 13:15:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060606171515.XXNL15767.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 6 Jun 2006 13:15:15 -0400
To: Jon Loeliger <jdl@freescale.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21390>

Jon Loeliger <jdl@freescale.com> writes:

> If possible, I'd like to consider my (Linus') notion
> of the extension to the git protocol supplying the client
> hostname as part of a "standard" release like 1.4.0.

I think the virtual hosting of git-daemon is very important, and
I do not want to have a half-baked one hurriedly cobbled
together for 1.4.0 on the server side.

> We don't necessarily have to agree on how it is used yet,
> but if we can get the protocol enhancement into this
> release, I think it would make for a good "flag day"
> sort of change.

I do agree it is a good idea to have the client-side support in
1.4.0; that would work well with the current git-daemon.  Since
the extension is backward compatible, we can tell the users to
use 1.4.0 or later clients when the daemon side is done.  That
is much nicer than telling them to use what's on "master" that
is later than such-and-such commit.

> Specifically, I'd like to consider the portion my patch
> that passes "\0HOST=%s\0" along with the git: protocol
> connection.
>
> Any chance for that?  If you'd like, I work on resubmitting
> just those bits with the connect function refactoring
> that you outlined.

I appreciate the offer very much.  Although I said port is
something the server side can usually tell, I would throw in
port there as well.  Maybe there is some port forwarding (or
reverse NAPT) involved in the path from the client to the
server.  Any reason to spell HOST in all uppercase by the way?

And thanks for reminding me.  The list of things-to-have in the
message was based on a week old "What's in", and I was about to
compose a message describing what I did not talk about in it,
because I wanted to say something about virtual hosting of
git-daemon.
