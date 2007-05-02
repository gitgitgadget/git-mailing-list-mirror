From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git benchmarks at OpenOffice.org wiki
Date: Wed, 2 May 2007 16:35:17 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705021630170.4015@racer.site>
References: <200705012346.14997.jnareb@gmail.com> <200705021624.25560.kendy@suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	releases@openoffice.org
To: Jan Holesovsky <kendy@suse.cz>
X-From: git-owner@vger.kernel.org Wed May 02 16:35:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjFvH-0003d5-Cs
	for gcvg-git@gmane.org; Wed, 02 May 2007 16:35:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993255AbXEBOfL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 May 2007 10:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993256AbXEBOfL
	(ORCPT <rfc822;git-outgoing>); Wed, 2 May 2007 10:35:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:52333 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S2993255AbXEBOfK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2007 10:35:10 -0400
Received: (qmail invoked by alias); 02 May 2007 14:35:08 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp057) with SMTP; 02 May 2007 16:35:08 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/oGCwgK/vozHVhDBCIRlV79/oTz22+0RO8uku4EX
	fyM9WrRdLFpo0C
X-X-Sender: gene099@racer.site
In-Reply-To: <200705021624.25560.kendy@suse.cz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46023>

Hi,

On Wed, 2 May 2007, Jan Holesovsky wrote:

> On Tuesday 01 May 2007 23:46, Jakub Narebski wrote:
> 
> > What I am concerned about is some of git benchmark results at Git page
> > on OpenOffice.org wiki:
> >   http://wiki.services.openoffice.org/wiki/Git#Comparison
> > Actually it is comparison with CVS and Subversion, although most
> > benchmarks are done only for git.
> 
> I did the git numbers, so if they are wrong - blame me :-)

Good to have you here!

> > 'Checkout time' (which should be renamed to 'Initial checkout time'),
> > in which git also loses with 130 minutes (Linux, 2MBit DSL) [from
> > go-oo.org], 100min (Linux, 2MBit DSL, Wireless, no proxy) [from
> > go-oo.org] versus 117 minutes (Linux, 2MBit DSL), 26 minutes (Linux,
> > 2MBit DSL, with compression (-z 6)) for CVS, and  60 Minutes (Windows,
> > 34Mbit Line) for Subversion, would also be helped by the above.
> 
> Good point, and I already changed the page in the morning.  I also added the
> checkout time that I got over a fast line [it was 44min].

It took me longer here, but the reason might be that my "local" repository 
is on NFS, due to quota on the machine.

> > What I'm really concerned about is branch switch and merging branches,
> > when one of the branches is an old one (e.g. unxsplash branch), which
> > takes 3min (!) according to the benchmark. 13-25sec for commit is also
> > bit long, but BRANCH SWITCHING which takes 3 MINUTES!? There is no
> > comparison benchmark for CVS or Subversion, though...

I imagine that might be related to the vast amount of remote branches. 
IIRC we do not pack them with git-gc, and ext3 is not that good with big 
directories (remember: 3464 branches!).

Maybe oprofile knows a bit more where the hotspots are.

Ciao,
Dscho
