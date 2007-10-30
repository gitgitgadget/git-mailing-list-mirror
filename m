From: Jan Hudec <bulb@ucw.cz>
Subject: Re: remote#branch
Date: Tue, 30 Oct 2007 20:36:10 +0100
Message-ID: <20071030193610.GA4442@efreet.light.src>
References: <20071029174000.GA4449@efreet.light.src> <alpine.LFD.0.999.0710291112590.30120@woody.linux-foundation.org> <20071029214925.GH21133@thunk.org> <alpine.LFD.0.999.0710291545250.30120@woody.linux-foundation.org> <20071030030104.GK21133@thunk.org> <7vtzo9s221.fsf@gitster.siamese.dyndns.org> <20071030044026.GA9600@thunk.org> <alpine.LFD.0.999.0710292150400.30120@woody.linux-foundation.org> <20071030053732.GA16963@hermes.priv> <alpine.LFD.0.999.0710300738550.30120@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Cc: Tom Prince <tom.prince@ualberta.net>, Theodore Tso <tytso@mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Petr Baudis <pasky@suse.cz>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Oct 30 20:43:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImwzP-0006pw-UG
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 20:43:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757131AbXJ3Tla (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 15:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757045AbXJ3Tl3
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 15:41:29 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:48803 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756922AbXJ3Tl1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 15:41:27 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id CBDB8573A8;
	Tue, 30 Oct 2007 20:41:25 +0100 (CET)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id qnuN0HBgqrYD; Tue, 30 Oct 2007 20:41:22 +0100 (CET)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id E7E1257251;
	Tue, 30 Oct 2007 20:41:21 +0100 (CET)
Received: from bulb by efreet.light.src with local (Exim 4.68)
	(envelope-from <bulb@ucw.cz>)
	id 1Imwsk-0001PZ-9I; Tue, 30 Oct 2007 20:36:10 +0100
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0710300738550.30120@woody.linux-foundation.org>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62742>


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 30, 2007 at 07:59:45 -0700, Linus Torvalds wrote:
> > So, how should git deal with
> >=20
> > git://repo.or.cz/linux-2.6/linux acpi-2.6/ibm-acpi-2.6.git
> > git://repo.or.cz/linux-2.6/linux+acpi-2.6/ibm-acpi-2.6.git
> > git://repo.or.cz/linux-2.6/linux%20acpi-2.6/ibm-acpi-2.6.git
>=20
> The way it has always cared. Git itself does no quoting what-so-ever=20
> (except for the *argument* quoting etc that it needs).
>=20
> Now, the *transport* back-end may end up quoting it, of course, the same=
=20
> way it may end up using some random protocol. The user shouldn't care=20
> about the implementation details!
>=20
> In the case of the git transport, there is no quoting even by the=20
> transport protocol. In the case of http, libcurl would hopefully quote fo=
r=20
> us.

So the three addresses will all be different, right?

> > compared to=20
> >=20
> > http://repo.or.cz/linux-2.6/linux acpi-2.6/ibm-acpi-2.6.git
> > http://repo.or.cz/linux-2.6/linux+acpi-2.6/ibm-acpi-2.6.git
> > http://repo.or.cz/linux-2.6/linux%20acpi-2.6/ibm-acpi-2.6.git
>=20
> No difference, what-so-ever, that I can see. Git doesn't quote it.

Yes. But the server will unquote it. ' ' should not have been there, but it=
's
just passed through if it was. '+' is quoting for ' ' and '%20' is quoting
for ' ' as well. Therefore all these three addresses are the *SAME*.

Now the user expectation will be that when these are the same, the git://
ones above will be as well. But they are not. This is not about following a=
ny
RFC for sake of it, but about being consistent with ourselves.

> Notice how the fact that we use http:// doesn't actually mean that you ca=
n=20
> feed the result to a web browser anyway? It's not like you get a "link"=
=20
> that git follows. You get a name.
>=20
> Yes, you can try to "co-locate" things so that something smart=20
> disambiguates (maybe have an "index.html" file, so a web browser gets a=
=20
> gitweb page, and git gets the raw data). But even then, notice how even=
=20
> web browser will do the quoting for you: try
>=20
> 	firefox "http://www.google.com/search?q=3DHtml spaces"
>=20
> just for fun.

Sure. There is no abiguity in decoding this, so why refuse it.

> [...]
>  - <remote shorthand> ("origin")
>  - <path> ("../git.git")
>  - <host>:<path> ("master.kernel.org:/pub/scm/...")
>  - <protocol>://<host>/<path> ("git://repo.or.cz/...")
>=20
> See? We may not follow RFC's, but we follow "easy to use".

The first three don't look like URL ("URL" always means the thing defined by
RFC 2396, at least to me), so I don't expect any quoting there. But for the
last case http:// (and for that matter, sftp://) do use quoting, so I would
expect the quoting of something that differs only by starting with git:// to
work the same.=20

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHJ4eqRel1vVwhjGURAnhOAKCCplYJfp3Pd5p5qTuQJz4utIWYlwCg6gLd
+SY/elJumr5jOwG/17qvQg4=
=XyWk
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
