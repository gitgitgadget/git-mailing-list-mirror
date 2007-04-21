From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] Add keyword unexpansion support to convert.c
Date: Fri, 20 Apr 2007 18:54:59 -0700
Message-ID: <7vbqhiwky4.fsf@assigned-by-dhcp.cox.net>
References: <200704171041.46176.andyparkins@gmail.com> <"200704171803.58940.an
	dyparkins"@gmail.com> <200704172012.31280.andyparkins@gmail.com>
	<alpine.LFD.0.98.0704171530220.45 04@xanadu.home>
	<Pine.LNX.4.63.0704171244450.1696@qynat.qvtvafvgr.pbz> <alpin
	e.LFD.0.98.0704171624190.4504@xanadu.home>
	<Pine.LNX.4.63.0704171302200.1696 @qynat.qvtvafvgr.pbz>
	<alpine.LFD.0.98.0704171708360.4504@xanadu.home>
	<7vy7kqlj5r.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0704201605580.4634@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Andy Parkins <andyparkins@gmail.com>,
	git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: David Lang <david.lang@digitalinsight.com>
X-From: git-owner@vger.kernel.org Sat Apr 21 03:55:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hf4ou-0008At-G0
	for gcvg-git@gmane.org; Sat, 21 Apr 2007 03:55:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbXDUBzD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 21:55:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754064AbXDUBzD
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 21:55:03 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:51810 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754060AbXDUBzA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2007 21:55:00 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070421015459.PVFP1266.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Fri, 20 Apr 2007 21:54:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id pduz1W00Z1kojtg0000000; Fri, 20 Apr 2007 21:55:00 -0400
In-Reply-To: <Pine.LNX.4.63.0704201605580.4634@qynat.qvtvafvgr.pbz> (David
	Lang's message of "Fri, 20 Apr 2007 17:42:08 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45146>

David Lang <david.lang@digitalinsight.com> writes:

>> But with keyword expansion and fancier "external tools" whose
>> semantics are not well defined (iow, defined to be "do whatever
>> they please"), does it still make sense to consider two blobs
>> that appear in totally different context "the same" and omit
>> checking out (and causing the external tools hook not getting
>> run)?  I already pointed out to Andy that the branch name the
>> file was taken from, if it were to take part of the keyword
>> expansion, would come out incorrectly in his printed svg
>> drawing.
>
> this is part of the rope you are handing out. the external tool could
> do a lot of things that don't make sense. you could have the tool
> include the serial number of the cpu you happen to be running on at
> the moment, it wouldn't make sense to do this, but it could be
> done. the fact that the rope could be used to hang someone doesn't
> mean that you should outlaw rope.

I do not think you understand, especially after reading the part
you say "Andy and I both...".

The point of my comment was that with Andy's definition of when
the "external tools" should trigger, that CPU serial number
embedder would _NOT_ trigger for a path when you switch branches
that have the same contents at that path.  External tools can do
stupid things and that is what you are calling the rope.  But
the case I am talking about is that we deliberately do _not_
call external tools, so even if external tools can do sensible
things if given a chance to, they are not given a chance to do
so, and deciding not to call them in some cases is made by us.
I think that's different from "we gave you rope, you hang
yourself and that is not our problem".

People have every right to say "if you consistently call these
external tools, they behave sensibly, but you only call them
when you choose, and that is where the idiocy is coming from".
How would you respond to that?
