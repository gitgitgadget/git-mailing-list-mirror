From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Fix memory leak in transport-helper
Date: Tue, 27 Oct 2009 14:31:05 -0400
Message-ID: <20091027183105.GA9504@sigill.intra.peff.net>
References: <1255577814-14745-1-git-send-email-spearce@spearce.org>
 <20091015185253.6117@nanako3.lavabit.com>
 <20091015143340.GI10505@spearce.org>
 <200910151721.08352.johan@herland.net>
 <20091015154142.GL10505@spearce.org>
 <7vfx9k4d33.fsf@alter.siamese.dyndns.org>
 <20091015204543.GP10505@spearce.org>
 <alpine.LNX.2.00.0910270032170.14365@iabervon.org>
 <alpine.DEB.1.00.0910271510430.4985@pacific.mpi-cbg.de>
 <alpine.LNX.2.00.0910271329510.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Oct 27 19:31:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2qpB-0003GQ-T4
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 19:31:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756034AbZJ0SbG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2009 14:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755997AbZJ0SbF
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 14:31:05 -0400
Received: from peff.net ([208.65.91.99]:44519 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755947AbZJ0SbF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2009 14:31:05 -0400
Received: (qmail 2834 invoked by uid 107); 27 Oct 2009 18:34:47 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (216.239.45.19)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 27 Oct 2009 14:34:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Oct 2009 14:31:05 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0910271329510.14365@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131366>

On Tue, Oct 27, 2009 at 01:37:19PM -0400, Daniel Barkalow wrote:

> > Why did you not leech the transport->data = NULL; part from Peff/Sverre's 
> > patch?
> 
> Because this code is only called just before transport itself is freed by 
> the caller, and, in general, a transport with these methods is invalid 
> without a valid transport->data. I expect that's also why Peff called it a 
> hack not appropriate for actual application.

More or less. I called it a hack because I didn't even look far enough
to know whether or not that was the case. I was just trying to get it to
stop segfaulting so Sverre could continue his work.

-Peff
