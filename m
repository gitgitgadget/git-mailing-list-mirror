From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/3] daemon: Set SO_REUSEADDR on listening sockets.
Date: Fri, 03 Feb 2006 12:57:07 -0800
Message-ID: <7vmzh8cg9o.fsf@assigned-by-dhcp.cox.net>
References: <20060203202330.1895.60474.stgit@metalzone.distorted.org.uk>
	<20060203202704.1895.18383.stgit@metalzone.distorted.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 03 21:57:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F57zs-0008Us-PC
	for gcvg-git@gmane.org; Fri, 03 Feb 2006 21:57:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945958AbWBCU5K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Feb 2006 15:57:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945960AbWBCU5K
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Feb 2006 15:57:10 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:56272 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1945958AbWBCU5I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2006 15:57:08 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060203205545.BOHX6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 3 Feb 2006 15:55:45 -0500
To: Mark Wooding <mdw@distorted.org.uk>
In-Reply-To: <20060203202704.1895.18383.stgit@metalzone.distorted.org.uk>
	(Mark Wooding's message of "Fri, 03 Feb 2006 20:27:04 +0000")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15554>

Mark Wooding <mdw@distorted.org.uk> writes:

> From: Mark Wooding <mdw@distorted.org.uk>
>
> Without this, you can silently lose the ability to receive IPv4
> connections if you stop and restart the daemon.
>
> Signed-off-by: Mark Wooding <mdw@distorted.org.uk>

I've always wanted to ask HPA and Linus about this why we did
not do SO_REUSEADDR.  I've seen some non-git servers also not
using it, giving me an excuse to take a coffee break during work
;-).  Is it because they predate REUSEADDR, or is there a valid
reason to avoid using REUSEADDR under certain conditions?
