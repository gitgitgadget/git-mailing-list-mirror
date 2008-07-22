From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 2/2] spawn pager via run_command interface
Date: Tue, 22 Jul 2008 09:31:08 +0200
Message-ID: <20080722073108.GA9714@artemis.madism.org>
References: <7vtzeir68z.fsf@gitster.siamese.dyndns.org> <20080722044157.GA20787@sigill.intra.peff.net> <20080722053921.GA4983@glandium.org> <20080722060643.GA25023@sigill.intra.peff.net> <20080722061807.GA6714@glandium.org> <20080722064603.GA25221@sigill.intra.peff.net> <20080722071009.GA3610@sigill.intra.peff.net> <20080722071246.GA3584@sigill.intra.peff.net> <20080722071411.GB3584@sigill.intra.peff.net> <20080722071630.GA3669@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="oyUTqETQ0mS9luUI";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Mike Hommey <mh@glandium.org>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, David Bremner <bremner@unb.ca>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 22 09:32:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLCM3-0000gX-WB
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 09:32:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbYGVHbR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 03:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbYGVHbQ
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 03:31:16 -0400
Received: from pan.madism.org ([88.191.52.104]:53361 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750763AbYGVHbQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 03:31:16 -0400
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id ECB5634AB1;
	Tue, 22 Jul 2008 09:31:09 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id D2D892CB84C; Tue, 22 Jul 2008 09:31:08 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	David Bremner <bremner@unb.ca>
Content-Disposition: inline
In-Reply-To: <20080722071630.GA3669@sigill.intra.peff.net>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89459>


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2008 at 07:16:30AM +0000, Jeff King wrote:
> On Tue, Jul 22, 2008 at 03:14:12AM -0400, Jeff King wrote:
>=20
> >  static struct child_process pager_process =3D {
> >  	.argv =3D pager_argv,
> > -	.in =3D -1
> > +	.in =3D -1,
> > +#ifndef __MINGW32__
> > +	.preexec_cb =3D pager_preexec,
> > +#endif
>=20
> I couldn't recall if this initializer style is portable enough for us.
> It was already there wrapped in ifdefs, but perhaps it was only ok
> because the mingw version always uses the same compiler?

  it's not, I asked long time ago, and it's C99, which mingw supports
indeed, and we don't want to require a C99 compiler.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkiFjLwACgkQvGr7W6HudhxKQACfYEKukZSN2SsFRtnJ2mqAgued
isEAniC6XaFnboTS8r5Quo2wkKVMu9u0
=ZRIK
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
