From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH] Teach rebase to rebase even if upstream is up to
 date  with -f
Date: Thu, 12 Feb 2009 21:37:38 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902122134500.10279@pacific.mpi-cbg.de>
References: <1234468061-29923-1-git-send-email-srabbelier@gmail.com>  <alpine.DEB.1.00.0902122126460.10279@pacific.mpi-cbg.de> <bd6139dc0902121230w1b9fec28sae4e14bdda58a50b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailinglist <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 21:38:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXiKB-0006ze-Ny
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 21:38:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759049AbZBLUgv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 15:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758595AbZBLUgv
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 15:36:51 -0500
Received: from mail.gmx.net ([213.165.64.20]:33253 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758893AbZBLUgu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 15:36:50 -0500
Received: (qmail invoked by alias); 12 Feb 2009 20:36:48 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp052) with SMTP; 12 Feb 2009 21:36:48 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18PRLIAvxMPWAFeTvITbNEO+2D2nyoACM65VYE0Fi
	K7aiNcCR9br4XI
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <bd6139dc0902121230w1b9fec28sae4e14bdda58a50b@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109643>

Hi,

On Thu, 12 Feb 2009, Sverre Rabbelier wrote:

> On Thu, Feb 12, 2009 at 21:28, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > FWIW I typically use 'git rebase --whitespace=fix $(git merge-base
> > origin/master master)' for that, but that only works when there is a
> > single merge base.
> 
> Hehe, shouldof known there is an easier way to do it currently. Why
> does that work though?

It works because you are not rebasing onto 'master', but the merge base of 
'master' and your current branch.

So in contrast to the other situation, there are commits left to be 
rebased :-)

> Also, any comments on the patch? ;)

There is probably a thinko in it: if "master" already has your patches, 
then you cannot apply them on top of "master".  That should conflict 
rather horribly, and not change the commits that are already upstream.

Or I misunderstand something here.  Quite possible, I am pretty tired.

Ciao,
Dscho
