From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Status of Mac OS/X ports of git and cogito?
Date: Sun, 11 Sep 2005 14:43:40 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0509111427190.23242@iabervon.org>
References: <deofnh$jl0$1@sea.gmane.org> <7vd5o03uof.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0509111159190.32555@wgmdd8.biozentrum.uni-wuerzburg.de>
 <7vvf17tsoa.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	John Ellson <ellson@research.att.com>, git@vger.kernel.org,
	Patrick Mauritz <oxygene@studentenbude.ath.cx>,
	Jason Riedy <ejr@EECS.Berkeley.EDU>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sun Sep 11 20:41:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEWjr-0001DK-Rb
	for gcvg-git@gmane.org; Sun, 11 Sep 2005 20:39:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbVIKSjh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 14:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbVIKSjh
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 14:39:37 -0400
Received: from iabervon.org ([66.92.72.58]:34060 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751081AbVIKSjh (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Sep 2005 14:39:37 -0400
Received: (qmail 18132 invoked by uid 1000); 11 Sep 2005 14:43:40 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 11 Sep 2005 14:43:40 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vvf17tsoa.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8317>

On Sun, 11 Sep 2005, Junio C Hamano wrote:

> Patrick and Jason CC:'ed because they also have portability
> issues and seem to have good ideas about how they should be
> solved.  Linus CC:'ed because he once expressed rather strongly
> his dislike about autoconf.
> 
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > I have three fixes in my personal tree without which git refuses to 
> > compile:
> >
> > - daemon.c needs a define or typedef for socklen_t.
> 
> I still keep that patch around (the patch was end of July), but
> have not touched it only because I did not hear from you asking
> about its inclusion.
> 
> > - mailinfo.c needs to have a simple strcasestr implementation, because 
> >   10.2.8 (at least in my setup) is lacking it!
> 
> Yes, I've used it knowing that it is marked as a GNU extension,
> hoping if somebody else can supply a patch to work it around ;-).
> 
> I am slightly reluctant to do autoconf [*1*], but I might be
> tempted to take patches if it is done cleanly.

I've never noticed autoconf successfully improving portability, and it 
seems to mostly obfuscate errors. E.g., the GNU binutils I was trying to 
build recently, if you don't have "msgfmt", helpfully runs "no" instead. 
Of course, that's autoconf being misused, but if binutils can't use it 
correctly, I doubt any other project can keep from messing up.

Compatibility workarounds with simple detection scripts invoked by people 
who find they actually need workarounds are probably best.

	-Daniel
*This .sig left intentionally blank*
