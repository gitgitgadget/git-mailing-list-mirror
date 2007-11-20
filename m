From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Re: Partial checkouts / submodules
Date: Tue, 20 Nov 2007 20:22:32 +0100
Message-ID: <20071120192231.GA23240@pvv.org>
References: <20071120155922.GA6271@pvv.org> <20071120173350.GA2261MdfPADPa@greensroom.kotnet.org> <20071120181932.GA20705@pvv.org> <Pine.LNX.4.64.0711201336530.32410@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: skimo@liacs.nl, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Nov 20 20:23:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuYgR-0008Ln-AX
	for gcvg-git-2@gmane.org; Tue, 20 Nov 2007 20:22:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758141AbXKTTWh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2007 14:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758131AbXKTTWh
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Nov 2007 14:22:37 -0500
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:40671 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757933AbXKTTWg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2007 14:22:36 -0500
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.60)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1IuYg4-0001CR-ES; Tue, 20 Nov 2007 20:22:32 +0100
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711201336530.32410@iabervon.org>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65571>

On Tue, Nov 20, 2007 at 01:59:41PM -0500, Daniel Barkalow wrote:
> On Tue, 20 Nov 2007, Finn Arne Gangstad wrote:
> 
> > I'll try to boil this down to the simplest case possible. If
> > submodules can do this I'll be really happy :)
> > 
> > Developer A makes a change in submodule1 and in submodule2
> > Developer B makes a change in submodule2 and in submodule3
> > 
> > A and B don't know about eachother. They send their modifications
> > somewhere (push to a shared repository with a well chosen branch name,
> > for example), or send a mail "please pull from my repo" to the patch
> > queue manager.
> > 
> > It is absolutely crucial that for each developer, either both their
> > modifications go in, or none of them. Git should make picking only
> > one of their modifications hard.
> 
> This is the case; if developer A changes 2 from 2-O to 2-A, and developer 
> B changes 2 from 2-O to 2-B, merging both supermodule commits gets a 
> conflict, which requires a merge in submodule 2 before the supermodule 
> merge can be committed.

And this is partly why I wanted to branch all the involved modules: In
~99% of the cases, 2-A and 2-B modify different files, or at least
wildly different parts of the same file, so the merge should be
trivial/automatic. Therefore, the supermodule merge should also be a
trivial/automatic merge - but it isn't, is it?

- Finn Arne
