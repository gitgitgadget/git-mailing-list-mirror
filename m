From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] mailmap from blobs
Date: Wed, 12 Dec 2012 12:59:00 -0500
Message-ID: <20121212175900.GA32767@sigill.intra.peff.net>
References: <20121212105822.GA15842@sigill.intra.peff.net>
 <7vhanr5f74.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 18:59:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TiqaZ-0002dH-NA
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 18:59:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754314Ab2LLR7G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 12:59:06 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:44109 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751964Ab2LLR7F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 12:59:05 -0500
Received: (qmail 27176 invoked by uid 107); 12 Dec 2012 18:00:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 12 Dec 2012 13:00:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Dec 2012 12:59:00 -0500
Content-Disposition: inline
In-Reply-To: <7vhanr5f74.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211376>

On Wed, Dec 12, 2012 at 09:54:23AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I noticed recently that the GitHub contributions page for git.git did
> > not seem very accurate. The problem is that while it uses shortlog, it
> > does not respect .mailmap, because we do not have a working tree from
> > which to read the .mailmap.
> >
> > This series adds a config option analogous to mailmap.file, but which
> > reads from a blob in the repository (so the obvious thing to set it to
> > is "HEAD:.mailmap" in a bare repo, and probably "master:.mailmap" if you
> > frequently want to traverse while on unrelated branches). The obvious
> > alternative is to checkout a temporary file of .mailmap and point
> > mailmap.file at it, but this is a bit more convenient.
> 
> Yeah, I think this is sane.
> 
> Have you considered defaulting to read from HEAD:.mailmap even when
> this new configuration is not there if core.bare is set?  I would
> imagine that it would be the most convenient and match people's
> expectations.

Yeah, I almost suggested that, but I figured it could wait for the
feature to prove itself in the real world before turning it on by
default. It _should_ be pretty harmless, though, so I don't mind turning
it on by default.

-Peff
