From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] Makefile: improve customization for supporting HP-UX
Date: Sun, 24 Aug 2008 00:03:58 +0200
Message-ID: <20080823220358.GH23800@genesis.frugalware.org>
References: <1219520484-7712-1-git-send-email-vmiklos@frugalware.org> <20080823200928.GA7185@schiele.dyndns.org> <20080823202601.GF23800@genesis.frugalware.org> <20080823210243.GB7185@schiele.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vIq7vvlOcsOjFaxi"
Cc: git@vger.kernel.org
To: Robert Schiele <rschiele@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 24 00:06:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KX1EH-0002eM-J4
	for gcvg-git-2@gmane.org; Sun, 24 Aug 2008 00:05:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751777AbYHWWEA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 18:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752799AbYHWWEA
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 18:04:00 -0400
Received: from virgo.iok.hu ([193.202.89.103]:49968 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751593AbYHWWEA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 18:04:00 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 959EB1B2537;
	Sun, 24 Aug 2008 00:03:58 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 8D2AB4465E;
	Sat, 23 Aug 2008 23:05:39 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 23701119003C; Sun, 24 Aug 2008 00:03:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080823210243.GB7185@schiele.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93493>


--vIq7vvlOcsOjFaxi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 23, 2008 at 11:02:43PM +0200, Robert Schiele <rschiele@gmail.co=
m> wrote:
> On Sat, Aug 23, 2008 at 10:26:01PM +0200, Miklos Vajna wrote:
> > On Sat, Aug 23, 2008 at 10:09:28PM +0200, Robert Schiele <rschiele@gmai=
l.com> wrote:
> > > The systems I build on are:
> > >=20
> > > 1x HP-UX B.11.11 U 9000/785
> >=20
> > This is the same version I'm using at the moment.
> >=20
> > The NEEDS_LIBICONV is simple, the linker fails to find iconv symbols:
> >=20
> > /usr/ccs/bin/ld: Unsatisfied symbols:
> >    libiconv (first referenced in libgit.a(utf8.o)) (code)
> >    libiconv_open (first referenced in libgit.a(utf8.o)) (code)
> >    libiconv_close (first referenced in libgit.a(utf8.o)) (code)
> > collect2: ld returned 1 exit status
> > gmake: *** [git] Error 1
>=20
> Huh?  Where does the "lib" prefix come from on your system?  Do you have =
some
> custom iconv header file in the way?  On my system I see:
>=20
> [13] % nm /usr/lib/libc.2 | grep ^iconv
> iconv               |   1255080|extern|entry  |
> iconv               |   1255112|extern|code   |$CODE$
> iconv_close         |   1254800|extern|entry  |
> iconv_close         |   1254832|extern|code   |$CODE$
> iconv_open          |   1255208|extern|entry  |
> iconv_open          |   1255272|extern|code   |$CODE$
> [14] %=20

Ah, OK, that is specific to this machine. If you install the libiconv
package, then #include <iconv.h> includes /usr/local/include/iconv.h
where iconv is a define to libiconv. So that is not needed generally,
thanks for pointing out.

> Thus I think the snprintf part of your patch makes sense but the iconv st=
uff
> seems to be something flawed on your machine.

OK, I'll send a patch with that part only in a bit.

--vIq7vvlOcsOjFaxi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiwiU4ACgkQe81tAgORUJYalACgpR4zS9ftap3q+wCryy8CRuvW
M08An2uShmH0PlLSFdy3HU+A3CfeogUo
=ilCQ
-----END PGP SIGNATURE-----

--vIq7vvlOcsOjFaxi--
