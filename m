From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Edit user manual for grammar
Date: Thu, 14 Jun 2007 00:59:20 -0400
Message-ID: <20070614045920.GX6073@spearce.org>
References: <588192970706120518p201b52fdi9ed48896278b9f3e@mail.gmail.com> <200706121643.19837.andyparkins@gmail.com> <20070612175421.GA26767@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Thu Jun 14 06:59:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyhQu-0001ye-0T
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 06:59:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbXFNE72 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jun 2007 00:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbXFNE72
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 00:59:28 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:54833 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751393AbXFNE71 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2007 00:59:27 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1HyhQb-0002yu-9L; Thu, 14 Jun 2007 00:59:25 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C745920FBAE; Thu, 14 Jun 2007 00:59:20 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070612175421.GA26767@fieldses.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50165>

"J. Bruce Fields" <bfields@fieldses.org> wrote:
> On Tue, Jun 12, 2007 at 04:43:19PM +0100, Andy Parkins wrote:
> >  - "recovery" becomes "recovering" from Steve Hoelzer's original version
> >    of this patch
> >  - "if you want" is nicer as "if you wish"
> >  - "you may" should be "you can"; "you may" is "you have permission to"
> >    rather than "you can"'s "it is possible to"
> 
> What we really need is a complete recovery tutorial to stick in here
> someplace.  (One day git complains about a corrupt pack file.  What do
> you do?)  What's been stopping me from doing it, besides time, is no
> idea how to come up with a good example to work with.

  dd if=/dev/urandom of=.git/pack/pack-DEAD.pack bs=1 seek=12 count=512

Now run git-log.  Its probably toast.  The front of the packfile
is usually commits, and the first object is usually the most
recent commit.  It starts at byte 12.  ;-)

We actually do this in the test suite to verify that verify-pack will
detect the corruption.  Recovering from it is a bit more interesting
and difficult.

The more common corruption is to repack away an important object
by accident in a shared object directory arrangement.  Or just
havee your OS' "disk corruptor^H^H^H^H^H^H^Hvirus scanner" delete
the thing.  E.g. create a few commits, pick one out of git-log
and just rm its file in .git/objects/??.  How do you get out of
that mess?  ;-)

-- 
Shawn.
