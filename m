From: Junio C Hamano <junkio@cox.net>
Subject: Re: git and time
Date: Thu, 28 Sep 2006 10:28:45 -0700
Message-ID: <7vodszuche.fsf@assigned-by-dhcp.cox.net>
References: <20060928165509.77413.qmail@web51001.mail.yahoo.com>
	<Pine.LNX.4.64.0609281003070.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthew L Foster <mfoster167@yahoo.com>
X-From: git-owner@vger.kernel.org Thu Sep 28 19:29:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSzgz-0003be-LS
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 19:29:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbWI1R2s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 13:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751957AbWI1R2r
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 13:28:47 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:32509 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751330AbWI1R2q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 13:28:46 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060928172846.VQA26416.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>;
          Thu, 28 Sep 2006 13:28:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id TtUo1V0061kojtg0000000
	Thu, 28 Sep 2006 13:28:48 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609281003070.3952@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 28 Sep 2006 10:11:01 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28023>

Linus Torvalds <torvalds@osdl.org> writes:

> On Thu, 28 Sep 2006, Matthew L Foster wrote:
>> 
>> I am not saying git should "police any one else's clocks", I am saying git should be designed or
>> configured in such a way, using local time, that it obviates the current reliance on everyone
>> else's clock being set correctly. 
>
> Matt!
>
> THERE IS NO SUCH RELIANCE! NONE.
>
> Trust me. When we say that git ignores time, WE MEAN IT. Git does not rely 
> on time, git does not use time, git does not CARE!
>
> Please stop looking at gitweb _immediately_. If you think time has some 
> meaning for git, stop. It doesn't. We've told you over and over and over 
> again that there is absolutely _zero_ reliance on everybody else's clock 
> being set correctly. The damn clock could go _backwards_, or make huge 
> jumping purple leaps of imagination, and git wouldn't care.

I think Matthew means (by "relying") that everybody's clock must
be set correctly in order for us to show the commits in gitweb
or rev-list output so that their timestamps are monotonically
decreasing (because we list things from newer to older).  I
sympathise.

We order things by causality (i.e. ancestry order), but that
unfortunately (!!)  happens to match timestamp order for simple
history made on a single machine.  This can easily lead to such
a misunderstanding that we are somehow trying to show things in
linear time order, hence we subscribe to the notion of global,
uniform and monotonic time.

Of course, we don't.
