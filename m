From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] Added basic color support to git add --interactive
Date: Sun, 4 Nov 2007 01:43:06 -0400
Message-ID: <20071104054305.GA13929@sigill.intra.peff.net>
References: <47112491.8070309@gmail.com> <20071015034338.GA4844@coredump.intra.peff.net> <20071016194709.3c1cb3a8@danzwell.com> <20071017015152.GN13801@spearce.org> <20071022164048.71a3dceb@danzwell.com> <20071023042702.GB28312@coredump.intra.peff.net> <20071023035221.66ea537f@danzwell.com> <20071102224100.71665182@paradox.zwell.net> <20071104045735.GA12359@segfault.peff.net> <7v640ivagv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dan Zwell <dzwell@zwell.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Wincent Colaiuta <win@wincent.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan del Strother <maillist@steelskies.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 04 06:43:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoYGb-0006xf-Vx
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 06:43:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752168AbXKDFnL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 01:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752041AbXKDFnK
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 01:43:10 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4291 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751830AbXKDFnJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 01:43:09 -0400
Received: (qmail 14266 invoked by uid 111); 4 Nov 2007 05:43:07 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 04 Nov 2007 01:43:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 04 Nov 2007 01:43:06 -0400
Content-Disposition: inline
In-Reply-To: <7v640ivagv.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63353>

On Sat, Nov 03, 2007 at 10:36:00PM -0700, Junio C Hamano wrote:

> I think you would end up spitting out:
> 
>         COLOR something RESET LF COLOR RESET LF
> 
> instead of:
> 
> 	COLOR something RESET LF LF
> 
> when you get "something\n\n" if you did that.  Not a big deal,
> though, as at this point we would be human I/O bound.

Yes, though I wonder if the former is "more correct" in the sense that
we don't know what the attributes are doing, and maybe it matters for
them to apply to each line, whether it has text or not.

But I don't think it's possible for a blank line to actually do anything
with the attributes we're currently allowing, and we don't have any
plans to allow arbitrary terminal control codes in the color specs, so
it probably doesn't matter.

-Peff
