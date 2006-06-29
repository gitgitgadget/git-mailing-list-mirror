From: Junio C Hamano <junkio@cox.net>
Subject: Re: xdiff: generate "anti-diffs" aka what is common to two files
Date: Wed, 28 Jun 2006 23:04:52 -0700
Message-ID: <7vbqscwl8b.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0606282149060.12404@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 29 08:04:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fvpe4-0007Rr-JM
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 08:04:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbWF2GEy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 02:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932227AbWF2GEy
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 02:04:54 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:53401 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932224AbWF2GEx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jun 2006 02:04:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060629060452.EGGI16011.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 29 Jun 2006 02:04:52 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22841>

Linus Torvalds <torvalds@osdl.org> writes:

> Junio: the patch that actually _uses_ this comes next. It's based on my 
> previous "throw-away" example patches, if you want me to base it on 
> something else, please holler.

Nah, I appreciate that you did it this way, because it gave me a
test case to "git-am" your two patches into a temporary branch
and "pull --squash" that into lt/merge-tree branch ;-).

	git am ./+LT.mbox
        ... two patches, applied with --whitespace=strip ...
	git tag -f CG
        git reset --hard HEAD^^
        git pull --squash . tag CG
        git commig -C CG
        git tag -d CG
