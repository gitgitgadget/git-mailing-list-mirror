From: Junio C Hamano <junkio@cox.net>
Subject: Re: Newbie falls at first hurdle
Date: Sat, 17 Sep 2005 09:50:39 -0700
Message-ID: <7v1x3n8wps.fsf@assigned-by-dhcp.cox.net>
References: <200509171309.46893.alan@chandlerfamily.org.uk>
	<7vek7nbrk7.fsf@assigned-by-dhcp.cox.net>
	<200509171730.19055.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 17 18:50:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGftk-0008Q6-Ht
	for gcvg-git@gmane.org; Sat, 17 Sep 2005 18:50:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbVIQQum (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Sep 2005 12:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbVIQQum
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Sep 2005 12:50:42 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:54741 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751156AbVIQQul (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Sep 2005 12:50:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050917165040.RMDC28889.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 17 Sep 2005 12:50:40 -0400
To: Alan Chandler <alan@chandlerfamily.org.uk>
In-Reply-To: <200509171730.19055.alan@chandlerfamily.org.uk> (Alan Chandler's
	message of "Sat, 17 Sep 2005 17:30:18 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8768>

Alan Chandler <alan@chandlerfamily.org.uk> writes:

> The editor file that came up with this listed all the files it was going to 
> commit INCLUDING some .files from the root directory (I am using eclipse, so 
> I had files like .project and .classpath there).  It says in the 
> Documentation that git ignores those - has it done?

We ignore '.git' but we let you have paths starting with dots
these days -- the change happened quite a while ago and if some
documentation still says we do not, then you spotted a
documentation bug.

> I then deleted these directories again and then attempted to check them out 
> from the repository with
>
> git checkout master
>
> None of these directories has been created in my working directory.

After you told git about those files, you removed them from your
working tree.  "git checkout" tries not to lose your local
changes -- which means that what you removed will be left
removed (so are what you locally edited).

    $ git checkout -f

would give them back, but you would also lose other local
changes if you have some.
