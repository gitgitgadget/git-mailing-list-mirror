From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] Change error messages in ident.c...
Date: Thu, 10 May 2012 16:22:27 -0400
Message-ID: <20120510202227.GA30965@sigill.intra.peff.net>
References: <1336676770-17965-1-git-send-email-angusgh@gmail.com>
 <20120510192339.GA32357@sigill.intra.peff.net>
 <7vipg3n6pu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Angus Hammond <angusgh@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 10 22:22:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSZsg-0008IG-Qr
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 22:22:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756411Ab2EJUWa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 16:22:30 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39119
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755896Ab2EJUW3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 16:22:29 -0400
Received: (qmail 2471 invoked by uid 107); 10 May 2012 20:22:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 10 May 2012 16:22:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 May 2012 16:22:27 -0400
Content-Disposition: inline
In-Reply-To: <7vipg3n6pu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197627>

On Thu, May 10, 2012 at 01:04:13PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I am also tempted to suggest that we simply replace the static buffers
> > with dynamic strbufs.
> 
> Yeah, I think that is a proper approach for this issue, as it will make
> two of these messages unnecessary (or all?  I couldn't think of a way
> to deal with missing getpwent case myself, though).

It doesn't get rid of the "you don't exist" message, and I think just
dying there makes sense.  But that is actually the one that I consider
the most likely to happen in practice, and should probably have a more
useful error message.

-Peff
