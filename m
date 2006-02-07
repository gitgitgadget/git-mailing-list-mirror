From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] git-commit: revamp the git-commit semantics.
Date: Tue, 07 Feb 2006 13:39:19 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0602071304160.5397@localhost.localdomain>
References: <7vpsm2hzng.fsf@assigned-by-dhcp.cox.net>
 <e5bfff550602050536j73f1091dq9afae232f574d0b4@mail.gmail.com>
 <7v64ntindq.fsf@assigned-by-dhcp.cox.net> <43E67745.2080302@gmail.com>
 <7voe1le71b.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0602071135110.5397@localhost.localdomain>
 <7vfymvvz1r.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 07 19:39:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6XkJ-00006c-SG
	for gcvg-git@gmane.org; Tue, 07 Feb 2006 19:39:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964858AbWBGSjV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Feb 2006 13:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964857AbWBGSjV
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Feb 2006 13:39:21 -0500
Received: from relais.videotron.ca ([24.201.245.36]:64926 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S964858AbWBGSjU
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 7 Feb 2006 13:39:20 -0500
Received: from xanadu.home ([24.202.136.67]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IUB005E3YHJ2NG0@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 07 Feb 2006 13:39:19 -0500 (EST)
In-reply-to: <7vfymvvz1r.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15706>

On Tue, 7 Feb 2006, Junio C Hamano wrote:

> That is this '--only/--include are available but currently the
> traditional --include is the default' is all about.  It is about
> not breaking current users during transition.  And People's
> Scripts.  If a tool wants traditional semantics, it can hardcode
> "--include" (or --only if not), and does not have to worry about
> the default getting switched "some day".

I'm completely with you here.  However is there so many tools that 
relies on the current behavior of "git commit"?

> Once things are prepared that way, we can switch the default any
> day, as long as we give users enough advance notice.

Good.  It just seemed to me that you weren't convinced that any default 
switching was needed.  Sorry if I misread you.

What prompted my initial reply to you was this:

|The --only semantics is a useful thing in many situations, while
|the --include semantics is also a useful thing in many other
|cases.  The latter might be a better match to the way the git
|internal works, but both are equally useful options that support
|different workflows.  I do not see an inherent reason to declare
|one over the other to be "the default".  So we could instead
|have no defaults at all (i.e. you have to explicitly say which
|kind you want if you use paths...).

to which I disagreed.

> It is possible that you are well aware of all of the above, and
> are arguing that "enough advance notice" period should be zero
> days.  But I don't think that is nice.

Certainly not zero days.  I'm just trying to counter-balance the 
"without disrupting the established workflow of old timers" argument 
which is the worst enemy of healthy software evolution.  If such an 
argument was to prevail in the Linux world then we would have had those 
evil "stable driver ABI" for a long time already.  If that argument was 
to prevail for git then that would be the beginning of its stagnation.

As for the advance notice, it might be a good idea to simply switch the 
default in 1.3.0 giving any script author relying on the --include 
behavior (if any) proper insentive to fix them. The 1.3.x branch being 
the so called "unstable" branch makes it the appropriate place to do 
it at the earliest, providing script authors enough time to test their 
modifications on the real thing before it becomes official 1.4.0.

But you should consider all above rambling as part of the feedback you 
asked for.  I don't pretend to always be right.


Nicolas
