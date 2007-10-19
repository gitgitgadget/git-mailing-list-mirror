From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: RE: git push bug?
Date: Fri, 19 Oct 2007 23:46:29 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710192338400.25221@racer.site>
References: <000001c81280$ebc5c5e0$5267a8c0@Jocke>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: 'Steffen Prohaska' <prohaska@zib.de>, 'git' <git@vger.kernel.org>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
X-From: git-owner@vger.kernel.org Sat Oct 20 00:47:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ij0cL-0004rW-Ca
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 00:46:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752605AbXJSWqq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 18:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752491AbXJSWqq
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 18:46:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:57656 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751958AbXJSWqp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 18:46:45 -0400
Received: (qmail invoked by alias); 19 Oct 2007 22:46:43 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp012) with SMTP; 20 Oct 2007 00:46:43 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/rl387DsDrO7cx8uTJ0RTCUcK24DHLEPjlmnPsai
	KxhKB1Fh5LtDga
X-X-Sender: gene099@racer.site
In-Reply-To: <000001c81280$ebc5c5e0$5267a8c0@Jocke>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61771>

Hi,

On Fri, 19 Oct 2007, Joakim Tjernlund wrote:

> > From: Johannes Schindelin [mailto:Johannes.Schindelin@gmx.de] 
> > 
> > On Fri, 19 Oct 2007, Joakim Tjernlund wrote:
> > 
> > > On Thu, 2007-10-18 at 23:00 +0100, Johannes Schindelin wrote:
> > > > 
> > > > On Thu, 18 Oct 2007, Joakim Tjernlund wrote:
> > > > 
> > > > > First, I didn't know that I could do that. Secondly, I was also 
> > > > > looking do v2.6.23:linus refspecs
> > > > 
> > > > 
> > > > First, then our documentation could be better.  How?
> > > 
> > > Well, it isn't clear to me how all this is supposed to work and what 
> > > is bugs. Clearifying that would help.
> > > 
> > > For instances I did a push with v2.6.23:refs/heads/linus and now I 
> > > got a branch with the SHA1 of v2.6.23 
> > > tag(0b8bc8b91cf6befea20fe78b90367ca7b61cfa0d) in it. Makes gitk 
> > > display that branch as "linus^{}".
> > 
> > It strikes me as really odd that you would _want_ to create a branch 
> > remotely, that has _never_ existed locally.
> 
> It strikes me as really odd that a core developers like yourself
> hasn't tried to justify/explain why push works as it does.

Well, I explained that I think the "src:dst" way to specify things are not 
meant for git newbies.  Don't use it.

git push <remote> <branchname> works exactly as advertised.  It pushes the 
specified branch to the remote repository.

> As I am trying to convince our dev. group here to move to git instead of 
> subversion, I need to learn how git works. Now I have gotten to the push 
> function and I need to know what can be done with push and how, pitfalls 
> too. As I go along I find behavior that I find odd and report these to 
> the list.
> 
>  git push <repo> v2.6.23:refs/heads/linus
> will make a tag look like a branch

Don't use src:dest notation.

>  git push <repo> linus:linus
> won't let me create the remote branch linus

Don't use src:dest notation.

> but
>  git push <repo> linus
> will

Use this.  This is good.

>  git push <repo> :linus
> OOPS, now I just deleted remote branch linus, no warning

Don't use src:dest notation.

>  git push <repo> linus:refs/head/linus
> creates a branch that is invisible(wont show in git branch -a)

Don't use src:dest notation.

>  git push <repo> linus:refs/heads/newbranch
> creates remote branch newbranch, but you have to know the magic words
> refs/heads/ to do it.

Don't use src:dest notation.

> Se what I mean? 

Yes.

I hope you return the honour.

> > > > Second, why not "git checkout -b linus v2.6.23 && git push origin 
> > > > linus"?
> > > 
> > > An extra checkout that takes time but works.
> > 
> > Not only that: before trying to publish something, I would have 
> > expected you to have that branch locally, and that you actually worked 
> > on it.
> > 
> > > Doesn't make the above "weiredness" go away though.
> > 
> > Yes it does.
> 
> No it doesn't. If someone else in my group wants to create a branch they 
> might do the same mistakes as I did.

Yes, it does.  You no longer can push a tag onto a remote branch by 
accident.  Just don't use the src:dest notation.  Forget about it.  You 
definitely don't need it before you understand git better.

Hth,
Dscho
