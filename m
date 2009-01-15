From: Andreas Bombe <andreas.bombe@mytum.de>
Subject: Re: current git kernel has strange problems during bisect
Date: Thu, 15 Jan 2009 17:54:25 +0100
Message-ID: <20090115165425.GA7517@bombe-desk.opditex>
References: <200901111602.53082.borntraeger@de.ibm.com> <20090111194258.GA4840@uranus.ravnborg.org> <alpine.LFD.2.00.0901111200330.6528@localhost.localdomain> <200901112239.20306.borntraeger@de.ibm.com> <f73f7ab80901131226s6af7730cucf9c44bc2b4f9545@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Borntraeger <borntraeger@de.ibm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Kyle Moffett <kyle@moffetthome.net>
X-From: git-owner@vger.kernel.org Thu Jan 15 18:22:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNVvd-0001q9-C5
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 18:22:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758166AbZAORVZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 12:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758089AbZAORVY
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 12:21:24 -0500
Received: from dd13538.kasserver.com ([85.13.135.107]:58169 "EHLO
	dd13538.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758080AbZAORVX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 12:21:23 -0500
X-Greylist: delayed 1614 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Jan 2009 12:21:23 EST
Received: from localhost.localdomain (p5B0D50D8.dip.t-dialin.net [91.13.80.216])
	by dd13538.kasserver.com (Postfix) with ESMTP id 46FAA18156E8E;
	Thu, 15 Jan 2009 17:54:30 +0100 (CET)
Received: from andreas by localhost.localdomain with local (Exim 4.69)
	(envelope-from <andreas@bombe-desk.opditex>)
	id 1LNVU9-0003fD-SG; Thu, 15 Jan 2009 17:54:25 +0100
Mail-Followup-To: Kyle Moffett <kyle@moffetthome.net>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f73f7ab80901131226s6af7730cucf9c44bc2b4f9545@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105859>

On Tue, Jan 13, 2009 at 03:26:09PM -0500, Kyle Moffett wrote:
> On Sun, Jan 11, 2009 at 4:39 PM, Christian Borntraeger
> <borntraeger@de.ibm.com> wrote:
> > In my opinion we should really avoid subtree merges in the future as a curtesy
> > to people who do the uncool work of testing, problem tracking and bisecting.
> > </rant>
> 
> As an alternative, you can relatively easily rewrite the following
> independent histories:
> 
> A -- B -- C
> X -- Y -- Z
> 
> To look like this:
> 
> A -- B -- C -- X' -- Y' -- Z'
> 
> Where X' is (C + sub/dir/X), Y' is (C + sub/dir/Y), etc...

Given that the subtree may have been in development for a long time, it
is almost a certainty that the older commits may compile on A but not
on C.  By basing it all on C you create a lot of uncompilable commits
which hurt bisection just as bad.  At least with missing kernel sources
it is obvious that an attempt at compilation is futile and a waste of
time.
