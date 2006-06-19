From: Florian Forster <octo@verplant.org>
Subject: Re: [PATCH] Fix git to be (more) ANSI C99 compliant.
Date: Mon, 19 Jun 2006 23:21:16 +0200
Message-ID: <20060619212116.GL1331@verplant.org>
References: <1150609831500-git-send-email-octo@verplant.org> <Pine.LNX.4.64.0606180946090.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oYAXToTM8kn9Ra/9"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 19 23:21:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsRBR-0006tT-FV
	for gcvg-git@gmane.org; Mon, 19 Jun 2006 23:21:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964892AbWFSVVS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Jun 2006 17:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964895AbWFSVVS
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jun 2006 17:21:18 -0400
Received: from verplant.org ([213.95.21.52]:53950 "EHLO huhu.verplant.org")
	by vger.kernel.org with ESMTP id S964892AbWFSVVR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Jun 2006 17:21:17 -0400
Received: from octo by huhu.verplant.org with local (Exim 4.50)
	id 1FsRBM-0008N7-5f; Mon, 19 Jun 2006 23:21:16 +0200
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606180946090.5498@g5.osdl.org>
X-Pgp-Fingerprint: E7F2 3FEC B693 9F6F 9B77  ACF6 8EF9 1EF5 9152 3C3D
X-Pgp-Public-Key: http://verplant.org/pubkey.txt
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22138>


--oYAXToTM8kn9Ra/9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 18, 2006 at 09:50:37AM -0700, Linus Torvalds wrote:
> > While most of this patch fixes void-pointer arithmetic
>=20
> This one I disagree with. Doing arithmetic on "void *" is _really_ useful=
,=20

Agreed: If you want to walk over the memory pointed to by a void-pointer
you want to do that byte-wise in the great majority of all cases.

> and I think most compilers end up supporting it either to be
> compatible with gcc, or just because it's hard to not do it.

Now this statement I don't agree with. (And by that I don't mean I
assume it to be false.)

I didn't start writing the patch because I like C99 so much. In fact, in
my opinion it introduces some possibilities I'd rather not have in C
because people might actually use them. But by default the Sun cc
complains about void-pointer arithmetic and I feel awkward to force the
compiler to accept broken code.

Maybe Rene Scharfe's method (as used in the patch to git-tar-tree) is a
good way around it? There are no explicit casts involved and standard-
compliant compilers like it, too. The downside is that you have two
variables for the same thing/memory.

Regards,
-octo
--=20
Florian octo Forster
Hacker in training
GnuPG: 0x91523C3D
http://verplant.org/

--oYAXToTM8kn9Ra/9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFElxVLjvke9ZFSPD0RAqcFAJ0X0n3LxdR/leHKgnOnFI9lAGok5ACeJmY0
eG8t7jylp4ERIQtjnpLqxS0=
=x5uj
-----END PGP SIGNATURE-----

--oYAXToTM8kn9Ra/9--
