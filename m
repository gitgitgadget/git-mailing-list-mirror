From: Jan Hudec <bulb@ucw.cz>
Subject: Re: GIT push to sftp (feature request)
Date: Tue, 7 Aug 2007 23:50:34 +0200
Message-ID: <20070807215034.GB3804@efreet.light.src>
References: <200708051105.44376.pavlix@pavlix.net> <46a038f90708051412p722aa906v73e986a805f1558b@mail.gmail.com> <vpqir7t8vy0.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
To: Martin Langhoff <martin.langhoff@gmail.com>,
	pavlix <pavlix@pavlix.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 07 23:52:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIWys-0007TX-91
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 23:52:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965611AbXHGVup (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Aug 2007 17:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936054AbXHGVuo
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 17:50:44 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:36989 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935795AbXHGVul (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2007 17:50:41 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id D39925733E;
	Tue,  7 Aug 2007 23:50:39 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id wWFX6xgkgcuY; Tue,  7 Aug 2007 23:50:37 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 915D45729C;
	Tue,  7 Aug 2007 23:50:36 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1IIWwk-0003MC-LX; Tue, 07 Aug 2007 23:50:34 +0200
Content-Disposition: inline
In-Reply-To: <vpqir7t8vy0.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55276>


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 06, 2007 at 00:20:55 +0200, Matthieu Moy wrote:
> "Martin Langhoff" <martin.langhoff@gmail.com> writes:
>=20
> > Git tries to be smart in at least 2 ways that don't work with dump
> > protocols: it works locklessly (yet it performs atomic updates) and it
> > sends only the objects needed over the wire (saving a lot of
> > bandwidth).
> >
> > Using dumb protocols it's impossible to do either.
>=20
> That's not exactly true. You can't be as efficient with dumb protocols
> than you are with a dedicated protocol (something with some
> intelligence on both sides), but at least the second point you mention
> can be achieved with a dumb protocol, and bzr is a proof of existance.
> To read over HTTP, it uses ranges request, and to push over
> ftp/sftp/webdav, it appends new data to existing files (its ancestor,
> GNU Arch, also had a way to be network-efficient on dumb protocols).

I believe bzr locks are not completely safe in a sense that breaking a lock
does not cause the operation to immediately abort. GNU Arch ones did, but
it's specific data layout was part of a reason why it worked (it wrote the
data to a directory, so removing that would abort the operation).

> Regarding atomic and lock-less updates, I believe this is
> implementable too as soon as you have an atomit "rename" in the
> protocol. But here, bzr isn't a proof of existance, it does locking.

Actually rename or link is necessary for atomic updates, lockless or lockfu=
l.

Slight problem with it is, that unix (and similar) systems allow overwriting
another file on rename (and do so atomically in a sense the destination
always exists), while windooze fail if the target exists. Most network
protocols don't specify overwriting and simply do whatever the underlying
system does. GNU Arch solved this by renaming directories, which are not
overwriten under any system.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGuOkqRel1vVwhjGURAkXgAKDleM5qiE3MF+535nWbimjB1cGbFQCfULF2
KlX3NE8tgkpQj60wcJd55Ds=
=ko9i
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
