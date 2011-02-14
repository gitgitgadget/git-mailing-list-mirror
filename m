From: Jeff King <peff@peff.net>
Subject: Re: Re* [1.8.0] Provide proper remote ref namespaces
Date: Mon, 14 Feb 2011 17:35:57 -0500
Message-ID: <20110214223557.GA13070@sigill.intra.peff.net>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
 <201102140036.42197.johan@herland.net>
 <7vfwrrukzq.fsf@alter.siamese.dyndns.org>
 <201102141018.46527.johan@herland.net>
 <7vfwrqtrsk.fsf_-_@alter.siamese.dyndns.org>
 <AANLkTincKapKgcWEE1Z+vQesSjZBFAnfH0uL+a7GhQ6b@mail.gmail.com>
 <AANLkTi=Fpey7e+E1eKOiSaS1hjW2d8eOy9PVLR34Sc5J@mail.gmail.com>
 <AANLkTin5ZcZU8iwPSm4A87bYRrSCcXJVLBFGSr2+j30j@mail.gmail.com>
 <vpqr5bath2z.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Dmitry Potapov <dpotapov@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Feb 14 23:36:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp71b-0003Ph-SJ
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 23:36:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751997Ab1BNWgB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 17:36:01 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:51530 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750948Ab1BNWgA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 17:36:00 -0500
Received: (qmail 24938 invoked by uid 111); 14 Feb 2011 22:35:58 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 14 Feb 2011 22:35:58 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Feb 2011 17:35:57 -0500
Content-Disposition: inline
In-Reply-To: <vpqr5bath2z.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166787>

On Mon, Feb 14, 2011 at 10:57:24PM +0100, Matthieu Moy wrote:

> Jay Soffian <jaysoffian@gmail.com> writes:
> 
> > Alternately, you could take the wall of text approach, which I was
> > trying to avoid:
> >
> >   push.default is unset; its implicit value is changing in 1.8.0 from
> >   'matching' to 'current'. To squelch this message and maintain the current
> >   behavior post-1.8.0, use 'git config [--global] push.default matching'. To
> >   squelch this message and adopt the 1.8.0 behavior now, use
> >   'git config [--global] push.default current'. See 'git help config' and
> >   search for 'push.default' for further information.
> 
> I actually like this, although it's a bit verbose: I think telling the
> user "something will change" without telling what is very frustrating,
> so the "from 'matching' to 'current'" part seems really good.

I like this one, too. It lays out what is happening and what the
possible choices are. I don't think we should be afraid of a lot of text
in a change-of-behavior message like this. It's _supposed_ to be
annoying and catch their attention, and there are instructions right
there for shutting it up.

We have used this strategy before, and I don't remember anyone
complaining about "this message is too long".

> I'd remove the [] around the --global, to make the command
> cut-and-paste ready. Advanced users know whether to remove the
> --global, and newbies don't want to remove it.

Agreed, and put the commands on their own line for simpler
cut-and-paste, like:

  push.default is unset; its implicit value is changing in 1.8.0 from
  'matching' to 'current'. To squelch this message and maintain the
  current behavior post-1.8.0, run:

    git config --global push.default matching

  To squelch this message and adopt the 1.8.0 behavior now, run:

    git config --global push.default current

  See 'git help config' and search for 'push.default' for further
  information.

I think the whitespace makes it easier to see there are two choices, and
most people have some kind of triple-click-to-copy-whole-line in their
terminal.

-Peff
