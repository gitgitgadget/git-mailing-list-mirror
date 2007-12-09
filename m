From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: git-svn branch naming question
Date: Sun, 9 Dec 2007 03:05:10 +0100
Message-ID: <20071209020510.GM3199@genesis.frugalware.org>
References: <20071208010438.GE3199@genesis.frugalware.org> <20071208105901.GA2844@xp.machine.xx> <20071208141449.GH3199@genesis.frugalware.org> <20071208165657.GC2844@xp.machine.xx> <20071208235248.GK3199@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bFUYW7mPOLJ+Jd2A"
Cc: git@vger.kernel.org
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Sun Dec 09 03:05:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1BY8-00013C-3D
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 03:05:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752849AbXLICFO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2007 21:05:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752743AbXLICFO
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 21:05:14 -0500
Received: from virgo.iok.hu ([193.202.89.103]:39510 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752733AbXLICFN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Dec 2007 21:05:13 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id CFCCF1B2511;
	Sun,  9 Dec 2007 03:05:11 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 0A13A4465C;
	Sun,  9 Dec 2007 03:04:05 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 3B23911904C1; Sun,  9 Dec 2007 03:05:11 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20071208235248.GK3199@genesis.frugalware.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67583>


--bFUYW7mPOLJ+Jd2A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 09, 2007 at 12:52:48AM +0100, Miklos Vajna <vmiklos@frugalware.=
org> wrote:
> >   [svn-remote "svn"]
> >         url =3D https://url/to/your/svn/repo
> >         fetch =3D trunk:refs/heads/trunk
> >         branches =3D branches/*:refs/heads/*
> >         tags =3D tags/*:refs/heads/tags/*
> >=20
> > but I advice you to not do this. refs/remotes has a special meaning in =
git,
> > e.g.  you can't commit directly to it (which makes sense, because it on=
ly
> > tracks the state of the remote repo. On the other hand remote branches =
won't
> > get cloned per default.)
>=20
> yes, that's exactly what i want to do - in case the target is to convert
> an svn repo to a git one (and i need git-svn since git-svnimport is to
> be removed in 1.5.4)

hm, this seem to be not-working for me.

after "git svn init -s url" i edited the config:

$ cat .git/config
[core]
        repositoryformatversion =3D 0
        filemode =3D true
        bare =3D false
        logallrefupdates =3D true
[svn-remote "svn"]
        url =3D svn+ssh://vmiklos@svn.gnome.org/svn/ooo-build
        fetch =3D trunk:refs/master
        branches =3D branches/*:refs/*
        tags =3D tags/*:refs/tags/*

and wanted to fetch the revisions, but actually

$ git svn fetch

does not fetch any revisions. (yes, it does once i put back the
"remotes" prefix). is this a bug? :)

thanks,
- VMiklos

--bFUYW7mPOLJ+Jd2A
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHW01We81tAgORUJYRAszQAKClVF1nXom3g8+Y4twsLw81k7zR7gCfeVRa
qUbhOWlW7Ga5VvE05juG8fY=
=WX2T
-----END PGP SIGNATURE-----

--bFUYW7mPOLJ+Jd2A--
