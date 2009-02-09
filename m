From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: Trouble testing out a patch on a branch new scratch git.git repository
Date: Mon, 9 Feb 2009 16:14:26 -0600
Message-ID: <200902091615.24958.bss@iguanasuicide.net>
References: <e38bce640902081256j3cd84aadn2f0cc863cfca904d@mail.gmail.com> <7vmycww6if.fsf@gitster.siamese.dyndns.org> <e38bce640902091359j3f306839h9aeb699e18e420ab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6051766.2MfJj7B8iy";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Brent Goodrick <bgoodr@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 23:22:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWeVh-0000Da-9k
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 23:21:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753621AbZBIWUX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 17:20:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753503AbZBIWUW
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 17:20:22 -0500
Received: from rei.iguanasuicide.net ([209.20.91.252]:57881 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752766AbZBIWUW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 17:20:22 -0500
Received: from [63.167.76.199] (helo=dellbuntu.localnet)
	by rei.iguanasuicide.net with esmtpsa (TLS-1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LWeUE-00080z-Iq; Mon, 09 Feb 2009 22:20:18 +0000
User-Agent: KMail/1.11.0 (Linux/2.6.27.7-9-default; KDE/4.2.0; x86_64; ; )
In-Reply-To: <e38bce640902091359j3f306839h9aeb699e18e420ab@mail.gmail.com>
X-Virus-Scanned: clamav@iguanasuicide.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109146>

--nextPart6051766.2MfJj7B8iy
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 09 February 2009 15:59:40 Brent Goodrick wrote:
> To explain what I mean: Yesterday, I had this configuration on my
> bg/no-progress branch:
>
>              A---B---C---D (bg/no-progress)
>             /
> ----1-----2----3----4 (master)
>
> B C and D commits are noisy,
> fix-the-white-space-and-conform-to-coding-guidelines type commits. I
> want to collapse A through D into one commit called E on that branch
> so that I can run git format-patch -M on the result and provide a nice
> patch email. I would end up with:
>
>              E (bg/no-progress)
>             /
> ----1-----2----3----4 (master)

Here's my way to do that:
git rebase -i $(git merge-base master bg/noprogress) bg/no-progress
# Editor opens
# Change "pick" -> "squash" for commits B, C, and D.
# rebase runs
# Maybe resolve conflicts

If you are willing to have:
             E (bg/no-progress)
            /
=2D-1--2--3--4 (master)

at the end, it's a little bit simpler:
git rebase -i master bg/no-progress
# All the rest the same.
=2D-=20
Boyd Stephen Smith Jr.           	 ,=3D ,-_-. =3D.
bss@iguanasuicide.net            	((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy 	 `-'(. .)`-'
http://iguanasuicide.net/        	     \_/


--nextPart6051766.2MfJj7B8iy
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkmQqvwACgkQdNbfk+86fC1+/QCfUDubC0yxGxzBKwNXJphflGxQ
5UAAn1Yk+qrTLnRQ08Ivl6PPzUVbXMXX
=Wf4o
-----END PGP SIGNATURE-----

--nextPart6051766.2MfJj7B8iy--
