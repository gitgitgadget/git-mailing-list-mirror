From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH] lessen the impression of unexpectedness on remote
	hangup
Date: Wed, 13 Jun 2012 23:28:05 +0200
Message-ID: <20120613212805.GA19146@book.hvoigt.net>
References: <20120610182310.GB2427@book.hvoigt.net> <20120611190207.GA20889@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 13 23:28:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sev6w-0004AF-JZ
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jun 2012 23:28:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754260Ab2FMV2O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jun 2012 17:28:14 -0400
Received: from smtprelay04.ispgateway.de ([80.67.31.42]:39336 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732Ab2FMV2N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2012 17:28:13 -0400
Received: from [77.20.33.80] (helo=localhost)
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1Sev6k-0004GQ-60; Wed, 13 Jun 2012 23:28:06 +0200
Content-Disposition: inline
In-Reply-To: <20120611190207.GA20889@sigill.intra.peff.net>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199948>

On Mon, Jun 11, 2012 at 03:02:07PM -0400, Jeff King wrote:
> On Sun, Jun 10, 2012 at 08:23:10PM +0200, Heiko Voigt wrote:
> 
> > If a server accessed through ssh is denying access git will currently
> > issue the message
> > 
> > 	"fatal: The remote end hung up unexpectedly"
> > 
> > as the last line. This sounds as if something really ugly just happened.
> > Since this is a quite typical situation in which users regularly get
> > lets just say:
> > 
> > 	"fatal: The remote end hung up"
> > 
> > Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
> > ---
> > We just got this bug report in msysgit
> > 
> > https://github.com/msysgit/msysgit/issues/28
> > 
> > and IIRC there have been more people questioning that line.
> 
> This does not seem like it would lessen the surprise all that much. I
> wonder if we could use some context about where we are in the protocol
> to tell more. For example, if the remote end hangs up before advertising
> its refs, it is probably an authentication error or a missing
> repository. And we should say that. If it happens during ref negotiation
> or during the pack file, then it really is unexpected; the other end has
> broken protocol, and it probably makes sense to say so.

I agree that would be better. I will have a look if I can cook something
up. In the meantime I think changing the message is better than
unnecessarily worrying the user.

Cheers Heiko
