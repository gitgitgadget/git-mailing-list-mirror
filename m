From: Thomas Schwinge <tschwinge@gnu.org>
Subject: Re: [PATCH] Don't rely on unspecified behavior
Date: Sat, 28 Jul 2007 20:25:42 +0200
Message-ID: <20070728182542.GA22651@fencepost.gnu.org>
References: <11856407793933-git-send-email-tschwinge@gnu.org> <11856407791617-git-send-email-tschwinge@gnu.org> <20070728173948.GD23337@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Cc: git@vger.kernel.org,
	Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>
To: Thomas Glanzmann <thomas@glanzmann.de>
X-From: git-owner@vger.kernel.org Sat Jul 28 20:23:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEqxC-0001Qo-5n
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 20:23:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbXG1SXq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 14:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbXG1SXq
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 14:23:46 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:36761 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076AbXG1SXp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2007 14:23:45 -0400
Received: from tschwinge by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <tschwinge@gnu.org>)
	id 1IEqz0-0007dj-Kn; Sat, 28 Jul 2007 14:25:42 -0400
Content-Disposition: inline
In-Reply-To: <20070728173948.GD23337@cip.informatik.uni-erlangen.de>
X-Homepage: http://nic-nac-project.de/~schwinge/
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54047>


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

On Sat, Jul 28, 2007 at 07:39:48PM +0200, Thomas Glanzmann wrote:
> > Calling access(p, m) with p =3D=3D NULL is not specified, so don't do
> > that.  On GNU/Hurd systems doing so will result in an SIGSEGV.
>=20
> a friend of mine choked on this one when tried git for the second time
> (the first time "git-repack -a -d -f" screwed his repository after the
> initial checkout. This is fixed for a long time). Lucky me that he had
> his libusbdriver in LD_PRELOAD which could not handle the NULL argument.
> And I always thought libc would make the check before it does the system
> call or does GNU/hurts not use the gnu libc?

GNU/Hurd systems do (obviously ;-) use the GNU libc.  The glibc
maintainer Roland McGrath explicitly told me that ``access (NULL, m)''
shall not be caught as it is not specified and thus must not be invoked
like this.


I noticed that the patch I sent was prepared for an old version of the
file.  I'll send an updated patch that applies to the current revision.


Regards,
 Thomas

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFGq4omgfzh735dTTURAo8HAKDEsfPoYOyF93ENzDql7hcA+LOYuQCfdXwO
WeNQN298uuK7F+utbK2Vzcg=
=dRi/
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
