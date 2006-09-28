From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH 3/3] diff --stat: sometimes use non-linear scaling.
Date: Thu, 28 Sep 2006 10:17:57 +0200
Message-ID: <20060928081757.GF8056@admingilde.org>
References: <7vfyeejakq.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0609270810470.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JcvBIhDvR6w3jUPA"
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Jan Engelhardt <jengelh@linux01.gwdg.de>,
	Adrian Bunk <bunk@stusta.de>
X-From: git-owner@vger.kernel.org Thu Sep 28 10:18:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSr5n-0000m3-Uq
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 10:18:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751770AbWI1ISA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 04:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751772AbWI1ISA
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 04:18:00 -0400
Received: from agent.admingilde.org ([213.95.21.5]:55194 "EHLO
	mail.admingilde.org") by vger.kernel.org with ESMTP
	id S1751770AbWI1IR7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 04:17:59 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1GSr5h-0000hd-G0; Thu, 28 Sep 2006 10:17:57 +0200
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609270810470.3952@g5.osdl.org>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27995>


--JcvBIhDvR6w3jUPA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Wed, Sep 27, 2006 at 08:12:49AM -0700, Linus Torvalds wrote:
> No _way_ is it correct to show more than three characters if there were=
=20
> three lines of changes.
>=20
> I think "nonlinear" is fine, but this is something that is "superlinear"=
=20
> in small changes, and then sublinear in bigger ones (and then apparently=
=20
> totally wrong for one-line changes).
>=20
> It should at least never be superlinear, I believe.

So if we want to keep the logarithmic scale we can do some maths:

Assume we use a formula ala

	length =3D a log(change + b) + c

with three invariants a, b, and c.

We want to scale linearly at first, but want to reach width at
max_change:

	0 =3D a log(b) + c
	1 =3D a log(b + 1) + c
	width =3D a log(max_change + b) + c

But only I have not succeeded in solving these equations, I always stop
at the last invariant :-(

--=20
Martin Waitz

--JcvBIhDvR6w3jUPA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFG4U1j/Eaxd/oD7IRAoYyAJ469hDkNqDCl1uTi7W5V+j9e67tzQCfYpmq
byEybuch0CWZiiuwuBXa2vE=
=G8Mw
-----END PGP SIGNATURE-----

--JcvBIhDvR6w3jUPA--
