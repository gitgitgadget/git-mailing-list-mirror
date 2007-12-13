From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [RFH] convert shortlog to use parse_options
Date: Thu, 13 Dec 2007 10:35:36 +0100
Message-ID: <20071213093536.GC12398@artemis.madism.org>
References: <20071213055226.GA3636@coredump.intra.peff.net> <20071213090604.GA12398@artemis.madism.org> <20071213091055.GA5674@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="kVXhAStRUZ/+rrGn";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 13 10:35:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2kU2-0005zx-Cc
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 10:35:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756515AbXLMJfj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 04:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754253AbXLMJfi
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 04:35:38 -0500
Received: from pan.madism.org ([88.191.52.104]:44756 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753039AbXLMJfh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 04:35:37 -0500
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 058352FB87;
	Thu, 13 Dec 2007 10:35:37 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 652753F68E; Thu, 13 Dec 2007 10:35:36 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20071213091055.GA5674@coredump.intra.peff.net>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68136>


--kVXhAStRUZ/+rrGn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 13, 2007 at 09:10:56AM +0000, Jeff King wrote:
> On Thu, Dec 13, 2007 at 10:06:04AM +0100, Pierre Habouzit wrote:
>=20
> > No we can't. And I believe that such a thing is definitely bad practice
> > :/ So if you really need to, we will have to add some PARSE_OPT_STICKARG
> > or sth alike that would check that the argument was "sticked" to the
> > option either with `-wA,B,C` or `--long-opt=3DA,B,C` depending on the f=
act
> > that an option is short or long.
>=20
> Yes, I am not sure if the right solution is to just say "we are changing
> how -w works". Because it either must change, or it must be inconsistent
> with the rest of the option parsing for the rest of eternity.

In fact we have kind of the issue for every single optional argument out
there:

$ git describe --abbrev HEAD
error: option `abbrev' expects a numerical value
[...]

  *ouch*

So I believe that with optional arguments we must change the way we do
things, and that we _must_ enforce the argument to be sticked in that
case. Because this kind of backward incompatibility I totally missed in
the first place is unacceptable. Patch on its way.
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--kVXhAStRUZ/+rrGn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHYPzovGr7W6HudhwRAmckAJ93Eg02mU96xIrdJ9mZLs2WUoSjZgCfZfB+
qw2YcYlNQ/+eKLt3nz6wFyc=
=mLZ9
-----END PGP SIGNATURE-----

--kVXhAStRUZ/+rrGn--
