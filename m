From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Git as a filesystem
Date: Fri, 21 Sep 2007 16:33:43 -0700
Message-ID: <20070921233343.GA8327@muzzle>
References: <fbe8b1780709210351x30775090ldab559f25c27645d@mail.gmail.com> <Pine.LNX.4.64.0709211208440.28395@racer.site> <fbe8b1780709210441n281248dbh5ba9934d09d6bbfc@mail.gmail.com> <alpine.LFD.0.9999.0709210912120.32185@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Stahlir <peter.stahlir@googlemail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Sep 22 01:33:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYs0N-00049T-JK
	for gcvg-git-2@gmane.org; Sat, 22 Sep 2007 01:33:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758512AbXIUXdq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2007 19:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758087AbXIUXdq
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 19:33:46 -0400
Received: from hand.yhbt.net ([66.150.188.102]:54943 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757996AbXIUXdp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 19:33:45 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 1F3667DC029;
	Fri, 21 Sep 2007 16:33:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.9999.0709210912120.32185@xanadu.home>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58891>

Nicolas Pitre <nico@cam.org> wrote:
> On Fri, 21 Sep 2007, Peter Stahlir wrote:
> 
> > This is was I was looking for. My motivation is whether it is possible
> > to run a system, for example Debian on a computer on top of gitfs,
> > and then have a huge mirror on it, for example a complete 252GB
> > Debian mirror as space efficient as possible.
> > 
> > I wonder how big a deltified Debian mirror in one pack file would be. :)
> 
> It would be just as big as the non gitified storage on disk.
> 
> The space saving with git comes from efficient delta storage of 
> _versioned_ files, i.e. multiple nearly identical versions of the same 
> file where the stored delta is only the small difference between the 
> first full version and subsequent versions.  Unless you plan on storing 
> many different Debian versions together, you won't benefit from any 
> delta at all. And since Debian packages are already compressed, git 
> won't be able to compress them further.
> 
> So don't waste your time.

On a similar note, has anybody experimented with using git to
store maildirs or news spools?  I'd imagine the quoted portions of
most message threads could be delta-compressed quite efficiently.

-- 
Eric Wong
