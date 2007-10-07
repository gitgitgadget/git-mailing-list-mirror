From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: git fetch -- double fetch
Date: Sun, 7 Oct 2007 19:14:28 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0710071903150.23070@iabervon.org>
References: <20071006185759.GE28610@shadowen.org> <Pine.LNX.4.64.0710071728570.4174@racer.site>
 <20071007214433.GA30833@shadowen.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Andy Whitcroft <apw@shadowen.org>
X-From: git-owner@vger.kernel.org Mon Oct 08 01:14:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IefKb-00030A-BR
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 01:14:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756436AbXJGXOa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 19:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754753AbXJGXOa
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 19:14:30 -0400
Received: from iabervon.org ([66.92.72.58]:39417 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754745AbXJGXOa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 19:14:30 -0400
Received: (qmail 17383 invoked by uid 1000); 7 Oct 2007 23:14:28 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 7 Oct 2007 23:14:28 -0000
In-Reply-To: <20071007214433.GA30833@shadowen.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60238>

On Sun, 7 Oct 2007, Andy Whitcroft wrote:

> On Sun, Oct 07, 2007 at 05:29:38PM +0100, Johannes Schindelin wrote:
> > Hi,
> > 
> > On Sat, 6 Oct 2007, Andy Whitcroft wrote:
> > 
> > > I have recently been seeing repeated fetching of some branches.  I feel
> > > this has happened in at least three of my repos on three distinct
> > > projects:
> > > 
> > > apw@pinky$ git fetch origin
> > > remote: Generating pack...
> > > remote: Done counting 5 objects.
> > > remote: Deltifying 5 objects...
> > > remote:  100% (5/5) done
> > > Unpacking 5 objects...
> > > remote: Total 5 (delta 0), reused 0 (delta 0)
> > >  100% (5/5) done
> > > * refs/remotes/origin/master: fast forward to branch 'master' of ssh://git@abat-dev/var/www/git/abat
> > >   old..new: ce046f0..41c9dde
> > > * refs/remotes/origin/master: fast forward to branch 'master' of ssh://git@abat-dev/var/www/git/abat
> > >   old..new: ce046f0..41c9dde
> > 
> > What does "git config --get-all remote.origin.fetch" say?
> 
> apw@pinky$ git config --get-all remote.origin.fetch
> +refs/heads/master:refs/remotes/origin/master
> +refs/heads/*:refs/remotes/origin/*
> apw@pinky$
> 
> I don't think that I did anything to this config, I think that is what
> the clone setup for me.

Ah, both the first line and the pattern match, and there's nothing at that 
stage to filter out duplicates.

	-Daniel
*This .sig left intentionally blank*
