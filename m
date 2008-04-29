From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Excruciatingly slow git-svn imports
Date: Tue, 29 Apr 2008 00:11:22 -0700
Message-ID: <20080429071122.GG24171@muzzle>
References: <CC0F600D-71F3-493A-AA9C-AF901C1A58C4@adacore.com> <2C39C19D-0B81-4879-92DC-C0436DB6E84E@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Geert Bosch <bosch@adacore.com>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 09:12:12 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jqk0a-0007Ac-FB
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 09:12:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755811AbYD2HLY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 03:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755678AbYD2HLY
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 03:11:24 -0400
Received: from hand.yhbt.net ([66.150.188.102]:53660 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751391AbYD2HLY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 03:11:24 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 248F72DC08B;
	Tue, 29 Apr 2008 00:11:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2C39C19D-0B81-4879-92DC-C0436DB6E84E@midwinter.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80660>

Steven Grimm <koreth@midwinter.com> wrote:
> On Apr 24, 2008, at 11:54 AM, Geert Bosch wrote:
> 
> >I'm trying to import a 9.7G, 130K revision svn repository
> >but it seems to only import about 6K revisions per day on fast  
> >hardware
> >using a recent git (1.5.5).
> 
> I've found that git-svn gets slower as it runs. Try interrupting the  
> clone and running "git svn fetch" -- it should pick up where it left  
> off and will be MUCH faster if my experience is any indication. When I  
> clone the big svn repository at work I usually restart it every 1000  
> revisions or so and it finishes in a fraction of the time it takes if  
> I let it do everything in a single run.

That's really strange to hear...  The git-svn process itself does not
store much state other than the current revision and the log information
for the next 100 or so revisions it needs to import.

Are you packing the repository?  Which SVN protocol are you using?  Does
memory usage of git-svn stay stable throughout the run?

-- 
Eric Wong
