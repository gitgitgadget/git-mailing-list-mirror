From: Pierre Habouzit <madcoder@madism.org>
Subject: Re: obnoxious CLI complaints
Date: Thu, 10 Sep 2009 00:58:21 +0200
Message-ID: <20090909225820.GD29776@artemis.corp>
References: <ef38762f0909091427m5b8f3am72c88fd4dbfebc59@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0IvGJv3f9h+YhkrH"
Cc: git@vger.kernel.org
To: Brendan Miller <catphive@catphive.net>
X-From: git-owner@vger.kernel.org Thu Sep 10 00:58:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlW7Q-0004Cq-FH
	for gcvg-git-2@lo.gmane.org; Thu, 10 Sep 2009 00:58:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752823AbZIIW6U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Sep 2009 18:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752718AbZIIW6U
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Sep 2009 18:58:20 -0400
Received: from pan.madism.org ([88.191.52.104]:41923 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752652AbZIIW6T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Sep 2009 18:58:19 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 4CD0544584;
	Thu, 10 Sep 2009 00:58:22 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 1FB7B777046; Thu, 10 Sep 2009 00:58:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <ef38762f0909091427m5b8f3am72c88fd4dbfebc59@mail.gmail.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128090>


--0IvGJv3f9h+YhkrH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 09, 2009 at 02:27:56PM -0700, Brendan Miller wrote:
> 5. Most commands require lots of flags, and don't have reasonable
> defaults. e.g. archive.
>=20
> git archive --format=3Dtar --prefix=3Dmyproject/ HEAD | gzip >myproject.t=
ar.gz
>=20
> Should just be:
> git archive
> run from the root of the repo.

You can't, because "myproject" cannot be guessed most of the time.

If you really want to automatize it, it's a 2 liner shell script, or
alternatively you can add that to your .gitconfig:

[alias]
    archive-gz=3D!git archive --prefix=3D"$(basename "$(dirname "$(readlink=
 -m "$(git rev-parse --git-dir)")")")"/ HEAD | gzip -c

It will use the name of the directory containing your .git/ directory as a
prefix, and compress it using gzip to stdout.

git archive-gz > myproject.tar.gz will do what you want.

See, that's the point about git having so many flags. You only need to
look the man page _once_ (despite what you pretend): the one time you
need to write your convenient wrapper around git commands that suits
your exact needs.


--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--0IvGJv3f9h+YhkrH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEUEARECAAYFAkqoMwwACgkQvGr7W6Hudhx+cACgldRzSwFLcny4s+Z70druNsR0
E7cAl0IiMNEeT+a02v0rHiABAyPJSVk=
=sHrr
-----END PGP SIGNATURE-----

--0IvGJv3f9h+YhkrH--
