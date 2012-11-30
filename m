From: Jeff King <peff@peff.net>
Subject: Re: [msysGit] [PATCH/RFC 1/5] mingw: make fgetc raise SIGINT if
 apropriate
Date: Fri, 30 Nov 2012 13:11:20 -0500
Message-ID: <20121130181119.GA7197@sigill.intra.peff.net>
References: <1352815447-8824-1-git-send-email-kusmabite@gmail.com>
 <1352815447-8824-2-git-send-email-kusmabite@gmail.com>
 <alpine.DEB.1.00.1211301857170.31987@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Erik Faye-Lund <kusmabite@gmail.com>, git@vger.kernel.org,
	msysgit@googlegroups.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Nov 30 19:11:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TeV3q-0008Kr-Rg
	for gcvg-git-2@plane.gmane.org; Fri, 30 Nov 2012 19:11:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753142Ab2K3SLX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2012 13:11:23 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:47746 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759124Ab2K3SLW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2012 13:11:22 -0500
Received: (qmail 5157 invoked by uid 107); 30 Nov 2012 18:12:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 30 Nov 2012 13:12:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Nov 2012 13:11:20 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.1211301857170.31987@s15462909.onlinehome-server.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210935>

On Fri, Nov 30, 2012 at 06:58:11PM +0100, Johannes Schindelin wrote:

> Hi,
> 
> On Tue, 13 Nov 2012, Erik Faye-Lund wrote:
> 
> > Set a control-handler to prevent the process from terminating, and
> > simulate SIGINT so it can be handled by a signal-handler as usual.
> 
> One thing you might want to mention is that the fgetc() handling is not
> thread-safe, and intentionally so: if two threads read from the same
> console, we are in trouble anyway.

That makes sense to me, but I'm confused why it is part of mingw_fgetc,
which could in theory read from arbitrary streams, no? It it is not
necessarily a console operation at all. I feel like I'm probably missing
something subtle here...

-Peff
