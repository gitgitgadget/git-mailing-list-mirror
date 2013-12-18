From: Joey Hess <joey@kitenet.net>
Subject: Re: RLIMIT_NOFILE fallback
Date: Wed, 18 Dec 2013 16:03:49 -0400
Message-ID: <20131218200349.GA14532@kitenet.net>
References: <20131218171446.GA19657@kitenet.net>
 <xmqqy53ihwe4.fsf@gitster.dls.corp.google.com>
 <20131218191702.GA9083@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 18 21:04:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtNLe-00034s-QB
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 21:04:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961Ab3LRUD7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Dec 2013 15:03:59 -0500
Received: from wren.kitenet.net ([80.68.85.49]:51139 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750872Ab3LRUD6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 15:03:58 -0500
Received: by darkstar.kitenet.net (Postfix, from userid 1000)
	id 500A9305EE8; Wed, 18 Dec 2013 15:03:49 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20131218191702.GA9083@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239477>


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Jeff King wrote:
> I wish we understood why getrlimit was failing. Returning EFAULT seems
> like an odd choice if it is not implemented for the system. On such a
> system, do the other fallbacks actually work? Would it work to do:
>=20
> That is, does sysconf actually work on such a system (or does it need a
> similar run-time fallback)? And either way, we should try falling back
> to OPEN_MAX rather than 1 if we have it.

For what it's worth, the system this happened on was a QNAP TS-219PII
Linux willow 2.6.33.2 #1 Fri Mar 1 04:41:48 CST 2013 armv5tel unknown

I don't have access to it to run tests of sysconf. (I already suggested its
owner upgrade its firmware.)

> As far as the warning, I am not sure I see a point. The user does not
> have any useful recourse, and git should continue to operate as normal.
> Having every single git invocation print "by the way, RLIMIT_NOFILE does
> not work on your system" seems like it would get annoying.

I agree with that.

--=20
see shy jo

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIVAwUBUrH/oskQ2SIlEuPHAQgpCBAApMPfgDv/q7kJa1jEyfljnSKPgTHoa4SQ
TSBxnmJbuweoUBaVyur3lX4zGRHKKJGRoYBbqeq6Zx4G5wJZqFaNEXzzbR+Pfl/m
7d7yIh88WPVGOgrtqsQCq/NyFK2OBGHiVnvmAe+BPJROM8I4Fj6kwu7umn7BENt5
dplGuGgvO3dBEBx9DJcequtw+G8CKfB00OjCZK5tEOdWkkXSPnTzVXPP8ECp3CQ3
sIdTQ+pX4gU4KxyweFdoKSFxdi8Y7AIGUeAoPKkGN9rmapJCd6MZR6LDYcVdeJJD
WGEEA1iTe9kMpcuuGQJlMt9Z3IesWy9GCUuhqxEywXZs/+wNkUjcuAvAnJFqzaCb
S9bb6sJRLSd7fJfu1pK0oIZ9LxUtMLw9m6RZGnhIagd+SlKanciKvueWo0zRaCO1
oRyDLHV/+hs08PWxT2N4l1vQ4xhLcd5mbAD4vVfzmm+TRRYABW8OZnDbn9z0I5GB
FgmuaJcwDki6EIIUBFUI9fyOPcn3Z7chiHk12fx102FAv+TrAAVGwY2D3oRw6aSt
Utrsyp3Um1gfjvhxPbts1jPvxsfCojubwSvWGlXQFy7E4Z7r3EKPzsgPEJEP6BSO
O7deiaaT1pt5D9S0CeOn4j/JEw3VHd9hu4aNH1ryaKnQt0iiHQuA6buu27svLFPK
ysfKZ6iRfD4=
=fbRu
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
