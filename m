From: Junio C Hamano <junkio@cox.net>
Subject: Re: Now what: multiple HEAD refs
Date: Thu, 15 Dec 2005 01:29:27 -0800
Message-ID: <7v8xumr9mw.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0512150105p5bacd6a1j938824ae2ab96858@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 15 10:31:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmpR1-0002NO-RO
	for gcvg-git@gmane.org; Thu, 15 Dec 2005 10:30:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422665AbVLOJ3b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Dec 2005 04:29:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422652AbVLOJ3b
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Dec 2005 04:29:31 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:2467 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1422666AbVLOJ33 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2005 04:29:29 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051215092805.TXHJ17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 15 Dec 2005 04:28:05 -0500
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0512150105p5bacd6a1j938824ae2ab96858@mail.gmail.com>
	(Alex Riesen's message of "Thu, 15 Dec 2005 10:05:51 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13691>

Alex Riesen <raa.lkml@gmail.com> writes:

> just a heads-up for everyone tried "git pull" after using "git merge" too much:
>
> $ git pull . ref1 HEAD (notice the space!)

If you were too used to git merge, you would have wrote
HEAD before ref1, so that does not sound plausible ;-).

        $ git pull . maint HEAD
        error: no such remote ref refs/heads/HEAD
        Fetch failure: .
	$ echo $?
        1

But worse yet, the above syntax is to create an Octopus, and you
probably did not mean that.

I think the reason why my trial here worked correctly while you
had trouble with it is because I have the send-pack fix from
Pasky last night.
