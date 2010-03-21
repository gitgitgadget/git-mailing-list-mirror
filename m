From: "R. Tyler Ballance" <tyler@monkeypox.org>
Subject: Re: [PATCH v2] Correct references to /usr/bin/python which does
 not exist on FreeBSD
Date: Sun, 21 Mar 2010 14:23:35 -0700
Message-ID: <20100321212335.GB32016@kiwi.sharlinx.com>
References: <20100321190145.GA32578@kiwi.sharlinx.com>
 <7veijdl6kp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jho1yZJdad60DJr+"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 21 22:23:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtSch-0006B1-Au
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 22:23:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753508Ab0CUVXq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Mar 2010 17:23:46 -0400
Received: from mail.geekisp.com ([216.168.135.169]:45777 "EHLO
	starfish.geekisp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753308Ab0CUVXp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 17:23:45 -0400
Received: (qmail 11437 invoked by uid 1003); 21 Mar 2010 21:23:43 -0000
Received: from localhost (HELO kiwi.sharlinx.com) (tyler@monkeypox.org@127.0.0.1)
  by mail.geekisp.com with SMTP; 21 Mar 2010 21:23:43 -0000
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7veijdl6kp.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142864>


--jho1yZJdad60DJr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On Sun, 21 Mar 2010, Junio C Hamano wrote:

> "R. Tyler Ballance" <tyler@monkeypox.org> writes:
>=20
> > On FreeBSD, Python does not ship as part of the base system but is avai=
lable
> > via the ports system, which install the binary in /usr/local/bin.
> > ---
>=20
> Sign-off?

Sorry, I was under the impression somebody who knew what the hell they were
doing would be the one adding a Sign-off By to the commit :)


>=20
> > diff --git a/Makefile b/Makefile
> > index 3a6c6ea..4f8fbf0 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -444,7 +444,11 @@ ifndef PERL_PATH
> >  	PERL_PATH =3D /usr/bin/perl
> >  endif
> >  ifndef PYTHON_PATH
> > -	PYTHON_PATH =3D /usr/bin/python
> > +	ifeq ($(uname_S),FreeBSD)
> > +		PYTHON_PATH =3D /usr/local/bin/python
> > +	else
> > +		PYTHON_PATH =3D /usr/bin/python
> > +	endif
> >  endif
>=20
> I would have expected that the patch would look more like this:
>=20
> diff --git a/Makefile b/Makefile
> index 98372eb..5bb0769 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -831,6 +831,7 @@ ifeq ($(uname_S),FreeBSD)
>  		NO_UINTMAX_T =3D YesPlease
>  		NO_STRTOUMAX =3D YesPlease
>  	endif
> +	PYTHON_PATH =3D /usr/local/bin/python
>  endif
>  ifeq ($(uname_S),OpenBSD)
>  	NO_STRCASESTR =3D YesPlease
>=20
> What am I missing?

No, that looks right, I didn't notice the specialized section towards the
bottom for FreeBSD or the others for that matter.

Third time's the charm

Cheers,
-R. Tyler Ballance
--------------------------------------
 Jabber: rtyler@jabber.org
 GitHub: http://github.com/rtyler
Twitter: http://twitter.com/agentdero
   Blog: http://unethicalblogger.com


--jho1yZJdad60DJr+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iEYEARECAAYFAkumjlcACgkQFCbH3D9R4W9srQCeIotg+bYfvxM57OkQpbO491dR
XgwAoLb6fNJTTp+VbM9mal5un8UshzH8
=CS7p
-----END PGP SIGNATURE-----

--jho1yZJdad60DJr+--
