From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: [CLEANUP PATCH RESEND] git wrapper: Make while loop more reader-friendly
Date: Fri, 2 Jan 2009 12:28:03 -0600
Message-ID: <200901021228.07599.bss@iguanasuicide.net>
References: <alpine.DEB.1.00.0901021240270.27818@racer>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5450040.Bj6PdY2ITN";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 02 19:29:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIolY-0000J5-Jg
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 19:29:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758806AbZABS1m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 13:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758789AbZABS1m
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 13:27:42 -0500
Received: from rei.iguanasuicide.net ([209.20.91.252]:58322 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758773AbZABS1l (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 13:27:41 -0500
Received: from ip72-204-50-125.fv.ks.cox.net ([72.204.50.125] helo=[10.0.0.124])
	by rei.iguanasuicide.net with esmtpsa (TLS-1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LIokD-0003Ie-7o; Fri, 02 Jan 2009 18:27:37 +0000
User-Agent: KMail/1.9.10
In-Reply-To: <alpine.DEB.1.00.0901021240270.27818@racer>
X-Eric-Conspiracy: There is no conspiracy.
X-Virus-Scanned: clamav@iguanasuicide.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104398>

--nextPart5450040.Bj6PdY2ITN
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 2009 January 02 12:07:52 you wrote:
> It is not a good practice to prefer performance over readability in
> something as performance uncritical as finding the trailing slash
> of argv[0].
>
> So avoid head-scratching by making the loop user-readable, and not
> hyper-performance-optimized.

> -	do
> -		--slash;
> -	while (cmd <=3D slash && !is_dir_sep(*slash));
> +	while (cmd <=3D slash && !is_dir_sep(*slash))
> +		slash--;

What confused people?  The predecrement or the do/while?  Should people tha=
t=20
don't understand one of those be hacking on git?

That said, I'm not opposed to the patch.  It is easier on the eyes, though =
I=20
prefer the one-liner:
for (; cmd <=3D slash && !is_dir_sep(*slash); --slash);
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart5450040.Bj6PdY2ITN
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkleXLcACgkQdNbfk+86fC1NRwCcCVJD1HAsPpi8o1JLoxx5T833
qosAnArrO4MTykO1QMsUsq1nA8Qmbs3D
=x+BX
-----END PGP SIGNATURE-----

--nextPart5450040.Bj6PdY2ITN--
