From: Junio C Hamano <junkio@cox.net>
Subject: Re: confusion over the new branch and merge config
Date: Fri, 22 Dec 2006 00:21:24 -0800
Message-ID: <7vfyb85ojf.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0612211555210.18171@xanadu.home>
	<7vd56cam66.fsf@assigned-by-dhcp.cox.net>
	<200612220750.49644.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Dec 22 09:21:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gxfei-0005bI-Qq
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 09:21:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945969AbWLVIV0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 03:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945971AbWLVIV0
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 03:21:26 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:34524 "EHLO
	fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945969AbWLVIVZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 03:21:25 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061222082125.JJBQ25875.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>;
          Fri, 22 Dec 2006 03:21:25 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 1kLi1W0051kojtg0000000; Fri, 22 Dec 2006 03:20:43 -0500
To: Alan Chandler <alan@chandlerfamily.org.uk>
In-Reply-To: <200612220750.49644.alan@chandlerfamily.org.uk> (Alan Chandler's
	message of "Fri, 22 Dec 2006 07:50:49 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35141>

Alan Chandler <alan@chandlerfamily.org.uk> writes:

> And according to the man page git branch -r should print ONLY the remote 
> branches

Heh, sounds like you spotted a bug -- patches welcome (or I'll
fix it myself if I get around to it before everybody else).
Thanks.

>> > $ git checkout origin/next
>> > git checkout: to checkout the requested commit you need to specify
>> >               a name for a new branch which is created and switched
>
> What about the error message saying that origin/next is read only.  
> Something like
>
> git-checkout: the requested commit is on a remote read only branch.  You 
> need to specify a new local branch with the -b option to proceed.

I agree that explicitly suggesting the use of -b is a good idea,
but your wording is a bit too specific; after all you might do

	$ H=`git-rev-parse origin/next`
        $ git checkout $H

and there is not enough information to say "is on a remote read
only branch".  We could do that with more specific hacks in
git-checkout; patches welcome.
