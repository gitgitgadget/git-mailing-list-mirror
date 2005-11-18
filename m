From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: "make test" fails with current HEAD
Date: Fri, 18 Nov 2005 11:54:15 +0100
Message-ID: <20051118105415.GN31613@kiste.smurf.noris.de>
References: <pan.2005.11.17.15.31.56.755022@smurf.noris.de> <7v7jb6o1kl.fsf@assigned-by-dhcp.cox.net> <20051118075117.GK31613@kiste.smurf.noris.de> <7vbr0imlha.fsf@assigned-by-dhcp.cox.net> <pan.2005.11.18.08.56.22.908009@smurf.noris.de> <Pine.LNX.4.63.0511181134080.8037@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dp9QYJgVRVEW2bsm"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 11:56:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ed3tb-0005xa-Hs
	for gcvg-git@gmane.org; Fri, 18 Nov 2005 11:55:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161050AbVKRKzE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 05:55:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161044AbVKRKzD
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 05:55:03 -0500
Received: from run.smurf.noris.de ([192.109.102.41]:40931 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S1161039AbVKRKzB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2005 05:55:01 -0500
Received: from kiste.smurf.noris.de ([192.109.102.35] ident=mail)
	by server.smurf.noris.de with smtp (Exim 4.50)
	id 1Ed3sl-0002Bu-Ce; Fri, 18 Nov 2005 11:54:25 +0100
Received: (nullmailer pid 25239 invoked by uid 501);
	Fri, 18 Nov 2005 10:54:15 -0000
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0511181134080.8037@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.9i
X-Smurf-Spam-Score: -2.5 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12223>


--dp9QYJgVRVEW2bsm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Johannes Schindelin:
> From my diff man page:
>=20
> -- snip --
> DIAGNOSTICS
>        An  exit status of 0 means no differences were found, 1 means some=
=20
>        differences were found, and 2 means trouble.
> -- snap --
>=20
> The exit value 2 is ambiguous for at least one version of GNU diff.
>=20
AFAIK, We have
0 - no difference
1 - produced a reasonable diff
1 - produced a bad diff because binary stuff starts
    after 4096-or-whatever bytes and diff didn't notice
2 - didn't produce a diff -- binary files differ
2 - something else broke

Right now we simply don't consider the second -2- case, because we just
successfully wrote the two files in question; there's not *that* much
that can fail after that. The second -1- case is sufficiently rare too.

So I still think a "Just write a 'Binary files FOO and BAR differ' line
if the exit status is 2" rule would at least fix the current bug with
diff 2.8.7.

--=20
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
<Knghtbrd> xtifr - beware of james when he's off his medication  =3D3D>

--dp9QYJgVRVEW2bsm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDfbLX8+hUANcKr/kRApyFAKCPsoYq0QVFsRyw95lpdkEEbISh5gCgqEIf
1XLVp5izmpm37HL5c/O4LpQ=
=HW1d
-----END PGP SIGNATURE-----

--dp9QYJgVRVEW2bsm--
