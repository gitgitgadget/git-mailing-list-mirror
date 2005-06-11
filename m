From: Junio C Hamano <junkio@cox.net>
Subject: [OT] mutually supervised developers
Date: Sat, 11 Jun 2005 14:19:31 -0700
Message-ID: <7vy89gsiak.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Sat Jun 11 23:15:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DhDJs-0001lU-9H
	for gcvg-git@gmane.org; Sat, 11 Jun 2005 23:15:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261835AbVFKVTi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Jun 2005 17:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261836AbVFKVTg
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Jun 2005 17:19:36 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:27541 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S261835AbVFKVTd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jun 2005 17:19:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050611211930.XPAL16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 11 Jun 2005 17:19:30 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I think this is somewhat offtopic here, but I was wondering:

 - if a development model like this would make sense,

 - and if so if we would want GIT to support such a model,

 - and if so if the current GIT already offers such support,

 - and if not what kind of primitives at the core layer we would
   need to add.

Let's assume that a project is co-managed by a handful top-tier
developers and has an active development community.  There is
_the_ public repository that all users consider the canonical
starting point to base their work off of.  It would be like -git
snapshot tree or -mm tree in Linux 2.6 kernel.

These developers are all active in the community, and at times
are overenthusiastic.  Their own changes are usually quite good,
they also have good taste when accepting outside patches, but
they all tend to commit not-so-well-thought-out crapola of their
own from time to time to their own repository.

I am wondering if the world would be a better place if this
fictitious project sets up public repositories in the following
way:

 (1) each developer's own repository is public;

 (2) these developers pull from each other "only good stuff",
     rejecting things he or she feels questionable.  Let's
     forget that current GIT does not give a direct support for
     cherrypicking for now.

 (3) the public canonical repository is updated to contain the
     intersection (_not_ union) of these developer repositories.
     Let's also forget that current GIT does not have automated
     way to do such a thing.

This would give each developer an "adult supervision" by all the
other developers, because any stuff that somebody finds
questionable will not be included in the "intersection".  The
public canonical repository is essentially to contain the
community "concensus".

Applying the above outline literally is inpractical in that it
gives any slow (or just otherwise busy) developer an unintended
"veto" power to freeze the canonical tree, so the management of
the canonical repository part may need to be tweaked with
something like majority rule, but the basic idea is to help
people get mutual supervision to prevent them from spreading
crap they may later regret.

Would people find something like this arrangement workable and
worthwhile?

