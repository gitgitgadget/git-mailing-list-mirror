From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Wishlist for a bundle-only transport mode
Date: Wed, 21 Nov 2007 17:26:36 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711211719330.27959@racer.site>
References: <8aa486160711210654p357ccd87i4809e0cda9471303@mail.gmail.com>
 <200711211752.40264.jnareb@gmail.com> <Pine.LNX.4.64.0711211658510.27959@racer.site>
 <200711211811.34391.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Santi =?iso-8859-1?q?B=E9jar?= <sbejar@gmail.com>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 21 18:27:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IutLm-0000Ot-EY
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 18:26:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752686AbXKUR0k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 12:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752541AbXKUR0k
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 12:26:40 -0500
Received: from mail.gmx.net ([213.165.64.20]:48077 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751897AbXKUR0j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 12:26:39 -0500
Received: (qmail invoked by alias); 21 Nov 2007 17:26:37 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp024) with SMTP; 21 Nov 2007 18:26:37 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18MYCZRUNwMsLfKql/JQygBXtdoeiYuIAeSVPLuYr
	gJowXy1aLMiv4q
X-X-Sender: gene099@racer.site
In-Reply-To: <200711211811.34391.jnareb@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65686>

Hi,

On Wed, 21 Nov 2007, Jakub Narebski wrote:

> Johannes Schindelin wrote:
> > On Wed, 21 Nov 2007, Jakub Narebski wrote:
> >
> >> That has the disadvantage of pushing to bundle when you make an error 
> >> in the lastpart of path to existing repository.
> > 
> > As I wrote in another reply, I would not allow overwriting an existing 
> > file.
> 
> > Specifying a non-existing file should be good enough.
> 
> What I meant here that if you do "git push /some/path/to/rpeo.git", with 
> mistake in the last part of path to repository, you would end up with a 
> bundle, and you would have to really watch what happened to catch the 
> error.

I use tab completion all the time, so this would not happen to me.  IMHO 
that is a lesser issue than to introduce a "protocol".

> I'd rather use "git push bundle:///some/path/to/bundle" or "git push 
> --bundle bundlename" to catch errors better.
> 
> Besides it should be IMHO be possible to overwrite bundle if you are 
> doing fast-forward push...

Not as far as I can see.  A push there would see what the bundle has 
already, and put them into the new bundle as _prerequisites_.  So the 
bundle would lose information.

BTW this was my gripe (that I decided not to make public earlier) with 
Santi's proposal to begin with: a push would not have any way to specify 
what the other side has already.  So I think "git push <bundle>" is the 
wrong way of creating a bundle.

Except if we add some cunning strategy not to overwrite, ever, but to 
create <bundle>.<n> with an incrementing <n>.  But that might be too much.

Ciao,
Dscho
