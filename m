From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitk: UTF-8 support
Date: Wed, 23 Nov 2005 22:23:24 -0800
Message-ID: <7v1x16y36r.fsf@assigned-by-dhcp.cox.net>
References: <1132719301.12227.5.camel@dv>
	<7v64qi50sw.fsf@assigned-by-dhcp.cox.net>
	<20051123235315.oht0zjidc4ccg8gs@webmail.spamcop.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 24 07:27:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfAW1-0007Yh-6F
	for gcvg-git@gmane.org; Thu, 24 Nov 2005 07:23:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161017AbVKXGX0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Nov 2005 01:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161018AbVKXGX0
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Nov 2005 01:23:26 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:60863 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1161017AbVKXGXZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Nov 2005 01:23:25 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051124062211.GUQL17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 24 Nov 2005 01:22:11 -0500
To: Pavel Roskin <proski@gnu.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12679>

Pavel Roskin <proski@gnu.org> writes:

> Then what would you do to work with a repository using utf-8 if the current
> locale is not utf-8?

Obviously the same way as I did to try things out:

	$ LANG=en_US.utf8 DISPLAY=:0 gitk blah

> Anyway, I see your point.  Not ever git repository uses utf-8.  It is not
> enforced by git.

That is not the point.  Point is that I think the user can use
LANG and LC_ALL (I suspect LC_CTYPE is what matters) to get what
you want, and I suspect hardcoding utf8 robs users the
possibility to deal with a repository that uses something else.

And as I suggested in another message (in the died-out thread
about gitweb), we could have i18n.commitEncoding in the
configuration to help gitk and gitweb.  I think that is the same
as your "other option".
