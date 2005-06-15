From: Paul Mackerras <paulus@samba.org>
Subject: Re: reducing line crossings in gitk
Date: Wed, 15 Jun 2005 21:18:35 +1000
Message-ID: <17072.3723.242985.824999@cargo.ozlabs.ibm.com>
References: <17066.53047.660907.453399@cargo.ozlabs.ibm.com>
	<7v8y1gvjfz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 15 13:15:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DiVqT-0007zm-Rg
	for gcvg-git@gmane.org; Wed, 15 Jun 2005 13:14:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261412AbVFOLTJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Jun 2005 07:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbVFOLTJ
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jun 2005 07:19:09 -0400
Received: from ozlabs.org ([203.10.76.45]:3790 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261418AbVFOLSo (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Jun 2005 07:18:44 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 1441467B17; Wed, 15 Jun 2005 21:18:41 +1000 (EST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v8y1gvjfz.fsf@assigned-by-dhcp.cox.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano writes:

>  - What support from the core GIT side would you need if you
>    wanted to let users browse a remote repo?  A way to inspect
>    what is under ".git/refs/" hierarchy on the remote side?
>    Anything else?

I would need git-rev-list, git-cat-file, and git-diff-tree to be able
to operate on the remote repository.

>  - Pasting into the SHA1 field to "Go To" was a nuisance when
>    the field already had a string in it.  Clearing the SHA1
>    field when focus gets in would be one way to solve it, but
>    then you would lose the way to pasting out of that field, so
>    I do not know what to suggest offhand.

I could rebind the middle mouse button to replace the contents of the
sha1 field with the selection instead of inserting it.

>  - How do I "Find" backwards?  Not being able to find a way to
>    do this was the most annoying thing for me.

The "?" key is bound to find backwards (i.e. select previous match)
and the "/" key is bound to find forwards (select next match).  I
don't have a button for find backwards (and I'd rather not clutter it
up by adding one, but maybe I could add a menu item for it).

>  - After typing something in "Find" and hitting <ENTER>, if the
>    focus stays in it and lets me hit <ENTER> again to go to the
>    next one would be nicer.  Somehow hitting <ENTER> again would
>    not do this for me right now.

Hmmm, if the focus stays in the find field then you can't use "?", up,
down, etc.  I could make <enter> do find-next if you like.

>  - Indicaing "Find" wrapping around without annoying the user
>    too much (i.e. I do _not_ want you to add "Find reached the
>    beginning of time, wrapping around and continuing from the
>    top" pop-up window) would be nicer.  Currently I can tell by
>    looking at the scrollbar on the history pane jumping back, so
>    this is not a big issue, though.

I could make it beep - how about that?

>  - Can I have a way to "Find" next commit that touches a given
>    pathname?
> 
>     $ git-rev-list | git-diff-tree -s -r --stdin '<that pathname>'
> 
>    which would give you a sequence of lines that look like:
>        "commit-SHA1 (from parent-commit-SHA1)"
> 
>    you would pick the commit-SHA1 from the output and jump to it.

Interesting idea... I could add a "Path" entry to the find type menu.

>  - In addition to "Find" which looks at the commit message, can I
>    have one that uses pickaxe to find changes?
> 
>  - Can I have an option to use diffcore options to tweak the
>    diff that is shown in the lower-left pane?

Also interesting ideas, I'll see what I can do.

Regards,
Paul.
