From: Jason Riedy <jason@acm.org>
Subject: Re: Managing websites with git
Date: Tue, 02 Dec 2008 10:55:34 -0500
Message-ID: <87vdu2po5l.fsf@sparse.dyndns.org>
References: <fe5a74300811300830x850d81csc5cf1f9b367bac11@mail.gmail.com>
	<20081130170722.GJ6572@eratosthenes.sbcglobal.net>
	<20081130172717.GA7047@coredump.intra.peff.net>
	<87k5ajflp0.fsf@sparse.dyndns.org>
	<20081202011154.GA6390@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 02 17:39:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7YH6-0005c0-Pe
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 17:39:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755293AbYLBQhd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 11:37:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755279AbYLBQhd
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 11:37:33 -0500
Received: from a.mail.sonic.net ([64.142.16.245]:37817 "EHLO a.mail.sonic.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755220AbYLBQhc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 11:37:32 -0500
X-Greylist: delayed 1713 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Dec 2008 11:37:32 EST
Received: from nan.sparse.yi.org (misc-148-78-88-138.pool.starband.net [148.78.88.138])
	(authenticated bits=0)
	by a.mail.sonic.net (8.13.8.Beta0-Sonic/8.13.7) with ESMTP id mB2G8ku2012834;
	Tue, 2 Dec 2008 08:08:51 -0800
In-Reply-To: <20081202011154.GA6390@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 1 Dec 2008 20:11:54 -0500")
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.0.60 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102156>

And Jeff King writes:
> To clarify: one should not push to the _current branch_ of a
> non-bare repo...

Ah, ok, thanks!  Issuing a warning makes sense.  I'm not sure if
denying such a push by default does...

> Doing git push $remote HEAD:branch-that-is-checked-out
> has _never_ worked without further action on $remote. Now we're warning
> about it.

It works just fine.  I suspect we have different definitions of
"works".

To me, that push updates the branch's reference.  The working
copy and index now may be out of sync, but neither the working
copy nor the index is the branch's reference.  Trying to commit
from the index correctly refuses.  The warning is a nice
reminder, but I don't see why this should be denied by default.
The user (me) hasn't lost anything, and every tool does what it
is supposed to do (from my point of view).

But I'm one of those people who has always liked the three levels
of git.  And I use them all.

(And in context: I used to update the IEEE754 group's web site by
a git push to the checked-out master, with a hook to reset
everything.  Worked just fine (and very quickly) until they shut
off shell access.  There was no need for an extra branch on the
server side.)

> If you have other specific complaints about new git behavior,
> I'm sure the list would be happy to hear about it.

I'll try to find time when I encounter another.  I'm pretty sure
that switching to denying pushes to checked-out branches is the
first one that *really* will make me change how I work.

Jason
