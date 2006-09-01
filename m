From: Junio C Hamano <junkio@cox.net>
Subject: Re: Mozilla .git tree
Date: Fri, 01 Sep 2006 12:56:31 -0700
Message-ID: <7vfyfb5pjk.fsf@assigned-by-dhcp.cox.net>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 01 21:57:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJF8e-0006Mz-6h
	for gcvg-git@gmane.org; Fri, 01 Sep 2006 21:57:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbWIAT40 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Sep 2006 15:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751460AbWIAT40
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Sep 2006 15:56:26 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:13516 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751445AbWIAT40 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Sep 2006 15:56:26 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060901195625.EVDT12909.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>;
          Fri, 1 Sep 2006 15:56:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id H7wL1V00k1kojtg0000000
	Fri, 01 Sep 2006 15:56:21 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609011129270.27779@g5.osdl.org> (Linus Torvalds's
	message of "Fri, 1 Sep 2006 11:35:23 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26309>

Linus Torvalds <torvalds@osdl.org> writes:

> On Fri, 1 Sep 2006, A Large Angry SCM wrote:
>> 
>> Unfortunately, the zlib CRC is of the _uncompressed_ data [1], so
>> inflating the stream is still necessary to check for corruption.
>
> I don't think that is unfortunate.
>
> We really should inflate the stream anyway, since not only inflating it, 
> but also applying any deltas to the base object is really the only way to 
> verify its correctness for a delta thing. Otherwise, the SHA1 of the base 
> could be totally corrupt.
>
> And once you inflate it and apply all deltas, you obviously also get the 
> full SHA1 check, so you're _really_ safe.
>
> So let's do the really safe thing first, and see if it actually results in 
> any problems.

I think this makes sense.
