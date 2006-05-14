From: Junio C Hamano <junkio@cox.net>
Subject: Re: Tracking branch history
Date: Sun, 14 May 2006 16:16:54 -0700
Message-ID: <7vfyjc19jt.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0605121838490.6713@iabervon.org>
	<loom.20060513T140528-554@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon May 15 01:17:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfPpb-0004mo-Ua
	for gcvg-git@gmane.org; Mon, 15 May 2006 01:17:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbWENXQ5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 May 2006 19:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbWENXQ4
	(ORCPT <rfc822;git-outgoing>); Sun, 14 May 2006 19:16:56 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:36264 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751393AbWENXQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 May 2006 19:16:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060514231655.UAV17501.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 14 May 2006 19:16:55 -0400
To: git@vger.kernel.org
In-Reply-To: <loom.20060513T140528-554@post.gmane.org>
	(elrond+kernel.org@samba-tng.org's message of "Sat, 13 May 2006
	12:53:14 +0000 (UTC)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19990>

Elrond <elrond+kernel.org@samba-tng.org> writes:

> Daniel Barkalow <barkalow <at> iabervon.org> writes:
>
>> 
>> One feature that might make git more intuitive to people is if we were to 
>> additionally track the history of what commit was the head of each branch 
>> over time. This is only vaguely related to the history of the content, but 
>> it's well-defined and sometimes significant.
>> 
>> E.g., if you know that two weeks ago, what you had worked, but it doesn't 
>> work now, you can use git-bisect to figure out what happened, but first 
>> you have to figure out what commit it was that you were using two weeks 
>> ago. Two weeks ago, we had that information, but we didn't keep it.
>
> On a related issue:
>
> Looking at a commit:
>    commit id-commit
>    parent id-1
>    parent id-2
>    parent id-3
>
>        Merge branch 'branch-2', 'branch-3'
>
> One can tell the name of the branches for id-2 and id-3 (branch-2, 3),
> but one can't tell the name of id-1.

That's deliberate.  If you are merging into a branch other than
"master", the message would say:

        commit ea892b27b15fbc46a3bb3ad2ddce737dc6590ae5
        Merge: 7278a29... 8d48ad6...
        Author: Junio C Hamano <junkio@cox.net>
        Date:   Sat May 13 18:49:54 2006 -0700

            Merge branch 'lt/config' into next

            * lt/config:
              git config syntax updates
              Another config file parsing fix.
              checkout: use --aggressive when running a 3-way merge (-m).
              Fix git-pack-objects for 64-bit platforms
              fix diff-delta bad memory access

The point is to keep the punch line as short and meaningful for
the most common case.
