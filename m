From: Jan Hudec <bulb@ucw.cz>
Subject: Re: QGit: Shrink used memory with custom git log format
Date: Tue, 27 Nov 2007 20:19:15 +0100
Message-ID: <20071127191915.GB9174@efreet.light.src>
References: <e5bfff550711240014n78f24b46qf012957d92b1a8e1@mail.gmail.com> <20071127015248.GK14735@spearce.org> <Pine.LNX.4.64.0711271045430.27959@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bCsyhTFzCvuiizWE"
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Marco Costalba <mcostalba@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Nov 27 20:19:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ix5yD-00071u-K6
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 20:19:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757510AbXK0TTZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 14:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756894AbXK0TTZ
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 14:19:25 -0500
Received: from ns1.bluetone.cz ([212.158.128.13]:43057 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756574AbXK0TTY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 14:19:24 -0500
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id BD7FB575D3;
	Tue, 27 Nov 2007 20:19:22 +0100 (CET)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id rH1sL9L24UUx; Tue, 27 Nov 2007 20:19:18 +0100 (CET)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 45A985757C;
	Tue, 27 Nov 2007 20:19:17 +0100 (CET)
Received: from bulb by efreet.light.src with local (Exim 4.68)
	(envelope-from <bulb@ucw.cz>)
	id 1Ix5xj-0002Pg-F0; Tue, 27 Nov 2007 20:19:15 +0100
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711271045430.27959@racer.site>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66253>


--bCsyhTFzCvuiizWE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 27, 2007 at 10:48:00 +0000, Johannes Schindelin wrote:
> On Mon, 26 Nov 2007, Shawn O. Pearce wrote:
> > [...]
> > Otherwise I think what you really want here is a libgit that you can
> > link into your process and that can efficiently inflate an object
> > on demand for you.  Like the work Luiz was working on this past
> > summer for GSOC.  Lots of downsides to that current tree though...
> > like die() kills the GUI...
>=20
> But then, die() calls die_routine, which you can override.  And C++ has=
=20
> this funny exception mechanism which just begs to be used here.  The only=
=20
> thing you need to add is a way to flush all singletons like the object=20
> array.

Unfortunately, exceptions won't really work. Why? Because to use exceptions,
you need to have an exception-safe code. That is the code needs to free any
allocated resources when it's aborted by exception. And git code is not
exceptions safe. Given the lack of destructors in C, it means registering a=
ll
resource allocation in some kind of pool, so they can be freed en masse in
case of failure. Than you can also use longjmp for die (for C they really
behave the same).

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--bCsyhTFzCvuiizWE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHTG2zRel1vVwhjGURAts2AKC6MQrydVMgP1mI8SJs6D9lpMKw8wCfTAjh
h1AFxPpjdfFm1CKo5u6bQj8=
=ueRM
-----END PGP SIGNATURE-----

--bCsyhTFzCvuiizWE--
