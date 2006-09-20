From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: Fix showing of path in tree view
Date: Wed, 20 Sep 2006 16:32:42 -0700
Message-ID: <7vpsdqdsh1.fsf@assigned-by-dhcp.cox.net>
References: <20060920231224.GN13132@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 21 01:33:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQBYl-0005wn-2d
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 01:32:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWITXco (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 19:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbWITXco
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 19:32:44 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:45533 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1750712AbWITXcn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Sep 2006 19:32:43 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060920233242.UTAD2704.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>;
          Wed, 20 Sep 2006 19:32:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id QnYU1V00Q1kojtg0000000
	Wed, 20 Sep 2006 19:32:29 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060920231224.GN13132@pasky.or.cz> (Petr Baudis's message of
	"Thu, 21 Sep 2006 01:12:24 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27430>

Petr Baudis <pasky@suse.cz> writes:

> This patch fixes two things - links to all path elements except the last
> one were broken since gitweb does not like the trailing slash in them, and
> the root tree was not reachable from the subdirectory view.
>
> To compensate for the one more slash in the front, the trailing slash is
> not there anymore. ;-) I don't care if it stays there though.

Hmph.  I see the breakage and behaviour-wise your patch is fine.

But I think the older one was visually nicer and more intuitive
in one very small detail that I think matters.  Slashes between
path components were not part of the anchor elements, so it was
clear that there were two links in "gitweb / gitweb.perl" page
title, not just one link.  Now it is not obvious that clicking
different parts of the path string in "/stgit/commands/mail.py"
would lead to different places.  And as you are aware, losing
the leading "/" would be nicer as well ;-).
