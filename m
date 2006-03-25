From: Keith Packard <keithp@keithp.com>
Subject: Re: Fix branch ancestry calculation
Date: Fri, 24 Mar 2006 23:54:16 -0800
Message-ID: <1143273256.6850.86.camel@neko.keithp.com>
References: <Pine.LNX.4.64.0603221723230.9196@g5.osdl.org>
	 <44240619.20103@dm.cobite.com>
	 <Pine.LNX.4.64.0603240739360.26286@g5.osdl.org>
	 <1143218338.6850.68.camel@neko.keithp.com>
	 <20060325014532.GB32522@pe.Belkin>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-/P/NyuIFzL/4YgbGdBUk"
Cc: keithp@keithp.com, Linus Torvalds <torvalds@osdl.org>,
	David Mansfield <centos@dm.cobite.com>,
	David Mansfield <cvsps@dm.cobite.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 25 08:54:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FN3bl-0000K6-DV
	for gcvg-git@gmane.org; Sat, 25 Mar 2006 08:54:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbWCYHyq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Mar 2006 02:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbWCYHyq
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Mar 2006 02:54:46 -0500
Received: from home.keithp.com ([63.227.221.253]:16391 "EHLO keithp.com")
	by vger.kernel.org with ESMTP id S1750967AbWCYHyp (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Mar 2006 02:54:45 -0500
Received: from localhost (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id BB4B1130020;
	Fri, 24 Mar 2006 23:54:43 -0800 (PST)
Received: from keithp.com ([127.0.0.1])
	by localhost (keithp.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 26756-03; Fri, 24 Mar 2006 23:54:43 -0800 (PST)
Received: by keithp.com (Postfix, from userid 1033)
	id E56C413001F; Fri, 24 Mar 2006 23:54:42 -0800 (PST)
Received: from neko.keithp.com (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 681C114001;
	Fri, 24 Mar 2006 23:54:42 -0800 (PST)
Received: by neko.keithp.com (Postfix, from userid 1488)
	id 8B4536AC1E0; Fri, 24 Mar 2006 23:54:17 -0800 (PST)
To: Chris Shoemaker <c.shoemaker@cox.net>
In-Reply-To: <20060325014532.GB32522@pe.Belkin>
X-Mailer: Evolution 2.4.2.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17962>


--=-/P/NyuIFzL/4YgbGdBUk
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-03-24 at 20:45 -0500, Chris Shoemaker wrote:

> If that last sentence was a typo then you already know this, but
> otherwise you may be disappointed to learn that it's not _always_
> possible to discern the correct ancestry tree.

Sure, it's possible to generate trees which can't be figured out. So
far, I haven't found any which can't be pieced back together, except in
cases where the tree was accidentally damaged (child branches created on
two separate parent branches)

> If you end up comparing the ancestry tree discovered by your tool and
> the tree output by a patched cvsps, I would be very interested in the
> results.

So far, I've found several concrete trees where cvsps (in any form)
assigns branch points many versions too early compared to the 'true'
history. My tool is getting better answers, but still can't compute the
tree for the X.org X server tree yet. That one has a wide variety of
damage, including the direct copying of ,v files between repositories
which had divered, and the accidental branching of files from different
parent branches. I keep poking at it...

> -chris
>=20
> (*) You can distinguish between A->B->head and B->A->head simply by
> date.

I'm doing a lot more date-based identification than I'm really
comfortable with; the bad thing here is that branch points can occur
long before any commits to that branch, when doing date-based
operations, you have a range of possible matching branch points and it's
hard to disambiguate.

--=20
keith.packard@intel.com

--=-/P/NyuIFzL/4YgbGdBUk
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEJPcoQp8BWwlsTdMRAie7AKDMJMAKeW9aXWknPLN5yNNBkkNxyACaAn50
hUjUh5rroLwHa6sx0abb/UM=
=kvsW
-----END PGP SIGNATURE-----

--=-/P/NyuIFzL/4YgbGdBUk--
