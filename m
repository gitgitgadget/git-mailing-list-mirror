From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: How can I merge some files rather than all files modified on one branch to my branch?
Date: Mon, 2 Mar 2009 21:10:17 -0600
Message-ID: <200903022110.23207.bss@iguanasuicide.net>
References: <856bfe0e0903020119y68188a39m90c683949220b2f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3034362.vh6YniDAlq";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Emily Ren <lingyan.ren@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 04:12:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeL39-0000Cm-7u
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 04:12:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757467AbZCCDKg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2009 22:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757369AbZCCDKe
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 22:10:34 -0500
Received: from eastrmmtao107.cox.net ([68.230.240.59]:55541 "EHLO
	eastrmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753439AbZCCDKc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2009 22:10:32 -0500
Received: from eastrmimpo03.cox.net ([68.1.16.126])
          by eastrmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090303031024.DSBM23750.eastrmmtao107.cox.net@eastrmimpo03.cox.net>;
          Mon, 2 Mar 2009 22:10:24 -0500
Received: from localhost ([72.204.50.125])
	by eastrmimpo03.cox.net with bizsmtp
	id NTAP1b00T2i4SyG02TAQn1; Mon, 02 Mar 2009 22:10:24 -0500
X-Authority-Analysis: v=1.0 c=1 a=Qrc3XbOd-VgA:10 a=cb-GUKYa6SIA:10
 a=Fq1VQ0LPAAAA:8 a=eScD4ElyJNvA4ntO1S8A:9 a=wC4MiCaL-T7GJBaCBNAA:7
 a=sAwd-dkjdsdaQ24muTCiue0TFXQA:4 a=LY0hPdMaydYA:10 a=T3brmoaXcPoA:10
 a=BpTeDOyiBn_xlawT3-sA:9 a=DQzrOSbUS9-EY4W9JOTTfms52fgA:4 a=rPt6xJ-oxjAA:10
X-CM-Score: 0.00
Received: from bss by localhost with local (Exim 4.69)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LeL1T-00027z-GU; Mon, 02 Mar 2009 21:10:23 -0600
User-Agent: KMail/1.11.0 (Linux/2.6.26-1-amd64; KDE/4.2.0; x86_64; ; )
In-Reply-To: <856bfe0e0903020119y68188a39m90c683949220b2f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111989>

--nextPart3034362.vh6YniDAlq
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 02 March 2009 03:19:05 Emily Ren wrote:
> I want to merge some files rather than all files modified on one
> branch to my branch, how can I do?

In addition to what Junio suggested, I'll offer another method, assuming th=
e=20
branch you are merging from is not yet published:
(1) Rewrite the history of the to-be-merged branch so that all the changes =
to=20
the files you want occur "before" and in separate commits from the file you=
=20
want to ignore.  So the current tree:

A-->B-->C (yours)
 \
  ->D-->E (theirs)

becomes:

A-->B-->C (yours)
 \
  ->D1-->E1-->D2-->E2 (theirs)

with D1 and D2 being the separate parts of commit D and similarly for E1 an=
d=20
E2.

(2) Merge in the rewritten history, but only the part that you want, giving:

A-->B-->C--->F (yours)
 \         /
  ->D1-->E1-->D2-->E2 (theirs)

This preserves the full intent of what you are trying to do, a partial merg=
e. =20
If you merge "theirs" in fully at some point in the future, you shouldn't s=
ee=20
any conflicts arising from not recording the merge or missing changes arisi=
ng=20
from recording a full merge that did not happen.
=2D-=20
Boyd Stephen Smith Jr.                   ,=3D ,-_-. =3D.
bss@iguanasuicide.net                   ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy         `-'(. .)`-'
http://iguanasuicide.net/                    \_/


--nextPart3034362.vh6YniDAlq
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkmsn5oACgkQ55pqL7G1QFnzTwCgh9710ezwUeAuaXu3OLxNMpyT
8lQAnRypGfh+vsolm8K+ElkBaFg+qVgt
=pluz
-----END PGP SIGNATURE-----

--nextPart3034362.vh6YniDAlq--
