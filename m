From: Junio C Hamano <junkio@cox.net>
Subject: Re: A look at some alternative PACK file encodings
Date: Wed, 06 Sep 2006 18:11:20 -0700
Message-ID: <7v1wqo5vlz.fsf@assigned-by-dhcp.cox.net>
References: <44FF41F4.1090906@gmail.com>
	<9e4733910609061623k73086dbey4a600ecf2852c024@mail.gmail.com>
	<Pine.LNX.4.64.0609062037560.18635@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 07 03:11:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GL8QM-00062u-QV
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 03:11:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161058AbWIGBLN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 21:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161059AbWIGBLN
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 21:11:13 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:54268 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1161058AbWIGBLL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Sep 2006 21:11:11 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060907011111.OXK12909.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>;
          Wed, 6 Sep 2006 21:11:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id KDBB1V01i1kojtg0000000
	Wed, 06 Sep 2006 21:11:12 -0400
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0609062037560.18635@xanadu.home> (Nicolas Pitre's
	message of "Wed, 06 Sep 2006 20:40:40 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26584>

Nicolas Pitre <nico@cam.org> writes:

> On Wed, 6 Sep 2006, Jon Smirl wrote:
>
>> Shawn is doing some prototype work on true dictionary based
>> compression. I don't know how far along he is but it has potential for
>> taking 30% off the Mozilla pack.
>
> BTW I'm half-way done with support for deltas which base object is 
> referenced with an offset in the pack instead of a hash.  It is quite 
> messy though since it touches pretty core code all over the place when 
> it comes to fetching objects out of a pack.

I wonder how you made unpack-objects to work with it.  Do you
store an extra bit in the packed stream to say "this object will
be used as a delta base for later objects so remember its offset
and resulting SHA1", or do you just remember every entry as you
unpack?
