From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/5] Suggested for PU: revision caching system to
 significantly speed up packing/walking
Date: Fri, 7 Aug 2009 22:50:55 -0400
Message-ID: <20090808025055.GA14731@coredump.intra.peff.net>
References: <op.ux8i6hrbtdk399@sirnot.private>
 <alpine.DEB.1.00.0908061645470.8306@pacific.mpi-cbg.de>
 <4A7AEFA8.5010001@drmicha.warpmail.net>
 <c77435a80908061039p30b83511qb7c378cfd68a6cf6@mail.gmail.com>
 <alpine.DEB.1.00.0908062030340.8306@pacific.mpi-cbg.de>
 <4A7B95A8.2010000@vilain.net>
 <alpine.DEB.1.00.0908070808340.8306@pacific.mpi-cbg.de>
 <alpine.LFD.2.00.0908071029580.16073@xanadu.home>
 <c77435a80908071502y48d14a38h79eec14a1be8c6fb@mail.gmail.com>
 <7vzlabp7e4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Nicolas Pitre <nico@cam.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sam Vilain <sam@vilain.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Nick Edelen <sirnot@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 08 04:51:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZc1d-0004AD-3s
	for gcvg-git-2@gmane.org; Sat, 08 Aug 2009 04:51:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256AbZHHCu5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2009 22:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757671AbZHHCu5
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Aug 2009 22:50:57 -0400
Received: from peff.net ([208.65.91.99]:57980 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757569AbZHHCu4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2009 22:50:56 -0400
Received: (qmail 23041 invoked by uid 107); 8 Aug 2009 02:53:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 07 Aug 2009 22:53:08 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Aug 2009 22:50:55 -0400
Content-Disposition: inline
In-Reply-To: <7vzlabp7e4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125237>

On Fri, Aug 07, 2009 at 03:48:51PM -0700, Junio C Hamano wrote:

> > The cache file for all of the linux repository (as of a few weeks ago)
> > is around 42MB, without names.  The names would probably add 2 or 3 MB
> > on top of that.  That's probably about as big as I'd want to get,
> 
> Hmm.  .git/objects/ as of today is about 482M here, so we are talking
> about roughly 10% overhead?

IIRC from previous discussions, kernel.org's main performance problem is
I/O, not CPU. Are there any provisions for sharing rev-caches between
similar repositories, as we already do for objects?

-Peff
