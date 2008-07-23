From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: regression in  92392b4
Date: Wed, 23 Jul 2008 13:50:26 +0200
Message-ID: <20080723115026.GH15243@artemis.madism.org>
References: <20080722231745.GD11831@artemis.madism.org> <20080723101415.GA23769@atjola.homenet> <alpine.DEB.1.00.0807231246560.2830@eeepc-johanness> <20080723111931.GF15243@artemis.madism.org> <alpine.DEB.1.00.0807231235150.8986@racer>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="dCSxeJc5W8HZXZrD";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: =?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>,
	spearce@spearce.org, Git ML <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 23 13:51:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLcsT-0000EB-AA
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 13:51:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405AbYGWLu3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 07:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751394AbYGWLu3
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 07:50:29 -0400
Received: from pan.madism.org ([88.191.52.104]:58284 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751390AbYGWLu2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 07:50:28 -0400
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 970B43A5EE;
	Wed, 23 Jul 2008 13:50:27 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id B7C79142484; Wed, 23 Jul 2008 13:50:26 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>,
	spearce@spearce.org, Git ML <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807231235150.8986@racer>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89636>


--dCSxeJc5W8HZXZrD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2008 at 11:37:00AM +0000, Johannes Schindelin wrote:
> Hi,
>=20
> On Wed, 23 Jul 2008, Pierre Habouzit wrote:
>=20
> > On Wed, Jul 23, 2008 at 10:49:04AM +0000, Johannes Schindelin wrote:
> >=20
> > > On Wed, 23 Jul 2008, Bj=C3=B6rn Steinbrink wrote:
> > > Funny.  That does not reproduce the bug here at all.
> > >=20
> > > But then, it is unsurprising, since both Pierre and me did something=
=20
> > > similar yesterday, fetching _just_ the pre-fetch refs into a freshly=
=20
> > > initted Git repository, and then fetching from kernel.org.
> > >=20
> > > Tested on x86_64.
> >=20
> > I can reproduce on x86_64 here.
>=20
> Well, I cannot.  However, I get some pread issue on i686.  To be nice to=
=20
> kernel.org, I downloaded the pack in question:
>=20
> 	http://pacific.mpi-cbg.de/git/thin-pack.pack
>=20
> You should be able to reproduce the behavior by piping this into
>=20
> git-index-pack --stdin -v --fix-thin --keep=3Dfetch-pack --pack_header=3D=
2,263

  I can reproduce. Funily enough, I just happened to see that I have
core.deltabasecachelimit =3D 0 in my git.git repository... which I
probably used meaning -1 but oh well. The bottom line is that the
pruning algorithm likely removes a pointer we still have a pointer to
somewhere...


--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--dCSxeJc5W8HZXZrD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkiHGwIACgkQvGr7W6Hudhw0CQCeMpIygbNspn+dIh7b/0hIj3hb
/cwAoIJI+OeghRewiyvt2hKKIRJ/8mG6
=q9I4
-----END PGP SIGNATURE-----

--dCSxeJc5W8HZXZrD--
