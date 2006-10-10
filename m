From: Junio C Hamano <junkio@cox.net>
Subject: Re: Does GIT has vc keywords like CVS/Subversion?
Date: Tue, 10 Oct 2006 10:41:13 -0700
Message-ID: <7vy7ro2hmu.fsf@assigned-by-dhcp.cox.net>
References: <4b3406f0610081825y1d066579yba305b6540c8d0e9@mail.gmail.com>
	<4529B77A.707@gmail.com>
	<Pine.LNX.4.64.0610090904360.3952@g5.osdl.org>
	<46a038f90610091408y29f60a12gea7040b5412331c6@mail.gmail.com>
	<20061010164927.GC16412@spearce.org>
	<Pine.LNX.4.64.0610101005420.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>,
	Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 10 19:41:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXLbS-00031f-7E
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 19:41:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbWJJRlP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 13:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751034AbWJJRlP
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 13:41:15 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:18104 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751033AbWJJRlO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Oct 2006 13:41:14 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061010174114.NAZT6077.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>;
          Tue, 10 Oct 2006 13:41:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id YhhG1V00J1kojtg0000000
	Tue, 10 Oct 2006 13:41:17 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610101005420.3952@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 10 Oct 2006 10:14:54 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28639>

Linus Torvalds <torvalds@osdl.org> writes:

> Well, it probably wouldn't be too nasty to try to have a "find nearest 
> commit" kind of thing. It's not quite as simple as bisection, but you 
> could probably use a bisection-like algorithm to do something like a 
> binary search to try to guess which tree is the closest. 

I had to do something like that in my day job once.  A customer
installation was made from a tarball of unknown vintage, and
then field patched with later fixes.

I ended up slurping the thing back and populated my index with
it.  Luckily I could guess a good initial point to find the
commit that gives minimum "git diff" output.  Then from the
remaining patches it was reasonably easy to find out which
changes were cherry-picked by hand with "git log master --
$paths".
