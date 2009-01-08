From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: collapsing commits with rebase
Date: Wed, 7 Jan 2009 20:11:32 -0600
Message-ID: <200901072011.37299.bss@iguanasuicide.net>
References: <93c3eada0901071608r190a723bma502b68c4ab81a08@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2076095.zx93CKkQIn";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: geoffrey.russell@gmail.com
X-From: git-owner@vger.kernel.org Thu Jan 08 03:12:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKkO7-000486-KD
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 03:12:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755327AbZAHCLL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 21:11:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757586AbZAHCLJ
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 21:11:09 -0500
Received: from rei.iguanasuicide.net ([209.20.91.252]:53336 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755866AbZAHCLG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 21:11:06 -0500
Received: from ip72-204-50-125.fv.ks.cox.net ([72.204.50.125] helo=[10.0.0.124])
	by rei.iguanasuicide.net with esmtpsa (TLS-1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LKkMS-0006oh-OS; Thu, 08 Jan 2009 02:11:05 +0000
User-Agent: KMail/1.9.10
In-Reply-To: <93c3eada0901071608r190a723bma502b68c4ab81a08@mail.gmail.com>
X-Eric-Conspiracy: There is no conspiracy.
X-Virus-Scanned: clamav@iguanasuicide.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104872>

--nextPart2076095.zx93CKkQIn
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 2009 January 07 18:08:44 Geoff Russell wrote:
>I have a series of commits:
>
>    A---B---C---D---E---F

Assuming you also have a ref (e.g. Foo) that points to F:
git checkout sha(B)
git merge -s sha(D)
git rebase --onto $(cat .git/HEAD) sha(E) Foo

should do what you want.

After the checkout:
A -> B [HEAD] -> C -> D -> E -> F [Foo]
(detached HEAD)

After the merge:
A -> B -> C -> D -> E -> F [Foo]
     |
     +--> [HEAD]
(detached HEAD)

After the rebase:
A -> B -> E' -> F' [Foo, HEAD]
     |
     +--> C -> D -> E -> F
(C, D, E, and F will be pruned at some point)
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart2076095.zx93CKkQIn
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkllYNkACgkQdNbfk+86fC20gwCeNtR86ksYkOh9BYPpyDVXnO7H
zrMAnjzFUVyMy7CTJANWt8zQJ5bENzH5
=idIi
-----END PGP SIGNATURE-----

--nextPart2076095.zx93CKkQIn--
