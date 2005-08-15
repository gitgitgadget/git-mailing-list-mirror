From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Alternate object pool mechanism updates.
Date: Sun, 14 Aug 2005 18:53:02 -0700
Message-ID: <7vr7cw7ypt.fsf@assigned-by-dhcp.cox.net>
References: <7vmznmp5ja.fsf@assigned-by-dhcp.cox.net>
	<20050813120815.GC5608@pasky.ji.cz>
	<7v1x4wcca0.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0508141726390.3553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 15 03:53:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4UA7-0001WC-JE
	for gcvg-git@gmane.org; Mon, 15 Aug 2005 03:53:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932626AbVHOBxJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 Aug 2005 21:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932627AbVHOBxJ
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Aug 2005 21:53:09 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:61934 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932626AbVHOBxH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2005 21:53:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050815015302.DNYS1860.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 14 Aug 2005 21:53:02 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508141726390.3553@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 14 Aug 2005 17:29:05 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> I think this is great - especially for places like kernel.org, where a lot 
> of repos end up being related to each other, yet independent.

Yes.  There is one shortcoming in the current git-clone -s in
the proposed updates branch.  If the parent repository has
alternates on its own, that information should be copied to the
cloned one as well (e.g. Jeff has alternates pointing at you,
and I clone from Jeff with -s flag --- I should list not just
Jeff but also you to borrow from in my alternates file).

> However, exactly for places like kernel.org it would _also_ be nice if
> there was some way to prune objects that have been merged back into the
> parent.

Yes.  Another possibility is to use git-relink which was written
exactly to solve this in a different way.
