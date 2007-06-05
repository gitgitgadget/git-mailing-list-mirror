From: Jan Hudec <bulb@ucw.cz>
Subject: Re: How to remove invalid remote repository
Date: Tue, 5 Jun 2007 22:14:57 +0200
Message-ID: <20070605201457.GB3240@efreet.light.src>
References: <8A00BB77B01133479F4A56D932A1132202906FD8@EX-401.mail.navisite.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qcHopEYAB45HaUaB"
Cc: git@vger.kernel.org
To: Matt Seitz <seitz@neopathnetworks.com>
X-From: git-owner@vger.kernel.org Tue Jun 05 22:15:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvfQq-0005lg-0N
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 22:15:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764122AbXFEUPB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 16:15:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764166AbXFEUPB
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 16:15:01 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:40083 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764122AbXFEUPA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2007 16:15:00 -0400
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id C417B57508;
	Tue,  5 Jun 2007 22:14:58 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1HvfQf-0001Al-T2; Tue, 05 Jun 2007 22:14:57 +0200
Content-Disposition: inline
In-Reply-To: <8A00BB77B01133479F4A56D932A1132202906FD8@EX-401.mail.navisite.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49224>


--qcHopEYAB45HaUaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 05, 2007 at 14:41:04 -0500, Matt Seitz wrote:
> I mistakenly entered the wrong directory name for "git remote add" (I
> entered the working tree directory name instead of the ".git" directory
> name).=20

There does not seem to be any 'git remote remove'. So you'll do it by
changing the config. Either with git-config, or by editing .git/config (it
*IS* meant to be hand-edited).

> [...]
> So, how can I remove the incorrect remote repository reference and
> replace it with a correct one?
>=20
> [root@demo5 etc]# git config -l
> [...]
> remote.root-etc.url=3D/root/git/etc
                      ^^^^^^^^^^^^^
This is the URL. You can simply fix it either with=20
    git-config remote.root-etc.url /root/git/etc/.git
or by editing
=2Egit/config

> remote.root-etc.fetch=3D+refs/heads/*:refs/remotes/root-etc/*

The section corresponding to these two entries in .git/config looks like:

[remote "root-etc"]
url =3D /root/git/etc
fetch =3D +refs/heads/*:refs/remotes/root-etc/*

You can tweak it to your heart's content. The documentation is in man pages
of git-config and git-fetch.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--qcHopEYAB45HaUaB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGZcRBRel1vVwhjGURAiR/AKDmBcCIxk0VKon25Ni3RTWRVvnocACfYSyM
tvBvmb3tjYVI37qrpFJGWL4=
=01Xa
-----END PGP SIGNATURE-----

--qcHopEYAB45HaUaB--
