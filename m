From: Florian Forster <octo@verplant.org>
Subject: Re: [PATCH] gitweb: Supporting caches (was: Adding a `blame' interface.)
Date: Mon, 12 Jun 2006 19:57:35 +0200
Message-ID: <20060612175735.GA13432@verplant.org>
References: <11500407193506-git-send-email-octo@verplant.org> <46a038f90606111502g607be3cfnf83ce81764a5f909@mail.gmail.com> <20060612082448.GA11857@verplant.org> <Pine.LNX.4.64.0606120754460.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Cc: Martin Langhoff <martin.langhoff@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 12 19:58:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpqfU-0001DI-V0
	for gcvg-git@gmane.org; Mon, 12 Jun 2006 19:57:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbWFLR5i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Jun 2006 13:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750890AbWFLR5i
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jun 2006 13:57:38 -0400
Received: from verplant.org ([213.95.21.52]:3803 "EHLO huhu.verplant.org")
	by vger.kernel.org with ESMTP id S1750773AbWFLR5h (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Jun 2006 13:57:37 -0400
Received: from octo by huhu.verplant.org with local (Exim 4.50)
	id 1FpqfP-0003wJ-CF; Mon, 12 Jun 2006 19:57:35 +0200
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606120754460.5498@g5.osdl.org>
X-Pgp-Fingerprint: E7F2 3FEC B693 9F6F 9B77  ACF6 8EF9 1EF5 9152 3C3D
X-Pgp-Public-Key: http://verplant.org/pubkey.txt
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21719>


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 12, 2006 at 07:59:39AM -0700, Linus Torvalds wrote:
> The apache setup at least on kernel.org is already set up to do
> caching, as long as the generated headers for the page allow it in the
> first place.

I've actually looked into improving native HTTP caching (mostly for
small site without revers proxying) by providing a `Last-Modified'
header where possible and sending a `304 Not Modified' whenever
appropriate.

While it doesn't sound hard it's next to impossible: A commit's
timestamp doesn't change when head a points to it (or does not longer
point to it). Also displaying the timestamps as `Modified xy
{seconds,minutes, hours,...} ago' possess a big problem.

(I guess the webserver could use the `If-Modified-Since' header to check
if the displayed time needs to be updated, but if you ask me it's not
worth the effort.)

In short, the `blob', `blob_plain', and `blobdiff' pages could profit
=66rom that because they don't display the head(s) pointing to the current
commit. On the other hand, this is a little inconsistent and could be
considered a bug. So I'll give up on that unless someone has a great
idea how to handle this.

Regards,
-octo
--=20
Florian octo Forster
Hacker in training
GnuPG: 0x91523C3D
http://verplant.org/

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEjasPjvke9ZFSPD0RAoCiAJoDICeYInTc5W1EPOoBKdUNQSVzGACfVtxP
LUP6hcOleON7pCRvlh0DrTQ=
=5EVw
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
