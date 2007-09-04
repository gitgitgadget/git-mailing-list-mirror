From: Rutger Nijlunsing <rutger@nospam.com>
Subject: Re: [PATCH] Add a new lstat and fstat implementation based on
	Win32 API
Date: Tue, 4 Sep 2007 23:02:00 +0200
Organization: M38c
Message-ID: <20070904210200.GA32472@nospam.com>
References: <46DACE0D.5070501@trolltech.com> <46DBBC1E.4010407@eudaptics.com> <46DBFA2A.7050003@trolltech.com> <Pine.LNX.4.64.0709031428080.28586@racer.site> <46DC5ED4.8050202@trolltech.com> <46DD0C16.70101@eudaptics.com> <Pine.LNX.4.64.0709041145230.28586@racer.site> <46DD433A.5040604@eudaptics.com> <Pine.LNX.4.64.0709041324420.28586@racer.site> <Pine.LNX.4.64.0709041356070.28586@racer.site>
Reply-To: git@wingding.demon.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@eudaptics.com>,
	Marius Storm-Olsen <marius@trolltech.com>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Sep 04 23:29:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISfxc-0007YA-93
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 23:29:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755616AbXIDV3P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 17:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754166AbXIDV3H
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 17:29:07 -0400
Received: from post-23.mail.nl.demon.net ([194.159.73.193]:57986 "EHLO
	post-23.mail.nl.demon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754836AbXIDV3F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 17:29:05 -0400
X-Greylist: delayed 1620 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Sep 2007 17:29:05 EDT
Received: from wingding.demon.nl ([82.161.27.36]:37308)
	by post-23.mail.nl.demon.net with esmtp (Exim 4.51)
	id 1ISfXA-000OVC-9m; Tue, 04 Sep 2007 21:02:04 +0000
Received: from rutger by wingding.demon.nl with local (Exim 4.67)
	(envelope-from <rutger@wingding.demon.nl>)
	id 1ISfX6-0000R6-JL; Tue, 04 Sep 2007 23:02:00 +0200
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0709041356070.28586@racer.site>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57649>

On Tue, Sep 04, 2007 at 01:57:38PM +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Tue, 4 Sep 2007, Johannes Schindelin wrote:
> 
> > On Tue, 4 Sep 2007, Johannes Sixt wrote:
> > 
> > > Johannes Schindelin schrieb:
> > > > On Tue, 4 Sep 2007, Johannes Sixt wrote:
> > > > > Therefore, I've pushed out a fixup patch at the top of mingw.git's 
> > > > > devel branch that converts mtime to local time
> > > > 
> > > > On Linux, we compare to UTC to begin with, right?  We should do that 
> > > > here, too...  So if time(NULL) does not return UTC on MinGW, we have 
> > > > to wrap that function, too.
> > > 
> > > According to MSDN, time(NULL) returns "the number of seconds elapsed 
> > > since [epoch] according to the system clock". Please don't ask me what 
> > > "the system clock" is.
> > 
> > I think I know.  From my QEmu adventures I know that DOS/Windows expects 
> > the system clock to be set to local time, in contrast to _all_ other 
> > operating systems.
> 
> Now I am utterly confused.  MSDN says
> 
> 	FILETIME
> 
> 	Contains a 64-bit value representing the number of 100-nanosecond 
> 	intervals since January 1, 1601 (UTC).
> 
> Hmm.


[Warning: war stories ahead...]

If you really, really want to know more:

http://search.cpan.org/~shay/Win32-UTCFileTime-1.45/lib/Win32/UTCFileTime.pm


-- 
Rutger Nijlunsing ---------------------------------- eludias ed dse.nl
never attribute to a conspiracy which can be explained by incompetence
----------------------------------------------------------------------
