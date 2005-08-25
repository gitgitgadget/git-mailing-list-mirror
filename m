From: Jan Veldeman <jan.veldeman@gmail.com>
Subject: Re: [RFC] Stgit - patch history / add extra parents
Date: Thu, 25 Aug 2005 09:09:55 +0200
Message-ID: <20050825070955.GA762@eros.intern.mind.be>
References: <20050818195753.GA9066@fanta> <tnx64u2p81k.fsf@arm.com> <20050819194832.GA8562@fanta> <1124572356.7512.21.camel@localhost.localdomain> <20050821094059.GA5453@fanta> <Pine.LNX.4.63.0508221707520.23242@iabervon.org> <tnxvf1wd24m.fsf@arm.com> <Pine.LNX.4.63.0508231304130.23242@iabervon.org> <20050823212305.GA5936@fanta> <Pine.LNX.4.63.0508231731370.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 25 09:11:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8BsZ-0002Ua-Vs
	for gcvg-git@gmane.org; Thu, 25 Aug 2005 09:10:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751552AbVHYHKO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Aug 2005 03:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751554AbVHYHKO
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Aug 2005 03:10:14 -0400
Received: from NAT.office.mind.be ([62.166.230.82]:45209 "EHLO
	NAT.office.mind.be") by vger.kernel.org with ESMTP id S1751553AbVHYHKN
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2005 03:10:13 -0400
Received: (qmail 911 invoked by uid 10029); 25 Aug 2005 07:09:55 -0000
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0508231731370.23242@iabervon.org>
User-Agent: Mutt/1.3.28i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7748>

Daniel Barkalow wrote:

[...]
> > The parents which should be visible to the outside, will always be versions
> > of my development tree, which I have previously pushed out. My way of
> > working would become:
> > * make changes, all over the place, using stgit
> > * still make changes (none of these gets tracked, intermittent versions are
> >   lost)
> > * having a good day: changes looks good, I want to push this out:
> >   * push my tree out
> >   * stgit-free (which makes the pushed out commits, the new parents of my
> >     stgit patches)
> > * restart from top
> 
> I'm not sure how applicable to this situation stgit really is; I see stgit
> as optimized for the case of a patch set which is basically done, where
> you want to keep it applicable to the mainline as the mainline advances.

Maybe I forgot to mention this: I would also like to have my development
tree split up in a patch stack. The separate patches makes tracking the
mainline a lot easier (conflicts are a lot easier to solve)

> 
> For your application, I'd just have a git branch full of various stuff,
> and then generate clean commits by branching mainline, diffing development
> against it, cutting the diff down to just what I want to push, and
> applying that. Then the clean patch goes into stgit.

But this would assume that once the patch goes into stgit, it won't
change except when the parent gets updated. I think we will still change
the patches quite a bit and simultanious by a couple of people.

> 
> > [...]
> > my proposal does something like this, but a little more: not only does it
> > keep track of the link between old-top and new-top, it also keeps track of
> > the links between old-patch-in-between and new-patch-in-between.
> > (This makes sense when the top is being removed or reordered)
> 
> I was thinking of this as being the top and bottom commits for a single
> tracked patch, not as a whole series. I think patches lower wouldn't be
> affected, and patches higher would see this as a rebase.
> 

ah, ok, I misunderstood that part

Best regards,
Jan

PS. sorry if my responses are sometimes a bit late, I'm trying to find
more time to spend on this list ;-)
