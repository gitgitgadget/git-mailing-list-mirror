From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 0/4] refactor the --color-words to make it more hackable
Date: Sun, 11 Jan 2009 22:53:24 +0100
Message-ID: <200901112253.27165.trast@student.ethz.ch>
References: <alpine.DEB.1.00.0901112057300.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1588885.AKbo47SWmz";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 11 22:54:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LM8GT-0002SZ-Gn
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 22:54:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbZAKVxN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 16:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbZAKVxN
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 16:53:13 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:37015 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751023AbZAKVxM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 16:53:12 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 11 Jan 2009 22:53:11 +0100
Received: from [192.168.0.3] ([77.56.223.244]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 11 Jan 2009 22:53:10 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0901112057300.3586@pacific.mpi-cbg.de>
X-OriginalArrivalTime: 11 Jan 2009 21:53:11.0050 (UTC) FILETIME=[FEE8DEA0:01C97436]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105232>

--nextPart1588885.AKbo47SWmz
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Johannes Schindelin wrote:
>=20
> But at least _I_ think it is easy to follow, and it actually makes the co=
de
> more readable/hackable.  Correct me if I'm wrong.

It indeed seems a sane approach.  However, the final result segfaults
and/or prints garbage (on apparently every commit except very small
changes) when using the regex '\S+', which IMHO should give exactly
the same result as not using a regex at all.  In git.git:

  $ ./git-show --color-words=3D'\S+' 7eb5bbdb645
  Segmentation fault
  $ ./git-show --color-words=3D'\S+' d3240d935c4
  [...garbled output...]
  Segmentation fault

Plain --color-words is not affected.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch



--nextPart1588885.AKbo47SWmz
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklqalcACgkQqUud07tmzP0cQQCbB72OnZyp0n/4Eer+qbhGKWDc
NSsAn1VcHpte/mFqv2rbPxQ23i8S3Duf
=Rdmi
-----END PGP SIGNATURE-----

--nextPart1588885.AKbo47SWmz--
