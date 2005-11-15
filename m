From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Disable USE_SYMLINK_HEAD by default
Date: Mon, 14 Nov 2005 23:03:38 -0800
Message-ID: <7vveyuqto5.fsf@assigned-by-dhcp.cox.net>
References: <1132034390.22207.18.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 15 08:05:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EburH-0007rq-0L
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 08:03:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932319AbVKOHDk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 02:03:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932320AbVKOHDk
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 02:03:40 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:19874 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932319AbVKOHDk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 02:03:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051115070310.EQUD20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 15 Nov 2005 02:03:10 -0500
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <1132034390.22207.18.camel@dv> (Pavel Roskin's message of "Tue,
	15 Nov 2005 00:59:50 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11879>

Pavel Roskin <proski@gnu.org> writes:

> Applying this patch before 1.0 may be controversial,...

If I am not mistaken, I thought the last thread on the list
showed general consensus that symlinks were preferred when
available.  So applying this patch anytime would be
controversial...

> but I think there is a very good reason for that.

Which is...?  I do not think this paragraph justifies it:

> There should be exactly one git 1.0 repository format.  Now we
> have two that are present in the sources and that have
> received testing from the git users.

The one format is that .git/HEAD can either be a symlink or
regular file text symref; both variants are tested -- wouldn't
that be good enough?

The only thing I can think of that might be inconvenient is if
you try doing "cp -a" off of a filesystem that supports symlinks
to another filesystem that does not -- probably that would fail
copying the symlinked .git/HEAD.  But if that is the problem,
you could always git-clone, which should do the right thing, I
think.
