From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] parse-options: add PARSE_OPT_FAKELASTARG flag.
Date: Wed, 09 Jul 2008 09:47:24 +0200
Message-ID: <20080709074724.GB23482@artemis.madism.org>
References: <7v8wwcx446.fsf@gitster.siamese.dyndns.org> <20080708101452.GB19202@artemis.madism.org> <20080708103408.GC19202@artemis.madism.org> <7vvdzfoo1s.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="v9Ux+11Zm5mwPlX6";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org, Lars Hjemli <hjemli@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 09:48:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGUPY-0007dH-0B
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 09:48:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753380AbYGIHr0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 03:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753243AbYGIHr0
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 03:47:26 -0400
Received: from pan.madism.org ([88.191.52.104]:43420 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752797AbYGIHr0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 03:47:26 -0400
Received: from madism.org (APuteaux-103-1-3-109.w217-128.abo.wanadoo.fr [217.128.49.109])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 388193461F;
	Wed,  9 Jul 2008 09:47:25 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 5A94E85E7; Wed,  9 Jul 2008 09:47:24 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Lars Hjemli <hjemli@gmail.com>
Content-Disposition: inline
In-Reply-To: <7vvdzfoo1s.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87856>


--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 09, 2008 at 01:15:43AM +0000, Junio C Hamano wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> > If you set this for a given flag, and the flag appears without a value =
on
> > the command line, then the `defval' is used to fake a new argument.
> >
> > Note that this flag is meaningless in presence of OPTARG or NOARG flags.
> > (in the current implementation it will be ignored, but don't rely on it=
).
> >
> > Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> > ---
> >
> >     >   (3) inspired from (1) and (2), have a flag for options that says
> >     >       "I do take an argument, but if I'm the last option on the
> >     >       command line, please fake this argument for me.
> >     >
> >     > I really like (3) more FWIW as it doesn't generate ambiguous
> >     > parsers like (2) would, and it's not horrible like (1). And cherry
> >     > on top it's pretty trivial to implement I think.
>=20
> Yeah, I do not particularly want a major rewrite that only introduces
> possible ambiguity to the option parser (even though arguably it would add
> to the usability very much, just like we accept revs and paths when
> unambiguous), so I think this is a reasonable compromise.
>=20
> It feels more like LASTARG_DEFAULT but that is bikeshedding ;-)

  I absolutely don't like this FAKELASTARG name, so really, use what you
like.

> But I see one thinko (fix below) and another issue I am not sure what the
> best fix would be.

  Like I said it was just a draft, I did not test the new feature, so
I'm not really surprised it's partly broken ;)

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--v9Ux+11Zm5mwPlX6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkh0bQwACgkQvGr7W6HudhzONgCgnJbokd/aKTaOKDEti7putAXB
kKYAoKAeAknzY07eMP1ufaESgAb/g/UF
=wBXV
-----END PGP SIGNATURE-----

--v9Ux+11Zm5mwPlX6--
