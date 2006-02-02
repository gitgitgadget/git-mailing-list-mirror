From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC & PATCH] Solaris 8: ENOSYS when mkdir applied to automount.
Date: Wed, 01 Feb 2006 16:46:02 -0800
Message-ID: <7vwtge37w5.fsf@assigned-by-dhcp.cox.net>
References: <24768.1138840762@lotus.CS.Berkeley.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 02 01:46:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4Sbw-0006gL-8Y
	for gcvg-git@gmane.org; Thu, 02 Feb 2006 01:46:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751503AbWBBAqF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 19:46:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751505AbWBBAqE
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 19:46:04 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:13221 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751503AbWBBAqD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2006 19:46:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060202004433.POGK20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 1 Feb 2006 19:44:33 -0500
To: Jason Riedy <ejr@EECS.Berkeley.EDU>
In-Reply-To: <24768.1138840762@lotus.CS.Berkeley.EDU> (Jason Riedy's message
	of "Wed, 01 Feb 2006 16:39:22 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15472>

Jason Riedy <ejr@EECS.Berkeley.EDU> writes:

> I guess our home directories recently were changed from symlinks
> to autmounts.  Solaris 8's mkdir(2) returns ENOSYS when applied
> to these, breaking safe_create_leading_directories.  I don't
> know if ENOSYS is available everywhere, or if this odd behavior
> is appropriate everywhere.
>
> This works for me, but should I wrap mkdir for bizarre behavior
> by adding a compat/gitmkdir.c?

There was a similar patch for working around Cygwin that threw
different errno in an earlier thread:

    From: Alex Riesen <raa.lkml@gmail.com>
    Subject: [PATCH] Set errno to EEXIST if mkdir returns EACCES or EPERM

Somehow I started to trust your ability to code portably a lot
better than I trust myself, so please first disregard the
suggestion I gave in that thread and give me your honest opinion
on what the right fix/workaround would be.
