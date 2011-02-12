From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-gui: give more advice when detaching HEAD
Date: Sat, 12 Feb 2011 03:21:08 -0500
Message-ID: <20110212082108.GA19656@sigill.intra.peff.net>
References: <20110212070538.GA2459@sigill.intra.peff.net>
 <7v8vxlzojs.fsf@alter.siamese.dyndns.org>
 <20110212080456.GA18380@sigill.intra.peff.net>
 <7vzkq1y8dv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 12 09:21:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PoAj4-0003OL-8W
	for gcvg-git-2@lo.gmane.org; Sat, 12 Feb 2011 09:21:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752255Ab1BLIVB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Feb 2011 03:21:01 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:48966 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751676Ab1BLIVA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Feb 2011 03:21:00 -0500
Received: (qmail 629 invoked by uid 111); 12 Feb 2011 08:20:59 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sat, 12 Feb 2011 08:20:59 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 12 Feb 2011 03:21:08 -0500
Content-Disposition: inline
In-Reply-To: <7vzkq1y8dv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166601>

On Sat, Feb 12, 2011 at 12:17:16AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Is it that cheap? A full reachability check for something that is not in
> > any ref would involve going to the roots, wouldn't it?
> 
> You only need to dig until you hit a merge base, no?

Hmm, yeah, you're right. In the worst case of reachability checks, you
would share no ancestry and go to the roots searching for the merge
base, but of course that is very unlikely to be the case here. So it
should be much cheaper.

> And merge-base has an interface to compute exactly that, I think.

Want to do a proof-of-concept patch? Then we can get some real timings.

-Peff
