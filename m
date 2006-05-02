From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] repo-config: support --get-regexp and fix crash
Date: Tue, 02 May 2006 16:30:29 -0700
Message-ID: <7vmze0j97u.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0605021422150.7051@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 03 01:30:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fb4KB-0001lj-0s
	for gcvg-git@gmane.org; Wed, 03 May 2006 01:30:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbWEBXac (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 May 2006 19:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbWEBXac
	(ORCPT <rfc822;git-outgoing>); Tue, 2 May 2006 19:30:32 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:36236 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751077AbWEBXab (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 May 2006 19:30:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060502233031.PEMW9215.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 2 May 2006 19:30:31 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19440>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> 	Junio made me aware of a crash, a fix for which was too easy to
> 	merit a separate patch.

Not really.  The fix is clean-and-obvious, and is readily
applicable to "master" without being cooked in "next".  On the
other hand, --get-regexp may or may not be so; by conflating the
two, you are delaying the trivial and useful fix unnecessarily.

I already split the patch and applied the fix on "master", while
keeping the rest in "pu" (sorry, I ran out of patience to test
everything to put it in "next" -- will do so tomorrow).

It is usually a good idea to avoid making an otherwise good
clean patch a hostage to new features (intentionally or
accidentally).

> 	Strange thing I realized: A value is white-space-trimmed at the end
> 	only if the line does not end with a comment. This fact is accounted
> 	for in the new tests.

Thanks - a note like this helps me quite a bit, because I
usually apply e-mailed patches with --whitespace=strip, which
would have destroyed the test, leaving me scratching my head
without such a notice.
