From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: branch ahead in commits but push claims all up to date
Date: Tue, 24 Mar 2009 21:24:45 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0903242118270.19665@iabervon.org>
References: <7001b7a00903240821v2155d234x6a10c80a3e987acb@mail.gmail.com>  <7001b7a00903240822w70a57349xcc66a02cef62dc70@mail.gmail.com>  <43d8ce650903240918q2ffdba44w241e0f378a11fd3d@mail.gmail.com>  <alpine.LNX.1.00.0903241304090.19665@iabervon.org>
 <43d8ce650903241726s122cc468q4ea9188e1561832@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1547844168-47945306-1237944285=:19665"
Cc: Irene Ros <imirene@gmail.com>, git@vger.kernel.org
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 02:26:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmHsq-00019D-0W
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 02:26:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754089AbZCYBYt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 21:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753444AbZCYBYt
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 21:24:49 -0400
Received: from iabervon.org ([66.92.72.58]:48507 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752866AbZCYBYs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 21:24:48 -0400
Received: (qmail 2625 invoked by uid 1000); 25 Mar 2009 01:24:45 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Mar 2009 01:24:45 -0000
In-Reply-To: <43d8ce650903241726s122cc468q4ea9188e1561832@mail.gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114534>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1547844168-47945306-1237944285=:19665
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 25 Mar 2009, John Tapsell wrote:

> 2009/3/24 Daniel Barkalow <barkalow@iabervon.org>:
> > On Tue, 24 Mar 2009, John Tapsell wrote:
> >
> >> 2009/3/24 Irene Ros <imirene@gmail.com>:
> >> > Hi all,
> >> >
> >> > I've been using git for some time now and haven't run into this issue
> >> > before, perhaps someone else here has:
> >> >
> >> > I have a branch that is ahead of its origin by a few commits:
> >> >
> >> > $ git status
> >> > # On branch myBranch
> >> > # Your branch is ahead of 'origin/myBranch' by 10 commits.
> >>
> >> Tried running: git fetch   ?
> >>
> >> For some weird reason  "git push origin mybranch"  doesn't actually
> >> update origin/mybranch.  It's more annoying :-)
> >
> > It should, so long as you're using the native transport and
> > origin/mybranch actually tracks mybranch on origin.
> >
> > "git push" doesn't update it, but the code that implements the native
> > transport does update it if it succeeds.
> >
> > (Actually, I'm not 100% sure that, if you update origin through some other
> > channel with exactly the commit that you now have in mybranch locally, and
> > then try the push, it will update the local tracking for that branch; is
> > that what you've hit?)
> 
> I update via http - maybe that's why?  origin/mybranch is never
> updated when I push.  It's not just a once-off quirk.

Yup, http doesn't have it. One of my series currently in next moves it 
from the git-specific protocol to the common code, but there's still work 
to be done to allow the http push transport to report back to the common 
code what got updated successfully, which is largely a matter of making 
the http-push code run in-process instead of as a command run by 
transport.c, and using the just-added API.

	-Daniel
*This .sig left intentionally blank*
--1547844168-47945306-1237944285=:19665--
