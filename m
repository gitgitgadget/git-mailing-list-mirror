From: Jan Hudec <bulb@ucw.cz>
Subject: Re: Blamming a diff between two commits?
Date: Sun, 22 Feb 2009 20:11:38 +0100
Message-ID: <20090222191138.GC6504@efreet.light.src>
References: <499AB8A1.7090909@datacom.ind.br> <20090222123248.GA6504@efreet.light.src> <vpqtz6mpas3.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Cc: Samuel Lucas Vaz de Mello <samuellucas@datacom.ind.br>,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sun Feb 22 20:13:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbJlH-0007Vo-UF
	for gcvg-git-2@gmane.org; Sun, 22 Feb 2009 20:13:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752060AbZBVTLn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Feb 2009 14:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751975AbZBVTLn
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 14:11:43 -0500
Received: from cuda1.bluetone.cz ([212.158.128.5]:36213 "EHLO mail.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751856AbZBVTLn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Feb 2009 14:11:43 -0500
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by mail.bluetone.cz (Spam Firewall) with ESMTP
	id B431B329967; Sun, 22 Feb 2009 20:11:40 +0100 (CET)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145]) by mail.bluetone.cz with ESMTP id FxosvcpQveO9XnaH; Sun, 22 Feb 2009 20:11:40 +0100 (CET)
Received: from bulb by efreet.light.src with local (Exim 4.69)
	(envelope-from <bulb@ucw.cz>)
	id 1LbJjm-0004jc-UV; Sun, 22 Feb 2009 20:11:38 +0100
Content-Disposition: inline
In-Reply-To: <vpqtz6mpas3.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111051>


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 22, 2009 at 19:49:16 +0100, Matthieu Moy wrote:
> Jan Hudec <bulb@ucw.cz> writes:
> > On Tue, Feb 17, 2009 at 10:16:17 -0300, Samuel Lucas Vaz de Mello wrote:
> >> Hi,
> >>=20
> >> Is there any way to git blame (or annotate) a diff between two commits?
> >> [...]
> >
> > What about doing a diff of the blames? It should do the same thing (exc=
ept
> > the +/- would be at the begining of the lines). Well, not exactly, beca=
use if
> > there was a change, that was reverted again, blames would change, so it=
 would
> > appear here, but that's probably rare enough to ignore (if you don't ev=
en
> > want to see it rather than not).
>=20
> I don't think that would do it.
>=20
> Suppose I have the following history (in a one-line file) :
>=20
> revision: R1 -> R2 -> R3 -> R4 -> R5 -> R6
> content:  A  -> B  -> B  -> C  -> D  -> E=20
>=20
> If I do a blame at revision R3, I'll get
>=20
> R2 B
>=20
> Then, at revision R6, I'd get
>=20
> R6 E
>=20
> so the diff will be
>=20
> - R2 B
> + R6 E
>=20
> while the original poster actually wanted
>=20
> - R3 B
> + R6 E
>=20
> In the first case, the annotation for - lines tell where the removed
> line had been introduced before, while the second case tells up to
> which revision the line has been existing (or, it could show the
> revision which removed it, R4 here).

You are right, it is something different.

Both are probably useful, though -- knowing where the deleted line was
introduced would be useful so you can look up rationale for the old code in
the respective commit message and check whether the new version does not mi=
ss
any points mentioned there. Provided you have good descriptions in the
comments, of course.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmho2oACgkQRel1vVwhjGV7fQCeP90ioDa9p2KhiZ/xF1FZPUCb
9g0AnR446HRt3jyBqDszWvOgNEhmoId8
=DXEZ
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
