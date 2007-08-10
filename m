From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: msysgit: does git gui work?
Date: Fri, 10 Aug 2007 13:13:56 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708101309430.21857@racer.site>
References: <3CD6111C-13B5-444C-A28C-A7445C8A199B@zib.de>
 <E886F099-5E9F-4785-A560-F9AAAA4E4C1F@zib.de> <20070810053158.GJ24573@spearce.org>
 <B6C82889-ABE0-4B3D-A455-A2EE1CE48297@zib.de> <Pine.LNX.4.64.0708101113380.21857@racer.site>
 <3351C69E-C0A8-4D02-9E04-085E18F1DF75@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marius Storm-Olsen <marius@trolltech.com>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Fri Aug 10 14:15:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJTPA-0003Ht-Dl
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 14:15:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764440AbXHJMO7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Aug 2007 08:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935932AbXHJMO6
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Aug 2007 08:14:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:48457 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1763935AbXHJMOp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2007 08:14:45 -0400
Received: (qmail invoked by alias); 10 Aug 2007 12:14:43 -0000
Received: from ppp-82-135-7-57.dynamic.mnet-online.de (EHLO [192.168.1.4]) [82.135.7.57]
  by mail.gmx.net (mp047) with SMTP; 10 Aug 2007 14:14:43 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18/J9ogbug/z1FSCWRttBNaR4/Vu5y9lWUISGQOIj
	YbzIvEOAdOWkT5
X-X-Sender: gene099@racer.site
In-Reply-To: <3351C69E-C0A8-4D02-9E04-085E18F1DF75@zib.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55532>

Hi,

On Fri, 10 Aug 2007, Steffen Prohaska wrote:

> On Aug 10, 2007, at 12:16 PM, Johannes Schindelin wrote:
> 
> > On Fri, 10 Aug 2007, Steffen Prohaska wrote:
> > 
> > > I recognized that '.' is included in the PATH in /etc/profile.
> > > I don't think this is a good idea. At least it bit me once when
> > > I expected to run /bin/git but instead /git/./git was chosen.
> > > Shouldn't we remove '.' from the PATH?
> > 
> > In my experience, Windows users (not Mac users forced to use Windows)
> > _expect_ "." to be in the PATH.
> 
> Ah, what a crazy and dangerous world Windows is ;)

Yes, and I'd rather not disappoint those expectations.

> > Regarding the tclsh thing:  IMHO to unwaste space, we should add a
> > 
> > 	#!/bin/sh
> > 	exec tclsh84 "$@"
> > 
> > instead.  MinGW does not have symlinks, and we should not put more space
> > to waste than Windows does already, by copying files around (yes, the
> > repository will not care, but the working tree will).
> 
> I agree and pushed the following to mob
> 
> faeb4e3df9fb7c853dd1a46d6942776d4a743545
> 
> I forced a non-fast-forward of mob. Is this ok? Apparently it's allowed.

Yes, it is allowed exactly for this purpose.  When you want to redo/undo 
commits.

> Another question related to mob. How do I need to setup /git/.git/config
> to be able to push to git's mob?

My understanding is that the GitMe installer already sets up a remote 
named "mob".

	$ git push mob

It automatically pushes the "master" branch to "mob".  If you have to 
force the push, you'll have to do this:

	$ git push mob +master:mob

But please avoid this when possible, since you might well overwrite other 
people's work.

Ciao,
Dscho
