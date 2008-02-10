From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: Alternative approach to the git config NULL value checking patches..
Date: Mon, 11 Feb 2008 00:29:20 +0100
Message-ID: <20080210232920.GH5129@artemis.madism.org>
References: <alpine.LFD.1.00.0802101225110.2896@woody.linux-foundation.org> <7vir0wfqrz.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0802101406560.2896@woody.linux-foundation.org> <7vbq6oe98y.fsf@gitster.siamese.dyndns.org> <7v7ihce8ex.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="tcC6YSqBgqqkz7Sb";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 00:30:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOLce-0000qu-Ek
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 00:30:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753287AbYBJX3X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 18:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753083AbYBJX3X
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 18:29:23 -0500
Received: from pan.madism.org ([88.191.52.104]:47279 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752695AbYBJX3W (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 18:29:22 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 225012DC88;
	Mon, 11 Feb 2008 00:29:20 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 47E2F64D1; Mon, 11 Feb 2008 00:29:20 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7v7ihce8ex.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73435>


--tcC6YSqBgqqkz7Sb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 10, 2008 at 10:47:02PM +0000, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
> > But as you seem to imply, it might make sense to equate
> >
> > 	[some-random-section]
> >         	some-random-variable
> >
> > to
> >
> > 	[some-random-section]
> >         	some-random-variable =3D ""
> >
> > for variables that cannot possibly have any meaningful "bool"
> > semantics.  This third class of variables is a possible benefit
> > your patch brings in.  The code can be lax for these variables.
> >
> > However, it would make things inconsistent ("this variable is
> > bool and the above two forms mean completely opposite things,
> > while that variable is not bool and they mean the same thing").
> > I am just having a hard time convincing myself that this little
> > detail does not matter.
>=20
> Having said all that, it might be an option to change your patch
> slightly to say:
>=20
> 	const char config_true[] =3D "true";

I was about to suggest the same, and testing against "config_true" just
becomes an optimization, but isn't required. Seems an appropriate hack
to me.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--tcC6YSqBgqqkz7Sb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHr4jQvGr7W6HudhwRAgEYAKCeyFqOC8K9nk/7qusu4+fJEv56YgCgjpbc
s7bOclWvaJ+pmpbcSoQb5GE=
=8MVZ
-----END PGP SIGNATURE-----

--tcC6YSqBgqqkz7Sb--
