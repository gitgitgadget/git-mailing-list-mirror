From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: On PPC64, the parsing of integers on the commandline is  bitshifted.
Date: Fri, 08 Aug 2008 10:38:04 +0200
Message-ID: <20080808083804.GB13578@artemis.madism.org>
References: <20080807203122.GR22707@curie-int.orbis-terrarum.net> <X68iwLodMeAo1RYVJdU3iyNzAFylpDRpP1jkviJTeiOnoNs5n2qZcg@cipher.nrlssc.navy.mil> <CxVxAoKmEQsrgFdHEvL0sjkgBBIVZ3Zvsl0pPSuDSfH_8xM8NOSGfw@cipher.nrlssc.navy.mil> <7vhc9wijsq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="/WwmFnJnmDyWGHa4";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	"Robin H. Johnson" <robbat2@gentoo.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 08 10:39:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRNVA-0000Fx-Az
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 10:39:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753422AbYHHIiK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 04:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753401AbYHHIiJ
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 04:38:09 -0400
Received: from pan.madism.org ([88.191.52.104]:36279 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753395AbYHHIiI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 04:38:08 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 995F43D01B;
	Fri,  8 Aug 2008 10:38:06 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id B54A15BB160; Fri,  8 Aug 2008 10:38:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vhc9wijsq.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91634>


--/WwmFnJnmDyWGHa4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 07, 2008 at 09:42:29PM +0000, Junio C Hamano wrote:
> Brandon Casey <casey@nrlssc.navy.mil> writes:
>=20
> > Brandon Casey wrote:
> >> Robin H. Johnson wrote:
> >>> In a 64-bit userland, big-endian environment, the parser gets integers
> >>> wrong.
> >>=20
> >> There is a fix on master. Can you try that out?
> >> Unfortunately, looks like it did not make it into 1.5.6.5
> >
> > Also, just so you know, it is test-parse-options.c that is broken, not
> > the parsing code. So, the rest of git should be using an int with
> > OPT_INTEGER() and should operate correctly.
>=20
> Yup, that is why it is not on 'maint' --- but somebody should audit the
> parse_options() users in the real programs to make sure that there is no
> similar breakages, namely, giving a pointer to long to OPT_INTEGER().

  Well FWIW I'll probably write some __GNUC__ guarded glue using
__builtin_types_compatible and friends to ensure we're not passing crap
to the OPT_* macros. I just didn't have time to yet.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--/WwmFnJnmDyWGHa4
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkicBewACgkQvGr7W6HudhwraACfR2EiehREk+5VwTcTcs0i27wk
cJkAoINHZs0087QtFA6upwx4C9Q7oE/L
=OTgK
-----END PGP SIGNATURE-----

--/WwmFnJnmDyWGHa4--
