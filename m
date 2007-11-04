From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 01/10] Add a parseopt mode to git-rev-parse to bring parse-options to shell scripts.
Date: Mon, 05 Nov 2007 00:14:16 +0100
Message-ID: <20071104231416.GF4207@artemis.corp>
References: <1194172262-1563-1-git-send-email-madcoder@debian.org> <1194172262-1563-2-git-send-email-madcoder@debian.org> <7v8x5dsjne.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="V4b9U9vrdWczvw78";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 05 00:14:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ioofp-0007el-2k
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 00:14:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753581AbXKDXOT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 18:14:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753679AbXKDXOS
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 18:14:18 -0500
Received: from pan.madism.org ([88.191.52.104]:48341 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753551AbXKDXOS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 18:14:18 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 1472C25E02;
	Mon,  5 Nov 2007 00:14:16 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 44AAB435A19; Mon,  5 Nov 2007 00:14:16 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v8x5dsjne.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63456>


--V4b9U9vrdWczvw78
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 04, 2007 at 10:58:13PM +0000, Junio C Hamano wrote:
> Two comments.
>=20
>  * I have updated 1/10 with typo and indentation fixes.
>=20
>  * I see you changed 2/10 to use OPTIONS_KEEPDASHDASH instead of
>    PARSEOPT_OPTS, but the scripts that do not want the --keep
>    behaviour do not set OPTIONS_KEEPDASHDASH to empty, so I do
>    not see how this updatet would make _any_ difference.  The
>    user can still screw up by having OPTIONS_KEEPDASHDASH in
>    their environments by mistake, curiosity or just plain
>    stupidity.

  Hmmm right, I was worried by the fact that the old PARSEOPT_OPTS was
being possibly diverted to inject malicious commands. I tend to find the
forced `OPTIONS_KEEPDASHDASH=3D` thing quite painful, but indeed it is
probably the sole way to guard ourselves against user stupidity (or more
likely unclean environments).

  Do you mind adding: OPTIONS_KEEPDASHDASH=3D front to the 8 patches that
needs it, or should I send an updated series ? (actually it's more like
the 7 that needs it as git-clean has been rewritten as a builtin if I'm
correct).

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--V4b9U9vrdWczvw78
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHLlJIvGr7W6HudhwRAtWkAJ41LCJzCwzK1RYb0cZSVq7ZD8bNhQCfXpV/
VvbI1yZEAvvfozQ9pby+/j0=
=OJ7V
-----END PGP SIGNATURE-----

--V4b9U9vrdWczvw78--
