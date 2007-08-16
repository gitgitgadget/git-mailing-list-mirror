From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn fetch updating master
Date: Thu, 16 Aug 2007 02:03:28 -0700
Message-ID: <20070816090327.GC16849@muzzle>
References: <20070815181228.GA6363@glandium.org> <20070816080349.GA16849@muzzle> <20070816082706.GA29521@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Thu Aug 16 11:03:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILbGU-00013W-Lg
	for gcvg-git@gmane.org; Thu, 16 Aug 2007 11:03:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755436AbXHPJD3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Aug 2007 05:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755420AbXHPJD3
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Aug 2007 05:03:29 -0400
Received: from hand.yhbt.net ([66.150.188.102]:35817 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754891AbXHPJD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2007 05:03:28 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 391832DC08D;
	Thu, 16 Aug 2007 02:03:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20070816082706.GA29521@glandium.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55995>

Mike Hommey <mh@glandium.org> wrote:
> On Thu, Aug 16, 2007 at 01:03:49AM -0700, Eric Wong <normalperson@yhbt.net> wrote:
> > Mike Hommey <mh@glandium.org> wrote:
> > > Hi,
> > > 
> > > I was wondering why the master branch was hardcoded to be updated in
> > > post_fetch_checkout() in git-svn. Why not allow to use another branch ?
> > 
> > It shouldn't update master if it the branch already exists and is a
> > valid ref.
> > 
> > The default for git-clone is to create "master", too, so I wanted
> > git-svn clone behavior to be the same.
> 
> git-svn fetch is not only invoqued at cloning time...
> 
> My problem is that I (purposely) removed the master branch, so git-svn fetch
> is creating it again every time I run to update the svn branch...

Ah.  The old usage was: git-svn init && git-svn fetch; so it'll create
a master branch each time.   You can use --no-checkout with fetch to
avoid this behavior.

-- 
Eric Wong
