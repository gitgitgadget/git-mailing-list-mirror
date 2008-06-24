From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 1/2] Introduce leaky().
Date: Wed, 25 Jun 2008 00:10:48 +0200
Message-ID: <20080624221048.GI9189@artemis.madism.org>
References: <1214338474-16822-1-git-send-email-madcoder@debian.org> <1214338474-16822-2-git-send-email-madcoder@debian.org> <m3skv2jzey.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="tcC6YSqBgqqkz7Sb";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 00:12:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBGkD-00065f-7M
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 00:12:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756867AbYFXWKw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 18:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756284AbYFXWKv
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 18:10:51 -0400
Received: from pan.madism.org ([88.191.52.104]:38439 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756573AbYFXWKv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 18:10:51 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id E51222DCB5;
	Wed, 25 Jun 2008 00:10:49 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id C0C58CDB3; Wed, 25 Jun 2008 00:10:48 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
Content-Disposition: inline
In-Reply-To: <m3skv2jzey.fsf@localhost.localdomain>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86156>


--tcC6YSqBgqqkz7Sb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2008 at 09:28:30PM +0000, Jakub Narebski wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> > diff --git a/Makefile b/Makefile
>=20
> > +#
> > +# Define COLLECT_LEAKS_AT_EXIT if you want memory marked as leaky() at=
 exit.
>=20
> I think s/at exit/to be freed &/;

  err obviously.

> > diff --git a/cache.h b/cache.h
>=20
> Hmmm... cache?

  well cache.h has the prototypes for alloc.c that feels like the proper
place, but I don't care much :)

> >  /* alloc.c */
> > +#ifdef COLLECT_LEAKS_AT_EXIT
> > +extern void *leaky(void *);
> > +#else
> > +# define leaky(x) x
> > +#endif
>=20
> Not=20
>=20
> +# define leaky(x) (x)
>=20
> to be careful?

ack.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--tcC6YSqBgqqkz7Sb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkhhcOgACgkQvGr7W6HudhytgwCgjcDrzM+6BEj+GvIZUJ75B3LW
r0gAn0jcbtvNO2qtMYJx/nd6xDSZmwZh
=GruA
-----END PGP SIGNATURE-----

--tcC6YSqBgqqkz7Sb--
