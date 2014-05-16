From: Jeff King <peff@peff.net>
Subject: Re: Truncated patch
Date: Fri, 16 May 2014 05:24:58 -0400
Message-ID: <20140516092458.GD21468@sigill.intra.peff.net>
References: <5375CDB1.6040001@davidnewall.com>
 <20140516085116.GC21468@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: David Newall <davidn@davidnewall.com>
X-From: git-owner@vger.kernel.org Fri May 16 11:25:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlEO3-0002OA-Vx
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 11:25:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754843AbaEPJZC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 05:25:02 -0400
Received: from cloud.peff.net ([50.56.180.127]:52912 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751475AbaEPJZA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 05:25:00 -0400
Received: (qmail 7646 invoked by uid 102); 16 May 2014 09:25:00 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 16 May 2014 04:25:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 May 2014 05:24:58 -0400
Content-Disposition: inline
In-Reply-To: <20140516085116.GC21468@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249287>

On Fri, May 16, 2014 at 04:51:16AM -0400, Jeff King wrote:

> On Fri, May 16, 2014 at 06:04:57PM +0930, David Newall wrote:
> 
> > The patch returned by http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/patch/?id=462fb2af9788a82a534f8184abfde31574e1cfa0
> > is truncated.  The page which refers to that patch, at http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=462fb2af9788a82a534f8184abfde31574e1cfa0,
> > shows the full patch.
> 
> Weird. It is truncated if I fetch it with "curl", but it looks fine in
> my browser. It's truncated at exactly 4K, and the transfer-encoding is
> chunked. Maybe cgit (or kernel.org's webserver) is doing something
> non-standard with chunking that the browser understands but curl does
> not?

I take it back. Now it is screwed up in my browser, too. Perhaps related
to hitting different kernel.org servers (though all three IPs now give
me the truncated output).

Looking at the raw protocol, the chunked encoding is fine; it literally
just quits after 4K, and sends the 0-byte "all done" chunk. So I'm
guessing it's either a bug in cgit, or a temporary error that
erroneously ended up cached (I don't know enough about cgit's or
kernel.org's caching infrastructure to say more).

-Peff
