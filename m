From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: rebase -i: learn to rebase root commit
Date: Mon, 29 Dec 2008 16:21:31 -0600
Message-ID: <200812291621.35732.bss@iguanasuicide.net>
References: <cover.1230568082.git.trast@student.ethz.ch> <5d0be6d15bbdaa8b95c1df161b67ecd4120d7ce4.1230569041.git.trast@student.ethz.ch> <200812292249.45900.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3395265.fUQuC0Va8R";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <junio@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Dec 29 23:22:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHQVR-0006Sa-R4
	for gcvg-git-2@gmane.org; Mon, 29 Dec 2008 23:22:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753396AbYL2WVQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2008 17:21:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753242AbYL2WVP
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 17:21:15 -0500
Received: from rei.iguanasuicide.net ([209.20.91.252]:36160 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753127AbYL2WVP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2008 17:21:15 -0500
Received: from [206.104.162.243]
	by rei.iguanasuicide.net with esmtpsa (TLS-1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LHQU3-0004HL-TT; Mon, 29 Dec 2008 22:21:12 +0000
User-Agent: KMail/1.9.10
In-Reply-To: <200812292249.45900.trast@student.ethz.ch>
X-Eric-Conspiracy: There is no conspiracy.
X-Virus-Scanned: clamav@iguanasuicide.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104135>

--nextPart3395265.fUQuC0Va8R
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 2008 December 29 15:49:42 Thomas Rast wrote:
> Thomas Rast wrote:
> > Teach git-rebase -i a new option --root, which instructs it to rebase
> > the entire history leading up to <branch>.  This is mainly for
> > symmetry with ordinary git-rebase; it cannot be used to edit the root
> > commit in-place (it requires --onto).
>
> Actually, I forgot the "rebase -i -p" code path, which dies if --root
> is used with -p.  Apologies.
>
> So for now, consider this broken and RFC: is there any sensible
> use/interpretation of -p --root that I'm missing?  Or should it just
> disallow this combination?

Here's the interpretation that *I* come up with for -p --root used together:
The commit with no parents (OLD_ROOT) is rebased as if -p were not given, c=
all=20
the resulting commit NEW_ROOT.  Then, the rebase continues as if "--onto=20
NEW_ROOT OLD_ROOT <branch>" was specified instead of "--onto=3DNEW_ROOT^ --=
root=20
<branch>".

Basically, --root only changes how the first commit is handled, which I thi=
nk=20
is consistent with other uses of --root.  It's also similar to cherry-picki=
ng=20
the first commit, follwed by a non-root rebase, which I think is also=20
consistent with the intention of --root.
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart3395265.fUQuC0Va8R
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklZTW8ACgkQdNbfk+86fC2OYACdHiXhOLosIgYJtOMNaNCHWABt
cx4AniUHSJW5Vnz5e373KGLnwF1DUInm
=xjFE
-----END PGP SIGNATURE-----

--nextPart3395265.fUQuC0Va8R--
