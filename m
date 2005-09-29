From: Junio C Hamano <junkio@cox.net>
Subject: Re: [howto] Kernel hacker's guide to git, updated
Date: Thu, 29 Sep 2005 14:04:46 -0700
Message-ID: <7virwjegb5.fsf@assigned-by-dhcp.cox.net>
References: <433BC9E9.6050907@pobox.com> <20050929200252.GA31516@redhat.com>
	<433C4B6D.6030701@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 29 23:06:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EL5aX-0003ny-Hw
	for gcvg-git@gmane.org; Thu, 29 Sep 2005 23:05:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbVI2VEs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Sep 2005 17:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbVI2VEs
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Sep 2005 17:04:48 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:21689 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751330AbVI2VEs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2005 17:04:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050929210444.XSUS29333.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 29 Sep 2005 17:04:44 -0400
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <433C4B6D.6030701@pobox.com> (Jeff Garzik's message of "Thu, 29
	Sep 2005 16:15:41 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9508>

Jeff Garzik <jgarzik@pobox.com> writes:

> Nope.  It intentionally includes the manual rsync because clone/pull 
> doesn't seem to grab tags.  Or at least last time I checked...

clone does (or should), fetch (and hence pull) does not
automatically.  Running the following one-liner every once in a
while would sync your set of tags with Linus:

git fetch origin `git-ls-remote --tags origin | sed -ne 's|^.*refs/tags/|tag |p'`
