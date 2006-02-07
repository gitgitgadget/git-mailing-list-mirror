From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] git-commit: revamp the git-commit semantics.
Date: Tue, 07 Feb 2006 11:59:26 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0602071135110.5397@localhost.localdomain>
References: <7vpsm2hzng.fsf@assigned-by-dhcp.cox.net>
 <e5bfff550602050536j73f1091dq9afae232f574d0b4@mail.gmail.com>
 <7v64ntindq.fsf@assigned-by-dhcp.cox.net> <43E67745.2080302@gmail.com>
 <7voe1le71b.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Marco Costalba <mcostalba@gmail.com>,
	git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 07 17:59:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6WBf-0003AS-BV
	for gcvg-git@gmane.org; Tue, 07 Feb 2006 17:59:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbWBGQ72 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Feb 2006 11:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932471AbWBGQ72
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Feb 2006 11:59:28 -0500
Received: from relais.videotron.ca ([24.201.245.36]:25947 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932172AbWBGQ71
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 7 Feb 2006 11:59:27 -0500
Received: from xanadu.home ([24.202.136.67]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IUB00IMQTV2EYG0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 07 Feb 2006 11:59:26 -0500 (EST)
In-reply-to: <7voe1le71b.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15699>

On Sun, 5 Feb 2006, Junio C Hamano wrote:

> I was hoping that, once people get used to --include and --only,
> they start to "revel in the index" (as Linus puts it), and
> realize that defaulting to --only is not such a good idea after
> all.  When that happens, I could leave --include as the
> default without getting complaints from them ;-).

I know this is like fighting old habits, but at some point one as to 
realize that there was a mistake in the interface and the best way to 
solve that mistake is to go with the objectively most intuitive 
solution.

People can get used to the index concept like you did yourself of 
course, but that is still dismissing the very reason for doing that 
change in the first place, which is that to a git beginner it is counter 
intuitive to have side effects when explicit paths are specified 
_alone_.

> The net effect, if we end up doing so, would be that we gained
> an extra flag --only that the user can use to explicitly ask for
> a partial commit when they want one, without disrupting the
> established workflow of old timers.

It is a bit deconcerting to see that git has already reached the 
software stone age and that so called "old timers" already have more 
weight than clean interfaces... even after less than a year.

Please don't make it another CVS and fix those inconsistencies clean and 
quick while the user base is not yet inapt to change.

> The --only semantics is a useful thing in many situations, while
> the --include semantics is also a useful thing in many other
> cases.  The latter might be a better match to the way the git
> internal works, but both are equally useful options that support
> different workflows.  I do not see an inherent reason to declare
> one over the other to be "the default".

What has happened to the "least surprise" principle?  That clearly 
favorize the former IMHO.

> So we could instead
> have no defaults at all (i.e. you have to explicitly say which
> kind you want if you use paths...).

And that would be just a nice usability annoyance.

Maybe being too intimate with git doesn't make it obvious to you, but if 
you do a survey of the number of tools that allows accepting a list of 
paths for their only arguments it should be pretty obvious that the vast 
majority operate only on those explicit paths without any hidden side 
effect.

If "git commit" is meant to be a user helper script to hide the low 
level git plumbing then it better do it with the least surprise 
principle in mind, otherwise it misses its very purpose.  And the faster 
this is corrected the better, especially since this is not such a 
disturbing change after all.


Nicolas
