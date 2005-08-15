From: Junio C Hamano <junkio@cox.net>
Subject: Re: Switching heads and head vs branch after CVS import
Date: Sun, 14 Aug 2005 17:40:15 -0700
Message-ID: <7vmznkav80.fsf@assigned-by-dhcp.cox.net>
References: <46a038f905081417241f9598cc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 15 02:41:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4T1j-0005hi-MO
	for gcvg-git@gmane.org; Mon, 15 Aug 2005 02:40:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932613AbVHOAkS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 Aug 2005 20:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932614AbVHOAkS
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Aug 2005 20:40:18 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:2231 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932613AbVHOAkR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2005 20:40:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050815004016.FVOL25443.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 14 Aug 2005 20:40:16 -0400
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f905081417241f9598cc@mail.gmail.com> (Martin Langhoff's
	message of "Mon, 15 Aug 2005 12:24:30 +1200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Martin Langhoff <martin.langhoff@gmail.com> writes:

> After having done a cvs import of Moodle using git-cvsimport-script
> all the cvs branches show up as heads. How do I switch heads within a
> checkout? cogito doesn't seem to be able to, and I'm unsure on how to
> do it with git.

The documentation may be quite sketchy on this front.

I do not speak for Pasky, so Cogito may treat them a little
differently, but at the core GIT level, you can treat branches
and heads synonymously.

What you have recorded in .git/refs/heads/frotz file is the SHA1
object name of the commit that is at the top of "frotz" branch.
When your .git/HEAD symlink points at refs/heads/nitfol, your
working tree is said to be on "nitfol" branch.

You switch branches by using "git checkout".  You can create a
new branch using "git checkout -b newbranch commit-id".  You
examine which branch you are on by "readlink .git/HEAD".  As you
already found out, you can merge branches with "git resolve
master other-branch 'comment'".  The last one is briefly covered
by the tutorial.
