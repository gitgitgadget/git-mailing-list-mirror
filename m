From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-cvsimport "you may need to merge manually"
Date: Thu, 16 Mar 2006 18:43:43 -0800
Message-ID: <7vu09x7puo.fsf@assigned-by-dhcp.cox.net>
References: <86veud23v0.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Mar 17 03:43:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FK4wO-0004AF-MD
	for gcvg-git@gmane.org; Fri, 17 Mar 2006 03:43:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751024AbWCQCnq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Mar 2006 21:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751017AbWCQCnp
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Mar 2006 21:43:45 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:38859 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750794AbWCQCnp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Mar 2006 21:43:45 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060317024217.DYWG15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 16 Mar 2006 21:42:17 -0500
To: git@vger.kernel.org
In-Reply-To: <86veud23v0.fsf@blue.stonehenge.com> (Randal L. Schwartz's
	message of "16 Mar 2006 18:37:39 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17652>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

> Starting recently, git-cvsimport has always ended with "you
> may need to merge manually".  Why?  It worked before.  What
> is it doing now?
>
>     $ cd /home/merlyn/Git/stonehenge.git || exit 1
>     $ git-cvsimport -v -k -o master -d /web/cvs stonehenge
>     .
>     .
>     .
>     skip patchset 323: 1142297290 before 1142351976
>     Fetching htdocs/courses.html   v 1.4
>     Update htdocs/courses.html: 8767 bytes
>     Fetching htdocs/rates.html   v 1.2
>     Update htdocs/rates.html: 2043 bytes
>     Tree ID 38280334da5eaa4fd80fe1011e63db4b527f1d13
>     Parent ID e93de754181fe963b8623423f509540021caead0
>     Committed patch 324 (master 2006-03-16 18:14:31)
>     Commit ID 985ca72d4e8a07d4189794231f035bac63c9e91d
>     DONE; you may need to merge manually.
>     $ git-status
>     #
>     # Updated but not checked in:
>     #   (will commit)
>     #
>     #       modified: htdocs/courses.html
>     #       modified: htdocs/rates.html
>     #
>
> Right... why didn't it commit those?  I'm having to issue "fake"
> commits now, so I've lost the cvs-log comments that were formerly
> very complete and cool.

I do not use cvsimport but I wonder what Commit ID 985ca7
contains.  Can you try "git show 985ca7" and see if that is the
commit you want?

Also, which branch are you on when you run git-cvsimport, and
which branch did the commit 985ca7 go?  I suspect it is storing
the tip commit 985ca7 to a branch that you are _not_ on
currently, but refraining from merging that to your current
branch, or something like that.
