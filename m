From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] guilt(1): Obvious bashisms fixed.
Date: Thu, 14 Jun 2007 17:18:34 +0200
Message-ID: <20070614151834.GL23324@artemis>
References: <11818254621527-git-send-email-madcoder@debian.org> <1181825462590-git-send-email-madcoder@debian.org> <20070614151512.GB934@filer.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="HBg0C3yr6HVa1ZCc";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Josef Sipek <jsipek@cs.sunysb.edu>
X-From: git-owner@vger.kernel.org Thu Jun 14 17:18:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hyr5t-00073s-Dw
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 17:18:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752251AbXFNPSh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jun 2007 11:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752209AbXFNPSh
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 11:18:37 -0400
Received: from pan.madism.org ([88.191.52.104]:59175 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752141AbXFNPSg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2007 11:18:36 -0400
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 35CBCDA55;
	Thu, 14 Jun 2007 17:18:35 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id E52A729EB; Thu, 14 Jun 2007 17:18:34 +0200 (CEST)
Mail-Followup-To: Josef Sipek <jsipek@cs.sunysb.edu>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070614151512.GB934@filer.fsl.cs.sunysb.edu>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50206>


--HBg0C3yr6HVa1ZCc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 14, 2007 at 11:15:12AM -0400, Josef Sipek wrote:
> On Thu, Jun 14, 2007 at 02:50:57PM +0200, Pierre Habouzit wrote:
> >   + function foo { } -> foo() { }
> >   + add wrapper for echo -e
> >   + couple of '[' bashisms
> >   + get rid of easy local variables to remove
> >   + avoid cd - (using subshells)
> ....=20
>=20
> Just a small nit-pick :)
>=20
> > diff --git a/guilt b/guilt
> > index 2ae76f8..80f3faf 100755
> > --- a/guilt
> > +++ b/guilt
> > @@ -20,7 +20,29 @@ SUBDIRECTORY_OK=3D1
> ....
> > +guilt_commands()
> >  {
> >  	local command
> >  	for command in $0-*
> > @@ -32,7 +54,7 @@ function guilt_commands
> >  	done
> >  }
> > =20
> > -if [ `basename $0` =3D "guilt" ]; then
> > +if [ "`basename $0`" =3D "guilt" ]; then
>=20
> You added quotes here - that's ok....
>=20
> >  	# being run as standalone
> > =20
> >  	# by default, we shouldn't fail
> > @@ -58,7 +80,7 @@ if [ `basename $0` =3D "guilt" ]; then
>=20
> But did not add them here.... :)

  heh, I tried my best, I've no automated tool for that, only my eyes
and thise code will break iff `basename $0` has spaces in it, which is
rather crazy anyways. But you're welcome to add the missing ones *sigh*

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--HBg0C3yr6HVa1ZCc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGcVxKvGr7W6HudhwRAgQmAJ0bA0uhq9eY0KX3PjSYEHUyp55vfwCghyxe
ZPBIq6/4UmrN7XlTgLlDkzc=
=zcp6
-----END PGP SIGNATURE-----

--HBg0C3yr6HVa1ZCc--
