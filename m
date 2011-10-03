From: Jeff King <peff@peff.net>
Subject: Re: Branches & directories
Date: Mon, 3 Oct 2011 03:51:58 -0400
Message-ID: <20111003075158.GA10965@sigill.intra.peff.net>
References: <CAE1pOi1axNmGaPVXqBH02x0N=Z6tgO9R00RTokuJm50eY-OoNg@mail.gmail.com>
 <4E889813.8070205@gmail.com>
 <CAE1pOi3bm72Rk+UYygS_bC9eh0VTPr-VQSdtBGqjgDpEzkutZw@mail.gmail.com>
 <20111003030723.GA24523@sigill.intra.peff.net>
 <CAE1pOi2xmVHrVJcC85wvCv=anhn_kYizyUMpUVZF4EE33RoGmg@mail.gmail.com>
 <vpqaa9ijzt4.fsf@bauges.imag.fr>
 <20111003073456.GA10054@sigill.intra.peff.net>
 <vpqmxdiikt2.fsf@bauges.imag.fr>
 <20111003074412.GC9455@sigill.intra.peff.net>
 <7v4nzqikhg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Robin Rosenberg <robin.rosenberg@gmail.com>,
	Kyle Moffett <kyle@moffetthome.net>,
	Michael Witten <mfwitten@gmail.com>,
	Evan Shelhamer <shelhamer@imaginarynumber.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 03 09:52:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAdJl-0005e6-TT
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 09:52:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752160Ab1JCHwC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Oct 2011 03:52:02 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51472
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751175Ab1JCHwA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 03:52:00 -0400
Received: (qmail 25082 invoked by uid 107); 3 Oct 2011 07:57:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 03 Oct 2011 03:57:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Oct 2011 03:51:58 -0400
Content-Disposition: inline
In-Reply-To: <7v4nzqikhg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182638>

On Mon, Oct 03, 2011 at 12:48:27AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Yeah, you'd have to maintain your own dependency tree, then. Which is
> > nasty (aside from the work involved), because I don't think you can
> > portably get the header dependencies out of the C compiler.
> 
> Heh, but doesn't your Makefile know the header dependencies anyway?

Sort of. It's often wrong (e.g., we are way over-inclusive in the git
Makefile; one of the things I like about ccache is that even when our
Makefile is overly conservative, ccache is fast. Or at least faster than
actually recompiling).

And of course it doesn't generally involve headers outside of your
project, whereas ccache does recompile if those change.

-Peff
