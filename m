From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 1/2] rebase -i --root: simplify code
Date: Mon, 26 Jan 2009 00:49:22 +0100
Message-ID: <200901260049.25563.trast@student.ethz.ch>
References: <alpine.DEB.1.00.0901260029480.14855@racer> <alpine.DEB.1.00.0901260031460.14855@racer>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart410986817.L8SlWLK2mZ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 26 00:50:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LREkg-000608-KW
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 00:50:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbZAYXtb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 18:49:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750901AbZAYXta
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 18:49:30 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:50598 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750912AbZAYXt3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 18:49:29 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 26 Jan 2009 00:49:27 +0100
Received: from thomas.localnet ([77.56.223.244]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 26 Jan 2009 00:49:26 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.25.20-0.1-default; KDE/4.1.96; x86_64; ; )
In-Reply-To: <alpine.DEB.1.00.0901260031460.14855@racer>
X-OriginalArrivalTime: 25 Jan 2009 23:49:26.0911 (UTC) FILETIME=[8EA148F0:01C97F47]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107141>

--nextPart410986817.L8SlWLK2mZ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Johannes Schindelin wrote:
>=20
> When we rebase with --root, what we are actually picking are the commits
> in $ONTO..$HEAD.  So $ONTO is really our $UPSTREAM.  Spell it out.
[...]
> +			UPSTREAM=3D$ONTO

While I think the simplification is reasonable, it breaks this check:

  get_saved_options () {
  # ...
          test ! -s "$DOTEST"/upstream && REBASE_ROOT=3Dt
  }

So you'll have to change that too.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart410986817.L8SlWLK2mZ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkl8+oUACgkQqUud07tmzP0u8wCcCLpjWDcfVm/C5+w8c5Itz3Qn
M2gAnjvNEveETGyHeXuKTwNY3XCBK5rE
=UgOP
-----END PGP SIGNATURE-----

--nextPart410986817.L8SlWLK2mZ--
