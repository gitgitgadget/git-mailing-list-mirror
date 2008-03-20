From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: auto gc again
Date: Thu, 20 Mar 2008 08:40:57 +0100
Message-ID: <20080320074057.GH17940@kernel.dk>
References: <20080318180118.GC17940@kernel.dk> <alpine.LFD.1.00.0803181112270.3020@woody.linux-foundation.org> <20080318181948.GH17940@kernel.dk> <alpine.LFD.1.00.0803191629240.2947@xanadu.home> <20080319211733.GD17940@kernel.dk> <alpine.LFD.1.00.0803191856290.2947@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Mar 20 08:41:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcFPQ-0002gm-Hw
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 08:41:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753822AbYCTHlE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2008 03:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754204AbYCTHlD
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 03:41:03 -0400
Received: from brick.kernel.dk ([87.55.233.238]:10814 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753710AbYCTHlA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2008 03:41:00 -0400
Received: by kernel.dk (Postfix, from userid 500)
	id C7F62257AD5; Thu, 20 Mar 2008 08:40:57 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0803191856290.2947@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77638>

On Wed, Mar 19 2008, Nicolas Pitre wrote:
> On Wed, 19 Mar 2008, Jens Axboe wrote:
> 
> > On Wed, Mar 19 2008, Nicolas Pitre wrote:
> > > On Tue, 18 Mar 2008, Jens Axboe wrote:
> > > 
> > > > But freshly pulled repo, git auto gc is enabled. And that is my main
> > > > annoyance, I just don't think that type of policy should be in there.
> > > 
> > > Just do this once:
> > > 
> > > 	git config --global gc.auto 0
> > > 	git config --global gc.autopacklimit 0
> > > 
> > > and be happy.
> > 
> > You don't get it. I did gc.auto 0. And know some other limit crops up, I
> > have to do gc.autopacklimit 0. I have LOTS of git trees. On many
> > machines. It's just annoying, period.
> 
> As suggested, gc.auto = 0 should probably be made to disable it 
> entirely, regardless of any other parameters that might exist.

Yes, agree.

> > > > Print the warning, include info on how to run git gc or even how to turn
> > > > it on automatically. But I'll bet you that most users will NOT want auto
> > > > gc. Ever.
> > > 
> > > Unfortunately, the harshest complaints about this whole issue were the 
> > > opposite.
> > 
> > I just don't buy that, I have more faith in users.
> 
> We also did in the past... even for a long period...
> 
> Alas, it is the users who made us (and actually made Linus, who was the 
> last to resist) change our minds.

OK, that's at least reassuring :-)

> > If they come around and complain it's slow, heck you told them it 
> > would be.
> 
> But they don't.  They just presume that Git is crap and move on.

That's pretty sad, I like to have high hopes for users.

> > But it's not a big deal, I'll just carry a local patch that disables
> > this crap and forget the whole deal. I just worry that if this is where
> > git 'usability' is heading, it wont be a good thing in the long run.
> 
> I wish the majority of users was thinking like you.  I, too, have some 
> conceptual problems with this auto gc things.  With the experience 
> we've gathered, the current state appears to be the 
> lesser of all evils though.

Alright, I must bow down to empirical evidence... The conceptual policy
problem is indeed what is bothering me so much, even more so than the
actual gc running on my machine.

gc.auto covering everything is good enough for me, GIT_GC_AUTO
environment variable would be better because of the way that I work. But
I can get by knowing that the gc.auto thing will at least only bite me
once per tree. And perhaps just wrap git clone in one of my scripts
that'll then do the gc.auto thing automatically.

-- 
Jens Axboe
