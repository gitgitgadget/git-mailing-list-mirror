From: Junio C Hamano <junkio@cox.net>
Subject: Re: as promised, docs: git for the confused
Date: Fri, 09 Dec 2005 11:12:29 -0800
Message-ID: <7vzmna2ig2.fsf@assigned-by-dhcp.cox.net>
References: <20051209094328.GT22159@pasky.or.cz>
	<20051209140123.3234.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 09 20:15:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EknfZ-0001Dy-Fs
	for gcvg-git@gmane.org; Fri, 09 Dec 2005 20:12:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932412AbVLITMe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Dec 2005 14:12:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbVLITMe
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Dec 2005 14:12:34 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:16581 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751292AbVLITMd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2005 14:12:33 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051209191047.LVDR17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 9 Dec 2005 14:10:47 -0500
To: linux@horizon.com
In-Reply-To: <20051209140123.3234.qmail@science.horizon.com>
	(linux@horizon.com's message of "9 Dec 2005 09:01:23 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13432>

linux@horizon.com writes:

> "I want to do X and Y but not Z.  What commands are worth knowing?"
>
> I have 106 git-* commands available to me (my document covers 105;
> I'll have to find the extra), and the biggest question I have is
> "how many of those man pages can I get away with NOT reading?"

This primarily comes from the way git is architected.  We have
many commands that are not so interesting from the end-user
perspective.  If git were architected differently, many of them
may not exist in executable command form, but would instead be
library functions and listed in section 3git of the manual.

> Heck, that categorized list is what I started out writing, and I happen
> to think it's the most important part of the whole document.

And I think I agree it but with a twist.  The full listing for
Porcelain writers is mostly fine as is in git(7); maybe what you
wrote have clarification material, in which case I'd appreciate
a patch to Documentation/git.txt.

What we need is a separate list aimed for end users, and
somebody looking only at that list should be able to do
day-to-day work with only the commands listed there, and does
not even have to know something called rev-parse or merge-base
exist.

A good start for this list would be the list of selected
commands git.sh used to show (these days, git.c wrapper shows
everything that starts with "git", but the old one limited
itself to show only the ones that may be useful by the
end-user).

> The man page tells me HOW to execute a command.  But before I'm ready for
> that level of detail, I need to figure out WHICH command to execute.

Exactly.  The tutorial can also use a minor split.  It starts
out to give taste of internal workins of Porcelains, but ends up
being a fuzzy mix of "user manual" and "hints to porcelain
writers".  We probably should have a separate "end user
tutorial" --- the Alice-Bob scenario by Horst might be a good
place to start.
