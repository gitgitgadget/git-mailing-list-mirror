From: Junio C Hamano <junkio@cox.net>
Subject: Re: Joining Repositories
Date: Wed, 18 Jan 2006 18:12:00 -0800
Message-ID: <7v64ohotjj.fsf@assigned-by-dhcp.cox.net>
References: <200601181325.59832.Mathias.Waack@rantzau.de>
	<20060118125158.GN28365@pasky.or.cz>
	<20060118140917.GA15438@mythryan2.michonline.com>
	<Pine.LNX.4.64.0601180813170.3240@g5.osdl.org>
	<7vbqy9xx2r.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ryan Anderson <ryan@michonline.com>, Petr Baudis <pasky@suse.cz>,
	Mathias Waack <Mathias.Waack@rantzau.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 19 03:14:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzPJz-0002g2-8E
	for gcvg-git@gmane.org; Thu, 19 Jan 2006 03:14:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161158AbWASCMw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jan 2006 21:12:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161159AbWASCMM
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jan 2006 21:12:12 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:11909 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1161163AbWASCMD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jan 2006 21:12:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060119020950.SFYL26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 18 Jan 2006 21:09:50 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vbqy9xx2r.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 18 Jan 2006 09:30:52 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14877>

Junio C Hamano <junkio@cox.net> writes:

> Linus Torvalds <torvalds@osdl.org> writes:
>
>> Now, let's see what Junio comes up with,...
>
> Well, since the reason the original RFI came was...
> ...
> So for this case, I think the "coolest merge" is the right
> thing to do.

I said this only because I wanted to recommend a solution
available today to the original requester.

If I were to talk about (one potential) future solution, I would
say "bind" commit would work naturally for this case, without
disrupting the development histories of the projects being
combined.  After all, the "bind" commit approach is not much
different from what you did with "the coolest merge ever", with
a few twists, such as (1) not overlaying but requiring each
subproject to be bound at a non-overlapping subdirectory, and
(2) letting a subproject keep its own independent history that
does not know about other subprojects even after combination
happens (as opposed to the coolest merge, after which there is
no git history that does not have gitk as its part).

Of course, "gitlink" would equally work well and have similar
characteristics.  The implementation details will certainly
differ and the user interaction may somewhat be different as
well, but I do not think of any reason either approach would not
work well in this situation.

So would Cogito subprojects support (will it be in the 0.17?),
but it might look less powerful when compared with the "bind" or
"gitlink", if it comes in the form of the patch Pasky sent to
the list, since it does not attempt to tie the versions of two
projects together.  Certainly that makes it the easiest to use
and understand what is going on, though.
