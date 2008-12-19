From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: [PATCH] Make git revert warn the user when reverting a merge commit.
Date: Thu, 18 Dec 2008 21:24:11 -0600
Message-ID: <200812182124.15568.bss@iguanasuicide.net>
References: <200812182039.15169.bss@iguanasuicide.net> <alpine.DEB.1.00.0812190353520.14632@racer>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart9197984.sF22UE5nm0";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Alan <alan@clueserver.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 19 04:25:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDVzW-0003pM-SZ
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 04:25:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752233AbYLSDYI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 22:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752224AbYLSDYG
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 22:24:06 -0500
Received: from rei.iguanasuicide.net ([209.20.91.252]:53382 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753AbYLSDYF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 22:24:05 -0500
Received: from ip72-204-50-125.fv.ks.cox.net ([72.204.50.125] helo=[10.0.0.123])
	by rei.iguanasuicide.net with esmtpsa (TLS-1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LDVy7-00067v-0X; Fri, 19 Dec 2008 03:24:03 +0000
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0812190353520.14632@racer>
X-Eric-Conspiracy: There is no conspiracy.
X-Virus-Scanned: clamav@iguanasuicide.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103535>

--nextPart9197984.sF22UE5nm0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Blah, my --in-reply-to didn't work so this didn't thread right.

On Thursday 2008 December 18 20:57:57 you wrote:
> On Thu, 18 Dec 2008, Boyd Stephen Smith Jr. wrote:
> > +		do {
> > +			switch (action) {
> > +			case REVERT:
> > +				warning("revert on a merge commit may not do what you expect.");
> > +				continue;
> > +			case CHERRY_PICK:
> > +				/* Cherry picking a merge doesn't merge the history, but
> > +				 * I don't think many people expect that.
> > +				 */
> > +				continue;
> > +			}
> > +			/* Unhandled enum member. */
> > +			die("Unknown action on a merge commit.");
> > +		} while (0);
> > +
>
> Wow.  That must be one of the, uhm, less beautiful ways to write
>
> 		if (action =3D=3D REVERT)
> 			warning("revert on a merge commit may not do what you "
> 				"expect.");
> 		else if (action !=3D CHERRY_PICK)
> 			die("Unknown action on a merge commit.");

My way, a smart compiler will warn at compile time that there's a new enum=
=20
member that needs to be handled.  Your way, no such compile-time warning wi=
ll=20
be emitted.  At runtime, they have the same behavior.  Athestically, I agre=
e=20
with you, but my way may have technical advantages.

I did check the CodingGuidelines and didn't see this construct mentioned.

> Besides, I am actually pretty much against this change.

I've never had a need to revert a merge commit, so it's not a big win eithe=
r=20
way for me.  I wrote the patch because alan@clueserver.org had the revert=20
behavior bite him and Linus suggested a warning might be apropos.
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart9197984.sF22UE5nm0
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklLE98ACgkQdNbfk+86fC1ukgCeNODu4M+bLjaE6K9p8WhGH2Ge
iswAn2MukYXNEYVmYMWtZfjIiyuaF4m3
=8GjW
-----END PGP SIGNATURE-----

--nextPart9197984.sF22UE5nm0--
