From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 1/2] parse_options: Add flag to prevent errors for  further processing
Date: Sun, 22 Jun 2008 19:07:33 +0200
Message-ID: <20080622170733.GA16252@artemis.madism.org>
References: <1213758236-979-1-git-send-email-shawn.bohrer@gmail.com> <1213758236-979-2-git-send-email-shawn.bohrer@gmail.com> <7v1w2v2zsh.fsf@gitster.siamese.dyndns.org> <20080618033010.GA19657@sigill.intra.peff.net> <7vwskn1g2p.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="J/dobhs11T7y2rNN";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Jeff King <peff@peff.net>, Shawn Bohrer <shawn.bohrer@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 22 19:08:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAT3a-0006kz-M3
	for gcvg-git-2@gmane.org; Sun, 22 Jun 2008 19:08:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752726AbYFVRHj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2008 13:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752886AbYFVRHj
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 13:07:39 -0400
Received: from pan.madism.org ([88.191.52.104]:56394 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751671AbYFVRHi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2008 13:07:38 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id D432E3669D;
	Sun, 22 Jun 2008 19:07:34 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 8DA5D8D4E; Sun, 22 Jun 2008 19:07:33 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Shawn Bohrer <shawn.bohrer@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vwskn1g2p.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85788>


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2008 at 05:13:02AM +0000, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>=20
> > I think the only right way to accomplish this is to convert the revision
> > and diff parameters into a parseopt-understandable format.
>=20
> Not necessarily.  You could structure individual option parsers like how
> diff option parsers are done.  You iterate over argv[], feed diff option
> parser the current index into argv[] and ask if it is an option diff
> understands, have diff eat the option (and possibly its parameter) to
> advance the index, or allow diff option to say "I do not understand this",
> and then handle it yourself or hand it to other parsers.

  If you do that, you need to relocate pars option structures, and we
decided some time ago that it wasn't a good idea. Note that "recursing"
is not really trivial, because with flags aggregation and stuff like
that, things that look like an option can also be a value in the context
of an other option parser.

  That's why we settled for the other way Dscho pointed. But for that, I
need to work on it more than what I really have time to nowadays, and
moreover, it needs some things (the setup_revisions split and the log
traversal bits change) to be merged.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkhehtMACgkQvGr7W6HudhxQ8QCgnw9BflEXJlCJ059Bhs5kFrQv
hpsAoJeH29iByqXiuqkQ1YdkMYgb20XQ
=dHC6
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
