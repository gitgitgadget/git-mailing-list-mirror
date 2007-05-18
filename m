From: Jan Hudec <bulb@ucw.cz>
Subject: Re: Opinions on bug fix organisation
Date: Fri, 18 May 2007 21:50:00 +0200
Message-ID: <20070518195000.GC3327@efreet.light.src>
References: <200705161138.30134.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uh9ZiVrAOUUm9fzH"
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 18 21:50:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hp8T4-0007ie-Vx
	for gcvg-git@gmane.org; Fri, 18 May 2007 21:50:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752893AbXERTuV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 15:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754375AbXERTuV
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 15:50:21 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:4311 "EHLO mail.bluetone.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752893AbXERTuU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 15:50:20 -0400
Received: from ([85.207.119.145])
	by mail.bluetone.cz with ESMTP  id 5203017.374798;
	Fri, 18 May 2007 21:50:00 +0200
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1Hp8Se-0001Dz-Au; Fri, 18 May 2007 21:50:00 +0200
Content-Disposition: inline
In-Reply-To: <200705161138.30134.andyparkins@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-esp: ESP<0>=
	RBL:<0> 
	SHA:<0> 
	UHA:<0> 
	BAYES:<0> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47655>


--uh9ZiVrAOUUm9fzH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 16, 2007 at 11:38:28 +0100, Andy Parkins wrote:
> Now, I want to make a commit that fixes that bug.  These are the options:
>=20
>  * -- * -- B -- * -- * -- * -- F
>=20
>  or
>=20
>  * -- * -- B -- * -- * -- * -- M
>             \                 /
>              --------------- F
>=20
> That is - just commit a fix or, commit the fix, "F", directly on "B" then=
=20
> merge that fix back to HEAD with "M".
>=20
> I quite like option 2 because it records intent - i.e. "I wish I could ha=
ve=20
> gone back and changed this revision, but I can't", but it makes a more=20
> complicated history.
>=20
> What do people think?

The big advantage of the later is, that if you have:

 * -- B -- * -- * -- M1
       \
        -- * -- * -- M2

You can merge the fix done on yet another branch into how many branches you
need, so:

 * -- B -- * -- * ----- M1
       \               /
        -- * -- * ----/- M2
	 \           /  /
	  ----------F---

If you had the fix on one of the branches, you could only cherry-pick it to
the other, but the history would not really reflect that.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--uh9ZiVrAOUUm9fzH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGTgNoRel1vVwhjGURArNpAJwJucEhFqAuxsvIzJWgxW/IsmF38QCgv7/2
DaXlhs8CioHAHtOxucsnN70=
=fyIl
-----END PGP SIGNATURE-----

--uh9ZiVrAOUUm9fzH--
