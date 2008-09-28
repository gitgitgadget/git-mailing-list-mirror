From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: git-describe doesn't show the most recent tag
Date: Sun, 28 Sep 2008 16:39:49 +0200
Message-ID: <20080928143949.GH5302@artemis.corp>
References: <ce513bcc0809280648s352cda3fj5eb35b6e9cd40af9@mail.gmail.com> <20080928135526.GG5302@artemis.corp> <ce513bcc0809280729p47cc3790nb77b3cae8b805221@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="kHRd/tpU31Zn62xO";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	open-iscsi@googlegroups.com
To: Erez Zilber <erezzi.list@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 28 16:46:04 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjxX9-0001q9-K6
	for gcvg-git-2@gmane.org; Sun, 28 Sep 2008 16:46:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbYI1Ojw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Sep 2008 10:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750886AbYI1Ojw
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Sep 2008 10:39:52 -0400
Received: from pan.madism.org ([88.191.52.104]:36326 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750787AbYI1Ojv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Sep 2008 10:39:51 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id BDBDF3B385;
	Sun, 28 Sep 2008 16:39:50 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 965772AC9C; Sun, 28 Sep 2008 16:39:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <ce513bcc0809280729p47cc3790nb77b3cae8b805221@mail.gmail.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96969>


--kHRd/tpU31Zn62xO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 28, 2008 at 02:29:21PM +0000, Erez Zilber wrote:
> On Sun, Sep 28, 2008 at 4:55 PM, Pierre Habouzit <madcoder@debian.org> wr=
ote:
> > On Sun, Sep 28, 2008 at 01:48:42PM +0000, Erez Zilber wrote:
> >> Why is this happening?
> >
> >       --tags
> >           Instead of using only the annotated tags, use any tag found in
> >           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >           .git/refs/tags.
> >
>=20
> I'm not sure that I understand the difference between tags and annotated =
tags.

  a lightweight tag is just a reference. an annotated tag has a message
associated. Usually tags are meant as local help, whereas annotated tags
are the ones pushed to the repositories and that never change. That's
why many tools ignore non annotated tags by default unless you pass
--tags to them.

> Anyway, if I move to the master branch, I see the following tags:
>=20
> [erez.zilber@erez-lx:/tmp/open-iscsi.git]$ ls .git/refs/tags/
> 2.0-868-rc1  2.0-869  2.0-869.1  2.0-869.2  2.0-869-rc2  2.0-869-rc3
> 2.0-869-rc4  2.0-870-rc1
> [erez.zilber@erez-lx:/tmp/open-iscsi.git]$ git-tag
> 2.0-868-rc1
> 2.0-869
> 2.0-869-rc2
> 2.0-869-rc3
> 2.0-869-rc4
> 2.0-869.1
> 2.0-869.2
> 2.0-870-rc1
>=20
> However:
> [erez.zilber@erez-lx:/tmp/open-iscsi.git]$ git-describe --tags
> 2.0-868-rc1-81-g31c9d42
>=20
> I was expecting to see 2.0-870-rc1 here.

  That's because master is not at -rc1 exactly, but some commits
afterwards. Please read the git-describe manpage fully, it's _really_
well explained:

       The command finds the most recent tag that is reachable from a commi=
t.
       If the tag points to the commit, then only the tag is shown. Otherwi=
se,
       it suffixes the tag name with the number of additional commits on top
       of the tagged object and the abbreviated object name of the most rec=
ent
       commit.


Which means that your master is 81 commits ahead of the exact 2.0-860-rc1 t=
ag,
at sha1 31c9d42

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--kHRd/tpU31Zn62xO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkjflzUACgkQvGr7W6Hudhy4KQCeLwiCUAUTKB+hWSgHtXFOTSMF
zb4An2WTM7VPzB6MPxtEz32gr+YoNzCz
=FmbV
-----END PGP SIGNATURE-----

--kHRd/tpU31Zn62xO--
