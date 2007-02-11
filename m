From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-pull and tag objects
Date: Sun, 11 Feb 2007 11:17:27 -0800
Message-ID: <7vire8ec6w.fsf@assigned-by-dhcp.cox.net>
References: <1170933407.15431.38.camel@okra.transitives.com>
	<81b0412b0702090133qa4eb0c0v6a2d309fe9653a3f@mail.gmail.com>
	<7v4ppurka1.fsf@assigned-by-dhcp.cox.net>
	<20070210142322.GB25607@thunk.org>
	<Pine.LNX.4.64.0702100938540.8424@woody.linux-foundation.org>
	<7vy7n5gs0y.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0702110948120.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Tso <tytso@mit.edu>, Alex Riesen <raa.lkml@gmail.com>,
	Alex Bennee <kernel-hacker@bennee.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Feb 11 20:17:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGKCf-00046E-V4
	for gcvg-git@gmane.org; Sun, 11 Feb 2007 20:17:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbXBKTR3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 14:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbXBKTR3
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 14:17:29 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:34880 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785AbXBKTR3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 14:17:29 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070211191728.WXME21177.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Sun, 11 Feb 2007 14:17:28 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id NKHU1W0051kojtg0000000; Sun, 11 Feb 2007 14:17:28 -0500
In-Reply-To: <Pine.LNX.4.64.0702110948120.8424@woody.linux-foundation.org>
	(Linus Torvalds's message of "Sun, 11 Feb 2007 09:49:21 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39302>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sat, 10 Feb 2007, Junio C Hamano wrote:
>> 
>> Although it is correct that the people who already saw the
>> original tag would not lose the tag object from their repository
>> when you publish a replacement tag, we have _always_ overwritten
>> the refs/tags/$tag to point at the new one, effectively losing
>> the original.
>> 
>> * 0a623e7c (Jul 5, 2005)
>> In this version "git fetch $repo tag v2.6.13" would have done just
>> 
>> 	echo "$head" >"$GIT_DIR/$destination"
>> 
>> without checking if it already existed.
>
> Yes, but only if you actually explicitly asked for it, methinks.
>
> If you just do a "git pull", it won't do it.
>
> So I think it's ok. 

Well, what you are saying is that it used to be Ok in Jul 5 2005
version but with tag following it is not Ok anymore, isn't it?
