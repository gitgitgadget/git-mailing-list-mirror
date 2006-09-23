From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Kill git-resolve.sh
Date: Sat, 23 Sep 2006 15:12:01 -0700
Message-ID: <7v64fensge.fsf@assigned-by-dhcp.cox.net>
References: <20060923195530.5570.23774.stgit@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 24 00:12:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRFjH-00067W-FE
	for gcvg-git@gmane.org; Sun, 24 Sep 2006 00:12:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbWIWWME (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Sep 2006 18:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWIWWME
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 18:12:04 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:49301 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1750775AbWIWWMD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Sep 2006 18:12:03 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060923221201.JDSQ16798.fed1rmmtao09.cox.net@fed1rmimpo01.cox.net>;
          Sat, 23 Sep 2006 18:12:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id RyC01V00J1kojtg0000000
	Sat, 23 Sep 2006 18:12:00 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060923195530.5570.23774.stgit@machine.or.cz> (Petr Baudis's
	message of "Sat, 23 Sep 2006 21:55:30 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27633>

Petr Baudis <pasky@suse.cz> writes:

> Seriously, is anyone still using this thing? It's collecting dust and
> blocking the name for something potentially useful like a tool for
> user-friendly marking of resolved conflicts or resolving index conflicts.
>
> We've loved you when Git was young, now thank you and please go away. ;-)
>
> Signed-off-by: Petr Baudis <pasky@suse.cz>

I've always wanted to do this at some point.  Perhaps add a big
red warning to git-resolve.sh right now and say "after the next
'master' release this will go away" to its stdout for a few
weeks to find out who screams?

On a very related note, we should prepare plan to deprecate
merge-recursive.py.  My preference is:

	(1) rename merge-recursive.py to merge-recursive-old.py,
	    make it available as "recursive-old" strategy.

            install git-merge-recur as git-merge-recursive.
            Calling for "recur" or "recursive" strategy gets the
            same thing from this point on.

	(2) remove merge-recur synonym once people who are using
            "USE_RECUR_FOR_RECURSIVE" or "merge.twohead = recur"
            to use the bleeding edge migrate.

and I think step (1) can happen fairly soon.  Maybe immediately
after the next release from the "master".

Perhaps that is the good timing to remove git-resolve.sh as
well.  Or maybe immediately before that release?  I dunno, and I
do not think anybody cares really much.
