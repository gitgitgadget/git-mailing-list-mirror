From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] t6030 (bisect): work around Mac OS X "ls"
Date: Thu, 24 Jul 2008 18:44:12 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807241842030.8986@racer>
References: <Pine.GSO.4.62.0807232014030.14945@harper.uchicago.edu> <200807240757.26290.chriscool@tuxfamily.org> <20080724060647.GA24587@glandium.org> <Pine.GSO.4.62.0807240233310.27074@harper.uchicago.edu> <20080724165434.GA26660@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jonathan Nieder <jrnieder@uchicago.edu>,
	Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Thu Jul 24 19:45:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM4sK-0002DY-4f
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 19:45:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751704AbYGXRoM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 13:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751605AbYGXRoL
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 13:44:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:50658 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751594AbYGXRoJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 13:44:09 -0400
Received: (qmail invoked by alias); 24 Jul 2008 17:44:08 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp067) with SMTP; 24 Jul 2008 19:44:08 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18LnrtvZ9wL0rIlgIjZ4hzJWmgxy2qOc0T+VwwoCQ
	v/PzKm5+F4bJLd
X-X-Sender: gene099@racer
In-Reply-To: <20080724165434.GA26660@glandium.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89922>

Hi,

On Thu, 24 Jul 2008, Mike Hommey wrote:

> On Thu, Jul 24, 2008 at 02:43:51AM -0500, Jonathan Nieder wrote:
>
> > Mike Hommey wrote:
> > 
> > > On Thu, Jul 24, 2008 at 07:57:26AM +0200, Christian Couder wrote:
> > >
> > >> +	test -z "$(ls .git/BISECT_*)" &&
> > > 
> > > That is still a useless use of ls ;)
> > 
> > It is much better than what I wrote, at least.
> 
> But could also be written with echo instead of ls.

Sure, but then it looks uglier:

		test ".git/BISECT_*" = "$(echo .git/BISECT_*)" &&

and it is much easier to hide a typo there.

And now the big question: is it performance critical?  Or is obvious 
correctness the highest goal here?

Hth,
Dscho
