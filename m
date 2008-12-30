From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: for newbs = little exercise / tutorial / warmup for windows and
 other non-sophisticated new Git users :-)
Date: Tue, 30 Dec 2008 18:29:17 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0812301730440.19665@iabervon.org>
References: <gj68a0$u56$3@ger.gmane.org> <gj6kqq$nvh$4@ger.gmane.org> <3ab397d0812291505v77824e6fvdecebc80f38a5f89@mail.gmail.com> <gjdh0r$n3c$4@ger.gmane.org> <gjdlcl$5no$4@ger.gmane.org> <gjdmm6$9oj$4@ger.gmane.org> <3ab397d0812301035w3dcd872fkae9509629a0ed7de@mail.gmail.com>
 <gje4ff$ip6$4@ger.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Zorba <cr@altmore.co.uk>
X-From: git-owner@vger.kernel.org Wed Dec 31 00:30:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHo2n-0008Py-Pz
	for gcvg-git-2@gmane.org; Wed, 31 Dec 2008 00:30:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752503AbYL3X3U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 18:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbYL3X3T
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 18:29:19 -0500
Received: from iabervon.org ([66.92.72.58]:38068 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752503AbYL3X3T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2008 18:29:19 -0500
Received: (qmail 17916 invoked by uid 1000); 30 Dec 2008 23:29:17 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 30 Dec 2008 23:29:17 -0000
In-Reply-To: <gje4ff$ip6$4@ger.gmane.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104226>

On Tue, 30 Dec 2008, Zorba wrote:

> > good news, use "git checkout versionA", not "git checkout versionA ."
> > (so, use it wihtout the dot), and you should be back in working order.
> 
> ** yes but I don't get the files copied out into the tree which is all my 
> little heart ever desired

So in order for this to make sense, you're going to need to know a little 
tiny bit about branches (which, fortunately, is trivial compared to 
branches in most SCMs). In git, a branch is a mutable pointer to a commit, 
which is the latest commit on the branch (all of the earlier commits on 
the branch are linked off of the latest one; each commit points to the one 
before). By default, you have a branch called "master", and that's the 
branch that your series of commands builds up. Now, at any given time, you 
can have a "current branch" (a.k.a. HEAD), which is the branch that you'd 
put a new commit on if you made one. "master" is your current branch while 
you're building up that history.

When you want to navigate the history, however, you want to leave all of 
the branches alone and take your working directory into the history. This 
is known as being on "(no branch)" or, as Zippy would say, having a 
"detached HEAD". This way you leave the "master" branch pointing to 
versionD, which is, after all, the latest commit, while you get yourself 
an old version. You can do this with:

$ git checkout versionA

because you've made a tag for it. In order to get back to developing (as 
opposed to looking at history), you use:

$ git checkout master

(because "master" is your branch, while "versionA" is a tag).

If you're on master, either after checking it out explicitly or before 
you've used checkout at all, doing:

$ git checkout versionA .

with *not* switch you away from the current branch, but will get the 
contents of "." from versionA into your index and working directory, and 
it doesn't remove things that you have currently.

> ** LOL, I have to admit I am enjoying this though, even if its driving me 
> slightly potty - haha
> I didn't write these early versions so I just wanna have them around to 
> rollback to if I end up hacking the thing to bits.
> But you're right - chances of using are slim - but you could say that about 
> every version sitting in any given SCM repo.
> Thats why we have SCM, and why we insure our cars etc etc. :-) 

Even if you never rolling back to it, it's useful for figuring out what 
you did when.

	-Daniel
*This .sig left intentionally blank*
