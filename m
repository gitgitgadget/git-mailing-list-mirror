From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH] enable rerere by default
Date: Wed, 7 Feb 2007 00:19:00 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702070016360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0702061103070.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <81b0412b0702060556r3e366defwe4b7afabdf5ffb7c@mail.gmail.com>
 <Pine.LNX.4.63.0702061602360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vhctyhon2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Feb 07 00:19:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEZal-0001d9-Nh
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 00:19:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030565AbXBFXTF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Feb 2007 18:19:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030567AbXBFXTE
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Feb 2007 18:19:04 -0500
Received: from mail.gmx.net ([213.165.64.20]:47916 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030563AbXBFXTC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Feb 2007 18:19:02 -0500
Received: (qmail invoked by alias); 06 Feb 2007 23:19:00 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp049) with SMTP; 07 Feb 2007 00:19:00 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vhctyhon2.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38878>

Hi,

On Tue, 6 Feb 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> How do I disable rerere by default?
> >
> > How'd you like it? Should this rather become a config variable, or do you 
> > want to make a file called "rr-cache" in the templates, which just 
> > contains a word "disabled"? (git-rerere checks if a _directory_ 
> > $GIT_DIR/rr-cache exists.)
> 
> Is it so bad to do "rm -rf .git/rr-cache"?

I guess the problem is that you cannot do that by a hook, or by installing 
appropriate templates.

Since the test for rr-cache always is a test for a directory, it might 
make sense to _not_ fail in init-db when creating the directory. In that 
case, rerere can be disabled by installing templates which make rr-cache a 
_file_.

Ciao,
Dscho
