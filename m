From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Mozilla import and large history
Date: Sat, 26 Aug 2006 01:40:02 -0400
Message-ID: <20060826054002.GA22343@spearce.org>
References: <200608240015.15071.jnareb@gmail.com> <200608252135.27894.jnareb@gmail.com> <e5bfff550608251433o36713ee1na5544992320b5845@mail.gmail.com> <7vveog45ff.fsf@assigned-by-dhcp.cox.net> <e5bfff550608252144p2d234a7cnf2ca2922c98d921b@mail.gmail.com> <7vejv43wq9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 26 07:40:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGqu1-0007kZ-3K
	for gcvg-git@gmane.org; Sat, 26 Aug 2006 07:40:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422705AbWHZFkI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Aug 2006 01:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422725AbWHZFkI
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Aug 2006 01:40:08 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:64176 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S964915AbWHZFkG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Aug 2006 01:40:06 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GGqto-0006ZT-3o; Sat, 26 Aug 2006 01:40:04 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6C5C220FB7F; Sat, 26 Aug 2006 01:40:02 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vejv43wq9.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26031>

Junio C Hamano <junkio@cox.net> wrote:
> People with long history stored in some SCM tend to want to
> migrate their history and then switch, and I expect that to be
> the norm, especially with the progress Mozilla import team is
> making with the CVS interface.

Not to hijack a thread or anything but we are definately making
some progress here.  Jon Smirl is able to import blob revisions,
create trees, commits and tags.  Import for Mozilla is down from
approx. a week to around 4 hours but right now we are finding that
the import isn't always correct.

Fortunately we've built a script to compare the result of the import
into GIT with the result of the import into SVN, as the cvs2svn
import is believed to be correct.  The script is not however very
fast, as it compares an SVN revision to the corresponding GIT tree
by checking out the SVN revision to a working directory, loading
the GIT tree into an index and using git-diff-files to compare them.

That simple script has caught a number of errors but has also
confirmed a number of cases as working correctly.  We're slowly
working through the errors.

We may also do a CVS checkout based script to verify branch heads
and labels all match, just as an extra check against what the native
SVN import had given.

-- 
Shawn.
