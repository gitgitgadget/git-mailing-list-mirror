From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC PATCH] Add support for figuring out where in the git archive we are
Date: Tue, 16 Aug 2005 16:40:03 -0700
Message-ID: <7vll315u3w.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0508161536390.3553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 17 01:40:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5B2T-0006xt-Hv
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 01:40:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbVHPXkG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Aug 2005 19:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbVHPXkG
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Aug 2005 19:40:06 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:6097 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750709AbVHPXkF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2005 19:40:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050816234004.XWKZ19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 16 Aug 2005 19:40:04 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508161536390.3553@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 16 Aug 2005 15:45:35 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> If you use the GIT_DIR environment variable approach, it assumes that all
> filenames you give it are absolute and acts the way it always did before.

> Comments? Like? Dislike?

Comments: Wouldn't that mean git-*-scripts would not benefit from this
          because git-sh-setup would set GIT_DIR for you even if
          you don't?

	  Even if you do not have to do discovery, it may make
	  more sense to do the pathname translation (making them
	  all relative to the project root) for consistency.

	  If you can do "cd drivers && git-diff-files ../net"
	  that would be very useful.  More realistically, people
	  would very much appreciate if stripping the leading ./ in
          "find . -type f -print0 | xargs -0 git-blah-command".

Like:	  Yes, you finally saw the light ;-).

Dislike:  I believe I was one of the original proponent for this
          kind of thing, so no.
