From: Junio C Hamano <junkio@cox.net>
Subject: Re: removing content from git history
Date: Wed, 21 Feb 2007 12:22:50 -0800
Message-ID: <7vbqjnntut.fsf@assigned-by-dhcp.cox.net>
References: <20070221164527.GA8513@ginosko.local>
	<Pine.LNX.4.64.0702210904350.4043@woody.linux-foundation.org>
	<7vy7mrnxlo.fsf@assigned-by-dhcp.cox.net>
	<alpine.LRH.0.82.0702211414410.31945@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Michael Hendricks <michael@ndrix.org>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Feb 21 21:23:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJxzX-0001Zs-HG
	for gcvg-git@gmane.org; Wed, 21 Feb 2007 21:23:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423084AbXBUUWw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Feb 2007 15:22:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423085AbXBUUWw
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Feb 2007 15:22:52 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:46064 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423084AbXBUUWv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Feb 2007 15:22:51 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070221202252.JPOP233.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Wed, 21 Feb 2007 15:22:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id SLNq1W00A1kojtg0000000; Wed, 21 Feb 2007 15:22:51 -0500
In-Reply-To: <alpine.LRH.0.82.0702211414410.31945@xanadu.home> (Nicolas
	Pitre's message of "Wed, 21 Feb 2007 14:33:11 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40323>

Nicolas Pitre <nico@cam.org> writes:

> On Wed, 21 Feb 2007, Junio C Hamano wrote:
>
>> While I agree in principle to the argument that there is no
>> taking it back what's already published, I've heard people
>> wanting to just stop distributing further, without worrying
>> about copies already out there.  'missing objects' support would
>> help us in such a situation.
>
> I still think this is a "put your head in the sand and pretend that some 
> sensitive data never existed in the wild" attitude.  And I really don't 
> see the point of supporting that illusion in GIT with technical means.

Well, I think we are in agreement (and that is why I said "I've
heard people wanting").

But it is entirely possible that somebody has a project that is
internal to a company managed for a long time with git, that he
wants to go open source, with (almost) full history.  And the
project may have some proprietary add-on bit which cannot be
published, while building the public bits does not require that
part.  Stubbing things out may help that kind of situation.  The
development team can keep going forward, internally using the
real objects, while pushing stub objects out to the public
repository, without having to rewrite the history and re-partition
the project.

But after having thought about that, I think it would not buy us
much.  You would want to re-partition the project sooner or
later in such a situation *anyway*, so our time is better spent
on giving better support to split existing projects.  It may
already be sufficient in the form of admin-rewritehist, in which
case we can worry about other things ;-).
