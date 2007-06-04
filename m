From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Git Vs. Svn for a project which *must* distribute binaries too.
Date: Mon, 4 Jun 2007 19:48:54 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0706041923580.22840@iabervon.org>
References: <5971b1ba0706040448i6e166031od1212192a549c4a9@mail.gmail.com> 
 <alpine.LFD.0.98.0706040755560.23741@woody.linux-foundation.org>
 <5971b1ba0706040838nc9ea7c7h54a57d4235d53bcf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Bryan Childs <godeater@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 05 01:49:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvMII-0001Ho-Oc
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 01:49:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756218AbXFDXs4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 19:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757104AbXFDXs4
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 19:48:56 -0400
Received: from iabervon.org ([66.92.72.58]:2244 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756218AbXFDXs4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 19:48:56 -0400
Received: (qmail 28678 invoked by uid 1000); 4 Jun 2007 23:48:54 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 Jun 2007 23:48:54 -0000
In-Reply-To: <5971b1ba0706040838nc9ea7c7h54a57d4235d53bcf@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49141>

On Mon, 4 Jun 2007, Bryan Childs wrote:

> On 6/4/07, Linus Torvalds < [send email to
> torvalds@linux-foundation.org via gmail]
> torvalds@linux-foundation.org> wrote:
> > So I *hope* that you want to just have automated build machinery that
> > builds the binaries to a *separate* location? You could use git to archive
> > them, and you can obviously (and easily) name the resulting binary blobs
> > by the versions in the source tree, but I'm just saying that trying to
> > track the binaries from within the same git repository as the source code
> > is less than optimal.
> 
> Oh lord no - I never meant to imply that we'd be checking those
> binaries in, I just meant to hi-light that we need a central
> repository to build those binaries from - otherwise we'd end up with a
> selection of binaries for our users to download which contain a bunch
> of different features if they were built from a combination of
> repositories. I know you think everyone else is a moron, but we're not
> quite dumb enough to think maintaining binaries in a repository is a
> good idea :)

Actually, I've been playing with using git's data-distribution mechanism 
to distribute generated binaries. You can do tags for arbitrary binary 
content (not in a tree or commit), and, if you have some way of finding 
the right tag name, you can fetch that and extract it.

I came up with this at my job when we were trying to decide what to do 
with firmware images that we'd shipped, so that we'd be able to examine 
them again even if we lose the compiler version we used at the time. We 
needed an immutable data store with a mapping of tags to objects, and I 
realized that we already had something with these exact characteristics.

	-Daniel
*This .sig left intentionally blank*
