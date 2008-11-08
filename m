From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: absurdly slow git-diff
Date: Sat, 08 Nov 2008 01:14:26 +0100
Message-ID: <20081108001426.GA19357@artemis.corp>
References: <20081107200126.GA20284@toroid.org> <alpine.LFD.2.00.0811071335010.3468@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="G4iJoqBmSsgzjUCe";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Abhijit Menon-Sen <ams@toroid.org>,
	Davide Libenzi <davidel@xmailserver.org>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Nov 08 01:17:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KybWF-0005JL-MP
	for gcvg-git-2@gmane.org; Sat, 08 Nov 2008 01:17:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751635AbYKHAOa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 19:14:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752000AbYKHAOa
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 19:14:30 -0500
Received: from pan.madism.org ([88.191.52.104]:58719 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751619AbYKHAO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 19:14:29 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 612FF3C363;
	Sat,  8 Nov 2008 01:14:28 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id C53BB7D511F; Sat,  8 Nov 2008 01:14:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0811071335010.3468@nehalem.linux-foundation.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100367>


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 07, 2008 at 09:37:29PM +0000, Linus Torvalds wrote:
>=20
> On Sat, 8 Nov 2008, Abhijit Menon-Sen wrote:
> >
> > If anyone's interested, the files are http://toroid.org/misc/1 and
> > http://toroid.org/misc/2

> I'm also adding Pierre, since he was talking about trying to implement
> another diff algorithm (although I'm not at all sure that the patience=20
> diff really would help this case at all).

FWIW Patience diff wouldn't help at all here. Patience diff is just a
matter of preseeding your preferred diff algorithm with better (wrt
human readability) candidate for the invariant lines. IOW it helps
dividing the problem into smaller bits, but requires *unique lines* to
start with. If you haven't any, then basically, Patience diff does
nothing and calls your usual diff algorithm on the whole files.

It does so in a pseudo linear complexity, hence should not make overall
time really worse, but will not help for the ending time usually either.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkU2eEACgkQvGr7W6HudhwIAACfes2RpcnQoK3Bwn+DHCvE5Hdl
T7MAn0T4OLgtwoyMoiU8Ku/qVUyEI6HR
=Uu/2
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
