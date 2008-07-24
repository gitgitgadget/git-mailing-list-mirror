From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 2/2] git-checkout: improve error messages, detect  ambiguities.
Date: Thu, 24 Jul 2008 10:33:22 +0200
Message-ID: <20080724083322.GB10950@artemis.madism.org>
References: <1216774940-4955-1-git-send-email-madcoder@debian.org> <1216808133-31919-1-git-send-email-madcoder@debian.org> <1216808133-31919-2-git-send-email-madcoder@debian.org> <1216808133-31919-3-git-send-email-madcoder@debian.org> <7v7ibc9p93.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="xXmbgvnjoT4axfJE";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 10:34:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLwHO-0005W0-7b
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 10:34:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbYGXIda (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 04:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750977AbYGXIda
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 04:33:30 -0400
Received: from pan.madism.org ([88.191.52.104]:34189 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750744AbYGXId3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 04:33:29 -0400
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 66DAB3A98F;
	Thu, 24 Jul 2008 10:33:24 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id E0A4F464F25; Thu, 24 Jul 2008 10:33:22 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v7ibc9p93.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89853>


--xXmbgvnjoT4axfJE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2008 at 11:04:08PM +0000, Junio C Hamano wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> > The patch is twofold: it moves the option consistency checks just under
> > the parse_options call so that it doesn't get in the way of the tree
> > reference vs. pathspecs desambiguation.
>=20
> I think this goes a bit too far.
>=20
> Even if you have a file called 'master' tracked in your project, when you
> say:
>=20
>     $ git checkout master
>=20
> that's almost always branch switching.  Forcing "git checkout master --"
> disambiguation for such a common case is simply a wrong thing to do from
> the usability point of view.
>=20
> So how about (obviously we are interested only in the case without
> disambiguating '--' here):
>=20
>     (3-1) if there is only one token left and if it is a rev, that's the
>           branch to check out or commit to detach to.
>=20
>     (3-2) otherwise the user might have mistyped one of the paths, so help
>           avoiding by making sure the first token is unambiguously either
>           a rev or a path (but not both).

  It sounds really reasonable, and your patch seems really fine.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--xXmbgvnjoT4axfJE
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkiIPlIACgkQvGr7W6HudhyP9ACfTwb0V91cGhFGNfGIbLPpV+/H
wiQAnikvNGXwB1H6kBmf2cfyepOuqbiW
=ChV3
-----END PGP SIGNATURE-----

--xXmbgvnjoT4axfJE--
