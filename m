From: Keith Packard <keithp@keithp.com>
Subject: Re: git-cvsimport doesn't quite work, wrt branches
Date: Tue, 13 Jun 2006 16:30:59 -0700
Message-ID: <1150241459.20536.98.camel@neko.keithp.com>
References: <87irn5ovn6.fsf@rho.meyering.net>
	 <Pine.LNX.4.64.0606131008470.5498@g5.osdl.org>
	 <1150224411.20536.79.camel@neko.keithp.com>
	 <46a038f90606131555m7b1fa744g9770140c87598b7b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-GGkcKWSqAPCNUhpXuat+"
Cc: keithp@keithp.com, Linus Torvalds <torvalds@osdl.org>,
	Jim Meyering <jim@meyering.net>,
	Git Mailing List <git@vger.kernel.org>,
	Matthias Urlichs <smurf@smurf.noris.de>,
	Yann Dirson <ydirson@altern.org>, Pavel Roskin <proski@gnu.org>
X-From: git-owner@vger.kernel.org Wed Jun 14 01:31:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqIM6-0008Hp-Ak
	for gcvg-git@gmane.org; Wed, 14 Jun 2006 01:31:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbWFMXb1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Jun 2006 19:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964797AbWFMXb0
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jun 2006 19:31:26 -0400
Received: from home.keithp.com ([63.227.221.253]:46864 "EHLO keithp.com")
	by vger.kernel.org with ESMTP id S964796AbWFMXbZ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Jun 2006 19:31:25 -0400
Received: from localhost (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 1BF7213001F;
	Tue, 13 Jun 2006 16:31:22 -0700 (PDT)
Received: from keithp.com ([127.0.0.1])
	by localhost (keithp.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 19233-05-2; Tue, 13 Jun 2006 16:31:21 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1033)
	id C5D1413001E; Tue, 13 Jun 2006 16:31:21 -0700 (PDT)
Received: from neko.keithp.com (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 7953214001;
	Tue, 13 Jun 2006 16:31:21 -0700 (PDT)
Received: by neko.keithp.com (Postfix, from userid 1488)
	id 19CE954337; Tue, 13 Jun 2006 16:31:00 -0700 (PDT)
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90606131555m7b1fa744g9770140c87598b7b@mail.gmail.com>
X-Mailer: Evolution 2.6.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21818>


--=-GGkcKWSqAPCNUhpXuat+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-06-14 at 10:55 +1200, Martin Langhoff wrote:

> In terms of history parsing, parsecvs and cvs2svn are similar. I like
> cvs2svn "many passes" approach better, though the Python source is
> really messy. A good thing about cvs2svn is that it is a lot more
> conservative WRT memory use.

I will try to fix parsecvs so it doesn't take so much memory. Of course,
my goal was to import various X.org repositories which have horrible
issues, but aren't all that huge. And, for them, it works just fine.
=20
> So far, I have been relying on parsecvs for initial imports, and for
> cvsps+git-cvsimport for incrementals on top of that initial import.
> But parsecvs falls over with large repos.

I'd like some help figuring out how to do incremental imports with
parsecvs. As parsecvs already constructs the project history from the
present into the past, it should be possible to "notice" when it hits
existing bits in the repository and stop automatically. I think this
will just take saving a bit of state in the git repository to mark where
in CVS the tips of each branch come from.

> The main problem, however, is that it doesn't do incremental imports,
> so this would be a roundabout way of fixing parsecvs's
> memory-bound-ness. We still need cvsps :(

Parsecvs is currently O(nrev * nfile), and I'd like to make it O(nrev)
instead.

--=20
keith.packard@intel.com

--=-GGkcKWSqAPCNUhpXuat+
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBEj0qyQp8BWwlsTdMRAoebAKDba1yGdgQ62TgTZSF7FPlcw+RnUwCeIIEs
nK1m/A4b39kvE4TC2/3WOFo=
=km2s
-----END PGP SIGNATURE-----

--=-GGkcKWSqAPCNUhpXuat+--
