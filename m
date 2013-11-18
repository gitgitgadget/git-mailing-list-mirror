From: Joey Hess <joey@kitenet.net>
Subject: [announce] git-repair
Date: Mon, 18 Nov 2013 14:13:50 -0400
Message-ID: <20131118181350.GA28776@kitenet.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 18 19:20:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ViTRF-0001r4-5U
	for gcvg-git-2@plane.gmane.org; Mon, 18 Nov 2013 19:20:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751557Ab3KRSUm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Nov 2013 13:20:42 -0500
Received: from wren.kitenet.net ([80.68.85.49]:59546 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751297Ab3KRSUk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Nov 2013 13:20:40 -0500
X-Greylist: delayed 407 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Nov 2013 13:20:40 EST
Received: by darkstar.kitenet.net (Postfix, from userid 1000)
	id 1063A305E67; Mon, 18 Nov 2013 13:13:50 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238004>


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I've created git-repair as a small spinoff from git-annex.

http://git-repair.branchable.com/

git-repair is a complement to git fsck, which only finds problems, but
does not try to fix them.

At its simplest, git-repair deletes all corrupt objects and corrupt
packs, makes a fresh clone from a remote[1] and rsyncs the missing
objects back into the repository.

If that is not sufficient to fully recover the repository, it can also
reset branches back to commits before the corruption happened, delete
branches that are no longer available due to the lost data, and remove
any missing files from the index. It will only do this if run with the
--force option, since that rewrites history and throws out missing data.

I would be very sad to have to use git-repair --force on a git
repository holding source code, although it might manage to preserve
commits that I had forgotten to push. It's more likely to be useful in a
git repository being used for non-source-code purposes, where the loss
of some files won't break the build of a program.

[1] It would be more efficient if it could git fetch individual missing
    objects from the remote, but my current understanding is that the
    git protocols do not allow doing that.

--=20
see shy jo

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIVAwUBUopY3ckQ2SIlEuPHAQjRnw/8CfNvaRW5noi2cjdFQRjSSYyMTHzRs3xn
MekkeLvR1IRNdAzx8r7nobAniNK6HJZfAuJBdmMksFOtOtqn4XaemAmvytKSInbO
NqoDODnoaw4E7kraCOU5S2qIhZAD53keCx0L+PzYsCAUYbIHSxdR1NLgcy/VPUB8
ZN17YnmqJkyQMZ95aDe1RbWY0V66eyfjL6nk3n3b0Y55uCTiPhQK/VZvyN8mW3W8
dJbP6aIuQHgPmbbmRHSPURNEzcMBbsDq8D0NOPVcd+/FY4inQht0zjPFM/CkPyLK
b6zrnpXYPwCkCDyzFQRjHfpxvo5abo5bIaf609/9xCH+x6bBz7azTiyDCcn3i7qA
yQpbELlEkHUupNoeIw6dJqUQTzYXznzhC/kFvX67eQLb7az6BtRLp+XqjoNO4nkx
FCsCnlOQp9mzmc2dpgC2mxbTrCEx1eBszU934qv3LnTDTpfnxyqvOe6QiNu+LvYx
N+q7pdBrKv0QXrUxX2BA83VBOQs1HGX92XtTHhwBGuqetX8ab6wgvNbMdYJusCBC
+h9RRTi0nn/Y19dYFue/KNdBIVutYuZ0dF2voyjH0OEVYD9ME80ohSJMRkzIEX7F
z+0OHdi9Ed+uaaTPWP6X730DTHW6XbbnHa6BTsQTJaDMU/2cvfqQ3hhm2IU6NfMf
IhbCXIPaUEU=
=y6vT
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
