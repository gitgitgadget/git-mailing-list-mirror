From: Junio C Hamano <junkio@cox.net>
Subject: Re: git binary directory?
Date: Mon, 07 Nov 2005 09:27:48 -0800
Message-ID: <7vvez4s6zv.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0511051247330.3316@g5.osdl.org>
	<7voe4y5w3v.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511052013550.3316@g5.osdl.org>
	<7vy84249re.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511060816390.3316@g5.osdl.org>
	<7v7jbly1lh.fsf@assigned-by-dhcp.cox.net>
	<20051106221952.GP1431@pasky.or.cz>
	<7virv5wc86.fsf@assigned-by-dhcp.cox.net>
	<20051107004346.GR1431@pasky.or.cz>
	<Pine.LNX.4.64.0511061653380.3316@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Nov 07 18:28:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZAn2-00022b-Pu
	for gcvg-git@gmane.org; Mon, 07 Nov 2005 18:28:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965214AbVKGR15 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Nov 2005 12:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965336AbVKGR1z
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Nov 2005 12:27:55 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:15551 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S965344AbVKGR1w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2005 12:27:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051107172728.BWXZ16347.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 7 Nov 2005 12:27:28 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511061653380.3316@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 6 Nov 2005 16:54:55 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11273>

Linus Torvalds <torvalds@osdl.org> writes:

> On Mon, 7 Nov 2005, Petr Baudis wrote:
>> 
>> I want to avoid extra fork()s and exec()s. They seem to routinely matter
>> in orders of magnitude of speed in tight loops.
>
> Yes. The more I think about it, the less I like the separate binary 
> directory after all. The "git cmd" format is great for high-level 
> commands, but we've always done "git-diff-tree" and "git-rev-list" etc 
> without the "git cmd" indirection.

Extra fork() and exec() problem still exists, but "git cmd"
format have worked with "git diff-tree" and "git rev-list" for
quite some time (since Jun 14th), so you might've always done it
with dash but that is not a requirement.

It looks like that both you and Pasky are not so enthusiastic
about moving thing out of /usr/bin/, so let's keep things the
way they are for 1.0 release and rethink when we do 2.0 (or
whatever comes after 1.0).
