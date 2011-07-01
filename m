From: Jeff King <peff@peff.net>
Subject: Re: [Wishlist] could git tell which password it is asking when
 asking a password.
Date: Fri, 1 Jul 2011 16:48:23 -0400
Message-ID: <20110701204823.GB32731@sigill.intra.peff.net>
References: <877h82nlua.dlv@debian.org>
 <7v62nmos0k.fsf@alter.siamese.dyndns.org>
 <7v1uy9q5v1.fsf@alter.siamese.dyndns.org>
 <BANLkTi=aAinh=0jxb5MoqVOdUB7zxoy2XdSqk+pdsewLXU62ZA@mail.gmail.com>
 <7vwrg1opov.fsf@alter.siamese.dyndns.org>
 <87tyb5n6pk.dlv@debian.org>
 <7vfwmpoi9y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?UsOpbWk=?= Vanicat <vanicat@debian.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 01 22:48:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qckda-0001u7-VC
	for gcvg-git-2@lo.gmane.org; Fri, 01 Jul 2011 22:48:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756854Ab1GAUs0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Jul 2011 16:48:26 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:40049
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756745Ab1GAUsZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2011 16:48:25 -0400
Received: (qmail 6779 invoked by uid 107); 1 Jul 2011 20:48:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 01 Jul 2011 16:48:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Jul 2011 16:48:23 -0400
Content-Disposition: inline
In-Reply-To: <7vfwmpoi9y.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176536>

On Fri, Jul 01, 2011 at 01:30:49PM -0700, Junio C Hamano wrote:

> R=C3=A9mi Vanicat <vanicat@debian.org> writes:
>=20
> > I also believe that having the host name would be useful, both for =
human
> > (another example would be git remote update when there are several
> > remote) and script. =20
>=20
> Patches welcome, but I have to warn you that the code may _not_ know =
the
> URL at that point in the callchain.

Yeah, you have to save it; the simplest time is when we parse the
username+password bits out of the URL during http_auth_init, and then
pass it through to git_getpass.

But see the patch series I just mentioned elsewhere in the thread. Righ=
t
now it still uses "Password:" for http authentication, but it would be =
a
one-liner to have it use "Password for 'user@example.com':".

-Peff
