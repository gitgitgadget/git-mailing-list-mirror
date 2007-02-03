From: Junio C Hamano <junkio@cox.net>
Subject: Re: Why is it bad to rewind a branch that has already been pushed out?
Date: Sat, 03 Feb 2007 11:42:13 -0800
Message-ID: <7vy7nf3u5m.fsf@assigned-by-dhcp.cox.net>
References: <7v1wl7bv66.fsf@assigned-by-dhcp.cox.net>
	<200702031041.13437.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 03 20:42:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDQm8-0003aQ-6H
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 20:42:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbXBCTmP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 14:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbXBCTmP
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 14:42:15 -0500
Received: from fed1rmmtai14.cox.net ([68.230.241.45]:52319 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751346AbXBCTmO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 14:42:14 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070203194214.URLQ4586.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Sat, 3 Feb 2007 14:42:14 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id K7iD1W00h1kojtg0000000; Sat, 03 Feb 2007 14:42:13 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38588>

Andy Parkins <andyparkins@gmail.com> writes:

> In the following I've assumed that both "h" and "a" commits are 
> independent work, neither of which works on "j" (which isn't quite what 
> you described).  It's not really appropriate for the tutorial, so I 
> haven't really helped you.
> ...
>> (4) Alice pulls from me again:
>>
>> 	---o---o---o---j---a---a---*
>>                   \             /
>>                    h---h---h---h
>>
>> Contrary to the description, git will happily have Alice merge
>> between the two branches, and never gets confused.
>
> The problem is not that the working tree is wrong, it is that the 
> history is wrong.  This sequence of development isn't best represented 
> by a merge.  When we look at the history later, we'll see it as two 
> branches, but that isn't true.
>
> The graph shows that "j" was committed and then probably conflicted 
> in "*" and fixed.  The problem is that you can't point to any non-merge 
> commit that reverted/corrected "j" and explains why that wasn't a good 
> idea - so the "story" that the history tells us is incomplete.  The 
> correction was done just as a conflict resolution in "*".

Actually, if you are assuming a, h, and j are unrelated, then
the merge done by Alice will _not_ revert 'j', so the history
will perfectly be fine.  The merge result will have a half-baked
work done with 'j', and everybody can build on top of.
