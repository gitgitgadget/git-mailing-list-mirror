From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] pack-objects: re-validate data we copy from elsewhere.
Date: Fri, 01 Sep 2006 18:52:55 -0700
Message-ID: <7vr6yv3uh4.fsf@assigned-by-dhcp.cox.net>
References: <20060829165811.GB21729@spearce.org>
	<9e4733910608291037k2d9fb791v18abc19bdddf5e89@mail.gmail.com>
	<20060829175819.GE21729@spearce.org>
	<9e4733910608291155g782953bbv5df1b74878f4fcf1@mail.gmail.com>
	<20060829190548.GK21729@spearce.org>
	<9e4733910608291252q130fc723r945e6ab906ca6969@mail.gmail.com>
	<20060829232007.GC22935@spearce.org>
	<9e4733910608291807q9b896e4sdbfaa9e49de58c2b@mail.gmail.com>
	<20060830015122.GE22935@spearce.org>
	<9e4733910608291958l45c0257dla6e5ebd4176f7164@mail.gmail.com>
	<20060830031029.GA23967@spearce.org>
	<Pine.LNX.4.64.0608300124550.9796@xanadu.home>
	<7vzmdmh2lu.fsf@assigned-by-dhcp.cox.net> <44F871BA.3070303@gmail.com>
	<Pine.LNX.4.64.0609011129270.27779@g5.osdl.org>
	<7vveo741tc.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0609011721390.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 02 03:52:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJKgl-0001OB-AD
	for gcvg-git@gmane.org; Sat, 02 Sep 2006 03:52:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbWIBBws (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Sep 2006 21:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbWIBBws
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Sep 2006 21:52:48 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:59805 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750811AbWIBBwr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Sep 2006 21:52:47 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060902015247.XEQW6235.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>;
          Fri, 1 Sep 2006 21:52:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id HDsn1V00e1kojtg0000000
	Fri, 01 Sep 2006 21:52:47 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609011721390.27779@g5.osdl.org> (Linus Torvalds's
	message of "Fri, 1 Sep 2006 17:23:15 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26316>

Linus Torvalds <torvalds@osdl.org> writes:

> On Fri, 1 Sep 2006, Junio C Hamano wrote:
>>
>> 	[...] Instead make sure they are not corrupt, but
>> do so only when we are not streaming to stdout, [...]
>
> Hmm. I see you making pack_to_stdout available to those functions, but I 
> don't actually see you using it - looks like you revalidate regardless.
>
> Which is safe, of course, but it doesn't match your description ;)

Oops, that was a thinko.  My previous crappoid had

	if (pack_to_stdout)
        	return 0;

at the beginning of revalidate function.


-- 
VGER BF report: U 0.499951
