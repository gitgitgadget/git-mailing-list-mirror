From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] do not stream large files to pack when filters are
 in use
Date: Fri, 24 Feb 2012 16:19:13 -0500
Message-ID: <20120224211913.GA30942@sigill.intra.peff.net>
References: <20120224093924.GA11680@sigill.intra.peff.net>
 <20120224094805.GB11846@sigill.intra.peff.net>
 <7vehtkyp6i.fsf@alter.siamese.dyndns.org>
 <20120224204810.GC21447@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 24 22:19:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S12Xw-0000Np-4H
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 22:19:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756685Ab2BXVTP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Feb 2012 16:19:15 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56041
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755101Ab2BXVTP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2012 16:19:15 -0500
Received: (qmail 29158 invoked by uid 107); 24 Feb 2012 21:19:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 24 Feb 2012 16:19:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Feb 2012 16:19:13 -0500
Content-Disposition: inline
In-Reply-To: <20120224204810.GC21447@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191482>

On Fri, Feb 24, 2012 at 03:48:10PM -0500, Jeff King wrote:

> > By the way, I tried this with the tip of 'pu' as of last night, and the
> > result segfaults on me in t1050 (hash-object -w) ;-).
> 
> Eek. I ran through "make test" on my finished series without a problem,
> but it may be a bad interaction with something in "pu", or maybe a
> heisenbug. I'll investigate.

Or maybe I'm just an idiot, and apparently didn't actually run the test
suite correctly. Because it is very reproducible, and is because
hash-object --stdin passes a NULL for the path.

I'll post the fixed series in a minute (with this fix, and the improved
convert_to_git wrapper).

-Peff
