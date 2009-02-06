From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] add -p: import Term::ReadKey with 'require'
Date: Sat, 7 Feb 2009 00:21:13 +0100
Message-ID: <200902070021.18928.trast@student.ethz.ch>
References: <20090206140126.GA18364@coredump.intra.peff.net> <1233948601-4828-1-git-send-email-trast@student.ethz.ch> <20090206203037.GB19959@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart19592128.kLzIV2HmK1";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junio@pobox.com>,
	Suraj Kurapati <sunaku@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 07 00:22:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVa28-0003oH-Ld
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 00:22:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752638AbZBFXV0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 18:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752462AbZBFXV0
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 18:21:26 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:40489 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752399AbZBFXVZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 18:21:25 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 7 Feb 2009 00:21:23 +0100
Received: from thomas.localnet ([77.56.223.244]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 7 Feb 2009 00:21:23 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.27.7-9-default; KDE/4.2.0; x86_64; ; )
In-Reply-To: <20090206203037.GB19959@coredump.intra.peff.net>
X-OriginalArrivalTime: 06 Feb 2009 23:21:23.0708 (UTC) FILETIME=[A051E3C0:01C988B1]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108799>

--nextPart19592128.kLzIV2HmK1
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Jeff King wrote:
> I believe it is fine. The tricky thing is that perl's parsing is
> dependent on what functions have been defined. So it is OK to say
>=20
>   ReadKey 0;
>=20
> if a subroutine ReadKey has been defined, but otherwise it generates a
> warning about using the bareword as a function. However
>=20
>   ReadKey(0);
>=20
> parses unambiguously, so it is always OK, even if no subroutine has yet
> been defined.

Ok, that explains a lot.  I always thought Perl had a syntax
influenced somewhat by the functional programming languages, where the
parentheses are usually optional.  Clearly not so.

> (note that you could also skip the import and just call
> Term::ReadKey::ReadKey by its full name).

I tried that but couldn't get either Term::ReadKey::ReadKey or
Term::ReadKey->ReadKey to work.  In retrospect, I suppose it requires
parentheses too.

Thanks for the review!

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart19592128.kLzIV2HmK1
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkmMxe4ACgkQqUud07tmzP02SwCffdpcESvXqvI1Ax0XM/LJ2uJ9
JegAoIIq89vTxLLDASeHtizf2vplom3L
=gpY5
-----END PGP SIGNATURE-----

--nextPart19592128.kLzIV2HmK1--
