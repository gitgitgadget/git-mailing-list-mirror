From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [RFC] Re: Convert 'git blame' to parse_options()
Date: Tue, 24 Jun 2008 09:50:48 +0200
Message-ID: <20080624075048.GA24357@artemis.madism.org>
References: <20080623183358.GA28941@sigill.intra.peff.net> <alpine.LFD.1.10.0806231137070.2926@woody.linux-foundation.org> <alpine.LFD.1.10.0806231158340.2926@woody.linux-foundation.org> <20080623210935.GC13395@artemis.madism.org> <alpine.LFD.1.10.0806231425270.2926@woody.linux-foundation.org> <7v3an3hke8.fsf@gitster.siamese.dyndns.org> <20080623222404.GM13395@artemis.madism.org> <7vmylbg4ks.fsf@gitster.siamese.dyndns.org> <20080623233146.GP13395@artemis.madism.org> <7v8wwvg15z.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="17pEHd4RhPHOinZp";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 09:52:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB3K6-00054M-NT
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 09:52:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbYFXHuw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 03:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbYFXHuw
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 03:50:52 -0400
Received: from pan.madism.org ([88.191.52.104]:43581 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750789AbYFXHuv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 03:50:51 -0400
Received: from madism.org (APuteaux-103-1-3-109.w217-128.abo.wanadoo.fr [217.128.49.109])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id AE4A4233;
	Tue, 24 Jun 2008 09:50:49 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 79A7699B65; Tue, 24 Jun 2008 09:50:48 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7v8wwvg15z.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86004>


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2008 at 11:51:52PM +0000, Junio C Hamano wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> >   Unrelated but worth to note: many parse_options users just don't care
> > about argv[0] and having it kept each time would rather be a pain for
> > them (they would need to call argv++, argc-- themselves).
>=20
> Not necessarily.  If they were parsing by hand, they were written to deal
> with the fact that argv[0] is not the program argument (iow, they start
> counting from one).  And before and after calling parse_options(), they
> need to change that assumption anyway, because parse_options() makes
> argv[0] disappear.

  Sure, but for _some_ commands it's easier not having to argv++,
argc--. The patch I sent just allow the caller to ask parse_options to
keep argv[0] in place or not, so that one can cascade parsers if wanted.
Note that with the series I sent, it's less useful to cascade option
parser, you rather mix more of them in your step by step parser. But oh
well, it's a useful feature anyways. We can even make it default, my
sole concern what that NULL-terminated thing, and now that I know we can
count on it, then, well, I absolutely don't care :)

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkhgp1YACgkQvGr7W6HudhxakgCbBTOkLhCYQI56Nz1coCB9rXGY
N1gAniRBS/WVVPZN6/v6dBwV2dRLqzS/
=hTfE
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
