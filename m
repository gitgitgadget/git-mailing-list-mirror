From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Don't cache DESTDIR in perl/perl.mak.
Date: Wed, 12 Dec 2007 21:02:11 +0100
Message-ID: <20071212200211.GB1060@artemis.madism.org>
References: <20071210093102.3050.qmail@06e91d20307a62.315fe32.mid.smarden.org> <7vodcyl5dy.fsf@gitster.siamese.dyndns.org> <20071212180050.GA18980@untitled>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="CdrF4e02JqNVZeln";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <gitster@pobox.com>, Gerrit Pape <pape@smarden.org>,
	git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Dec 12 21:02:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2Xmw-0002Dd-By
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 21:02:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752953AbXLLUCP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 15:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753088AbXLLUCP
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 15:02:15 -0500
Received: from pan.madism.org ([88.191.52.104]:50692 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752876AbXLLUCO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 15:02:14 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 491192FA36;
	Wed, 12 Dec 2007 21:02:12 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 593C44993DF; Wed, 12 Dec 2007 21:02:11 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>, Gerrit Pape <pape@smarden.org>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20071212180050.GA18980@untitled>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68097>


--CdrF4e02JqNVZeln
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 12, 2007 at 06:01:48PM +0000, Eric Wong wrote:
> Junio C Hamano <gitster@pobox.com> wrote:
> > Hmph.  That's reverting this:
> >=20
> > commit 4c5cf8c44ce06a79da5bafd4a92e6d6f598cea2e
> > Author: Eric Wong <normalperson@yhbt.net>
> > Date:   Sun Aug 13 04:13:25 2006 -0700
> >=20
> >     pass DESTDIR to the generated perl/Makefile
> >    =20
> >     Makes life for binary packagers easier, as the Perl modules will
> >     be installed inside DESTDIR.
> >    =20
> >     Signed-off-by: Eric Wong <normalperson@yhbt.net>
> >     Signed-off-by: Junio C Hamano <junkio@cox.net>
> >=20
> > Eric, care to comment?
>=20
> I used to make a statically linked binary package for working on an
> ancient box that didn't have a lot of libraries I wanted, and I probably
> just called `make install' into DESTDIR as a single step without calling
> `make' alone without DESTDIR argument, or I had DESTDIR set in
> config.mak

  Actually this fact generated a bug in debian packaging because git is
built then installed twice in different DESTDIRS, then parts of the
install is pruned (the two installs are arch-dependant and
arch-independant files install so it's a very good reason in term of
packaging).

  The fact that perl.mak caches the DESTDIR make it install things in
the wrong place because it doesn't honour make DESTDIR=3Dfoo install and
always use the cached value instead, which is wrong.

  I think Gerrit won't care if it's cached or not, he just cares that it
still honours environment if present.
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--CdrF4e02JqNVZeln
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHYD5DvGr7W6HudhwRAhCPAJ94RtcB7z3fdinmyZ4BgcKT/tUlMQCdEGNH
WxhqqORoNVC/ilQ7uxU+On0=
=tyRU
-----END PGP SIGNATURE-----

--CdrF4e02JqNVZeln--
