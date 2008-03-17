From: Theodore Tso <tytso@MIT.EDU>
Subject: Re: repo.or.cz renovated
Date: Mon, 17 Mar 2008 15:34:23 -0400
Message-ID: <20080317193423.GI8368@mit.edu>
References: <20080313231413.27966.3383.stgit@rover> <m3ve3nwtl3.fsf@localhost.localdomain> <20080317181015.GC10335@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Mar 17 20:35:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbL7f-0004AY-Uc
	for gcvg-git-2@gmane.org; Mon, 17 Mar 2008 20:35:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756653AbYCQTfG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2008 15:35:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756661AbYCQTfF
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Mar 2008 15:35:05 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:50630 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756346AbYCQTfD (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Mar 2008 15:35:03 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m2HJYZne028124;
	Mon, 17 Mar 2008 15:34:36 -0400 (EDT)
Received: from closure.thunk.org (c-98-216-98-217.hsd1.ma.comcast.net [98.216.98.217])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m2HJYOUY007017
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 17 Mar 2008 15:34:30 -0400 (EDT)
Received: from tytso by closure.thunk.org with local (Exim 4.67)
	(envelope-from <tytso@mit.edu>)
	id 1JbL6F-00067f-Qb; Mon, 17 Mar 2008 15:34:23 -0400
Content-Disposition: inline
In-Reply-To: <20080317181015.GC10335@machine.or.cz>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77459>

On Mon, Mar 17, 2008 at 07:10:15PM +0100, Petr Baudis wrote:
> Actually, it was overwhelmed to so much by its success but by lack of
> good maintenance. ;-) I gave it some love again for the past week and
> the improvement was, well, overwhelming. :-)
> 
> I finally fixed tons of failures and broken repositories, and most
> importantly repacked some of the big repositories with object databases
> in pretty horrid shape. The effect has been immense, having everything
> in database of 1/3 the size and single big pack drastically reduced the
> I/O load.

Are you making sure that repositories which are forks off of some
parent repository are using objects/info/alternates to share objects?
(If so you have to be careful when you prune not to drop objects, but
it can make a huge difference in disk utilization and I/O bandwidth).

At least for master.kernel.org, and for those git repositories which I
own, I make a point of periodically logging in and running git gc,
copying over the object packs so I can do a prune operation safely,
etc.  --- and I suspect most of the master.kernel.org git users do
something similar.  On repo.or.cz we don't have shell access, so the
project administrators can't do that for you.

> So for anyone running a hosting site, make sure your repositories are
> nicely packed. It makes huge difference to the I/O load!

It seems that a Really Good Idea would be do the the packing and
pruning via cron scripts that run during the off hours...

> My current plan is to have a [Search project] box at the front page,
> together with direct link to 'show all'. Other than that, what makes
> sense to display on the front page? I think recently added projects (age
> < 1 week) for sure. I'm not so sure about recently changed projects -
> maybe it is better to keep the front page cruft-free.

There are plenty of ways which sites like freshmeat and sourceforge
have come up to make it easy to browse a large number of software
projects.  One way that might make sense is Sourceforge's Software Map
(i.e., http://sourceforge.net/softwaremap/).


					- Ted
