From: moe <moe-git@mbox.bz>
Subject: Re: git and larger trees, not so fast?
Date: Thu, 23 Aug 2007 02:30:46 +0200
Message-ID: <20070823003045.GD27372@mbox.bz>
References: <20070809163026.GD568@mbox.bz> <alpine.LFD.0.999.0708111137250.30176@woody.linux-foundation.org> <20070811200630.GD19284@mbox.bz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Aug 23 02:56:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IO109-0006R5-Rl
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 02:56:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752419AbXHWA4i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 20:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752110AbXHWA4i
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 20:56:38 -0400
Received: from mx01.qsc.de ([213.148.129.14]:37353 "EHLO mx01.qsc.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751450AbXHWA4h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 20:56:37 -0400
X-Greylist: delayed 1546 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Aug 2007 20:56:37 EDT
Received: from x.xxs.cc (port-212-202-38-87.dynamic.qsc.de [212.202.38.87])
	by mx01.qsc.de (Postfix) with ESMTP id 96283C7988
	for <git@vger.kernel.org>; Thu, 23 Aug 2007 02:30:46 +0200 (CEST)
Received: (qmail 9543 invoked by uid 1000); 23 Aug 2007 00:30:46 -0000
Content-Disposition: inline
In-Reply-To: <20070811200630.GD19284@mbox.bz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56441>

On Sat, Aug 11, 2007 at 10:06:30PM +0200, moe wrote:
> On Sat, Aug 11, 2007 at 11:47:42AM -0700, Linus Torvalds wrote:
> > 
> > 
> > On Thu, 9 Aug 2007, moe wrote:
> > > 
> > > here's a test-case (should be safe to
> > > copy/paste on linux, bash):
> > 
> > moe: with current git (and thus the 1.5.3 release), the "git status" 
> > commands now take half a second for me, and the git commit takes just 
> > under a second.
> > 
> > The *initial* commit that adds everything still takes almost 5 seconds, 
> > but that was due to generating the diffstat summary - with a "-q" on the 
> > commit line that too drops down to just under a second.
> > 
> > In fact, the only thing that took more than a second for me with the 
> > current git is that initial "git add .", which took 1.791s for me. 
> > Considering that it had to hash all the 100,000 objects, I'm not 
> > surprised.
> > 
> > Anyway, it would be good if you re-did your real work tree with current 
> > commit, just to verify. You have slower hardware than I do, but hopefully 
> > it is now just about as fast as it can be.
>  
> hi linus,
> 
> thx for your efforts, the figures look very promising.
> i'm out of town right now but will test when i get
> stationary internet again (sometime tomorrow evening
> i think).

sorry for late followup, i was blocked on paid work
for longer than i expected.

i can happily confirm what others have already reported;
with the patches applied git works well even for my
bigger repo.

git status              : 0m1.036s
git commit (single file): 0m1.846s

http://www.gosimpsons.com/ProdImages/krustysealkeychain.jpg


regards, moe
