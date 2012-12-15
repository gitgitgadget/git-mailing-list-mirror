From: Jeff King <peff@peff.net>
Subject: Re: FW: Git log --graph doesn't output color when redirected
Date: Sat, 15 Dec 2012 05:16:59 -0500
Message-ID: <20121215101659.GB21577@sigill.intra.peff.net>
References: <72BB37CB88C48F4B925365539F1EE46C182613A9@icexch-m3.ic.ac.uk>
 <72BB37CB88C48F4B925365539F1EE46C18261403@icexch-m3.ic.ac.uk>
 <20121213131329.GA5042@sigill.intra.peff.net>
 <CACsJy8AgtwtJfMXzArJLiHQtR+WNRJxRdRgUts30EN-QvgGT=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Srb, Michal" <michal.srb11@imperial.ac.uk>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 15 11:17:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tjoo4-0007UL-K1
	for gcvg-git-2@plane.gmane.org; Sat, 15 Dec 2012 11:17:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751588Ab2LOKRC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2012 05:17:02 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:55330 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751037Ab2LOKRB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2012 05:17:01 -0500
Received: (qmail 19804 invoked by uid 107); 15 Dec 2012 10:18:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 15 Dec 2012 05:18:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 15 Dec 2012 05:16:59 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8AgtwtJfMXzArJLiHQtR+WNRJxRdRgUts30EN-QvgGT=g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211527>

On Sat, Dec 15, 2012 at 10:23:10AM +0700, Nguyen Thai Ngoc Duy wrote:

> On Thu, Dec 13, 2012 at 8:13 PM, Jeff King <peff@peff.net> wrote:
> > If you are using --format="%C(red)" or similar placeholders,
> > they are the odd duck by not respecting the auto-color mode.
> 
> But they should, shouldn't they? Just asking. I may do it to when I
> revive nd/pretty-placeholder-with-color-option.

If I were designing --format today, I would certainly say so. The only
thing holding me back would be backwards compatibility. We could get
around that by introducing a new placeholder like %c(color) that behaves
like %C(color), except respects the --color flag.

It looks like this came up before:

  http://article.gmane.org/gmane.comp.version-control.git/169225

but never got pushed to inclusion.

-Peff
