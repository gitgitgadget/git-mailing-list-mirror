From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Don't use $author_name undefined when $from contains no /\s</.
Date: Thu, 19 Oct 2006 14:34:21 -0700
Message-ID: <7vr6x4q9b6.fsf@assigned-by-dhcp.cox.net>
References: <87vemgn1s2.fsf@rho.meyering.net>
	<7vbqo8uvkn.fsf@assigned-by-dhcp.cox.net>
	<878xjckw7x.fsf@rho.meyering.net>
	<7vk62wruum.fsf@assigned-by-dhcp.cox.net>
	<87fydkj8q1.fsf@penguin.cs.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 19 23:34:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GafXC-0006X7-2C
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 23:34:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946533AbWJSVef (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Oct 2006 17:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946531AbWJSVef
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Oct 2006 17:34:35 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:59837 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1946532AbWJSVee (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Oct 2006 17:34:34 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061019213433.WSGY12581.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>;
          Thu, 19 Oct 2006 17:34:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id cMaS1V0081kojtg0000000
	Thu, 19 Oct 2006 17:34:26 -0400
To: Paul Eggert <eggert@CS.UCLA.EDU>
In-Reply-To: <87fydkj8q1.fsf@penguin.cs.ucla.edu> (Paul Eggert's message of
	"Thu, 19 Oct 2006 14:28:54 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29384>

Paul Eggert <eggert@CS.UCLA.EDU> writes:

> Junio C Hamano <junkio@cox.net> writes:
>
>> I see no good reason, other than saving a single byte from the
>> output stream perhaps.
>
> That wasn't the motivation.  Rather, it was to support the
> style where people use editors that highlight trailing
> blanks, since trailing blanks can cause trouble in some
> contexts (e.g., they can change the semantics of C programs
> and Makefiles).  When examining unified diffs, any added or
> removed trailing blanks will be easy to spot with such an
> editor, but only if "diff -u" doesn't output any trailing
> blanks of its own.

If "trailing space" highlighting picks up the first column blank
in "diff -u" output, that highlighting feature is *broken*.

"git diff --color" does the whitespace breakage highlighting,
but it knows that the first column *is* not payload and does not
highlight it.

> You can read more about this at the thread that inspired
> the diffutils change, rooted here:
>
> http://lists.gnu.org/archive/html/bug-gnu-utils/2006-09/msg00005.html

I've read it.  It was not convincing and was not even an amusing
read.
