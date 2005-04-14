From: Martin Schlemmer <azarah@nosferatu.za.org>
Subject: Re: Remove need to untrack before tracking new branch
Date: Fri, 15 Apr 2005 01:25:56 +0200
Message-ID: <1113521156.23299.140.camel@nosferatu.lan>
References: <20050413092656.GO16489@pasky.ji.cz>
	 <1113394537.23299.51.camel@nosferatu.lan>
	 <20050413221936.GI25711@pasky.ji.cz>
	 <1113461754.23299.68.camel@nosferatu.lan>
	 <1113467335.23299.77.camel@nosferatu.lan>
	 <1113467905.23299.81.camel@nosferatu.lan>
	 <20050414091106.GX25711@pasky.ji.cz>
	 <1113471609.23299.95.camel@nosferatu.lan>
	 <20050414224257.GM22699@pasky.ji.cz>
	 <1113519687.23299.126.camel@nosferatu.lan>
	 <20050414230047.GS22699@pasky.ji.cz>
	 <1113520175.23299.134.camel@nosferatu.lan>
Reply-To: azarah@nosferatu.za.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-MRdUg7tGBI4ANkr2Wtru"
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 01:19:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMDcN-0005yi-KQ
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 01:19:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbVDNXWp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 19:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261649AbVDNXWp
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 19:22:45 -0400
Received: from ctb-mesg3.saix.net ([196.25.240.75]:62388 "EHLO
	ctb-mesg3.saix.net") by vger.kernel.org with ESMTP id S261648AbVDNXWK
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2005 19:22:10 -0400
Received: from gateway.lan (wblv-146-239-208.telkomadsl.co.za [165.146.239.208])
	by ctb-mesg3.saix.net (Postfix) with ESMTP id DFF04266E;
	Fri, 15 Apr 2005 01:22:07 +0200 (SAST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gateway.lan (Postfix) with ESMTP id 532263A26DB;
	Fri, 15 Apr 2005 01:28:13 +0200 (SAST)
Received: from gateway.lan ([127.0.0.1])
 by localhost (gateway.lan [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 14157-09; Fri, 15 Apr 2005 01:28:07 +0200 (SAST)
Received: from nosferatu.lan (nosferatu.lan [192.168.0.2])
	(using TLSv1 with cipher IDEA-CBC-SHA (128/128 bits))
	(No client certificate requested)
	by gateway.lan (Postfix) with ESMTP id 346F23A26DA;
	Fri, 15 Apr 2005 01:28:07 +0200 (SAST)
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <1113520175.23299.134.camel@nosferatu.lan>
X-Mailer: Evolution 2.2.1.1 
X-Virus-Scanned: by amavisd-new using ClamAV at nosferatu.za.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-MRdUg7tGBI4ANkr2Wtru
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-04-15 at 01:09 +0200, Martin Schlemmer wrote:
> On Fri, 2005-04-15 at 01:00 +0200, Petr Baudis wrote:
> > Dear diary, on Fri, Apr 15, 2005 at 01:01:27AM CEST, I got a letter
> > where Martin Schlemmer <azarah@nosferatu.za.org> told me that...
> > > On Fri, 2005-04-15 at 00:42 +0200, Petr Baudis wrote:
> > > > Dear diary, on Thu, Apr 14, 2005 at 11:40:09AM CEST, I got a letter
> > > > where Martin Schlemmer <azarah@nosferatu.za.org> told me that...
> > > > > > > -       snprintf(cmd, sizeof(cmd), "diff -L %s -u -N  - %s", =
name, name);
> > > > > > > +       for (n =3D 0; n < 20; n++)
> > > > > > > +               snprintf(&(sha1[n*2]), 3, "%02x", ce->sha1[n]=
);
> > > > > > > +       snprintf(cmd, sizeof(cmd), "diff -L %s/%s -L uncommit=
ted/%s -u -N  - %s",
> > > > > > > +               sha1, ce->name, ce->name, ce->name);
> > > > > >=20
> > > > > > The "directory" sha1 is the sha1 of the tree, not of the partic=
ular
> > > > > > file - that one is in the "attributes" list (parentheses after =
the
> > > > > > filename), together with mode.
> > > > > >=20
> > > > >=20
> > > > > Does it really matter?  It is more just to get the patch prefix r=
ight,
> > > > > and I did it as it went nicely with the printed:
> > > > >=20
> > > > > ----
> > > > > show-diff.c:  a531ca4078525d1c8dcf84aae0bfa89fed6e5d96
> > > > > ----
> > > > >=20
> > > > > for example ...
> > > >=20
> > > > Yes, it matters, and I don't care how nicely it wents with what you
> > > > print before.
> > > >=20
> > >=20
> > > hah ;p
> > >=20
> > > > Either print there some nonsense which is clear not to be a tree ID=
, or
> > > > (much more preferably) print the real tree ID there. If some tool e=
ver
> > > > uses it (e.g. to help resolve conflicts, perhaps even actually doin=
g a
> > > > real merge based on the patch), you just confused it.
> > > >=20
> > >=20
> > > Ok, understood.  Do you think it will be scripted?  If not I guess we
> > > can just do labels like:
> > >=20
> > > --- committed/
> > > +++ uncommitted/
> > >=20
> > > ?
> >=20
> > Heh. Well, of course this could do. But is there any technical reason
> > why not just carry the sha1 id of the tree around and stuff it there?
> >=20
>=20
> Not at all. Just wanted to know if anybody saw the possible use before
> adding possible cruft that could be done shorter - will do a patch
> shortly.
>=20

Ho hum - none of the lowlevel tools know or work with the tree-id, and I
am not too sure if Linus will like adding something to get it ... any
ideas?


--=20
Martin Schlemmer


--=-MRdUg7tGBI4ANkr2Wtru
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCXvwEqburzKaJYLYRAmtHAJ9lfR06Bn8+7gsCMb211nN+XobTFACdGAaW
I8hnlGvrML8iWkFf6NuSU7Q=
=uqw4
-----END PGP SIGNATURE-----

--=-MRdUg7tGBI4ANkr2Wtru--

