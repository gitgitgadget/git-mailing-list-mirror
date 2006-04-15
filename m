From: Junio C Hamano <junkio@cox.net>
Subject: Re: Tentative built-in "git show"
Date: Sat, 15 Apr 2006 12:28:06 -0700
Message-ID: <7v3bgefxkp.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0604151203060.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 15 21:28:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUqRL-0005H7-38
	for gcvg-git@gmane.org; Sat, 15 Apr 2006 21:28:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750889AbWDOT2L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Apr 2006 15:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWDOT2L
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Apr 2006 15:28:11 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:28412 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750889AbWDOT2J (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Apr 2006 15:28:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060415192807.WJAO18224.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 15 Apr 2006 15:28:07 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604151203060.3701@g5.osdl.org> (Linus Torvalds's
	message of "Sat, 15 Apr 2006 12:09:56 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18761>

Linus Torvalds <torvalds@osdl.org> writes:

> This uses the "--no-walk" flag that I never actually implemented (but I'm 
> sure I mentioned it) to make "git show" be essentially the same thing as 
> "git whatchanged --no-walk".

I sometimes do "git show -4" myself, and wondered why defaulting
to "-n 1"is insufficient, but if you do something like this to
check the tip of each branch:

	git show master next pu

this may make sense.

Otherwise, it feels to me that (I haven't had caffeine nor
nicotine yet, so I need to re-think this later) log, show and
whatchanged are the same program in disguise with different set
of defaults.

        log		--pretty
        show		--pretty -n1 -p
        whatchanged	--pretty -r

... which implies that some of them might become historical
curiosity and no real reason to teach about each of them in the
tutorial.
