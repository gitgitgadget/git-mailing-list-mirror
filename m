From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-commit: revamp the git-commit semantics.
Date: Tue, 07 Feb 2006 10:18:17 -0800
Message-ID: <7vpslzuj6e.fsf@assigned-by-dhcp.cox.net>
References: <7vpsm2hzng.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550602050536j73f1091dq9afae232f574d0b4@mail.gmail.com>
	<7v64ntindq.fsf@assigned-by-dhcp.cox.net> <43E67745.2080302@gmail.com>
	<7voe1le71b.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602071135110.5397@localhost.localdomain>
	<7vfymvvz1r.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Feb 07 19:20:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6XPz-0003pC-I3
	for gcvg-git@gmane.org; Tue, 07 Feb 2006 19:18:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbWBGSSU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Feb 2006 13:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751029AbWBGSSU
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Feb 2006 13:18:20 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:14276 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750792AbWBGSST (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2006 13:18:19 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060207181712.NMFA15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 7 Feb 2006 13:17:12 -0500
To: git@vger.kernel.org
In-Reply-To: <7vfymvvz1r.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 07 Feb 2006 09:50:08 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15702>

Junio C Hamano <junkio@cox.net> writes:

> I was hoping that before 1.2.0 I can take a final "just in case"
> quick poll to see everybody agrees making --only the default is
> the way to go, then state it clearly that 1.3.0 will have the
> default switched to --only in the release announcement.

Clarification.  Here is what I want to do.

I've said enough times that we _may_ switch the default from
traditional --include semantics to new --only semantics.  Nico
already even objected to the "may" part, and I am hoping it is
shared by everybody on the list that "may" should be "will
soon".  Unless somebody comes up with a convincing argument
otherwise, I'll write "this will switch to --only by the time
1.3.0 release is made, so start converting your scripts to
explicitly say --include or --only if you want a specific
behaviour, and start training your fingers in the meantime as
well" in the 1.2.0 announcement, probably done sometime late
this week.

That means 1.2.0 (and its maintenance series 1.2.X) will ship
with --include semantics for "git commit paths...", and will
allow explicit --only/--include.  After 1.2.0, at some point,
the "master" branch will start shipping with --only semantics as
default.  No script should break when 1.3.0 happens.

People who want to use --include semantics will acquire a habit
of explicitly askign for --include during 1.3.0 development
period.  They do not need to unlearn anything when 1.3.0 happens.

People who learned to type --only can unlearn it to reduce
typing when 1.3.0 happens, but unlearning is not a requirement.
Being explicit should always work.

New people that come after 1.3.0 will get the --only semantics
by default, the intuitiveness of which has been argued to death,
without using any flags.
