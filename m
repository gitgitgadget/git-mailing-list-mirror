From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 0/3] Thinning the git toplevel directory
Date: Thu, 24 Feb 2011 14:08:09 -0500
Message-ID: <20110224190808.GB4318@sigill.intra.peff.net>
References: <20110219111103.GA1841@elie>
 <20110222155637.GC27178@sigill.intra.peff.net>
 <7v4o7vdfz2.fsf@alter.siamese.dyndns.org>
 <20110223045143.GA11846@sigill.intra.peff.net>
 <7vlj16aeih.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1102231213280.26358@xanadu.home>
 <1298502543.28664.19.camel@drew-northup.unet.maine.edu>
 <alpine.LFD.2.00.1102231908340.26358@xanadu.home>
 <1298567455.19041.39.camel@drew-northup.unet.maine.edu>
 <alpine.LFD.2.00.1102241252000.26358@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Drew Northup <drew.northup@maine.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Thu Feb 24 20:08:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsgXw-0000U3-VR
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 20:08:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755775Ab1BXTIM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Feb 2011 14:08:12 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:47207 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754834Ab1BXTIL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Feb 2011 14:08:11 -0500
Received: (qmail 26868 invoked by uid 111); 24 Feb 2011 19:08:10 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 24 Feb 2011 19:08:10 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Feb 2011 14:08:09 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1102241252000.26358@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167848>

On Thu, Feb 24, 2011 at 01:04:21PM -0500, Nicolas Pitre wrote:

> > It can be done as a separate patch, but it should all be done in the
> > public branch (pu?) as atomically as possible (one merge from Junio's
> > workspace). In other words, the public branch should never fail to build
> > because of this work.
> 
> Who said this would fail to compile?
> 
> If you move bar.c into the foo directory, then in the existing Makefile 
> you simply have to make a mechanical rename of bar.c to foo/bar.c.  
> Restructuring the Makefile can be done separately from the file move 
> without ever breaking the build (except for unintentional mistakes of 
> course).

Exactly. Maybe it wasn't clear in the previous bits of the thread, but
Makefile reorganization is a totally optional thing that can come on top
of file movement if we choose. I just brought it up with file movement
because having a bunch of subdirs is going to probably make us _want_ to
do something with Makefiles.

In the interim it may not work to run make from the "cmds" subdirectory,
but that is not a "fail to build" breakage. As long as we build via
"make" from the root, then there is no regression. Adding extra make
fluff on top of that is feature work, not a bug fix.

-Peff
