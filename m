From: Willy Tarreau <w@1wt.eu>
Subject: Re: Multiple working trees with GIT ?
Date: Thu, 24 Jan 2008 15:10:41 +0100
Message-ID: <20080124141041.GF13247@1wt.eu>
References: <20080124074952.GA8793@1wt.eu> <Pine.LNX.4.64.0801240947230.14173@reaper.quantumfyre.co.uk> <alpine.LSU.1.00.0801241102260.5731@racer.site> <20080124125606.GB13247@1wt.eu> <alpine.LSU.1.00.0801241336510.5731@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Julian Phillips <julian@quantumfyre.co.uk>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 24 15:43:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JI3IO-0005oW-0R
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 15:43:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753104AbYAXOmI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2008 09:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753723AbYAXOmI
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 09:42:08 -0500
Received: from 1wt.eu ([62.212.114.60]:1594 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753330AbYAXOmE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2008 09:42:04 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0801241336510.5731@racer.site>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71620>

On Thu, Jan 24, 2008 at 01:38:45PM +0000, Johannes Schindelin wrote:
> Hi,
> 
> On Thu, 24 Jan 2008, Willy Tarreau wrote:
> 
> > On Thu, Jan 24, 2008 at 11:04:42AM +0000, Johannes Schindelin wrote:
> > 
> > > On Thu, 24 Jan 2008, Julian Phillips wrote:
> > > 
> > > > You might want to have a look at the git-new-workdir script in 
> > > > contrib, it does basically the same thing.  It's been there for 
> > > > about 10 months now. It was based on an email from Junio:
> > > > 
> > > > http://article.gmane.org/gmane.comp.version-control.git/41513/
> > > 
> > > FWIW I have a patch to do something like that in "git branch" itself.
> > >
> > > > However, there are some caveats about using this approach, basically 
> > > > about the fact that there is nothing stopping you from updating refs 
> > > > that are currently checked out in another directory and causing 
> > > > yourself all sorts of pain ... the topic has cropped up a couple of 
> > > > times on the list since the script was added.
> > > 
> > > I agree; maybe we should have a telltale file 
> > > "refs/heads/<bla>.checkedout" which is heeded by "git checkout" and 
> > > "git branch -d/-D", as well as update_ref() (should only update that 
> > > ref when it HEAD points to it)?
> > 
> > Why not generalize this into HEAD.$branch (thus limiting to one checkout 
> > per branch) or HEAD.$checkoutdir ?
> 
> Because multiple working trees for the same repository will always be a 
> second-class citizen.  And I would rather not affect the common case too 
> much.

OK.

> Having a "lock" file which is heeded by just a few places which are 
> supposed to update refs (thinking about it, just update_ref() should be 
> enough), is at least a well-contained change.

indeed, with the appropriate warnings/error messages, that makes a lot of sense.

Cheers,
Willy
