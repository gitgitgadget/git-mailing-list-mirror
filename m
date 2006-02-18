From: Junio C Hamano <junkio@cox.net>
Subject: Re: Why can't git-rebase back up?
Date: Fri, 17 Feb 2006 23:39:21 -0800
Message-ID: <7vmzgpru8m.fsf@assigned-by-dhcp.cox.net>
References: <20060217135938.7412.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 18 08:39:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FAMgv-0005we-NW
	for gcvg-git@gmane.org; Sat, 18 Feb 2006 08:39:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbWBRHjX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Feb 2006 02:39:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750978AbWBRHjX
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Feb 2006 02:39:23 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:33508 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1750887AbWBRHjW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Feb 2006 02:39:22 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060218073620.RQGL17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 18 Feb 2006 02:36:20 -0500
To: linux@horizon.com
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16398>

linux@horizon.com writes:

> But suppose discover a nasty bug in -rc3 and want to move my build branch
> back to -rc2.  "git-rebase v2.6.16-rc2" does nothing.  After a bit
> of thought, I realize why, but sometime I do want to back up.
>
> What's the best way to do that?  Should git-rebase take an optional
> third argument which is the branch head we are moving away from?
> E.g. what I want to do would be
>
> 	git-rebase v2.6.16-rc2 build v2.6.16-rc3

The one in "next" has a topic branch change which lets you say:

	$ git rebase --onto v2.6.16-rc2 v2.6.16-rc3 build

which is a shorthand for

	$ git checkout build
	$ git rebase --onto v2.6.16-rc2 v2.6.16-rc3

That is, tear out my changes that forked from the development
trail that led to v2.6.16-rc3, and graft them on top of
v2.6.16-rc2.
