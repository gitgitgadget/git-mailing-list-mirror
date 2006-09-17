From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb:  Make git_get_refs_list do work of  git_get_references
Date: Sat, 16 Sep 2006 19:29:50 -0700
Message-ID: <7v4pv78btt.fsf@assigned-by-dhcp.cox.net>
References: <200609170226.39330.jnareb@gmail.com>
	<7vodtf8eym.fsf@assigned-by-dhcp.cox.net>
	<864pv7tgmx.fsf@blue.stonehenge.com>
	<7vejub8cms.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 17 04:30:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOmPr-0000bk-LZ
	for gcvg-git@gmane.org; Sun, 17 Sep 2006 04:29:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964931AbWIQC3w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Sep 2006 22:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964932AbWIQC3w
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Sep 2006 22:29:52 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:41682 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S964931AbWIQC3w (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Sep 2006 22:29:52 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060917022951.RRJF18985.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>;
          Sat, 16 Sep 2006 22:29:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id PEVf1V0021kojtg0000000
	Sat, 16 Sep 2006 22:29:39 -0400
To: merlyn@stonehenge.com (Randal L. Schwartz)
In-Reply-To: <7vejub8cms.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 16 Sep 2006 19:12:27 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27156>

Junio C Hamano <junkio@cox.net> writes:

> The code I was complaining about tries to do something like
> this:
>
> 	sub that_sub {
>         	...
>                 return wantarray ? (\@bar, \%foo) : \@bar;
> 	}
>
> and it is not done for optimization purposes (i.e. "if the
> caller only wants one and we are returning \@bar then we do not
> have to compute \%foo which is a big win" is not why it does
> this wantarray business).

Note.  I did not mean to imply conditional return should be done
for performance reasons.

And I do not think the way this conditional return is done
serves better DWIMmery, which was my primary complaint.  So I
should probably have said "It's not for better DWIM, it is not
even for better performance, and I do not see a point".
