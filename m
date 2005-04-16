From: Martin Schlemmer <azarah@nosferatu.za.org>
Subject: Re: Plug memory leak in update-cache.c
Date: Sat, 16 Apr 2005 02:00:21 +0200
Message-ID: <1113609621.8582.12.camel@nosferatu.lan>
References: <1113468830.23299.85.camel@nosferatu.lan>
	 <20050415234807.GS7417@pasky.ji.cz>
Reply-To: azarah@nosferatu.za.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-GPjmrmlAVq0xNDXccEl2"
Content-Transfer-Encoding: 8bit
Cc: GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 16 01:53:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMad7-0001bb-QV
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 01:53:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262449AbVDOX5A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 19:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262485AbVDOX4n
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 19:56:43 -0400
Received: from ctb-mesg2.saix.net ([196.25.240.74]:52991 "EHLO
	ctb-mesg2.saix.net") by vger.kernel.org with ESMTP id S262449AbVDOX4e
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2005 19:56:34 -0400
Received: from gateway.lan (wblv-146-246-09.telkomadsl.co.za [165.146.246.9])
	by ctb-mesg2.saix.net (Postfix) with ESMTP id AF52A3CFD;
	Sat, 16 Apr 2005 01:56:30 +0200 (SAST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gateway.lan (Postfix) with ESMTP id D27733A26DB;
	Sat, 16 Apr 2005 02:02:37 +0200 (SAST)
Received: from gateway.lan ([127.0.0.1])
 by localhost (gateway.lan [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 05741-14; Sat, 16 Apr 2005 02:02:33 +0200 (SAST)
Received: from nosferatu.lan (nosferatu.lan [192.168.0.2])
	(using TLSv1 with cipher IDEA-CBC-SHA (128/128 bits))
	(No client certificate requested)
	by gateway.lan (Postfix) with ESMTP id 247193A26DA;
	Sat, 16 Apr 2005 02:02:33 +0200 (SAST)
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050415234807.GS7417@pasky.ji.cz>
X-Mailer: Evolution 2.2.1.1 
X-Virus-Scanned: by amavisd-new using ClamAV at nosferatu.za.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-GPjmrmlAVq0xNDXccEl2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2005-04-16 at 01:48 +0200, Petr Baudis wrote:
> Dear diary, on Thu, Apr 14, 2005 at 10:53:50AM CEST, I got a letter
> where Martin Schlemmer <azarah@nosferatu.za.org> told me that...
> > Hi,
> >=20
> > Might not be that an big an issue as it should be freed on exit, but
> > might cause problems with big trees.
> >=20
> > ----
> >=20
> > Plug memory leak in update-cache.c.
> >=20
> > Signed-off-by: Martin Schlemmer <azarah@nosferatu.za.org>
> >=20
> > update-cache.c:  22f3ccd47db4f0888901109a8cbf883d272d1cba
> > --- 22f3ccd47db4f0888901109a8cbf883d272d1cba/update-cache.c
> > +++ uncommitted/update-cache.c
> > @@ -202,6 +202,7 @@
> >                         printf("%s: needs update\n", ce->name);
> >                         continue;
> >                 }
> > +               free(active_cache[i]);
> >                 active_cache[i] =3D new;
> >         }
> >  }
>=20
> FYI, new could've contained active_cache[i] at that time, so you needed
> to check for that. Fixed though, thanks for pointing it out.
>=20

Urk, no, please drop.  As Ingo pointed out, the memory was obtained via
mmap ...


--=20
Martin Schlemmer


--=-GPjmrmlAVq0xNDXccEl2
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCYFWVqburzKaJYLYRAlvcAJ9D21OmjOk1Y8O2PjbAbw/Ts0sphQCfWnFZ
D8AJN8PcEsxqidTilZszA1w=
=iy6h
-----END PGP SIGNATURE-----

--=-GPjmrmlAVq0xNDXccEl2--

