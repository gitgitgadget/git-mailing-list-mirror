From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Switch receive.denyCurrentBranch to "refuse"
Date: Fri, 30 Jan 2009 14:23:02 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901301421170.3586@pacific.mpi-cbg.de>
References: <cover.1233275583u.git.johannes.schindelin@gmx.de> <alpine.DEB.1.00.0901300133070.3586@pacific.mpi-cbg.de> <4982A99C.6070301@viscovery.net> <20090130073415.GA27224@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 30 14:24:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LStLq-0000e6-6A
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 14:24:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752694AbZA3NWl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 08:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752583AbZA3NWl
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 08:22:41 -0500
Received: from mail.gmx.net ([213.165.64.20]:39261 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752384AbZA3NWj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 08:22:39 -0500
Received: (qmail invoked by alias); 30 Jan 2009 13:22:37 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp015) with SMTP; 30 Jan 2009 14:22:37 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18kofk+YNMk5ZGNsrQFx1JuddiNHYiOpfOzOjObEo
	jkYYoYYQPtzk5U
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090130073415.GA27224@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107813>

Hi,

On Fri, 30 Jan 2009, Jeff King wrote:

> On Fri, Jan 30, 2009 at 08:17:48AM +0100, Johannes Sixt wrote:
> 
> > Johannes Schindelin schrieb:
> > > +		error("refusing to update checked out branch: %s\n"
> > > +			"if you know what you are doing, you can allow it by "
> > > +			"setting\n\n"
> > > +			"\tgit config receive.denyCurrentBranch true\n", name);
> > 
> > Oh, fscking hell, I should have screamed out loudly when Jeff named this
> > option "denyCurrentBranch" instead of "allowCurrentBranch". It's all too
> > easy to fall into the trap, like you here.
> 
> Sorry. ;P
> 
> On the other hand, you also missed the boat on receive.denyDeletes and
> receive.denyNonFastForwards.

The idea with these is that they are _booleans_, and therefore

	[receive]
		denyDeletes

is something natural to write, because "denyDeletes" is _not_ the default.

However, with denyCurrentBranch we wanted to change the default in the 
long run, so I agree it was a not-so-brilliant choice.

Ciao,
Dscho
