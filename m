From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [RFC] Re: Convert 'git blame' to parse_options()
Date: Tue, 24 Jun 2008 01:31:46 +0200
Message-ID: <20080623233146.GP13395@artemis.madism.org>
References: <alpine.LFD.1.10.0806231027210.2926@woody.linux-foundation.org> <alpine.LFD.1.10.0806231114180.2926@woody.linux-foundation.org> <20080623183358.GA28941@sigill.intra.peff.net> <alpine.LFD.1.10.0806231137070.2926@woody.linux-foundation.org> <alpine.LFD.1.10.0806231158340.2926@woody.linux-foundation.org> <20080623210935.GC13395@artemis.madism.org> <alpine.LFD.1.10.0806231425270.2926@woody.linux-foundation.org> <7v3an3hke8.fsf@gitster.siamese.dyndns.org> <20080623222404.GM13395@artemis.madism.org> <7vmylbg4ks.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="enGqbSaueFq5omEL";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 01:32:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAvWg-0005ci-Lj
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 01:32:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751917AbYFWXbu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 19:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751888AbYFWXbt
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 19:31:49 -0400
Received: from pan.madism.org ([88.191.52.104]:41237 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751145AbYFWXbt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 19:31:49 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id E970A3629B;
	Tue, 24 Jun 2008 01:31:47 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 7ABD018DB8; Tue, 24 Jun 2008 01:31:46 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7vmylbg4ks.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85953>


--enGqbSaueFq5omEL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2008 at 10:38:11PM +0000, Junio C Hamano wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> > Though I didn't fixed the fact that parse_options clobbers argv[0],
> > which can be easily fixed. The issue with that is that _some_ callers
> > use the fact that the filtered argv is NULL terminated.
>=20
> Isn't it just the matter of (1) leave argv[0] as is, (2) start copy dest
> at argv[1] not argv[0], and (3) terminate argv[nargc] =3D NULL where nargc
> is what you did not handle?
>=20
> You have argc args in incoming argv[], you consume zero or more of them
> starting from argv[1] up to potentially argv[argc-1] (and argv[argc] is
> NULL).  So why is it an issue?  Sorry, I do not understand.

  Are we sure argv[argc] is NULL when those are main() arguments ? If
yes there is no issue, and I should read posix more carefully, but I was
under the impression that POSIX wasn't enforcing that.

  Unrelated but worth to note: many parse_options users just don't care
about argv[0] and having it kept each time would rather be a pain for
them (they would need to call argv++, argc-- themselves).

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--enGqbSaueFq5omEL
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkhgMmIACgkQvGr7W6Hudhx/qACgi1uFwY5LZDZXOKfAu6G6VBjN
h1wAmwdZlweiXl8DvNLMdGSFmLjDf6mH
=PYjX
-----END PGP SIGNATURE-----

--enGqbSaueFq5omEL--
