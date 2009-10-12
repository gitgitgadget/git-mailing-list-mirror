From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Re: [PATCH/RFC] builtin-checkout: suggest creating local branch
  when appropriate to do so
Date: Mon, 12 Oct 2009 09:49:50 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0910120941150.4985@pacific.mpi-cbg.de>
References: <0016e68fd0123a175304754694b4@google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mikael Magnusson <mikachu@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, Jay Soffian <jaysoffian@gmail.com>,
	git@vger.kernel.org
To: Euguess@gmail.com
X-From: git-owner@vger.kernel.org Mon Oct 12 09:54:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxFjO-00059R-7E
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 09:54:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754324AbZJLHsE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 03:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753634AbZJLHsD
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 03:48:03 -0400
Received: from mail.gmx.net ([213.165.64.20]:56208 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751244AbZJLHsC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 03:48:02 -0400
Received: (qmail invoked by alias); 12 Oct 2009 07:47:14 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp042) with SMTP; 12 Oct 2009 09:47:14 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/bEXcUSUzbTaFKFcwqHGwSlFzliILtnSsejQWixN
	/qMbI3S/J6+br2
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <0016e68fd0123a175304754694b4@google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129994>

Hi,

On Tue, 6 Oct 2009, Euguess@gmail.com wrote:

> I'ma new user of git and I don't think i will ever have a commit in 
> git.git, because I'm not a programmer (I'm QA).

Welcome!

Let me take this opportunity to express my deep sadness that your first 
input to this list was brushed off so carelessly.

I sincerely hope that you give us another chance, and that you let us 
benefit from your fresh and unbiased view of the usability issues in Git 
(some of us use Git for so long, they think that Git has no usability 
issues anymore).

> I was reading this topic as carefully as i could and I think that this 
> makes a lot of sense to address this issue. As i understand when 
> somebody fetches from remote repo in order to be able to start working 
> on the code from this remote repo you should create tracking branch for 
> one of the branches from remote and only then you should do your changes 
> or perform merges.
>
> in case if you didn't do that and you try to checkout you will end up 
> having detached HEAD which is quite scary;) for non-experienced user and 
> as i see might lead to some unnecessary questions in this list or on IRC 
> channel...

Right.  We see that type of confusion in #git everyday, and blaming the 
user would be a violation of http://c2.com/cgi/wiki?BlameTheRightThing

> As for the solution i would choose the "simplest thing that will work" - 
> so i think that we just have to notify user about his suicide attempt to 
> checkout nonlocal branch and offer him a correct syntax to go with.
>
> Something like below should work:
> 
> % git clone git://git.git git
> % git checkout next
> You're attempting to checkout to non-local branch. This will lead to your HEAD
> being detached (our team is on its way!).
> Do you want to check out local branch 'next' tracking 'origin/next' instead?
> y/n
> 
> if yes, then:
> Created branch "next" tracking "origin/next"
> You can update it with 'git pull'.
> 
> If no - abort or continue with checkout to nonlocal branch? ('m not sure if
> detaching HEAD can provide some benefits if done on purpose)
> 
> I hope I'm not missing anything...

No, I think that is something perfectly fine to expect in a software whose 
UI complexity is unfortunately pretty much in disagreement with its 
internal complexity.

One thing one might add for the technically inclined folks (i.e. those who 
need to implement, and to see that Git is in dear need of some 
user-friendliness first): "git checkout" is a porcelain (i.e. a program 
meant for end-user consumption), and as such should not have a problem to 
react to isatty(0) (i.e. "is the input coming directly from the 
console?").

So yes, even if I was on the verge of giving up on this thread, I have 
been encouraged enough to get this uphill battle going again, and to try 
to overturn some stubborn resistance.

Ciao,
Dscho
