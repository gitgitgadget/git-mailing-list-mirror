From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: blame -M vs. log -p|grep -c ^+ weirdness
Date: Tue, 11 Aug 2009 13:56:04 +0200
Message-ID: <200908111356.06558.trast@student.ethz.ch>
References: <200908111216.05131.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2871994.Tk3YXWppXc";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: =?utf-8?q?Bj=C3=B6rn_Steinbrink?= <B.Steinbrink@gmx.de>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 11 14:04:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Maq5m-0004GO-M5
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 14:04:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752005AbZHKL4o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 07:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751922AbZHKL4n
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 07:56:43 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:45921 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751665AbZHKL4k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 07:56:40 -0400
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.1.375.2; Tue, 11 Aug
 2009 13:56:42 +0200
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.1.375.2; Tue, 11 Aug
 2009 13:56:20 +0200
User-Agent: KMail/1.12.0 (Linux/2.6.27.25-0.1-default; KDE/4.3.0; x86_64; ; )
In-Reply-To: <200908111216.05131.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125519>

--nextPart2871994.Tk3YXWppXc
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

Thomas Rast wrote:
>   git://csa.inf.ethz.ch/domjudge-public.git

Turns out this is locked down from the outside as of this writing, so
I mirrored it at

  git://thomasrast.ch/domjudge.git

>   git ls-files | while read f; do git blame -M -- "$f"; done |
[...]
>   git log --no-merges -p upstream/2.2.. | grep '^+' | grep -v -c '^+++'
[...]
> Bj=F6rn Steinbrink suggested on IRC that I use -M5 -C5 -C5 -C5, which
> indeed reduces it to

As Bj=F6rn kindly pointed out once he had access to the repo, the blame
=2DM works for binary files too, while log -p doesn't; and
'bin/sh-static' and 'doc/logos/DOMjudgelogo.pdf' live under other
names in the upstream repository too, so sufficiently many -C blame
them on upstream instead.  So that resolves the mystery.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart2871994.Tk3YXWppXc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkqBXFYACgkQqUud07tmzP0mJwCfUk6646x5GJmWmxNuhoKFqEnG
sLEAnj6EEhewFMDiEQaQyKYfoU151Co+
=940X
-----END PGP SIGNATURE-----

--nextPart2871994.Tk3YXWppXc--
