From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] Documentation: Clarify which paths git-clean will affect
Date: Tue, 5 May 2009 14:26:14 +0200
Message-ID: <200905051426.18814.trast@student.ethz.ch>
References: <20090505091302.GB27900@frsk.net> <200905051155.28985.trast@student.ethz.ch> <20090505100506.GF27900@frsk.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2444048.DyZQzmiR5q";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
To: Fredrik Skolmli <fredrik@frsk.net>
X-From: git-owner@vger.kernel.org Tue May 05 14:27:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1Jjx-0007l5-CX
	for gcvg-git-2@gmane.org; Tue, 05 May 2009 14:27:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753531AbZEEM1J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2009 08:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753069AbZEEM1I
	(ORCPT <rfc822;git-outgoing>); Tue, 5 May 2009 08:27:08 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:17414 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752015AbZEEM1G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2009 08:27:06 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 5 May 2009 14:27:04 +0200
Received: from thomas.localnet ([129.132.153.233]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 5 May 2009 14:27:03 +0200
User-Agent: KMail/1.11.2 (Linux/2.6.27.21-0.1-default; KDE/4.2.2; x86_64; ; )
In-Reply-To: <20090505100506.GF27900@frsk.net>
X-OriginalArrivalTime: 05 May 2009 12:27:03.0849 (UTC) FILETIME=[CBF8D190:01C9CD7C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118292>

--nextPart2444048.DyZQzmiR5q
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

=46redrik Skolmli wrote:
> On Tue, May 05, 2009 at 11:55:17AM +0200, Thomas Rast wrote:
> > That makes it sound as if the <path> case was not recursive, but it
> > is!
>=20
> Auch, good point. Any suggestions on how to formulate it?

I'm not entirely happy with it, but if we're going to change it, I'd
put the "recursive" near the top to make it more visible.  Maybe like
so:

=2D- 8< --
diff --git i/Documentation/git-clean.txt w/Documentation/git-clean.txt
index 43b2de7..3550fc0 100644
=2D-- i/Documentation/git-clean.txt
+++ w/Documentation/git-clean.txt
@@ -13,15 +13,15 @@ SYNOPSIS
 DESCRIPTION
 -----------
=20
=2DThis allows cleaning the working tree by removing files that are not
+Cleans the working tree by recursively removing files that are not
 under version control.
=20
 Normally, only files unknown to git are removed, but if the '-x'
 option is specified, ignored files are also removed. This can, for
 example, be useful to remove all build products.
=20
=2DIf any optional `<path>...` arguments are given, only those paths
=2Dare affected.
+If any optional `<path>...` arguments are given, those paths are
+affected.  Otherwise, the cleaning starts at the current directory.
=20
 OPTIONS
 -------
=2D- >8 --

As a side note, a random survey among a few other manpages did not
give any conclusive advice on the formulation of the first sentence.
I originally wanted to make it imperative ("clean the working
tree..."), but my perception may be skewed by the commit message
guidelines.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart2444048.DyZQzmiR5q
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkoAMGoACgkQqUud07tmzP0nMwCfQN/qpG5uJXfW+BRY3CzNLcCm
nz0AnRHgEW468r+d60xIDBCsGqt+2aP3
=2lzo
-----END PGP SIGNATURE-----

--nextPart2444048.DyZQzmiR5q--
