From: Martin Waitz <tali@admingilde.org>
Subject: Re: comparing file contents in is_exact_match?
Date: Thu, 6 Jul 2006 09:16:29 +0200
Message-ID: <20060706071629.GB12512@admingilde.org>
References: <20060706055729.GA12512@admingilde.org> <7vd5cj9rvm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KFztAG8eRSV9hGtP"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 06 09:16:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FyO6E-00075Y-KP
	for gcvg-git@gmane.org; Thu, 06 Jul 2006 09:16:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964870AbWGFHQb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Jul 2006 03:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964971AbWGFHQb
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Jul 2006 03:16:31 -0400
Received: from admingilde.org ([213.95.32.146]:4525 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S964870AbWGFHQa (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Jul 2006 03:16:30 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1FyO69-0000JG-By; Thu, 06 Jul 2006 09:16:29 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vd5cj9rvm.fsf@assigned-by-dhcp.cox.net>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23377>


--KFztAG8eRSV9hGtP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Wed, Jul 05, 2006 at 11:20:13PM -0700, Junio C Hamano wrote:
> Martin Waitz <tali@admingilde.org> writes:
> > Why is the content comparision in is_exact_match needed?
>=20
> Because your working tree can be out of sync with respect to
> what's in the index, in which case we cannot trust the sha1
> while running diff-index (without --cached flag).

so perhaps we need three phases instead of two:
first sort out all renames that can be detected by the sha1,
then compare file contents and finally do the diff.

> git-update-index --refresh before doing anything might help.

At the moment it is doing (N-1)^2 content compares, even if
the index is in sync.

--=20
Martin Waitz

--KFztAG8eRSV9hGtP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFErLjNj/Eaxd/oD7IRAk0xAJ4tGU/N2eVPFcviMTdNGJeuHILpHwCdFXTe
5NuCLHIYN73iW+YhsJE0k4A=
=FEB8
-----END PGP SIGNATURE-----

--KFztAG8eRSV9hGtP--
