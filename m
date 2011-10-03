From: Jeff King <peff@peff.net>
Subject: Re: Branches & directories
Date: Mon, 3 Oct 2011 03:34:56 -0400
Message-ID: <20111003073456.GA10054@sigill.intra.peff.net>
References: <CAE1pOi1J5DKtnyUQzu1K7G1+HLsWWCN7thCf6W8MwSzt4_vtOw@mail.gmail.com>
 <CAGZ=bqLZoLoyMcvnppg6SyFtJU8phSquQeBZ7uhwP=+ZL3DADw@mail.gmail.com>
 <CAE1pOi0Er1ZgftpNeCr85Zu27xR2127V_KdAtvKc1NOKmDUvzQ@mail.gmail.com>
 <CAGZ=bqLyS9tcpqztwGWFOXtDJRhugu+JYvz7wTnc0PTmECWX2g@mail.gmail.com>
 <CAE1pOi1axNmGaPVXqBH02x0N=Z6tgO9R00RTokuJm50eY-OoNg@mail.gmail.com>
 <4E889813.8070205@gmail.com>
 <CAE1pOi3bm72Rk+UYygS_bC9eh0VTPr-VQSdtBGqjgDpEzkutZw@mail.gmail.com>
 <20111003030723.GA24523@sigill.intra.peff.net>
 <CAE1pOi2xmVHrVJcC85wvCv=anhn_kYizyUMpUVZF4EE33RoGmg@mail.gmail.com>
 <vpqaa9ijzt4.fsf@bauges.imag.fr>
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
X-From: git-owner@vger.kernel.org Mon Oct 03 09:35:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAd3I-0000T7-8P
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 09:35:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991Ab1JCHfA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Oct 2011 03:35:00 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51450
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750775Ab1JCHe6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 03:34:58 -0400
Received: (qmail 24541 invoked by uid 107); 3 Oct 2011 07:40:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 03 Oct 2011 03:40:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Oct 2011 03:34:56 -0400
Content-Disposition: inline
In-Reply-To: <vpqaa9ijzt4.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182632>

On Mon, Oct 03, 2011 at 09:32:07AM +0200, Matthieu Moy wrote:

> Hilco Wijbenga <hilco.wijbenga@gmail.com> writes:
> 
> > Yes, I meant it literally. And, no, Git could not possibly know so it
> > would have to be optional behaviour. But it's probably a lot of work
> > for (for most people) little gain.
> 
> Not only little gain, but also important risk: users of this feature
> would be likely to spend hours debugging something just because some
> files weren't recompiled at the right time.
> 
> If you want to optimize the number of files compiled by "make", then
> ccache is your friend. This one is safe.

Yes. Despite my previous message showing what _could_ be done, I do
think it's crazy. You should just use ccache.

Speaking of which; does anybody know of a git-aware ccache-like tool?
We already have a nice index of the sha1 of each file in the repository
(along with a stat cache showing us whether it's up-to-date or not).
Something like ccache could avoid even looking in the C files at all if
it relied on git's index.

I don't know how much speedup it would yield in practice, though.

-Peff
