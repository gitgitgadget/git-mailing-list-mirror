From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [RFH] convert shortlog to use parse_options
Date: Thu, 13 Dec 2007 19:07:01 +0100
Message-ID: <20071213180701.GF1224@artemis.madism.org>
References: <20071213055226.GA3636@coredump.intra.peff.net> <20071213090604.GA12398@artemis.madism.org> <20071213091055.GA5674@coredump.intra.peff.net> <20071213093536.GC12398@artemis.madism.org> <7vbq8u4ho8.fsf@gitster.siamese.dyndns.org> <20071213180347.GE1224@artemis.madism.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="SFyWQ0h3ruR435lw";
	protocol="application/pgp-signature"; micalg=SHA1
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 13 19:08:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2sTT-0006AH-8t
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 19:07:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756559AbXLMSHG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 13:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756752AbXLMSHF
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 13:07:05 -0500
Received: from pan.madism.org ([88.191.52.104]:38268 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754860AbXLMSHC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 13:07:02 -0500
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id D901619737;
	Thu, 13 Dec 2007 19:07:01 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 51DFC42BE; Thu, 13 Dec 2007 19:07:01 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20071213180347.GE1224@artemis.madism.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68181>


--SFyWQ0h3ruR435lw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 13, 2007 at 06:03:47PM +0000, Pierre Habouzit wrote:
> On Thu, Dec 13, 2007 at 05:40:23PM +0000, Junio C Hamano wrote:
> > Pierre Habouzit <madcoder@debian.org> writes:
> >=20
> > > In fact we have kind of the issue for every single optional argument =
out
> > > there:
> > >
> > > $ git describe --abbrev HEAD
> > > error: option `abbrev' expects a numerical value
> > > [...]
> > >
> > >   *ouch*
> > >
> > > So I believe that with optional arguments we must change the way we do
> > > things, and that we _must_ enforce the argument to be sticked in that
> > > case.
> >=20
> > I think "Must" is a bit too strong an expression.
> >=20
> > 	git describe --abbrev 7 HEAD
> >         git describe --abbrev HEAD
> >         git describe --abbrev=3DHEAD
> > 	git describe --abbrev=3D7 HEAD
> > 	git describe --abbrev
> >=20
> > The --abbrev parser in this case could be asked with this question: "You
> > are on the command line.  There is a token after you.  Is it your
> > parameter?".

The other issue is that when you had --abbrev=3Dfoo or --abbrev foo, the
first one has to generate an error, whereas the second one should just
say "foo" is not for me. The point being that the callback is not really
aware of how the argument got assigned to it.

That means that we will have to pass more flags to callabacks, making it
less easy to write them. Again, I'm not sure that the coding hassle is
worth of the small gain.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--SFyWQ0h3ruR435lw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHYXTFvGr7W6HudhwRAu3JAKCMP9CqUFpAKt7McviXdR4ATvMVXgCcCEq2
MPcBsIT+mKcvCGZfMgz0GL4=
=M7ts
-----END PGP SIGNATURE-----

--SFyWQ0h3ruR435lw--
