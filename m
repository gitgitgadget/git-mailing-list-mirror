From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/3] Allow whole-tree operations to be started from a subdirectory
Date: Sat, 13 Jan 2007 17:50:18 -0800
Message-ID: <7vejpyidgl.fsf@assigned-by-dhcp.cox.net>
References: <7v8xg9x8uu.fsf@assigned-by-dhcp.cox.net>
	<7vy7o8rnyw.fsf_-_@assigned-by-dhcp.cox.net>
	<7vac0orml9.fsf_-_@assigned-by-dhcp.cox.net>
	<200701140111.20671.Josef.Weidendorfer@gmx.de>
	<45A97EC5.10401@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 14 02:50:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5uW4-0004xO-6L
	for gcvg-git@gmane.org; Sun, 14 Jan 2007 02:50:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbXANBu3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Jan 2007 20:50:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750726AbXANBu3
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jan 2007 20:50:29 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:46046 "EHLO
	fed1rmmtao01.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750712AbXANBu2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jan 2007 20:50:28 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070114015028.JAKZ9173.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>;
          Sat, 13 Jan 2007 20:50:28 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Apqe1W00R1kojtg0000000; Sat, 13 Jan 2007 20:50:44 -0500
To: Steven Grimm <koreth@midwinter.com>
In-Reply-To: <45A97EC5.10401@midwinter.com> (Steven Grimm's message of "Sat,
	13 Jan 2007 16:52:21 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36789>

Steven Grimm <koreth@midwinter.com> writes:

> Which is why I think the commands should just cd to the top directory
> as needed. Doing otherwise is just making the user do pointless
> busywork. IMO any command that, if run in a subdirectory, currently
> does nothing but spit out a "hey, you can't run me in a subdirectory!"
> error is not doing what the user wanted. The user never runs one of
> those commands hoping to see an error message or to test whether he's
> in the top-level directory. I can't think of any situation in which
> I'd want to see that error instead of the --top behavior.

Having said what I said in the other message, I 120% agree with
this.

The 20% you did not say but I am adding because I really want it
to happen is this.  I want to make running "git merge" from a
subdirectory first cd-up the interactive shell I am typing "git
merge" into and then run the command.  This is because the
reason why I am running one of these "whole tree" operations is
because I am done with what I have been doing in the
subdirectory I was in, and I am moving onto something different.

Of course this cannot be done from within "git merge" command,
but perhaps with clever use of shell aliases it might be
possible.
