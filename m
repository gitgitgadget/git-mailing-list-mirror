From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Partial checkouts / submodules
Date: Tue, 20 Nov 2007 15:18:14 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0711201508590.32410@iabervon.org>
References: <20071120155922.GA6271@pvv.org> <20071120173350.GA2261MdfPADPa@greensroom.kotnet.org>
 <20071120181932.GA20705@pvv.org> <Pine.LNX.4.64.0711201336530.32410@iabervon.org>
 <20071120192231.GA23240@pvv.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: skimo@liacs.nl, git@vger.kernel.org
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Tue Nov 20 21:18:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuZYJ-0007Pi-6v
	for gcvg-git-2@gmane.org; Tue, 20 Nov 2007 21:18:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757321AbXKTUSR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2007 15:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758807AbXKTUSQ
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Nov 2007 15:18:16 -0500
Received: from iabervon.org ([66.92.72.58]:51825 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756766AbXKTUSP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2007 15:18:15 -0500
Received: (qmail 14425 invoked by uid 1000); 20 Nov 2007 20:18:14 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 20 Nov 2007 20:18:14 -0000
In-Reply-To: <20071120192231.GA23240@pvv.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65575>

On Tue, 20 Nov 2007, Finn Arne Gangstad wrote:

> On Tue, Nov 20, 2007 at 01:59:41PM -0500, Daniel Barkalow wrote:
> > On Tue, 20 Nov 2007, Finn Arne Gangstad wrote:
> > 
> > > I'll try to boil this down to the simplest case possible. If
> > > submodules can do this I'll be really happy :)
> > > 
> > > Developer A makes a change in submodule1 and in submodule2
> > > Developer B makes a change in submodule2 and in submodule3
> > > 
> > > A and B don't know about eachother. They send their modifications
> > > somewhere (push to a shared repository with a well chosen branch name,
> > > for example), or send a mail "please pull from my repo" to the patch
> > > queue manager.
> > > 
> > > It is absolutely crucial that for each developer, either both their
> > > modifications go in, or none of them. Git should make picking only
> > > one of their modifications hard.
> > 
> > This is the case; if developer A changes 2 from 2-O to 2-A, and developer 
> > B changes 2 from 2-O to 2-B, merging both supermodule commits gets a 
> > conflict, which requires a merge in submodule 2 before the supermodule 
> > merge can be committed.
> 
> And this is partly why I wanted to branch all the involved modules: In
> ~99% of the cases, 2-A and 2-B modify different files, or at least
> wildly different parts of the same file, so the merge should be
> trivial/automatic. Therefore, the supermodule merge should also be a
> trivial/automatic merge - but it isn't, is it?

It's an automatic merge if you've got the submodule; if you don't have the 
submodule, you can't tell that the merge would be trivial, because you 
can't even see the order of the history in the submodule, let alone which 
files change and how. This just means that the patch queue manager is 
going to have to have all of the submodules, which is probably reasonable 
if the patch queue manager is responsible for making sure that the 
combination works.

	-Daniel
*This .sig left intentionally blank*
