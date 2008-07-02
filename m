From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] git-add--interactive: manual hunk editing mode
Date: Wed, 2 Jul 2008 11:03:53 +0200
Message-ID: <200807021103.56570.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1544981.XSOfx7FFkv";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 02 11:04:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDyGY-0003kk-An
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 11:04:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752118AbYGBJDn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 05:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752688AbYGBJDn
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 05:03:43 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:46773 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751543AbYGBJDl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 05:03:41 -0400
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 2 Jul 2008 11:03:39 +0200
Received: from cx-public-docking-1-071.ethz.ch ([129.132.149.71]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 2 Jul 2008 11:03:39 +0200
X-OriginalArrivalTime: 02 Jul 2008 09:03:39.0266 (UTC) FILETIME=[84A7FE20:01C8DC22]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87119>

--nextPart1544981.XSOfx7FFkv
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

[Wrong button at first, sorry for the double mail Junio]

Junio C Hamano wrote:
>=20
> If you change '-' to ' ', or remove '+', then you are temporarily
> reverting the change you have made since HEAD to your working tree copy.
> If you do not change anything, you are taking something that was in your
> working tree copy.  Both are simpler and easier to explain operations.
[...]
> Once you start to [support truly free editing of the hunk],
> you would need to worry about the case where
> the hunk extended to include later lines overlaps with the hunk after the
> one we are currently looking at, and run coalesce_overlapping_hunks to
> concatenate them into a larger single hunk.  But to be able to do that,
> you would need to keep track of the number of lines in a hunk yourself
> anyway, which would mean that you cannot rely on --recount anymore.  The
> extension recently made to "git apply" becomes redundant and unused code.
>=20
> In short, declaring that you are supporting the use to change ' ' to '-'
> means you are opening a whole can of worms, and I asked the question
> because I did not know if you are really prepared to deal with it.

This issue is why I feed the entire patch (not just the edited hunk)
to git-apply --check.  That's really the only promise this feature
makes: if you hand it a patch that does not apply, it will refuse.  If
you do hand it a hunk where you manually inserted some extra context,
then added some extra changes that weren't in the original hunk, well,
tough.  (You asked for a gun _and_ loaded it _and_ pointed it at your
foot!)

That being said, we could of course add a notice of the form

  # Do not edit in any other ways unless you know what you are doing.

if that constitutes appropriate "trigger safety".

=2D Thomas

=2D-=20
Thomas Rast
trast@student.ethz.ch





--nextPart1544981.XSOfx7FFkv
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkhrRHwACgkQqUud07tmzP3D6ACePDsTfXhlsyifooiAtypzZ4HY
QI4AoJHHlxpmQZQgBLi+mwIvuZoiqkfS
=4oQl
-----END PGP SIGNATURE-----

--nextPart1544981.XSOfx7FFkv--
