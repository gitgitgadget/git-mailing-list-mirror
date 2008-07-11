From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: feature request: git-log should accept sth like
 v2.6.26-rc8-227
Date: Fri, 11 Jul 2008 20:57:13 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807112041470.8950@racer>
References: <200807102057.15063.toralf.foerster@gmx.de> <200807111539.06606.toralf.foerster@gmx.de> <37fcd2780807110744k3b2a332csdf788dabd172622c@mail.gmail.com> <200807111658.40626.toralf.foerster@gmx.de> <20080711192902.GD1721@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-686901907-1215806234=:8950"
Cc: =?ISO-8859-15?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>,
	git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 21:58:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHOkx-000567-3G
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 21:58:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757150AbYGKT5Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 15:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756459AbYGKT5P
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 15:57:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:43010 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756184AbYGKT5O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 15:57:14 -0400
Received: (qmail invoked by alias); 11 Jul 2008 19:57:13 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp031) with SMTP; 11 Jul 2008 21:57:13 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19GWC1FjMxGrMtPIQ000olmkK4eq7UXhCnrUJY2mQ
	uluxKu3Vd4+N4r
X-X-Sender: gene099@racer
In-Reply-To: <20080711192902.GD1721@dpotapov.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88165>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-686901907-1215806234=:8950
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 11 Jul 2008, Dmitry Potapov wrote:

> On Fri, Jul 11, 2008 at 04:58:40PM +0200, Toralf Förster wrote:
> > 
> > $> git-log v2.6.26-rc9.. --pretty=short | grep "^commit" | cut -f2 -d' ' | xargs -n 1 git describe | grep '\-56\-'
> 
> The fastest way to do the same would be:
> 
> git rev-list v2.6.26-rc9.. | xargs git describe | grep '\-56\-'

You forgot the "--all" option to rev-list.

And I doubt it would be the "fastest" way, in terms of execution speed.

Also, it leaves out this case:

rc9 - A - B - C - D - F
    \               /
      ----- E -----

F would be "rc9-5", but also "rc9-2".

Oh, and this would leave out reflogs, too.

Can we please let this concept die now?

Hth,
Dscho

--8323329-686901907-1215806234=:8950--
