From: Jeff King <peff@peff.net>
Subject: Re: diff'ing files ...
Date: Tue, 7 Jun 2011 18:19:48 -0400
Message-ID: <20110607221948.GA10104@sigill.intra.peff.net>
References: <BANLkTi=1vaoLVmhyahDttmUmqw7RTp=8-A@mail.gmail.com>
 <20110606224356.GC13697@sigill.intra.peff.net>
 <BANLkTinwSembzVk4gSYSvsRdHhDfqizkyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nicolas Pitre <nico@fluxnic.net>, git@vger.kernel.org
To: Albretch Mueller <lbrtchx@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 00:20:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QU4d4-0007wA-RO
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 00:20:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224Ab1FGWTx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 18:19:53 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39045
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752510Ab1FGWTw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 18:19:52 -0400
Received: (qmail 22188 invoked by uid 107); 7 Jun 2011 22:19:58 -0000
Received: from 70-36-146-246.dsl.dynamic.sonic.net (HELO sigill.intra.peff.net) (70.36.146.246)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 07 Jun 2011 18:19:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Jun 2011 18:19:48 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTinwSembzVk4gSYSvsRdHhDfqizkyg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175273>

On Tue, Jun 07, 2011 at 10:12:35PM +0000, Albretch Mueller wrote:

> > ... binary diffs, though I don't know offhand the details of the algorithm.
> ~
>  this is the part that I need ;-)
> ~
>  Reading the source code without knowing the basic underlying
> ideas/algorithm (just an outline if possible) won't help much

You could read the comments in the source:

  $ head -n 7 diff-delta.c
  /*
   * diff-delta.c: generate a delta between two buffers
   *
   * This code was greatly inspired by parts of LibXDiff from Davide Libenzi
   * http://www.xmailserver.org/xdiff-lib.html
   *
   * Rewritten for GIT by Nicolas Pitre <nico@fluxnic.net>, (C) 2005-2007

According to the xdiff page linked:

  For binary files, LibXDiff implements both (with some modification)
  the algorithm described in File System Support for Delta Compression
  by Joshua P.  MacDonald, and the algorithm described in Fingerprinting
  By Random Polynomials by Michael O. Rabin.

Nicolas (cc'd) might be able to say what, if any, substantive changes
were made from those works.

-Peff
