From: Petr Baudis <pasky@suse.cz>
Subject: Re: Subversion-style incrementing revision numbers
Date: Wed, 20 Sep 2006 00:00:11 +0200
Message-ID: <20060919220011.GD8259@pasky.or.cz>
References: <Pine.LNX.4.62.0609191309140.9752@joeldicepc.ecovate.com> <20060919211844.GB8259@pasky.or.cz> <Pine.LNX.4.62.0609191525490.9752@joeldicepc.ecovate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 00:00:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPnda-00019M-Oj
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 00:00:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbWISWAP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Sep 2006 18:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbWISWAO
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Sep 2006 18:00:14 -0400
Received: from w241.dkm.cz ([62.24.88.241]:21915 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751149AbWISWAN (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Sep 2006 18:00:13 -0400
Received: (qmail 23950 invoked by uid 2001); 20 Sep 2006 00:00:11 +0200
To: Joel Dice <dicej@mailsnare.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0609191525490.9752@joeldicepc.ecovate.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27293>

Dear diary, on Tue, Sep 19, 2006 at 11:42:20PM CEST, I got a letter
where Joel Dice <dicej@mailsnare.net> said that...
> On Tue, 19 Sep 2006, Petr Baudis wrote:
> >Also, multiple IRNs could refer to a single real commit if you do e.g.
> >cg-admin-uncommit, since revlog logs revision updates, not new revisions
> >created. This may or may not be considered a good thing. If you rather
> >want to just create a new IRN at commit object creation time, also note
> >that some tools _might_ validly create commit objects and then throw
> >them away, which would generate non-sensical (and after prune, invalid)
> >IRNs.
> 
> I'm not too worried about cg-admin-uncommit or git-reset, since the IRN 
> feature is intended mainly for shared repositories.  I would suggest that 
> such commands simply be disallowed for such repositories.

  What kind of shared repositories? You yourself said that IRNs are
local to a repository, thus they are not preserved over cloning/fetching
from a repository, if you mean that.

> The problem of temporary commits certainly needs to be addressed.  In this 
> case, may I assume nothing under $GIT_DIR/refs is ever modified?  If so, 
> perhaps I could somehow hook into the git-update-ref step.  Is that what 
> the revlog code does?

  Yes. But not every commit is always recorded to something in refs/.
The simplest case is if you fetch from a remote repository (or push to
your repository), only the latest commit is recorded.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
