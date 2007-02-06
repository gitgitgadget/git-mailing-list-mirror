From: Junio C Hamano <junkio@cox.net>
Subject: Re: Difficulties in advertising a new branch to git newbies
Date: Mon, 05 Feb 2007 23:25:49 -0800
Message-ID: <7vodo7karm.fsf@assigned-by-dhcp.cox.net>
References: <87odognuhl.wl%cworth@cworth.org>
	<87y7nbdeaw.wl%cworth@cworth.org>
	<7vveifkczt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Tue Feb 06 08:26:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEKiO-0002SH-OQ
	for gcvg-git@gmane.org; Tue, 06 Feb 2007 08:26:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbXBFHZv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Feb 2007 02:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbXBFHZv
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Feb 2007 02:25:51 -0500
Received: from fed1rmmtai20.cox.net ([68.230.241.39]:59389 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751001AbXBFHZu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Feb 2007 02:25:50 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070206072550.HRUM1306.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Tue, 6 Feb 2007 02:25:50 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id L7Rp1W00T1kojtg0000000; Tue, 06 Feb 2007 02:25:50 -0500
In-Reply-To: <7vveifkczt.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 05 Feb 2007 22:37:42 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38815>

Junio C Hamano <junkio@cox.net> writes:

> If you add another DWIM rule, then I suspect that you would have
> harder time explaining why they get "hey, that is ambiguous"
> error.

I forgot to quote this part.

> ... to resolve "branch" as "remotes/*/branch" if unique?

One of the reasons I do not think it is a good idea is, saying
"if unique" makes it sound as if it is sane, but it forgets that
what confusion it is bringing into the picture when not unique.

If somebody says "git show master", obviously it would be found
under refs/heads/, and most likely there would be a tracking
branch refs/remotes/origin/master if you are not the project
lead, and if you work on more than one machines using
mothership-satellites configuration, you would probably have
refs/remotes/note/master and refs/remotes/laptop/master on your
mothership machine.  Now, "master" is not unique, but I do not
think we would want to complain "Gaah, master is not unique!  If
you mean heads/master, say so".

So addition to "if unique", we need another DWIM rule that says
"refs/heads/branch" trumps even when there are branch elsewhere
and prevents ambiguity rule from triggering.

And that is only one example I can think of in 10 minutes while
watching TV sitting next to my wife, without thinking much about
git X-<.  Who knows what other additional confusion we are
talking about?  That is what I fear most.
