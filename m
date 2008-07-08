From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 2/6] revisions: split the pure option parsing out from  parse_revisions.
Date: Tue, 08 Jul 2008 13:00:22 +0200
Message-ID: <20080708110022.GE19202@artemis.madism.org>
References: <1215510964-16664-1-git-send-email-madcoder@debian.org> <1215510964-16664-2-git-send-email-madcoder@debian.org> <1215510964-16664-3-git-send-email-madcoder@debian.org> <487346A1.4040006@viscovery.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="5oH/S/bF6lOfqCQb";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org, torvalds@linux-foundation.org,
	gitster@pobox.com, peff@peff.net
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Jul 08 13:01:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGAwk-0001DM-Fm
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 13:01:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754453AbYGHLAZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 07:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754440AbYGHLAZ
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 07:00:25 -0400
Received: from pan.madism.org ([88.191.52.104]:48611 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754216AbYGHLAY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 07:00:24 -0400
Received: from madism.org (APuteaux-103-1-3-109.w217-128.abo.wanadoo.fr [217.128.49.109])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 68844343CB;
	Tue,  8 Jul 2008 13:00:23 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 56FE7DC9C; Tue,  8 Jul 2008 13:00:22 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	torvalds@linux-foundation.org, gitster@pobox.com, peff@peff.net
Content-Disposition: inline
In-Reply-To: <487346A1.4040006@viscovery.net>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87747>


--5oH/S/bF6lOfqCQb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 08, 2008 at 10:51:13AM +0000, Johannes Sixt wrote:
> Pierre Habouzit schrieb:
> > +int handle_revision_opt(struct rev_info *revs, int argc, const char **=
argv,
> > +			int *unkc, const char **unkv)
> > +{
> > +	const char *arg =3D argv[0];
> > +
> > +	/* pseudo revision arguments */
> > +	if (!strcmp(arg, "--all") || !strcmp(arg, "--branches") ||
> > +	    !strcmp(arg, "--tags") || !strcmp(arg, "--remotes") ||
> > +	    !strcmp(arg, "--reflog") || !strcmp(arg, "--not") ||
> > +	    !strcmp(arg, "--no-walk") || !strcmp(arg, "--do-walk"))
> > +	{
> > +		unkv[*unkc++] =3D arg;
>=20
> +		unkv[(*unkc)++] =3D arg;

  Huh right. Good catch, I wonder why the testsuite failed to see that.
Anyways I pushed a fix on my public repo.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--5oH/S/bF6lOfqCQb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkhzSMUACgkQvGr7W6HudhzXAgCeKpDo9W/ARQ/lSRzrg2NMemka
p30AoIczWt71VNO45gy9veQqnRH0GHOe
=aWdt
-----END PGP SIGNATURE-----

--5oH/S/bF6lOfqCQb--
