From: Junio C Hamano <junkio@cox.net>
Subject: Re: gitk shows an empty line between "Comments" and changed files
Date: Fri, 28 Oct 2005 02:13:04 -0700
Message-ID: <7v4q72xavz.fsf@assigned-by-dhcp.cox.net>
References: <1130434230.19641.21.camel@dv>
	<7vslum3l2w.fsf@assigned-by-dhcp.cox.net>
	<1130463389.2186.14.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 28 11:15:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVQIQ-0004Ql-8e
	for gcvg-git@gmane.org; Fri, 28 Oct 2005 11:13:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965186AbVJ1JNG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Oct 2005 05:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965191AbVJ1JNG
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Oct 2005 05:13:06 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:12283 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S965186AbVJ1JNF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2005 05:13:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051028091244.SZDB9394.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 28 Oct 2005 05:12:44 -0400
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <1130463389.2186.14.camel@dv> (Pavel Roskin's message of "Thu, 27
	Oct 2005 21:36:29 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10762>

Pavel Roskin <proski@gnu.org> writes:

> git-patch-id is only used by git-cherry.  git-cherry writes the second
> SHA1 to some files in a temporary directory, but it never reads those
> files, it only checks that they exist.

I do not oppose dropping the commit-id line from the default
output, but having it optionally available would be useful in
one application.  Somebody _could_ write a tool that does
something like:

    git-rev-list ^$old_head $new_head |
    git-diff-tree -p -m --stdin --with-commit-ids |
    git-patch-id

to cache the patch-id --> commit-id mappings.  If this were kept
on the upstream repo for public query, it would be useful for
you to find out if your favorite patch as already been merged.
For example, gitweb could have an query page to let you submit a
patch-id and return the commit (or "no such patch merged yet").
