From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RFC] "Recursive Make considered harmful"
Date: Thu, 28 Jul 2005 09:38:40 -0700
Message-ID: <7vk6jac2cv.fsf@assigned-by-dhcp.cox.net>
References: <20050727083910.GG19290@mythryan2.michonline.com>
	<7v4qafrk8w.fsf@assigned-by-dhcp.cox.net>
	<7v64uvh0mo.fsf@assigned-by-dhcp.cox.net>
	<pan.2005.07.28.07.45.31.245357@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 28 18:43:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyBTD-0002yp-4W
	for gcvg-git@gmane.org; Thu, 28 Jul 2005 18:42:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261594AbVG1QmU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jul 2005 12:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbVG1Qjo
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jul 2005 12:39:44 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:17361 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261594AbVG1Qim (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2005 12:38:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050728163833.CAZU3209.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 28 Jul 2005 12:38:33 -0400
To: Matthias Urlichs <smurf@smurf.noris.de>
In-Reply-To: <pan.2005.07.28.07.45.31.245357@smurf.noris.de> (Matthias Urlichs's message of "Thu, 28 Jul 2005 09:45:31 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Matthias Urlichs <smurf@smurf.noris.de> writes:

> However, I *would* segregate gitk into its own Debian package, because
> it requires wish et al., which would pull a large chunk of X11 stuff,
> which people may not want on their server.

While I agree gitk should not come as part of git package, this
brings up a different issue.

Ideally, I'd want to see gitk packaged from its repository
kernel.org:/pub/scm/gitk/git.git/ Paul Mackerras maintains, not
from GIT one which _will_ lag behind.

We have a copy of gitk in git repository because Linus "merged"
it as "the coolest merge ever" example.  While I intend to keep
updating from gitk repository from time to time only because I
do not want to ship ancient version of it, I see a big problem
down the road.  What happens if someday Paul wanted to have a
toplevel Makefile of his own, or if somebody sends him a patch
to add debian/rules file to build a separate gitk package from
its own source tree?  Pulling/merging from gitk repo to update
the copy git has suddenly becomes a nightmere.

While I _do_ rely on gitk in my git work, and I _do_ like its
simplicity (just a single file right now), my longer term
preference is to drop the copy we have in git tree and treat it
just like the other repository browser, qgit.  Our documentation
should point people at it as part of the Porcelain suite.
