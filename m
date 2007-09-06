From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: strbuf new API, take 2 for inclusion
Date: Thu, 06 Sep 2007 19:15:02 +0200
Message-ID: <20070906171502.GF8451@artemis.corp>
References: <20070902224213.GB431@artemis.corp> <11890776114037-git-send-email-madcoder@debian.org> <20070906125811.GA32400@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="1Ow488MNN9B9o/ov";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 06 19:15:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITKwj-0000gE-Pi
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 19:15:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753201AbXIFRPJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 13:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753024AbXIFRPJ
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 13:15:09 -0400
Received: from pan.madism.org ([88.191.52.104]:41609 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752182AbXIFRPH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 13:15:07 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 6E7ED1E4F4;
	Thu,  6 Sep 2007 19:15:03 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 721F4E9F5; Thu,  6 Sep 2007 19:15:02 +0200 (CEST)
Mail-Followup-To: Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070906125811.GA32400@coredump.intra.peff.net>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57910>


--1Ow488MNN9B9o/ov
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 06, 2007 at 12:58:11PM +0000, Jeff King wrote:
> On Thu, Sep 06, 2007 at 01:20:04PM +0200, Pierre Habouzit wrote:
>=20
> >   I've also stripped as many STRBUF_INIT uses as possible, some people
> > didn't liked it. I've kept its use for "static" strbufs where it's way
> > more convenient that a function call.
>=20
> The STRBUF_INIT initializer just sets everything to '0' or NULL. Static
> objects already have this done automagically by the compiler, so there's
> no need to use STRBUF_INIT at all there.

  Yes, Junio already did that remark. The reason is that it's forward
compatible: if we ever change strbuf's intitial value for some reason,
we would just have to rebuild the code. As junio disliked it (and I'm
not sure I love it either) I've used it where using the _init() function
was impractical.


  And yes { 0 } would have worked the same as per C standard. It's just
that I setup my compiler to flag missing C89 initializers (because it
often detects real errors).

  Here are the whys'

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--1Ow488MNN9B9o/ov
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG4DWWvGr7W6HudhwRAnHwAJ0fI+2tIiw/gqdjI2NZsrkTHie5mACgiZaX
GI1a3EAArEqR6tblRpZvhHg=
=O+Kk
-----END PGP SIGNATURE-----

--1Ow488MNN9B9o/ov--
