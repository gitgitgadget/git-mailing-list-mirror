From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Supplant the "while case ... break ;; esac" idiom
Date: Mon, 24 Sep 2007 10:01:34 +0200
Message-ID: <20070924080134.GA9112@artemis.corp>
References: <853ax5mb1j.fsf@lola.goethe.zz> <85myvdktb3.fsf@lola.goethe.zz> <20070924060521.GB10975@glandium.org> <85k5qgk295.fsf@lola.goethe.zz> <ee77f5c20709232330n7b47d9e9v38677678dbf197da@mail.gmail.com> <86ejgowl5g.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="T4sUOijqQbZv57TR";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Sep 24 10:01:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZisw-0003KR-1b
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 10:01:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754054AbXIXIBg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2007 04:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753703AbXIXIBg
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Sep 2007 04:01:36 -0400
Received: from pan.madism.org ([88.191.52.104]:40094 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753260AbXIXIBg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2007 04:01:36 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id F22D221745;
	Mon, 24 Sep 2007 10:01:34 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 1348EE190; Mon, 24 Sep 2007 10:01:34 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	David Kastrup <dak@gnu.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <86ejgowl5g.fsf@lola.quinscape.zz>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59027>


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 24, 2007 at 07:57:31AM +0000, David Kastrup wrote:
> "David Symonds" <dsymonds@gmail.com> writes:
>=20
> > On 24/09/2007, David Kastrup <dak@gnu.org> wrote:
> >> Mike Hommey <mh@glandium.org> writes:
> >>
> >> > On Sun, Sep 23, 2007 at 10:42:08PM +0200, David Kastrup wrote:
> >> >> -while case $# in 0) break ;; esac
> >> >> +while test $# !=3D 0
> >> >
> >> > Wouldn't -ne be better ?
> >>
> >> Why?
> >
> > Because -ne does a numeric comparison, !=3D does a string comparison,
> > and it's a numeric comparison happening, semantically speaking.
>=20
> I don't see the point in converting $# and 0 into numbers before
> comparing them.  "!=3D" is quite more readable, and the old code also
> compared the strings.

  Fwiw $# already is a number. Hence test $# -ne 0 is definitely a
better test.

  $# !=3D 0 would yield sth like (strcmp(sprintf("%d", argc), "0"))
  $# -ne 0 would yield sth like (argc !=3D atoi("0")).

  Not that it matters much, but the latter looks better to me.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG927dvGr7W6HudhwRAkMOAKCl6OwCNFHREsjQHb8wYFNSQsJ8vQCfUP23
8UlSmigxDSIKoZ5Bvo9kPYA=
=SOLd
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
