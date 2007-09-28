From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] alloc_ref(): allow for trailing NUL
Date: Fri, 28 Sep 2007 15:13:48 +0200
Message-ID: <20070928131348.GB21309@artemis.corp>
References: <Pine.LNX.4.64.0709280356550.28395@racer.site> <Pine.LNX.4.64.0709280046241.5926@iabervon.org> <7vhclfqisq.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0709281259050.28395@racer.site> <20070928124102.GA21309@artemis.corp>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="rJwd6BRFiFCcLxzm";
	protocol="application/pgp-signature"; micalg=SHA1
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 28 15:14:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbFfN-0007dU-7u
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 15:14:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752521AbXI1NNx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2007 09:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752401AbXI1NNx
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 09:13:53 -0400
Received: from pan.madism.org ([88.191.52.104]:50575 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752172AbXI1NNw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2007 09:13:52 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 3C9A92230F;
	Fri, 28 Sep 2007 15:13:49 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id BF881BDBBE; Fri, 28 Sep 2007 15:13:48 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070928124102.GA21309@artemis.corp>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59392>


--rJwd6BRFiFCcLxzm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 28, 2007 at 12:41:02PM +0000, Pierre Habouzit wrote:
> 	void *xflexdupz(size_t offset, void *src, size_t len)
> 	{
> 		char *p =3D xmalloc(offset + len + 1);
> 		memset(p, 0, offset);
> 		memcpy(p + offset, src, len);
> 		p[offset + len] =3D '\0';
> 		return p;
> 	}
>=20
>   Then alloc_ref could be a wrapper around:
>   xflexdupz(offsetof(struct ref, name), ..., ...).
>=20
>   Of course right now alloc_ref doesn't perform any kind of copy, but a
> grep -A1 will convince you that it's not a problem:

  [...]
> 	remote.c:		ret =3D alloc_ref(strlen(name) + 6);
> 	remote.c-		sprintf(ret->name, "refs/%s", name);

  okay forget about me, my proposal doesn't work, too bad :)



--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--rJwd6BRFiFCcLxzm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG/P4MvGr7W6HudhwRAmZnAJ4n7wrWr+OoawO4aw6DQuzM0QGi/QCfQcx+
zvR7CQaZb2qTkxExvXD839Y=
=msF7
-----END PGP SIGNATURE-----

--rJwd6BRFiFCcLxzm--
