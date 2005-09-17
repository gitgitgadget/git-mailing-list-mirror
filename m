From: Junio C Hamano <junkio@cox.net>
Subject: Re: Newbie falls at first hurdle
Date: Sat, 17 Sep 2005 09:13:44 -0700
Message-ID: <7vek7nbrk7.fsf@assigned-by-dhcp.cox.net>
References: <200509171309.46893.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 17 18:15:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGfK2-0001EJ-HP
	for gcvg-git@gmane.org; Sat, 17 Sep 2005 18:13:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbVIQQNs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Sep 2005 12:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbVIQQNs
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Sep 2005 12:13:48 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:64738 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751132AbVIQQNq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Sep 2005 12:13:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050917161346.MVKO18416.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 17 Sep 2005 12:13:46 -0400
To: Alan Chandler <alan@chandlerfamily.org.uk>
In-Reply-To: <200509171309.46893.alan@chandlerfamily.org.uk> (Alan Chandler's
	message of "Sat, 17 Sep 2005 13:09:46 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8765>

Alan Chandler <alan@chandlerfamily.org.uk> writes:

> So 'git-update-cache --add *' would seem to be the next step.
>
> However this fails with a message 
>
> error: JavaSource: is a directory
> fatal: Unable to add JavaSource to database; maybe you want to use --add 
> option?

Sorry, that is not a very helpful error message.

We do not track 'directories'.  Only files and symlinks, which
could live within subdirectories, and that's why you got that
error message -- you told it to add a directory.  You'd need
something like this:

    $ find * ! -type d -print0 | xargs -0 git add
