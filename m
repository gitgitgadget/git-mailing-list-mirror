From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Avoid using non-portable `echo -n` in tests.
Date: Fri, 31 Oct 2008 19:36:01 +0100
Message-ID: <20081031183601.GB8464@artemis.corp>
References: <8A4A84EC-51F7-4038-957C-CCA5C00E5977@silverinsanity.com> <1225429753-70109-1-git-send-email-benji@silverinsanity.com> <20081031182456.GC3230@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="/NkBOFFp2J2Af1nK";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	Git List <git@vger.kernel.org>,
	Shawn O Pearce <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 31 19:37:20 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kvys2-0002tv-8A
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 19:37:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752325AbYJaSgH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 14:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751992AbYJaSgG
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 14:36:06 -0400
Received: from pan.madism.org ([88.191.52.104]:48947 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753226AbYJaSgF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 14:36:05 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 855F43B644;
	Fri, 31 Oct 2008 19:36:02 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 0B65A5EE243; Fri, 31 Oct 2008 19:36:01 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081031182456.GC3230@sigill.intra.peff.net>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99617>


--/NkBOFFp2J2Af1nK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2008 at 06:24:56PM +0000, Jeff King wrote:
> On Fri, Oct 31, 2008 at 01:09:13AM -0400, Brian Gernhardt wrote:
>=20
> > Not all /bin/sh have a builtin echo that recognizes -n.  Using printf
> > is far more portable.
> >=20
> > Discovered on OS X 10.5.5 in t4030-diff-textconv.sh and changed in all
> > the test scripts.
>=20
> Hmph. I think this is a good patch, and there is precedent in the past
> (20fa04ea, 2aad957, 9754563). But I am surprised this was not caught by
> our recent autobuilding project.

Set up a Debian autobuilder with dash as a /bin/sh (apt-get install
dash, dpkg-reconfigure -plow dash and say 'yes'). You'll see those kind
of problems arise immediately.

Dash is a POSIX compatible shell, with almost no extension added (in
particular its echo has no -n option) which helps to find those kind of
issues.

It would help detecting git shell scripts that use bashism as well.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--/NkBOFFp2J2Af1nK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkLUBAACgkQvGr7W6HudhznKgCeMBx5DoHvr0lV2eOxhk4xpMOl
27wAnjkkres3u35JvGpT3ennMGYTTL7b
=AmTH
-----END PGP SIGNATURE-----

--/NkBOFFp2J2Af1nK--
