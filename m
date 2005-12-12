From: Junio C Hamano <junkio@cox.net>
Subject: Re: patches between commits
Date: Mon, 12 Dec 2005 09:54:45 -0800
Message-ID: <7vu0dei4ka.fsf@assigned-by-dhcp.cox.net>
References: <7ac1e90c0512120731g3eacdcf0s7e9d1226c88dce73@mail.gmail.com>
	<20051212173352.GA3007@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 12 18:55:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Elrt1-0006xK-IZ
	for gcvg-git@gmane.org; Mon, 12 Dec 2005 18:54:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbVLLRyu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Dec 2005 12:54:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932087AbVLLRyu
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Dec 2005 12:54:50 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:15064 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932086AbVLLRyu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2005 12:54:50 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051212175303.JJV17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 12 Dec 2005 12:53:03 -0500
To: Alex Riesen <raa.lkml@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13529>

Alex Riesen <raa.lkml@gmail.com> writes:

> Bahadir Balban, Mon, Dec 12, 2005 16:31:12 +0100:
>> Suppose I have a HEAD branch, which is the latest. And I want to
>> generate `individual' patches for each commit I did since the
>> beginning of development for this branch.
>
> That is what I think "git format-patch <commit>" is for. It will
> generate patches to bring "<commit>" to HEAD.

Yes, but I think the real question Bahadir wants to know is what
the <commit> parameter should be, if you want to export the
whole history (I do not think there is any suitable argument to
"format-patch" that does this).

>> Secondly, is the sha1 of a tree what appears next to each commit when
>> I type git-log? Is this the only command that lets us know the sha1's
>> of commits?

Depends on what you have, to ask the question "what are their
object names?".

 - I have this commit, how do I find out its object name?
   E.g. I want to know the HEAD commit's object name, second to
   the last commit on "test" branch.

   $ git rev-parse --verify HEAD
   $ git rev-parse --verify test^

 - I have bunch of commits leading to the head of my "test"
   branch.  What are they?

   $ git rev-list test ;# unadorned list of object names and nothing else
   $ git rev-list --pretty test ;# this is git-log
   $ git whatchanged -m -M -p test ;# with patch in full glory
