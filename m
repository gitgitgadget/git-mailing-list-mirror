From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] completion: remove credential helpers from porcelain
 commands
Date: Tue, 5 May 2015 16:06:07 -0400
Message-ID: <20150505200607.GB12067@peff.net>
References: <1430831972-6788-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue May 05 22:06:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ypj6h-0002On-8w
	for gcvg-git-2@plane.gmane.org; Tue, 05 May 2015 22:06:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933042AbbEEUGN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 May 2015 16:06:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:54455 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933041AbbEEUGK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2015 16:06:10 -0400
Received: (qmail 25802 invoked by uid 102); 5 May 2015 20:06:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 05 May 2015 15:06:10 -0500
Received: (qmail 10108 invoked by uid 107); 5 May 2015 20:06:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 05 May 2015 16:06:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 May 2015 16:06:07 -0400
Content-Disposition: inline
In-Reply-To: <1430831972-6788-1-git-send-email-szeder@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268423>

On Tue, May 05, 2015 at 03:19:32PM +0200, SZEDER G=C3=A1bor wrote:

> Don't offer the "main" 'git credential' command or any of the credent=
ial
> helpers from contrib/credential/ when completing git commands.

Makes sense to me, modulo the typo Erik pointed out.

> I was tempted to simply filter out 'credential-*', so we don't have t=
o
> update this list when new credential helpers arrive.  However, the
> 'git-credential-*' "namespace" is not explicitly reserved for credent=
ial
> helpers, users have to set the 'credential.helper' config variable to=
 tell
> explicitly that 'git-credential-foo' should be used as credential hel=
per,
> and who knows, someone might have his own 'git-credential-bar' comman=
d that
> does something completely unrelated to git's credential system, so in=
 the
> end decided against it.  And credential helpers don't pop up too freq=
uently
> anyway.
>=20
> However, if you think filtering out 'credential-*' is the way to go, =
I'm
> happy to reroll.

I'd actually be fine with just marking all credential-* as "credentials
helper". I think we have staked out the "git-credential-foo" namespace,
so anybody putting something unrelated in there deserves what they get.
And it makes one fewer list to keep up to date.

I _do_ have other git-credential-foo's that should be ignored (and are
not in your list), but I am probably the only person in the world (they
are due to me experimenting with the credential helper code :) ).

-Peff
