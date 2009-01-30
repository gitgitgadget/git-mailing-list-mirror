From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Switch receive.denyCurrentBranch to "refuse"
Date: Fri, 30 Jan 2009 14:28:39 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901301426150.3586@pacific.mpi-cbg.de>
References: <cover.1233275583u.git.johannes.schindelin@gmx.de> <alpine.DEB.1.00.0901300133070.3586@pacific.mpi-cbg.de> <20090130023040.GR21473@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Fri Jan 30 14:29:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LStRG-0002TK-O2
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 14:29:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752912AbZA3N2R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 08:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752704AbZA3N2R
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 08:28:17 -0500
Received: from mail.gmx.net ([213.165.64.20]:47017 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752694AbZA3N2Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 08:28:16 -0500
Received: (qmail invoked by alias); 30 Jan 2009 13:28:15 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp041) with SMTP; 30 Jan 2009 14:28:15 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18nYzQ8Wvoni9XZye99IZnmztzwY85n+D76iRscrZ
	qqeeoHI9wuNHA3
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090130023040.GR21473@genesis.frugalware.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107815>

Hi,

On Fri, 30 Jan 2009, Miklos Vajna wrote:

> On Fri, Jan 30, 2009 at 01:34:28AM +0100, Johannes Schindelin <johannes.schindelin@gmx.de> wrote:
> > -		error("refusing to update checked out branch: %s", name);
> > +		error("refusing to update checked out branch: %s\n"
> > +			"if you know what you are doing, you can allow it by "
> > +			"setting\n\n"
> > +			"\tgit config receive.denyCurrentBranch true\n", name);
> 
> Shouldn't this be
> 
> git config receive.denyCurrentBranch ignore
> 
> instead of "true"?

Right.

However, as Junio pointed out, we do not want to give this resolution in 
the error message.  I am now leaning more to something like

	refusing to update checked out branch '%s' in non-bare repository

Hmm?

Old-timers will know "oh, what the hell, I did not mark my repository as 
bare!", and new-timers will no longer be confused.

Ciao,
Dscho
