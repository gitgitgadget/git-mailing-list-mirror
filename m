From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] push: Learn to set up branch tracking with '--track'
Date: Fri, 30 Jan 2009 01:28:38 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901300127450.3586@pacific.mpi-cbg.de>
References: <cover.1233236267u.git.johannes.schindelin@gmx.de> <alpine.DEB.1.00.0901291438030.3586@pacific.mpi-cbg.de> <20090129223308.GB12871@coredump.intra.peff.net> <20090129231715.GA17399@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 30 01:29:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LShGS-0003ZE-Ka
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 01:29:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755090AbZA3A2S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 19:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754812AbZA3A2S
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 19:28:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:53914 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754726AbZA3A2R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 19:28:17 -0500
Received: (qmail invoked by alias); 30 Jan 2009 00:28:15 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp038) with SMTP; 30 Jan 2009 01:28:15 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/VzBxuSvnVwMwE/7wcNVFmcmTf/gPcneKlLd19GC
	6oqFYK+pRoVSRD
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090129231715.GA17399@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107757>

Hi,

On Thu, 29 Jan 2009, Jeff King wrote:

> On Thu, Jan 29, 2009 at 05:33:08PM -0500, Jeff King wrote:
> 
> > So I think this patch is going about it the wrong way. Instead of
> > parsing the refspec, I think you actually want to look at what we _do_
> > push (or at least try to push -- probably even uptodate refs should also
> > have tracking established), and use that. Then you will have wildcards
> > expanded, --all handled, etc. And I suspect all you have to do is
> > iterate over the result of match_refs (which we call later), which
> > should be even easier (because you don't have to parse the refspecs
> > yourself). But I haven't looked carefully.
> 
> Something like the patch below (which is obviously missing all of the 
> infrastructure for doing this optionally, but is meant to illustrate 
> what I'm talking about).

Except that you miss http:// and rsync:// protocols.  Those were the 
reasons I did not touch send-pack.

Ciao,
Dscho
