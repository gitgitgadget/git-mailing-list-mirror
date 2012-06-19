From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] Makefile: split prefix flags from GIT-CFLAGS
Date: Tue, 19 Jun 2012 19:36:59 -0400
Message-ID: <20120619233659.GA6621@sigill.intra.peff.net>
References: <20120619195229.GA14692@sigill.intra.peff.net>
 <20120619200354.GC14714@sigill.intra.peff.net>
 <7vmx3zyqil.fsf@alter.siamese.dyndns.org>
 <20120619210426.GA21838@sigill.intra.peff.net>
 <7vzk7zx9pz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 20 01:37:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sh7yv-0005XU-7P
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 01:37:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755231Ab2FSXhD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 19:37:03 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:33169
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755141Ab2FSXhB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 19:37:01 -0400
Received: (qmail 16045 invoked by uid 107); 19 Jun 2012 23:37:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 19 Jun 2012 19:37:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Jun 2012 19:36:59 -0400
Content-Disposition: inline
In-Reply-To: <7vzk7zx9pz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200274>

On Tue, Jun 19, 2012 at 02:39:20PM -0700, Junio C Hamano wrote:

> >> I have to wonder if is this something we care about that much.
> >
> > It does speed up my build a fair bit, but I admit I have a somewhat
> > uncommon setup.
> 
> Oh, I wouldn't question the "speeding up" part.  I simply expected
> that people who use separate prefix depending on branch would have
> separate checkout for these branches they build and install
> regularly to their own prefixes, so recompilation due to prefix
> change would not be an issue, because by definition in such a set-up
> you won't change branch in a checkout.

I dunno if other people do that. For me, separate checkouts would be
overkill. I use a single working tree, and I don't mind switching
between topic branches, but I want to keep installed versions from
polluting each other (e.g., via cruft left in the exec-path or in
templates), which has caused oddness with testing in the past.

It's also nice that I can do:

  $ git checkout v1.7.10.5
  $ make install

and now I need only point my PATH to $HOME/local/git/v1.7.10.5/bin
to test that version forever. It saves lots of compile time when I'm
investigating bug reports.

Of course, I am probably one of the few people in the world who actually
wants to have 50 built versions of git on hand.

-Peff
