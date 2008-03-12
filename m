From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] git-quiltimport: fix security risk because of  un-sanitized $level.
Date: Wed, 12 Mar 2008 23:29:06 +0100
Message-ID: <20080312222906.GA12800@artemis.madism.org>
References: <20080312204648.GA28729@artemis.madism.org> <7v63vr64rn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="VS++wcV0S1rZb1Fb";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Git ML <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 23:30:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZZSS-0004Ai-GN
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 23:30:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753987AbYCLW3Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 18:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755773AbYCLW3N
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 18:29:13 -0400
Received: from pan.madism.org ([88.191.52.104]:45012 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754616AbYCLW3M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 18:29:12 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id D83642DEEB;
	Wed, 12 Mar 2008 23:29:07 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id AE17799E; Wed, 12 Mar 2008 23:29:06 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, Git ML <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7v63vr64rn.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77012>


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2008 at 08:55:56PM +0000, Junio C Hamano wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> > Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> > ---
> >
> >   I assume that nobody will have a series with -p1000 in it :)
> >   sorry for this gross mistake in the first place.
> >
> >   [ for the inattentive readers $level was used without quoting, for
> >     good reasons as it's sometime empty and then we don't want to pass
> >     an empty argument to git-apply, though someone could use that to run
> >     arbitrary commands, not nice ]
>=20
> A traditional way to deal with that situation in shell scripts is to use
> this idiom:
>=20
> 	${var_that_may_not_be_set+"$var_that_may_not_be_set"}

  Oh this is nicer than what I used indeed. My shell scripting skills
are quite limited :)

  Anyways, I happened to notice this stupid mistake when I re-read the
patch you merged. You probably want to use that trick instead (rather
than my poor sanitizing thing), and let git-apply sort out the rest.
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBH2FkyvGr7W6HudhwRAp3AAJ4xxABF8wrpzfXHIDbRfVzeXoWwAQCfUbbm
wxKeXozDh++SUjSbN8LnS/U=
=KQkq
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
