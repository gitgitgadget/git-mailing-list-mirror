From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] parse-options: fix parsing of "--foobar=" with no value
Date: Tue, 22 Jul 2008 20:54:27 +0200
Message-ID: <20080722185427.GA10453@artemis.madism.org>
References: <1216752267-12138-1-git-send-email-dkr+ml.git@free.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="d6Gm4EdcadzBjdND";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Olivier Marin <dkr+ml.git@free.fr>
X-From: git-owner@vger.kernel.org Tue Jul 22 20:55:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLN1G-000212-8B
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 20:55:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753244AbYGVSyb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 14:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753236AbYGVSyb
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 14:54:31 -0400
Received: from pan.madism.org ([88.191.52.104]:46238 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753166AbYGVSya (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 14:54:30 -0400
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 1B7D42D4E6;
	Tue, 22 Jul 2008 20:54:28 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 7535DA27B; Tue, 22 Jul 2008 20:54:27 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Olivier Marin <dkr+ml.git@free.fr>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1216752267-12138-1-git-send-email-dkr+ml.git@free.fr>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89512>


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2008 at 06:44:27PM +0000, Olivier Marin wrote:
> From: Olivier Marin <dkr@freesurf.fr>
>=20
> Before this patch, running a git command with a "--foobar=3D" argument
> will set the "foobar" option with a random value and continue.
> We should instead, exit with an error if a value is required, or use
> the default one if the value is optional.

  Wrong, --foobar=3D is the option "foobar" with the argument "" (empty
string). as soon as you use the --foobar=3D... form, that is the "stuck
form" for long option, there *is* a value.

  IOW --foobar=3D is not the same as --foobar at all. If like you claim,
--foobar=3D pass a "random" value to the option then *this* is a bug, it
should pass a pointer to an empty string (IOW a pointer that points to a
NUL byte), but I see nothing in the code that would explain what you
claim.


--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkiGLOEACgkQvGr7W6HudhypPwCdEp959FsPXWtheYFJq4wOKlCs
5mkAniWNS4/I9YJXEyllXw6Aeu6Xsz0p
=MFcF
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
