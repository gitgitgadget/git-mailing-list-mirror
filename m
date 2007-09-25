From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Small cache_tree_write refactor.
Date: Tue, 25 Sep 2007 13:40:01 +0200
Message-ID: <20070925114001.GB8308@artemis.corp>
References: <20070925082341.DF412BDBCF@madism.org> <Pine.LNX.4.64.0709251135530.28395@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="qlTNgmc+xy1dBmNv";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Sep 25 13:40:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ia8ly-0005IX-Qb
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 13:40:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752162AbXIYLkG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 07:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752025AbXIYLkG
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 07:40:06 -0400
Received: from pan.madism.org ([88.191.52.104]:38570 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751957AbXIYLkE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 07:40:04 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id A747121A40;
	Tue, 25 Sep 2007 13:40:02 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id D1F95BDB78; Tue, 25 Sep 2007 13:40:01 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0709251135530.28395@racer.site>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59114>


--qlTNgmc+xy1dBmNv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 25, 2007 at 10:38:16AM +0000, Johannes Schindelin wrote:
> Hi,
>=20
> On Tue, 25 Sep 2007, Pierre Habouzit wrote:
>=20
> > --- a/cache-tree.c
> > +++ b/cache-tree.c
> > @@ -369,10 +369,8 @@ int cache_tree_update(struct cache_tree *it,
> >  	return 0;
> >  }
> > =20
> > -static void write_one(struct cache_tree *it,
> > -		       char *path,
> > -		       int pathlen,
> > -			   struct strbuf *buffer)
> > +static void write_one(struct strbuf *buffer, struct cache_tree *it,
> > +                      const char *path, int pathlen)
>=20
> I don't know... is this really needed?  In some other projects, the codin=
g=20
> standard prefers the parameters in "in"..."out" order.

  Well, this is thought in an OO way, buffer would be the "this". This
method could be named strbuf_addtree(...) hence I felt that having the
buffer as a first argument to be right.

  But I don't care that much about that.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--qlTNgmc+xy1dBmNv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG+PORvGr7W6HudhwRAlAVAJ0bNXWI0+E5G5QsXEMWVYiq12Rv/QCfWnGT
wxUyjDMvdh9/2QVPj24spiI=
=cbx1
-----END PGP SIGNATURE-----

--qlTNgmc+xy1dBmNv--
