From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] push: Learn to set up branch tracking with '--track'
Date: Fri, 30 Jan 2009 16:58:25 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901301656290.3586@pacific.mpi-cbg.de>
References: <cover.1233236267u.git.johannes.schindelin@gmx.de> <alpine.DEB.1.00.0901291438030.3586@pacific.mpi-cbg.de> <20090129223308.GB12871@coredump.intra.peff.net> <20090129231715.GA17399@coredump.intra.peff.net> <alpine.DEB.1.00.0901300127450.3586@pacific.mpi-cbg.de>
 <20090130050925.GA18809@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 30 16:59:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSvmG-00013e-Pr
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 16:59:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751754AbZA3P6H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 10:58:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbZA3P6G
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 10:58:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:54543 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751384AbZA3P6F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 10:58:05 -0500
Received: (qmail invoked by alias); 30 Jan 2009 15:58:00 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp011) with SMTP; 30 Jan 2009 16:58:00 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX188VJhNByc8SCyOSNZs8sfiE8L0fQQrb41Hy+HxG9
	oGuegyTyBFvj+a
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090130050925.GA18809@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107833>

Hi,

On Fri, 30 Jan 2009, Jeff King wrote:

> On Fri, Jan 30, 2009 at 01:28:38AM +0100, Johannes Schindelin wrote:
> 
> > > Something like the patch below (which is obviously missing all of the 
> > > infrastructure for doing this optionally, but is meant to illustrate 
> > > what I'm talking about).
> > 
> > Except that you miss http:// and rsync:// protocols.  Those were the 
> > reasons I did not touch send-pack.
> 
> You didn't comment on the part of my email where I said exactly that,
> but that I think this is still the right path forward.
> 
> Pushing through those protocols is sorely in need of update (actually,
> I thought rsync was all but dead at this point). But http push is
> missing the update of tracking refs, the usual status output (it still
> has the "Maybe you are not up-to-date and need to pull first?" message
> that was removed from send-pack a year and a half ago), and who knows
> what other tweaks made to do_send_pack (which it appears to have been
> copy-and-pasted from in 2006) in the last few years.
> 
> So either we don't care about http-push being consistent with send-pack,
> and it is OK to have this feature in one but not the other. Or we do,
> and we really need to clean up the current divergence.

I do not see how your patch to send-pack makes that divergence any 
better, or for that matter, keeps it as bad as it is.

In other words, if you want to give the other protocols at least a 
_chance_ to catch up, you definitely need the support for push --track in 
builtin-push.c or at least in transport.c.

Ciao,
Dscho
