From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC, PATCH] A new merge algorithm (EXPERIMENTAL)
Date: Fri, 26 Aug 2005 18:08:33 -0700
Message-ID: <7vk6i89ofi.fsf@assigned-by-dhcp.cox.net>
References: <20050826184731.GA13629@c165.ib.student.liu.se>
	<Pine.LNX.4.58.0508261730480.3317@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 27 03:09:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8pBb-0001Ls-5F
	for gcvg-git@gmane.org; Sat, 27 Aug 2005 03:08:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965190AbVH0BIg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Aug 2005 21:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965189AbVH0BIg
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Aug 2005 21:08:36 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:47600 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S965188AbVH0BIg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2005 21:08:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050827010835.QOUA550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 26 Aug 2005 21:08:35 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508261730480.3317@g5.osdl.org> (Linus Torvalds's
	message of "Fri, 26 Aug 2005 17:38:21 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7830>

Linus Torvalds <torvalds@osdl.org> writes:

> On Fri, 26 Aug 2005, Fredrik Kuivinen wrote:
>>
>> In real numbers it is as follows: In Linus' kernel tree there are
>> 5996 commits. 400 of those have more than one parent. Of those 400
>> merge commits 4 have more than one shared head.
>
> Ok, that's already interesting in itself. I was wanting to re-run all the 
> merges with the new "git-merge-base -a" to see which merges might have had 
> different merge bases, and you've actually done that. Interesting to see 
> the numbers.

Fredrik, mind giving us the commit ID of those four for us to
take a look at them?

> I am of two minds on this. I hate the notion of a more complex merge. But
> at the same time, it clearly is a very interesting case when we do have
> multiple possible shared parents, and I think that at the very least we
> should warn the user. And using a more complex merge algorithm when it
> happens seems to be a very valid thing to do.

I agree.  GIT is lightening fast for trivial cases and we can
afford to spend more time to handle more complex ones carefully,
at the same time telling the user what we are doing is a good thing.

> Using python, which people have less exposure to, sounds like an 
> additional thorny issue..

Not too big a problem for me to follow the patch ;-).
