From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 6/7] parse-opt: add PARSE_OPT_KEEP_ARGV0 parser option.
Date: Tue, 24 Jun 2008 21:27:20 +0200
Message-ID: <20080624192720.GB9189@artemis.madism.org>
References: <alpine.LFD.1.10.0806222207220.2926@woody.linux-foundation.org> <1214298732-6247-1-git-send-email-madcoder@debian.org> <1214298732-6247-2-git-send-email-madcoder@debian.org> <1214298732-6247-3-git-send-email-madcoder@debian.org> <1214298732-6247-4-git-send-email-madcoder@debian.org> <1214298732-6247-5-git-send-email-madcoder@debian.org> <1214298732-6247-6-git-send-email-madcoder@debian.org> <1214298732-6247-7-git-send-email-madcoder@debian.org> <alpine.LFD.1.10.0806241015390.2926@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="hQiwHBbRI9kgIhsi";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
	Johannes.Schindelin@gmx.de
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jun 24 21:28:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBEBw-00019A-J4
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 21:28:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752657AbYFXT11 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 15:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752776AbYFXT10
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 15:27:26 -0400
Received: from pan.madism.org ([88.191.52.104]:54474 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751965AbYFXT10 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 15:27:26 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 1017536843;
	Tue, 24 Jun 2008 21:27:25 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id A08DB46DEE1; Tue, 24 Jun 2008 21:27:20 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
	Johannes.Schindelin@gmx.de
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0806241015390.2926@woody.linux-foundation.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86120>


--hQiwHBbRI9kgIhsi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2008 at 05:18:56PM +0000, Linus Torvalds wrote:
>=20
>=20
> On Tue, 24 Jun 2008, Pierre Habouzit wrote:
> >
> > This way, argv[0] isn't clobbered, to the cost of maybe not having a
> > resulting NULL terminated argv array.
>=20
> Umm. I think it's much easier to do by always having
>=20
> 	ctx->out  =3D argv;
>=20
> and then just initializing cpix to 0 or 1:
>=20
> 	ctx->cpidx =3D ((flags & PARSE_OPT_KEEP_ARGV0) !=3D 0);
>=20
> because now parse_options_end() doesn't need to play games any more. It=
=20
> doesn't need to care about PARSE_OPT_KEEP_ARGV0, it can just do exactly=
=20
> what it always used to do, because "ctx->cpidx + ctx->argc" automatically=
=20
> does the right thing (it is both the return value _and_ the index that yo=
u=20
> should fill with NULL.

  Oh right, ack it's more elegant.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--hQiwHBbRI9kgIhsi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkhhSpgACgkQvGr7W6HudhxCwgCfU1u3IMBsRbs3QtnXWNdSVBMF
zIcAn2dPET24TfvR30naDmTqfr28KPt8
=skMd
-----END PGP SIGNATURE-----

--hQiwHBbRI9kgIhsi--
