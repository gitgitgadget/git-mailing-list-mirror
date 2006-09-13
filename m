From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Marking abandoned branches
Date: Wed, 13 Sep 2006 13:32:12 -0400
Message-ID: <20060913173212.GD29933@spearce.org>
References: <9e4733910609130817r39bbf8a8x2e05461816d9d2a1@mail.gmail.com> <20060913152451.GH23891@pasky.or.cz> <9e4733910609130859v347a7a9ew5c3ebc982bf9b07b@mail.gmail.com> <Pine.LNX.4.63.0609131804050.19042@wbgn013.biozentrum.uni-wuerzburg.de> <9e4733910609131022y19327efy541ac451bdf4b009@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Petr Baudis <pasky@suse.cz>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 13 19:32:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNYb0-0003Mx-5L
	for gcvg-git@gmane.org; Wed, 13 Sep 2006 19:32:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbWIMRcT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Sep 2006 13:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbWIMRcT
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Sep 2006 13:32:19 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:39361 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1750832AbWIMRcS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Sep 2006 13:32:18 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GNYam-0006SQ-9z; Wed, 13 Sep 2006 13:32:08 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8ECC920E49A; Wed, 13 Sep 2006 13:32:12 -0400 (EDT)
To: Jon Smirl <jonsmirl@gmail.com>
Content-Disposition: inline
In-Reply-To: <9e4733910609131022y19327efy541ac451bdf4b009@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26926>

Jon Smirl <jonsmirl@gmail.com> wrote:
> On 9/13/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> >Hi,
> >
> >On Wed, 13 Sep 2006, Jon Smirl wrote:
> >
> >> Moving the refs into refs/abandoned would work too. We would need new
> >> git commands to do this and flags on the visualization tools to
> >> include the abandoned branches. On the other hand doing this is
> >> recording state about the repository in the refs directory instead of
> >> writing this state into the repo itself.
> >
> >Well, the refs directory is _part_ of the repository. Think about it, if
> >you do not know which branches are in the object database, you lack a lot
> >of information.
> 
> If you delete all of your heads you can recover them by following all
> of the chains in the repo to find them. Doing this would recover the
> abandoned branches too but it would mix them up with the active heads.
> This is not a big deal but it is info that is getting stored outside
> of the object db.

No.  Being able to get a ref back like that is like saying that I
can get files back in ext2 by deleting them then running fsck and
restoring the lost inodes to '/lost+found'.  Sure the data is there
but there's no way to tell which file is which!

The name of a ref, like the name of a file, is pretty important
when it comes to describing it.  Just having the SHA1 ID of 100
commits is pretty useless; it could take weeks to determine which
branch head is which.  The refs database is an important part of
the usability of a Git repository.

-- 
Shawn.
