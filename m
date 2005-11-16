From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [PATCH] symref support for import scripts
Date: Wed, 16 Nov 2005 20:57:37 +0100
Message-ID: <20051116195737.GE27727@kiste.smurf.noris.de>
References: <1132165648.4024.6.camel@dv> <7vu0ec7502.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7fVM7fn5T1d7Fqim"
Cc: Pavel Roskin <proski@gnu.org>, git@vger.kernel.org,
	Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 16 21:00:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcTR7-0002Uv-Nu
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 20:59:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030444AbVKPT7K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Nov 2005 14:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030472AbVKPT7K
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 14:59:10 -0500
Received: from run.smurf.noris.de ([192.109.102.41]:27283 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S1030444AbVKPT7I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2005 14:59:08 -0500
Received: from kiste.smurf.noris.de ([192.109.102.35] ident=mail)
	by server.smurf.noris.de with smtp (Exim 4.50)
	id 1EcTPW-0002Ty-03; Wed, 16 Nov 2005 20:57:47 +0100
Received: (nullmailer pid 27292 invoked by uid 501);
	Wed, 16 Nov 2005 19:57:37 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vu0ec7502.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
X-Smurf-Spam-Score: -2.5 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12046>


--7fVM7fn5T1d7Fqim
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Junio C Hamano:
> Martin and Matthias, are these OK with you two?  All of the
> changes look trivially correct, so I'll take them.
>=20
IMHO: That code needs to vanish anyway.

The only reason we have to read HEAD is that, at the end of the
day^Wimport, whatever HEAD points to may have been updated. Thus,
we need to merge forward, to get the index back into sync.

The only thing we want to do with HEAD, in order to accomplish that,
is to find the SHA1 it points to, before and after the import.
No use of git-symbolic-ref is necessary for that.

All the deref code was a good idea when we actually modified the
checked-out index and/or tree while importing, but that does not happen
any more.

--=20
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
A good supervisor can step on your toes without messing up your shine.

--7fVM7fn5T1d7Fqim
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDe48x8+hUANcKr/kRAopFAJ9C4w5YC3PFNTD6tewsI8Ybh3aFHwCeMJQG
zzj8Ndugn3vG7DGxxKfU++g=
=gLEO
-----END PGP SIGNATURE-----

--7fVM7fn5T1d7Fqim--
