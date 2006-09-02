From: Junio C Hamano <junkio@cox.net>
Subject: Re: Mozilla .git tree
Date: Sat, 02 Sep 2006 13:53:54 -0700
Message-ID: <7virk6yopp.fsf@assigned-by-dhcp.cox.net>
References: <9e4733910608291958l45c0257dla6e5ebd4176f7164@mail.gmail.com>
	<20060830031029.GA23967@spearce.org>
	<Pine.LNX.4.64.0608300124550.9796@xanadu.home>
	<7vzmdmh2lu.fsf@assigned-by-dhcp.cox.net>
	<7vr6yw58xp.fsf@assigned-by-dhcp.cox.net>
	<20060902011950.GB24234@spearce.org>
	<7v8xl23oia.fsf@assigned-by-dhcp.cox.net>
	<20060902043931.GA25146@spearce.org>
	<7vveo6zfx0.fsf@assigned-by-dhcp.cox.net>
	<9e4733910609020720w3633aa0cq5016fb1e223fc4cb@mail.gmail.com>
	<20060902173922.GA27826@spearce.org>
	<Pine.LNX.4.64.0609021151280.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>, Jon Smirl <jonsmirl@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 02 22:54:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJcVZ-0007e9-FA
	for gcvg-git@gmane.org; Sat, 02 Sep 2006 22:54:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751573AbWIBUxu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Sep 2006 16:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751575AbWIBUxu
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Sep 2006 16:53:50 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:19414 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751572AbWIBUxs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Sep 2006 16:53:48 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060902205348.FEXB2704.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>;
          Sat, 2 Sep 2006 16:53:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id HYto1V00P1kojtg0000000
	Sat, 02 Sep 2006 16:53:49 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26355>

Linus Torvalds <torvalds@osdl.org> writes:

> On Sat, 2 Sep 2006, Shawn Pearce wrote:
>
>> I think Junio and Nico have already agreed to change the base SHA1
>> to be an offset instead;

I am not in favor of that, at least not yet, especially I
haven't thought about the implications of that on streaming
unpacker.  I do not have much objections about changing
base-delta order, though.

> Of course, if we change the pack/index-file format for other reasons, then 
> we should obviously fix the 4G issue at the same time, but were there 
> actually any real other reasons at this point?

Not really, from my point of view.  Probably 70% of motivation
of the new \377tOc index format originally came from wanting to
have "where is the end of this object" which turned out to be
unneeded; and by making repack easier to use I think we do not
have to solve 4G issue either.

There is only one case that might need a single pack that can be
indexed with 4G offset: initial clone or repack of a huge
repository.


-- 
VGER BF report: U 0.788936
