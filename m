From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: git blame with valgrind massif
Date: Tue, 11 Dec 2007 22:27:43 +0100
Message-ID: <20071211212743.GD29110@artemis.madism.org>
References: <9e4733910712111257h20a4a916gd4747e816e4706ff@mail.gmail.com> <alpine.LFD.0.9999.0712111315060.25032@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="UoPmpPX/dBe4BELn";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Dec 11 22:28:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2Ce7-00069y-1I
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 22:28:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751518AbXLKV1q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 16:27:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751653AbXLKV1p
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 16:27:45 -0500
Received: from pan.madism.org ([88.191.52.104]:53265 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751518AbXLKV1p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 16:27:45 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id EB9172F70B;
	Tue, 11 Dec 2007 22:27:43 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 3F2662B150D; Tue, 11 Dec 2007 22:27:43 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.9999.0712111315060.25032@woody.linux-foundation.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67949>


--UoPmpPX/dBe4BELn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 11, 2007 at 09:22:53PM +0000, Linus Torvalds wrote:
>=20
>=20
> On Tue, 11 Dec 2007, Jon Smirl wrote:
> >=20
> > How do you interpret the massif output?
>=20
> Not very easy, since massif will tell you what *allocated* it, but then=
=20
> trying to see who was supposed to free it is another issue altogether.
>=20
> I also find the textual output to be very confusing. But what massif is=
=20
> really good at is to look at the memory usage over time in the postscript=
=20
> file it generates, and that gives you a much better feel for what=20
> particular allocation is a problem.
>=20
> In this case, it's patch_delta that generates all the memory usage (well,=
=20
> 98% of it ;^), but that's not that helpful unless you know git internals,=
=20

  No 37%, the 98% list is the list of calls that generate 98% of the
total allocations git blame does, and then massif lists each individual
call, and patch_delta generates 37% of the total.

  Though it's meaningless without knowing how much time this memory
stayed allocated>

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--UoPmpPX/dBe4BELn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHXwDPvGr7W6HudhwRAuTxAJ4nrGPMcSCt4fDwCCCkOkVu+BSkEgCggAw2
6biZ+lz8dDM14z4xp0ufxvY=
=eG3B
-----END PGP SIGNATURE-----

--UoPmpPX/dBe4BELn--
