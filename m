From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Shell utilities: Guard against expr' magic tokens.
Date: Thu, 13 Apr 2006 16:39:49 -0700
Message-ID: <7vodz5vyd6.fsf@assigned-by-dhcp.cox.net>
References: <slrne3tihk.1dq.mdw@metalzone.distorted.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 14 01:40:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUBPn-00032Q-6j
	for gcvg-git@gmane.org; Fri, 14 Apr 2006 01:39:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965051AbWDMXjw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Apr 2006 19:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965050AbWDMXjw
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Apr 2006 19:39:52 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:42489 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S965051AbWDMXjv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Apr 2006 19:39:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060413233950.UBXZ24539.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 13 Apr 2006 19:39:50 -0400
To: Mark Wooding <mdw@distorted.org.uk>
In-Reply-To: <slrne3tihk.1dq.mdw@metalzone.distorted.org.uk> (Mark Wooding's
	message of "Thu, 13 Apr 2006 22:01:24 +0000 (UTC)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18680>

Mark Wooding <mdw@distorted.org.uk> writes:

> From: Mark Wooding <mdw@distorted.org.uk>
>
> Some words, e.g., `match', are special to expr(1), and cause strange
> parsing effects.  Track down all uses of expr and mangle the arguments
> so that this isn't a problem.

Gaaaaaaaaaah.  

    http://www.opengroup.org/onlinepubs/009695399/utilities/expr.html

says use of length, substr, index, match as string arguments
produces unspecified results, so obviously the program was
wrong.

Thanks.
