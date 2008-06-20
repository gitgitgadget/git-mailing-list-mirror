From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH 09/11] Introduce filter_independent() in commit.c
Date: Fri, 20 Jun 2008 14:06:43 +0200
Message-ID: <20080620120643.GX29404@genesis.frugalware.org>
References: <45f73cd0355a5375dcd8a123dd0facf5cad99061.1213917600.git.vmiklos@frugalware.org> <f41fbf4630e6341ae89eacad52c465cecc605e42.1213917600.git.vmiklos@frugalware.org> <702cfa09fdf6203e1199415af21de787c4a19ead.1213917600.git.vmiklos@frugalware.org> <adba33a239d99b30fcccedc0638b060daec1016e.1213917600.git.vmiklos@frugalware.org> <6323597c45d409498ce231b063737bb36c52ef9f.1213917600.git.vmiklos@frugalware.org> <172740d7c998269dd0c454a1365a429acdf7cae2.1213917600.git.vmiklos@frugalware.org> <c83288c0995a7b4463b66e2f45d1a14839f0901c.1213917600.git.vmiklos@frugalware.org> <0d95a099ad6e47c60894983ab7bfd94a3aeddce7.1213917600.git.vmiklos@frugalware.org> <7vabhgq02p.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0806201350000.32725@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iqZLEkZLVO61ftFM"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 20 14:07:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9fP6-0006Bl-5o
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 14:07:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752655AbYFTMGs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 08:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752651AbYFTMGs
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 08:06:48 -0400
Received: from virgo.iok.hu ([193.202.89.103]:39845 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752638AbYFTMGr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 08:06:47 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 3B5481B2510;
	Fri, 20 Jun 2008 14:06:46 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id B11D244668;
	Fri, 20 Jun 2008 13:44:07 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id D05A11190AD9; Fri, 20 Jun 2008 14:06:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0806201350000.32725@wbgn129.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85626>


--iqZLEkZLVO61ftFM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 20, 2008 at 01:53:06PM +0200, Johannes Schindelin <Johannes.Sch=
indelin@gmx.de> wrote:
> > More worryingly, the flag is supposed to be cleaned from the objects=20
> > after get_merge_bases() returns.  I am not sure what you'll learn by=20
> > looking at the flag here.
>=20
> That is a valid point, methinks.  Probably the octopus_merge_base and the=
=20
> cleanup have to be decoupled here.  The cleanup should be nothing more=20
> than calling clear_commit_marks() for every head.

Actually get_octopus_merge_bases() _needs_ to clean up the flags as it
calls get_merge_bases() multiple times and get_merge_bases() expects
empty flags.

> A test case would be desirable, but probably pretty complicated.  Hmm.  I=
=20
> like tests when they are simple, because they are easy to verify by a=20
> human.  Miklos, any chance for such a test case?

Sure, I'll write one.

--iqZLEkZLVO61ftFM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhbnVMACgkQe81tAgORUJY3BwCfZ6hL3SUWISFxLVvzYAxYRgG8
xrIAoJQnOSm/AdJpe/EYxMUQSmn/oWfy
=+L3T
-----END PGP SIGNATURE-----

--iqZLEkZLVO61ftFM--
