From: Junio C Hamano <junkio@cox.net>
Subject: Re: symlinked directories in refs are now unreachable
Date: Sun, 14 Aug 2005 22:12:47 -0700
Message-ID: <7v64u7941c.fsf@assigned-by-dhcp.cox.net>
References: <1124073677.27393.15.camel@della.draisey.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 15 07:13:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4XHK-0004eJ-Ck
	for gcvg-git@gmane.org; Mon, 15 Aug 2005 07:12:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751031AbVHOFMw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Aug 2005 01:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751045AbVHOFMv
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Aug 2005 01:12:51 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:17552 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751030AbVHOFMv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2005 01:12:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050815051247.QOFG15197.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 15 Aug 2005 01:12:47 -0400
To: Matt Draisey <mattdraisey@sympatico.ca>
In-Reply-To: <1124073677.27393.15.camel@della.draisey.ca> (Matt Draisey's
	message of "Mon, 15 Aug 2005 02:41:17 +0000")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Matt Draisey <mattdraisey@sympatico.ca> writes:

> The behaviour of the symlinked in ref directories has changed from
> earlier versions of git.  They used to be taken into account in
> git-fsck-cache --unreachable.
>
> Can the previous behaviour be reinstated?

I would not have much problem accepting a patch for that; it
would make things safer when a symlink points to a real file
that is outside .git/refs/ that holds a pointer to a valid
object.

Having said that, I would first like to know why you have a
symlink there, and the real file pointed by it outside .git/refs
hierarchy.  The core GIT tools do not create such symlinks, so
either you are creating one by hand, or your Porcelain is
creating one for you for whatever reason.  I would like to know
a use case or two to illustrate why there are symlinks pointing
at real files outside .git/refs/ hierarchy, and how that
arrangement is useful.
