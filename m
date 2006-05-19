From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] [BUG] Add a test to check git-prune does not throw away revs hidden by a graft.
Date: Fri, 19 May 2006 15:22:13 -0700
Message-ID: <7v4pzlirje.fsf@assigned-by-dhcp.cox.net>
References: <20060518213519.14577.67309.stgit@gandelf.nowhere.earth>
	<Pine.LNX.4.64.0605181435230.10823@g5.osdl.org>
	<7viro3nh07.fsf@assigned-by-dhcp.cox.net>
	<20060518222045.GB6535@nowhere.earth>
	<20060518225216.GC6535@nowhere.earth>
	<7vsln7lzbj.fsf@assigned-by-dhcp.cox.net>
	<20060519185558.GE6535@nowhere.earth>
	<Pine.LNX.4.64.0605191159520.10823@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yann Dirson <ydirson@altern.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 20 00:22:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhDMW-0002GO-Rw
	for gcvg-git@gmane.org; Sat, 20 May 2006 00:22:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbWESWWP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 May 2006 18:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbWESWWP
	(ORCPT <rfc822;git-outgoing>); Fri, 19 May 2006 18:22:15 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:15241 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751377AbWESWWO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 May 2006 18:22:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060519222213.VFCF27327.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 19 May 2006 18:22:13 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20360>

Linus Torvalds <torvalds@osdl.org> writes:

> On Fri, 19 May 2006, Yann Dirson wrote:
>
>> On Thu, May 18, 2006 at 03:53:36PM -0700, Junio C Hamano wrote:
>> > Yann Dirson <ydirson@altern.org> writes:
>> > 
>> > > To make my point maybe more clear: if someone really wants to make a
>> > > graft permanent, wouldn't some history rewriting ... be the
>> > > way to go,...
>> > 
>> > Yes.
>> 
>> So if temporary usage is a typical use for grafts, don't we want to
>> protect people using them from pruning ?  I got no feedback to my
>> suggestion of changing the default behaviour, even to say it was a bad
>> idea :)

I just gave a terse "Yes" because I agree with Yann that if
really a permanent history rewriting is needed it should be done
by history rewriting not with graft (I do not necessarily
encourage people to rewrite history but if somebody wants to,
that is).

> We _could_ decide that fsck should just follow the "real parents" and the 
> grafts _both_. That's the safe thing to do by default. Possibly with a 
> flag to say "prefer one over the other", or even a "prefer which-ever 
> exists".

I agree with everything Linus said about the current grafts
usage.  My vote for fsck is to make it default to follow both by
default for safety, and perhaps an optional --ignore-graft
flag.
