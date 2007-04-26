From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/2] bookmarks
Date: Thu, 26 Apr 2007 00:50:48 -0700
Message-ID: <7v647jtvzb.fsf@assigned-by-dhcp.cox.net>
References: <200704252004.45112.andyparkins@gmail.com>
	<Pine.LNX.4.64.0704252056210.1005@reaper.quantumfyre.co.uk>
	<200704252142.33756.andyparkins@gmail.com>
	<Pine.LNX.4.64.0704252332170.18446@beast.quantumfyre.co.uk>
	<7vmz0vu1fc.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0704260816480.27356@beast.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Andy Parkins <andyparkins@gmail.com>
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Thu Apr 26 09:50:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hgykg-0003jX-S5
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 09:50:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933168AbXDZHuv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Apr 2007 03:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933340AbXDZHuv
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Apr 2007 03:50:51 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:51066 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933168AbXDZHuu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2007 03:50:50 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070426075048.SMRY1235.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Thu, 26 Apr 2007 03:50:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id rjqo1W00Y1kojtg0000000; Thu, 26 Apr 2007 03:50:49 -0400
In-Reply-To: <Pine.LNX.4.64.0704260816480.27356@beast.quantumfyre.co.uk>
	(Julian Phillips's message of "Thu, 26 Apr 2007 08:25:13 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45616>

Julian Phillips <julian@quantumfyre.co.uk> writes:

> That way you are not reliant on the user's tools following your rules.

You misunderstood -- what implements the rules is on the
repository side, not the end users' side.

> I don't think it unreasonable to say that anything that is in a public
> repository is public, and that the way to keep things private is to
> not push them into a public repository. Or is it?

I wouldn't have bothered to jump into the thread if this were
about public repositories.  You would not even need a separate
namespace refs/bm -- you do not have to push that out.

But that was not what Andy was talking about.

> I understand that some people may wish to make their working
> repositories public, but then there isn't any way we can say for sure
> that things will remain private.  Even if ls-remote was updated, an
> older version would simply ignore the new "this is private"
> configuration.

You misunderstood.  I am not talking about updating ls-remote.
The update to upload-pack/update-server-info is done on the side
of Andy's repository, not on the client side.

> or simply expand the current push configuration to accept that syntax,
> so that you can finely control which refs get pushed to the public
> repo?

You do not have to update anything on push side, as push just
pushes what you tell it to, unless you say 'push --all', in
which case you obviously mean all is all is all, so there is no
need for exclude.
