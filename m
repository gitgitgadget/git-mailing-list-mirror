From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String   Library.
Date: Fri, 07 Sep 2007 22:56:04 +0200
Message-ID: <20070907205604.GC23483@artemis.corp>
References: <4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com> <alpine.LFD.0.999.0709061839510.5626@evo.linux-foundation.org> <a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com> <alpine.LFD.0.999.0709070135361.5626@evo.linux-foundation.org> <alpine.LFD.0.999.0709070203200.5626@evo.linux-foundation.org> <fbqmdu$udg$1@sea.gmane.org> <20070907094120.GA27754@artemis.corp> <fbs79k$tac$1@sea.gmane.org> <20070907194115.GA23483@artemis.corp> <fbsd0g$gt6$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="TYecfFk8j8mZq+dy";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Walter Bright <boost@digitalmars.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 22:56:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITks8-000733-RA
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 22:56:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755202AbXIGU4I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 16:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965480AbXIGU4H
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 16:56:07 -0400
Received: from pan.madism.org ([88.191.52.104]:49871 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753664AbXIGU4G (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 16:56:06 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 9349D1E882;
	Fri,  7 Sep 2007 22:56:05 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id BAE1C1A389; Fri,  7 Sep 2007 22:56:04 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Walter Bright <boost@digitalmars.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <fbsd0g$gt6$1@sea.gmane.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58074>


--TYecfFk8j8mZq+dy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 07, 2007 at 08:40:56PM +0000, Walter Bright wrote:
> Pierre Habouzit wrote:
> >And for that bit-fields are
> >a really really fast and simple way to describe things.
>
> I should point out that inline functions are inlined, and there is no=20
> speed difference in the result.

  I know that, and that's why I said I was totally fine with the
bitfield notation to be only syntactic sugar on a template thingy if
that's the simplest way to have that it's OKay.

> >  Not to mention that the usual C idiom:
> >  union {
> >    unsigned flags;
> >    struct {
> >      // many bitfields
> >    };
> >  };
> >  Would need an explicit copy_flags(const my_struct foo) function to
> >work. Not pretty, not straightforward.
>=20
> I'm not following this. To copy a union, you just copy it with the=20
> assignment operator:
>=20
> 	U a, b;
> 	a =3D b;		// copies all the bit fields, too!

  That was the point indeed. But if you don't have bitfields, you can't
do the union. And if the bitfield is just syntactic sugar, it may be
unpossible to have such a union. But I may be wrong.

> >Right now, for D, only
> >gdc exists, it lags behind dmd quite a lot afaict, and there is no other
> >toolchain helpers yet.
>=20
> GDC was just released for D 1.020, which is behind D 1.021, but 1.021 was=
=20
> released just a couple days ago <g>.

  Sure, but it does not works on amd64 properly (and it's the
architecture I care about) and is not ready for the current gcc (4.2,
only 4.1 builds) and so on. It's not as stable as DMD is. It does not
lags too much version-wise, it lags in maturity. But well, youth has a
cure: time :)

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--TYecfFk8j8mZq+dy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG4brkvGr7W6HudhwRAjJ8AKCBDRCHEu/D2bkYFe08+tyaanVavgCgmDkn
avcPtrv2lsp0d8QS5XlNCjs=
=5s0z
-----END PGP SIGNATURE-----

--TYecfFk8j8mZq+dy--
