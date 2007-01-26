From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Hash name is SHA-1
Date: Fri, 26 Jan 2007 15:46:00 -0800
Message-ID: <7vzm85tkqv.fsf@assigned-by-dhcp.cox.net>
References: <11697294071178-git-send-email-vonbrand@inf.utfsm.cl>
	<20070125230302.GB13677@moooo.ath.cx>
	<7vr6ti659k.fsf@assigned-by-dhcp.cox.net>
	<200701261154.20723.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 27 00:46:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAalj-0007by-NM
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 00:46:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752176AbXAZXqE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 18:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752182AbXAZXqE
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 18:46:04 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:45138 "EHLO
	fed1rmmtao02.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752176AbXAZXqC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 18:46:02 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070126234601.MCZB9717.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>;
          Fri, 26 Jan 2007 18:46:01 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Fzl31W00a1kojtg0000000; Fri, 26 Jan 2007 18:45:04 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37901>

Andy Parkins <andyparkins@gmail.com> writes:

> As a further to the above cleanups, I'm also planning to fix all the sha1 
> named variables to be "hash" or "object" or something.  It strikes me that 
> this plan is related to this cleanup and might fix some of the issues like:
>
>> +       "git-read-tree (<sha> | "
>> +       "[[-m [--aggressive] | --reset | --prefix=<prefix>] "
>> +       "[-u | -i]] [--exclude-per-directory=<gitignore>] "
>> +       "<sha1> [<sha2> [<sha3>]])";

I've thought about this more than once but I do not think it is
worth to rename variable and functions wholesale.  When we do
fix-ups to a particular function that has "unsigned char
sha1[20]" renaming the variable to hash[OBNAME_SIZE] at the same
time would be of less impact, although the clean-up may take
longer.

On the other hand, I think the usage strings are fair game.
