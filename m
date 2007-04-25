From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: using stgit/guilt for public branches
Date: Wed, 25 Apr 2007 23:37:05 +0200
Organization: Dewire
Message-ID: <200704252337.05851.robin.rosenberg.lists@dewire.com>
References: <20070425122048.GD1624@mellanox.co.il> <20070425191838.GA6267@filer.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	Junio C Hamano <junkio@cox.net>,
	Catalin Marinas <catalin.marinas@arm.com>, git@vger.kernel.org,
	"Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>
To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
X-From: git-owner@vger.kernel.org Wed Apr 25 23:37:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgpAu-0000dx-IJ
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 23:37:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993124AbXDYVhP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 17:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993127AbXDYVhP
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 17:37:15 -0400
Received: from [83.140.172.130] ([83.140.172.130]:14975 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S2993124AbXDYVhN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 17:37:13 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 4433180265D;
	Wed, 25 Apr 2007 23:31:17 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 01125-10; Wed, 25 Apr 2007 23:31:16 +0200 (CEST)
Received: from [10.9.0.6] (unknown [10.9.0.6])
	by dewire.com (Postfix) with ESMTP id D69D2802651;
	Wed, 25 Apr 2007 23:31:16 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <20070425191838.GA6267@filer.fsl.cs.sunysb.edu>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45583>

onsdag 25 april 2007 skrev Josef Sipek:
> On Wed, Apr 25, 2007 at 03:20:49PM +0300, Michael S. Tsirkin wrote:
[...]
> > I am concerned that publishing a git branch managed by stg/guilt
> > would present problems: it seems that every time patches are re-ordered,
> > a patch is re-written or removed, or we update from upstream,
> > everyone who pulls the tree branch will have a hard-to-resolve conflict.
> > 
> > Is that really a problem? If so, would it be possible to work around this
> > somehow?
> 
> I thought about this problem a while back when I was trying to decide how to
> manage the Unionfs git repository. I came to the conclusion, that there was
> no clean way of doing this (at least not using guilt - I can't really speak
> for stgit, as I don't know how it does things exactly).

StGit has the same problem. Publishing such a branch is only for viewing if
you want to publish the tip, like the pu branch in the Git repo. You shouldn't
merge from pu either.

Patches your are done and not stored as patches anymore can be propagated 
to a "stable" branch using git branch -f stable HEAD~$(stg applied|wc -l) 
which is then pushed like  any other branch. Don't play the stg uncommit game 
too much to avoid a mess.

I'm  not sure the branch command is the best way, but you get the idea.

-- robin
