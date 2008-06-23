From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [RFC] Re: Convert 'git blame' to parse_options()
Date: Mon, 23 Jun 2008 22:04:14 +0200
Message-ID: <20080623200414.GB13395@artemis.madism.org>
References: <alpine.DEB.1.00.0806231312130.6440@racer> <alpine.LFD.1.10.0806230912230.2926@woody.linux-foundation.org> <20080623164917.GA25474@sigill.intra.peff.net> <alpine.LFD.1.10.0806230953550.2926@woody.linux-foundation.org> <20080623171505.GB27265@sigill.intra.peff.net> <alpine.LFD.1.10.0806231027210.2926@woody.linux-foundation.org> <alpine.LFD.1.10.0806231114180.2926@woody.linux-foundation.org> <20080623183358.GA28941@sigill.intra.peff.net> <alpine.LFD.1.10.0806231137070.2926@woody.linux-foundation.org> <20080623195314.GA29569@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="dTy3Mrz/UPE2dbVg";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 23 22:06:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAsHr-0007hy-Ky
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 22:05:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754887AbYFWUES (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 16:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754162AbYFWUES
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 16:04:18 -0400
Received: from pan.madism.org ([88.191.52.104]:52006 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753124AbYFWUER (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 16:04:17 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id C455237EF7;
	Mon, 23 Jun 2008 22:04:15 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 9FFEA18DB8; Mon, 23 Jun 2008 22:04:14 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <20080623195314.GA29569@sigill.intra.peff.net>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85914>


--dTy3Mrz/UPE2dbVg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2008 at 07:53:14PM +0000, Jeff King wrote:
> On Mon, Jun 23, 2008 at 11:47:49AM -0700, Linus Torvalds wrote:
> > Or are we going to sit around discussing this for another five months?
>=20
> Please! :)
>=20
> Pierre was working on the approach I mentioned, but I think he is short
> on time. I will take a look at the conversion, but I have a few other
> fixes on my plate first.
>=20
> In the meantime, I don't think your patch makes anything _worse_, since
> we already have these sorts of bugs in the current parsing code.

  To be fair, I lack the time to do a complete parse option overhaul
that is like a few days of work doing that only (and my employer will
probably complain if I do so ;P). Though I'm trying to make
parse_options incremental right now, and I believe that it can work
quite well, and allow way more incremental conversions.

  One can overcome many limitations by exposing some stuff from the
parse_options logic, and just parse things in one pass. The _really_
nice thing with this approach is that you can trivially merge
parse_options descriptors by chaining parse_option_step (see my other
mail).

  I'll probably have a RFC series soon.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--dTy3Mrz/UPE2dbVg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkhgAbwACgkQvGr7W6Hudhz9lQCgnnTnSp5NdSl7US+DsfTiL2M1
7r0AoJOdzoh58UpyzA4x2sa6VF2bkTuM
=vmUc
-----END PGP SIGNATURE-----

--dTy3Mrz/UPE2dbVg--
