From: =?UTF-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>
Subject: Re: [PATCH] git-for-each-ref: move GPG sigs off %(body) to
 %(signature).
Date: Tue, 30 Aug 2011 17:58:43 +0200
Organization: Gentoo
Message-ID: <20110830175843.24ee6c1d@pomiocik.lan>
References: <20110829213757.GB14299@sigill.intra.peff.net>
	<1314694641-24148-1-git-send-email-mgorny@gentoo.org>
	<4E5CB0D0.7000905@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA256;
 boundary="Sig_/fI2_FD_PnKYB79a8corrfOm"; protocol="application/pgp-signature"
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Aug 30 17:57:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyQgX-00063h-R0
	for gcvg-git-2@lo.gmane.org; Tue, 30 Aug 2011 17:57:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755509Ab1H3P5E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Aug 2011 11:57:04 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:45533 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752397Ab1H3P5D (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Aug 2011 11:57:03 -0400
Received: from pomiocik.lan (unknown [81.219.203.249])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: mgorny)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 1DFE51B415D;
	Tue, 30 Aug 2011 15:57:00 +0000 (UTC)
In-Reply-To: <4E5CB0D0.7000905@drmicha.warpmail.net>
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.24.5; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180415>

--Sig_/fI2_FD_PnKYB79a8corrfOm
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 30 Aug 2011 11:43:44 +0200
Michael J Gruber <git@drmicha.warpmail.net> wrote:

> > When grabbing a %(body) or %(contents) off a tag, one doesn't really
> > expect to get the GPG signature as well (as it's basically useless
> > without the complete signed text). Thus, strip it off those two
> > tags, and make available via %(signature) if anyone needs it.
>=20
> No, please do not change %(contents). It is the complete content which
> (together with the header) enters into the sha1 calculation.
>=20
> You will probably also face opposition as regards to %(body), changing
> existing behaviour.
>=20
> In fact, I wish we didn't have %(body) but %(contents:body) just like
> other modifiers such as :short.

Yeah, I was wondering why it is like that.

> I think I'd go for
>=20
> %(contents:signature)
>=20
> and implement
>=20
> %(contents:subject) the same as %(subject)
> %(contents:body) as contents minus subject minus signature

How should I implement the ':' magic? Through adding a new type or just
putting ':' in place?

--=20
Best regards,
Micha=C5=82 G=C3=B3rny

--Sig_/fI2_FD_PnKYB79a8corrfOm
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iJwEAQEIAAYFAk5dCLcACgkQfXuS5UK5QB2/nQP+OG8ZdY86KJjwfTD8PTSXQuT/
cffB+Y14dDVh/jNGbV5e71v4Tl/qJ7yuQL4mBEB+tIOoCrYs8q3V173riRkub+LC
cSWsgZgGT1i8dsn8ALSJPNKpbgHmpi1Mfh7qLVrO0qVzyUkH75k5L16nrLjRiWXD
z2wi0MeVCkD4fLAGLv0=
=pIzl
-----END PGP SIGNATURE-----

--Sig_/fI2_FD_PnKYB79a8corrfOm--
