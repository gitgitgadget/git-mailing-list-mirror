From: Jeff King <peff@peff.net>
Subject: Re: Branches & directories
Date: Mon, 3 Oct 2011 03:44:12 -0400
Message-ID: <20111003074412.GC9455@sigill.intra.peff.net>
References: <CAE1pOi0Er1ZgftpNeCr85Zu27xR2127V_KdAtvKc1NOKmDUvzQ@mail.gmail.com>
 <CAGZ=bqLyS9tcpqztwGWFOXtDJRhugu+JYvz7wTnc0PTmECWX2g@mail.gmail.com>
 <CAE1pOi1axNmGaPVXqBH02x0N=Z6tgO9R00RTokuJm50eY-OoNg@mail.gmail.com>
 <4E889813.8070205@gmail.com>
 <CAE1pOi3bm72Rk+UYygS_bC9eh0VTPr-VQSdtBGqjgDpEzkutZw@mail.gmail.com>
 <20111003030723.GA24523@sigill.intra.peff.net>
 <CAE1pOi2xmVHrVJcC85wvCv=anhn_kYizyUMpUVZF4EE33RoGmg@mail.gmail.com>
 <vpqaa9ijzt4.fsf@bauges.imag.fr>
 <20111003073456.GA10054@sigill.intra.peff.net>
 <vpqmxdiikt2.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Robin Rosenberg <robin.rosenberg@gmail.com>,
	Kyle Moffett <kyle@moffetthome.net>,
	Michael Witten <mfwitten@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Evan Shelhamer <shelhamer@imaginarynumber.net>,
	Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Oct 03 09:44:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAdCG-0003DE-54
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 09:44:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752002Ab1JCHoQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Oct 2011 03:44:16 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51463
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751175Ab1JCHoP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 03:44:15 -0400
Received: (qmail 24842 invoked by uid 107); 3 Oct 2011 07:49:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 03 Oct 2011 03:49:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Oct 2011 03:44:12 -0400
Content-Disposition: inline
In-Reply-To: <vpqmxdiikt2.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182635>

On Mon, Oct 03, 2011 at 09:41:29AM +0200, Matthieu Moy wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Speaking of which; does anybody know of a git-aware ccache-like tool?
> > We already have a nice index of the sha1 of each file in the repository
> > (along with a stat cache showing us whether it's up-to-date or not).
> > Something like ccache could avoid even looking in the C files at all if
> > it relied on git's index.
> 
> It would be a bit harder than that I think. IIRC, ccache hashes the
> preprocessed file, hence it will notice if a .h file changed, even if
> it's outside the project.

Yeah, you'd have to maintain your own dependency tree, then. Which is
nasty (aside from the work involved), because I don't think you can
portably get the header dependencies out of the C compiler.

Oh well.

-Peff
