From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [RFC] Cleaning up die() error messages
Date: Wed, 12 Oct 2005 08:04:36 +0200
Message-ID: <20051012060436.GA567@kiste.smurf.noris.de>
References: <20051010105008.GB30202@gentoo.org> <7vzmph42j2.fsf@assigned-by-dhcp.cox.net> <pan.2005.10.11.19.48.04.675482@smurf.noris.de> <434C2590.3040107@zytor.com> <pan.2005.10.12.01.20.17.917829@smurf.noris.de> <434C8095.4080201@zytor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9AazSAFPVKSPmRXK"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 12 08:06:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPZki-0008Rn-Mt
	for gcvg-git@gmane.org; Wed, 12 Oct 2005 08:06:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451AbVJLGGE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Oct 2005 02:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932467AbVJLGGE
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Oct 2005 02:06:04 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:49114 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S932451AbVJLGGD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2005 02:06:03 -0400
Received: from kiste.smurf.noris.de ([192.109.102.35] ident=mail)
	by server.smurf.noris.de with smtp (Exim 4.50)
	id 1EPZjA-0001rG-MX; Wed, 12 Oct 2005 08:05:25 +0200
Received: (nullmailer pid 10566 invoked by uid 501);
	Wed, 12 Oct 2005 06:04:36 -0000
To: "H\. Peter Anvin" <hpa@zytor.com>
Content-Disposition: inline
In-Reply-To: <434C8095.4080201@zytor.com>
User-Agent: Mutt/1.5.9i
X-Smurf-Spam-Score: -2.6 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10010>


--9AazSAFPVKSPmRXK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

H. Peter Anvin:
> >I thought about doing something like that, but ...
> >>However, a much bigger problem is cleanup.
> >
> >... exactly.
>=20
> I thought about this, and probably the sanest way is to wrap malloc()=20
> with something that creates a linked list of allocations.  If we abort,=
=20
> we can unwind the linked list and free all allocations.
>=20
There already is a malloc library that does this, plus it can call
cleanup for you -- there's more to cleaning up than freeing memory. :-/

Let's see if I can actually find it again.

On the other hand, I wonder if the overhead when managing data
structures like that really offsets the additional work we'd need to do
otherwise, which is simply checking a few more return values.

--=20
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
BOFH excuse #381:

Robotic tape changer mistook operator's tie for a backup tape.

--9AazSAFPVKSPmRXK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDTKd08+hUANcKr/kRArNqAJ9qGQy5bQtV7ERnikSkwvcLtWnyawCgicUa
Ouy5+IjgOjO3L+CTs/CISMg=
=DTcE
-----END PGP SIGNATURE-----

--9AazSAFPVKSPmRXK--
