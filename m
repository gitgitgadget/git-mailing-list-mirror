From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-name-rev off-by-one bug
Date: Wed, 30 Nov 2005 14:00:31 -0800
Message-ID: <7vy835okxs.fsf@assigned-by-dhcp.cox.net>
References: <20051128234256.1508.qmail@science.horizon.com>
	<7vhd9wngn6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511301235390.25300@iabervon.org>
	<7vsltdsxzb.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511301514500.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 30 23:04:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eha0J-0002Uz-Ir
	for gcvg-git@gmane.org; Wed, 30 Nov 2005 23:00:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbVK3WAe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 Nov 2005 17:00:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751041AbVK3WAd
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Nov 2005 17:00:33 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:33021 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751036AbVK3WAd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2005 17:00:33 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051130215918.XUVQ26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 30 Nov 2005 16:59:18 -0500
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0511301514500.25300@iabervon.org> (Daniel
	Barkalow's message of "Wed, 30 Nov 2005 16:06:39 -0500 (EST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13019>

Daniel Barkalow <barkalow@iabervon.org> writes:

> I actually had that problem with the original tables; there isn't a 
> canonical order in which to list a table of all of the possible matches 
> and non-matches between items so as to be complete.
>
> Perhaps it ought to list, on each line, which previous cases would match, 
> so that you could see that case 2 is really the conditions of 2 minus the 
> conditions for 2ALT, which is "all of the ancestors are empty, the head 
> has a directory/file conflict, and remote exists."

Sorry, I was not clear about it when I did that table the first
time.  2ALT was "alternatives suggested to replace 2" and listed
in the same table for comparison purpose.

The original table was designed in a way that if you have a
match on case N, there would not be any other case M that matches
the case, either N<M or M<N.  IOW, the order to read the table
did not matter.  At least that was the intention.

If you read "missing" = 0, "exists" = 1, and take OAB as bit2,
bit1, and bit0, you can easily see the pattern in the table.  It
counts in binary, although bit1 has various subcases so the
table has more than 8 rows, and it is easy to see it covers all.

> "If the index exists, it is an error for it not to match either the
>  head or (if the merge is trivial) the result."
>
> "A result of "no merge" is an error if the index is not empty and not
>  up-to-date."

That is good.

> Certainly, your complaints about the table should be addressed first. I 
> think I'd addressed all your complaints from last time, but at that point, 
> we got sidetracked into a discussion of the details of case #16.

... which was a good thing to think about in itself.  I feel I
understand the new table a bit better.
