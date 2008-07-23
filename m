From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: regression in  92392b4
Date: Wed, 23 Jul 2008 12:22:39 +0200
Message-ID: <20080723102239.GC15243@artemis.madism.org>
References: <20080722231745.GD11831@artemis.madism.org> <20080723101415.GA23769@atjola.homenet>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="f+W+jCU1fRNres8c";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: spearce@spearce.org, Git ML <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 23 12:23:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLbVV-0003Vj-Lw
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 12:23:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbYGWKWm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 06:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751625AbYGWKWm
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 06:22:42 -0400
Received: from pan.madism.org ([88.191.52.104]:39837 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750893AbYGWKWl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 06:22:41 -0400
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 5FADE3A59A;
	Wed, 23 Jul 2008 12:22:40 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 6A132146C9A; Wed, 23 Jul 2008 12:22:39 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	=?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>,
	spearce@spearce.org, Git ML <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <20080723101415.GA23769@atjola.homenet>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89624>


--f+W+jCU1fRNres8c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2008 at 10:14:15AM +0000, Bj=C3=B6rn Steinbrink wrote:
> On 2008.07.23 01:17:45 +0200, Pierre Habouzit wrote:
> >   Hi, here is a manual painful down-secting (opposed to a bisect ;P) I
> > did, since git in next cannot fetch on a regular basis for me. The
> > culprit seems to be commit  92392b4:
> >=20
> >     =E2=94=8C=E2=94=80(1:11)=E2=94=80=E2=94=80<~/dev/scm/git 92392b4...=
>=E2=94=80=E2=94=80
> >     =E2=94=94[artemis] git fetch
> >     remote: Counting objects: 461, done.
> >     remote: Compressing objects: 100% (141/141), done.
> >     remote: Total 263 (delta 227), reused 155 (delta 121)
> >     Receiving objects: 100% (263/263), 95.55 KiB, done.
> >     fatal: Out of memory, malloc failed
> >     fatal: index-pack failed
> >     [2]    16674 abort (core dumped)  git fetch
> >=20
> >     =E2=94=8C=E2=94=80(1:12)=E2=94=80=E2=94=80<~/dev/scm/git 92392b4...=
>=E2=94=80=E2=94=80
> >     =E2=94=94[artemis] git checkout -m HEAD~1; make git-index-pack
> >     Previous HEAD position was 92392b4... index-pack: Honor core.deltaB=
aseCacheLimit when resolving deltas
> >     HEAD is now at 03993e1... index-pack: Track the object_entry that c=
reates each base_data
> >     GIT_VERSION =3D 1.5.6.3.3.g03993
> > 	CC index-pack.o
> > 	LINK git-index-pack
> >=20
> >     =E2=94=8C=E2=94=80(1:12)=E2=94=80=E2=94=80<~/dev/scm/git 03993e1...=
>=E2=94=80=E2=94=80
> >     =E2=94=94[artemis] git fetch
> >     remote: Counting objects: 461, done.
> >     remote: Compressing objects: 100% (141/141), done.
> >     remote: Total 263 (delta 227), reused 155 (delta 121)
> >     Receiving objects: 100% (263/263), 95.55 KiB, done.
> >     Resolving deltas: 100% (227/227), completed with 153 local objects.
> >     From git://git.kernel.org/pub/scm/git/git
> >        5ba2c22..0868a30  html       -> origin/html
> >        2857e17..abeeabe  man        -> origin/man
> >        93310a4..95f8ebb  master     -> origin/master
> >        559998f..e8bf351  next       -> origin/next
> >=20
> > You can see the commit sha's in the prompt. 03993e1 is fine, 92392b4 is
> > broken, I've absolutely no clue about what happens.
> >=20
> > All I can say is that at some point in get_data_from_pack, obj[1].idx
> > points to something that is *not* a sha so it's probably corrupted.
> > (from index-pack.c).
>=20
> Here's how to reproduce:
>=20
> #!/bin/bash
>=20
> [ -d git-bug ] || \
> 	git clone git://git.kernel.org/pub/scm/git/git git-bug
> cd git-bug
>=20
> git update-ref refs/remotes/origin/html 5ba2c22
> git update-ref refs/remotes/origin/man 2857e17
> git update-ref refs/remotes/origin/maint 2d9c572
> git update-ref refs/remotes/origin/master 93310a4
> git update-ref refs/remotes/origin/next 559998f
> git update-ref refs/remotes/origin/pu 010581c8
>=20
> git reset --hard origin/master
>=20
> sleep 1
>=20
> git reflog expire --expire=3D0 --all
>=20
> git repack -A -d -f --depth=3D10 --window=3D10
> git prune
>=20
> git config core.deltaBaseCacheLimit 100
>=20
> git fetch

  *THANKS* I was missing the "git config core.deltaBaseCacheLimit". I
did the same as you but it wasn't failing here. FWIW I don't have
deltaBaseCacheLimit set in my config, but oh well.
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--f+W+jCU1fRNres8c
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkiHBm8ACgkQvGr7W6HudhwyIgCePV1NhLzV1Y8mJykyl4adDuwv
vt4An0204/nPpgTiFQhGNa+l+sr61nU7
=OWK2
-----END PGP SIGNATURE-----

--f+W+jCU1fRNres8c--
