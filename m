From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Considering teaching plumbing to users harmful
Date: Wed, 16 Jul 2008 17:53:49 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0807161605550.19665@iabervon.org>
References: <alpine.DEB.1.00.0807161804400.8950@racer>  <32541b130807161053w24a21d7bh1fa800a714ce75db@mail.gmail.com>  <alpine.DEB.1.00.0807161902400.8986@racer> <32541b130807161135h64024151xc60e23d222a3a508@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 16 23:54:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJExW-0004ti-LG
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 23:54:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757376AbYGPVxv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 17:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757172AbYGPVxv
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 17:53:51 -0400
Received: from iabervon.org ([66.92.72.58]:58202 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755855AbYGPVxu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 17:53:50 -0400
Received: (qmail 12272 invoked by uid 1000); 16 Jul 2008 21:53:49 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 Jul 2008 21:53:49 -0000
In-Reply-To: <32541b130807161135h64024151xc60e23d222a3a508@mail.gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88766>

On Wed, 16 Jul 2008, Avery Pennarun wrote:

> On 7/16/08, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> >  > At the very least, there will be branches.
> >
> > Oh.  And you have to teach plumbing for that?
> 
> In svn, a branch is a revision-controlled directory.  In git, a branch
> is a "ref".  What's a ref?  Well, it's a name for a commit.  What's a
> commit?  Well, it's a blob.  What's a blob?  Err, that's complicated.

You're simply wrong. A ref isn't a name for a commit (the point of having 
a ref is that it doesn't persist in naming the same commit). A commit 
isn't a blob. If you start telling people complicated and wrong things, 
they're surely going to be confused.

Git maintains history as a directed graph, with each commit pointing back 
at its history. Refs are the what holds the newest commits that nothing 
else points back to. If directed graphs aren't in your users' experience, 
you can put it this way: git maintains history like knitting, where each 
new stitch holds on to one or more previous stitches, and refs are the 
knitting needles that hold the ends where you're working (except that 
knitting is a lot wider than software development). gitk --all even 
provides the diagram you want to explain it.

SVN branches are incredible confusing because they fail to distinguish the 
directory structure of the project's source tree from the arrangement of 
available latest versions. And the version numbers for your branch 
increase when changes are made to other branches.

> >  I will not even bother to reply to your mentioning rebase, submodules, and
> >  the "complicated" log due to merges for that very reason: all of this can
> >  be done, easily, with porcelain.
> 
> My point was that the porcelain doesn't even make that stuff easy, and
> thus you need to understand fundamental git internal concepts to use
> them, and fundamental git internals are easiest to teach using the
> plumbing, which doesn't try to hide them.

I don't think the plumbing does a particularly good job of elucidating the 
fundamental git internals; the plumbing does single operations on the 
fundamental structures, but that doesn't explain what the fundamental 
structures are, or what they mean, or why you'd do particular things to 
them. In fact, they don't at all show the difference between what's 
expected to change frequently and what's permanent, which will tend to 
give you wrong ideas.

And for understanding the basic objects, "git show" will work better than 
"git cat-file" (there's no fundamental reason that trees are binary data 
and other types aren't, and no particular reason to care about the time 
format in commit headers, etc), and the plumbing programs for creating the 
fundamental objects are an even more uneven and arbitrary presentation.

	-Daniel
*This .sig left intentionally blank*
