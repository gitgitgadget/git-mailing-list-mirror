From: Joey Hess <joey@kitenet.net>
Subject: Re: [PATCH] do not require filters to consume stdin
Date: Mon, 29 Aug 2011 21:20:29 -0400
Message-ID: <20110830012029.GA27516@gnu.kitenet.net>
References: <20110829203107.GA4946@gnu.kitenet.net>
 <7vobz74yoe.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 30 03:20:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyD0U-0002tQ-79
	for gcvg-git-2@lo.gmane.org; Tue, 30 Aug 2011 03:20:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751882Ab1H3BUk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 21:20:40 -0400
Received: from wren.kitenet.net ([80.68.85.49]:45254 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751874Ab1H3BUi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2011 21:20:38 -0400
Received: from gnu.kitenet.net (dialup-4.88.13.110.Dial1.Atlanta1.Level3.net [4.88.13.110])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id 80102118BA7
	for <git@vger.kernel.org>; Mon, 29 Aug 2011 21:20:36 -0400 (EDT)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id 9E1C544BC9; Mon, 29 Aug 2011 21:20:29 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vobz74yoe.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180383>


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Junio C Hamano wrote:
> Isn't this filter already broken if clean request is for a blob contents
> that is different from what is on the filesystem?  The name %f is passed
> to give the filter a _hint_ on what the path is about (so that the filter
> can choose to work differently depending on the extension, for example),
> but the data may or may not come from the filesystem, depending on what is
> calling the filter, no?
>=20
> Most notably, renormalize_buffer() would call convert_to_git() on a buffer
> that is internal, possibly quite different from what is in the working
> tree.

So during a merge.

gitattributes(5) is not very clear about this, it would probably be good
to add a caveat there about what %f is not.

This seems to make it impractical to build the sort of thing described here:
http://lists-archives.org/git/737857-fwd-git-and-large-binaries-a-proposed-=
solution.html

Arguably that thread already reached the same conclusion about using
smudge/clean for handling large files, for other reasons. Since I
already have something that works without smudge/clean, perhaps I should
give up on them.

--=20
see shy jo

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIVAwUBTlw62skQ2SIlEuPHAQiCmQ/+KAPT3/YoSHRFaAYkgl3zOuPo2kRJ2H9V
dIcONl/5KhqOqqm6jsz8BtXO2MESesJkFrM8x4DzZ/6u9Zv3olvCUpd19DhgiZjB
01X1ruUE3afSEEfcmt9Ix+pnsq2xGORcYIiAT636aYsKI2HM+hw1+Z58Ur4fmBnu
G5CXC/RRQCPiYf3d8Iq6fbXAbjBG6EQsG453utbEGSYM9IZxSwO6rkzPiPV5TOYO
Jjnv+getZpC0o6mz+YAiNW0eAq5pve0gVxNOXU1sdql9MU9bGPbbS66GmhndXEwv
o8w85FryahLQzVg6wsxKEKA98dFa7b6VFD7qB/9gzyVObgUjwPaIX1QDo/QmUdhC
IIIr3wSXOux4qIAoXEF4g5gLwRzZsUPBfdru+NJUB+Abf+Mij9kGq5H2FM3h+8VV
EixNlOQH2uIcrJepmEyvQ25N/Ax4Ss1rPaX3YmRObg+mKweasBQdtU1j2+YBHCnn
TNgL2g26I5FFmRESHHTmuat3bfeXrYpBwrOqUqA8Wnl8G1h6YHD1QhPCxeVgsoqv
u3v80I907Y4J3NOpLCCUnimuQQ5ldWq5bZ4GMGZm9ihZMAB1N/IgVAOju5p1gjwV
SYlblC54oUgnBraHeUuNEeDXSDLvTaZsXI9h1A9eUFHdrhJucJ6yM+E8FeqIZmTD
5vBAV1BrkCI=
=UIkj
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
