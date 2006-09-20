From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git pull for update of netdev fails.
Date: Wed, 20 Sep 2006 12:34:37 -0400
Message-ID: <20060920163437.GC23260@spearce.org>
References: <20060920080308.673a1e93@localhost.localdomain> <Pine.LNX.4.64.0609200816400.4388@g5.osdl.org> <20060920155431.GO8259@pasky.or.cz> <Pine.LNX.4.63.0609201801110.19042@wbgn013.biozentrum.uni-wuerzburg.de> <20060920160756.GP8259@pasky.or.cz> <Pine.LNX.4.64.0609200915550.4388@g5.osdl.org> <Pine.LNX.4.64.0609200920290.4388@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 18:35:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQ529-0007dc-7N
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 18:34:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751791AbWITQeq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 12:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751818AbWITQeq
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 12:34:46 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:50839 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751791AbWITQep (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Sep 2006 12:34:45 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GQ51t-0003Ig-0n; Wed, 20 Sep 2006 12:34:33 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 90BDE20E48E; Wed, 20 Sep 2006 12:34:37 -0400 (EDT)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609200920290.4388@g5.osdl.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27370>

Linus Torvalds <torvalds@osdl.org> wrote:
> On Wed, 20 Sep 2006, Linus Torvalds wrote:
> > 
> > That's a really important point. You can trivially say "I don't care". 
> > It's literally one extra character. But it should be the _user_ that says 
> > so, not the SCM.
> > 
> > The whole point of the SCM is to care.
> 
> Btw, the "+" also protects you from local errors.
> 
> Let's say that you've committed some work of your own onto a branch that 
> you happen to follow. Guess what? By default, git refuses to throw your 
> hard work away.
> 
> This is not just a random thing. It is in fact one of the very core issues 
> of having multiple people work together on the same remote repo. We don't 
> do it very much (because it's often easier for everybody to have their 
> own), but the "CVS workflow" with one common repository is another example 
> why WE MUST NOT JUST RESET THE HEADS!

BTW `git push --force` works just great to reset the remote head.

I worked on a project not to long ago in which a user tried `git
push`, received a "not a fast-forward" error, didn't know what it
meant, tried `git push --force`, found that worked, and proceeded
to force every push he did from then on.  To much gnashing of teeth
from everyone else.

Of course an update hook finally took care of the problem, but having
non fast-forward pushs be permitted on a shared, bare repository
by default is interesting to say the least.  :-)
 
-- 
Shawn.
