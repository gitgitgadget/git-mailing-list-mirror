From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] push: Learn to set up branch tracking with '--track'
Date: Fri, 30 Jan 2009 18:05:30 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901301804030.3586@pacific.mpi-cbg.de>
References: <cover.1233236267u.git.johannes.schindelin@gmx.de> <alpine.DEB.1.00.0901291438030.3586@pacific.mpi-cbg.de> <20090129223308.GB12871@coredump.intra.peff.net> <20090129231715.GA17399@coredump.intra.peff.net> <alpine.DEB.1.00.0901300127450.3586@pacific.mpi-cbg.de>
 <20090130050925.GA18809@coredump.intra.peff.net> <alpine.DEB.1.00.0901301656290.3586@pacific.mpi-cbg.de> <20090130162258.GA7065@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 30 18:07:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSwpB-0001tK-GT
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 18:06:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751751AbZA3RFL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 12:05:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751643AbZA3RFK
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 12:05:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:57662 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751612AbZA3RFJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 12:05:09 -0500
Received: (qmail invoked by alias); 30 Jan 2009 17:05:05 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp066) with SMTP; 30 Jan 2009 18:05:05 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18ojQI81CAogfD1dhg113uldBUa3MEnmXvsTE2Fet
	NRxLVvXxAvrscR
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090130162258.GA7065@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107852>

Hi,

On Fri, 30 Jan 2009, Jeff King wrote:

> I think the right thing to do is:
> 
>   1. factor out "generic" routines from send-pack, including status
>      output formatting and tracking ref updating
> 
>   2. refactor http-push to use those routines, bringing it in line with
>      send-pack
> 
>   3. add --track support in the same generic way, and hook it from both
>      transports

Now we're thinking along the same lines!

> I can try to work on this, but I'm not excited about major surgery to 
> http-push, which I don't have a working test setup for.

You don't have an apache installed?

> I can't bring myself to care about refactoring rsync, given the recent 
> deprecation discussion.

Don't do it, then.

> If it is going to be added to push or transport, then the transport API 
> needs refactoring to actually pass out information on what happened 
> (specifically, how we expanded the refspecs into matching ref pairs). 
> And maybe that is a more sensible long-term solution, but it is going 
> involve a lot of changes, too.

I think that the --track should just be passed to the transport API, which 
should call the necessary git_config thing itself upon successful push.

Ciao,
Dscho
