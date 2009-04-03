From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] NO_PERL support
Date: Fri, 3 Apr 2009 17:11:49 +0200
Message-ID: <20090403151149.GJ22446@genesis.frugalware.org>
References: <20090403T065545Z@curie.orbis-terrarum.net> <20090403132029.GC21153@coredump.intra.peff.net> <alpine.DEB.1.00.0904031649400.10279@pacific.mpi-cbg.de> <20090403145329.GA25967@coredump.intra.peff.net> <alpine.DEB.1.00.0904031701430.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z3ND3gJe4e1E4uwh"
Cc: Jeff King <peff@peff.net>, "Robin H. Johnson" <robbat2@gentoo.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Apr 03 17:13:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lpl57-0008Er-20
	for gcvg-git-2@gmane.org; Fri, 03 Apr 2009 17:13:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764713AbZDCPLy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2009 11:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759803AbZDCPLy
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Apr 2009 11:11:54 -0400
Received: from virgo.iok.hu ([212.40.97.103]:38467 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753655AbZDCPLx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2009 11:11:53 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id E34F35809E;
	Fri,  3 Apr 2009 17:11:49 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 4AF04447E3;
	Fri,  3 Apr 2009 17:11:49 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 57B9311F0829; Fri,  3 Apr 2009 17:11:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0904031701430.10279@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115536>


--z3ND3gJe4e1E4uwh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 03, 2009 at 05:02:16PM +0200, Johannes Schindelin <Johannes.Sch=
indelin@gmx.de> wrote:
> 1) as it is all too easy, but not 2) as that would require too much work,=
=20
> which would be overkill.

What about something trivial like this?

diff --git a/builtin-add.c b/builtin-add.c
index cb67d2c..a3d798e 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -164,6 +164,10 @@ int interactive_add(int argc, const char **argv, const=
 char *prefix)
 	const char **args;
 	const char **pathspec =3D NULL;
=20
+#ifdef NO_PERL
+	return error("git was compiled without perl support.");
+#endif
+
 	if (argc) {
 		pathspec =3D validate_pathspec(argc, argv, prefix);
 		if (!pathspec)

This way it would be more explicit that it was disabled and the
situation is not about -i was removed in some new versions or anything.

--z3ND3gJe4e1E4uwh
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAknWJzUACgkQe81tAgORUJZoewCdHXvAwxRnf6IsvJXGFgPyRHwE
vA4Anijs43TLnNCjPgB9hFv7r14FAvv7
=/m8D
-----END PGP SIGNATURE-----

--z3ND3gJe4e1E4uwh--
