From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add support for author-oriented git-rev-list switches
 [rev 8]
Date: Thu, 09 Jun 2005 13:35:42 -0700
Message-ID: <7vy89jb74x.fsf@assigned-by-dhcp.cox.net>
References: <20050609090141.21555.qmail@blackcubes.dyndns.org>
	<2cfc403205060902373e5c284f@mail.gmail.com>
	<2cfc4032050609085341e46242@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jon.seymour@gmail.com,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu Jun 09 22:32:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgThS-0006j7-Of
	for gcvg-git@gmane.org; Thu, 09 Jun 2005 22:32:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262462AbVFIUg1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Jun 2005 16:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262465AbVFIUg1
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jun 2005 16:36:27 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:10181 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S262462AbVFIUfr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2005 16:35:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050609203543.OFDE1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 9 Jun 2005 16:35:43 -0400
To: jon@blackcubes.dyndns.org
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "JS" == Jon Seymour <jon.seymour@gmail.com> writes:

JS> test_output_expect_success
JS> If you like, I'll generalize it and move it into testlib.sh

Sounds sensible, and yes please I prefer to have it in
testlib.sh, and you would get bonus points if you converted some
(I do not demand you do all of them ;-)) existing cat/echo users
while you are at it.

Except for some minor points.

I do not think use of "local" to help readability is absolutely
necessary in this small function, and if it is a bashism, I
prefer to see it written in a more portable form.  I was
thinking about removing bashism from the test scripts, although
I have not gotten around to actually doing it [*1*, *2*].

[Footnotes]

*1* Auditing all the shell scripts to look for quoting bugs
while eradicating bashism would be another good "Janitor"
sub-project if somebody is interested on the list.

I do not know what happend to other items on the Janitor project
list.  Personally I liked the one Sean did to redo the command
line parameters using argp.

*2* Not that I claim what I have already written is bash free.
I do not have a handy reference that lists which is bashism and
which is in POSIX.  To stay away from bashism, I just try not to
use certain things that I did not use when I was introduced to
shell programming.  That list includes "${parameter#word}",
"${!parameter}", "function" and "local".

