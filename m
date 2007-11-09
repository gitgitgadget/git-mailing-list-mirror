From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH PARSEOPT 1/4] parse-options new features.
Date: Fri, 09 Nov 2007 01:17:19 +0100
Message-ID: <20071109001719.GA22255@artemis.corp>
References: <1194430832-6224-1-git-send-email-madcoder@debian.org> <1194430832-6224-2-git-send-email-madcoder@debian.org> <1194430832-6224-3-git-send-email-madcoder@debian.org> <7vbqa4z3ts.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="AqsLC8rIMeq19msA";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 02:12:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqIPn-0006to-NZ
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 02:12:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754151AbXKIBLx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 20:11:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751646AbXKIBLx
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 20:11:53 -0500
Received: from pan.madism.org ([88.191.52.104]:56823 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753864AbXKIBLw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 20:11:52 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id AEC032933E;
	Fri,  9 Nov 2007 01:17:20 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id B802334A2FB; Fri,  9 Nov 2007 01:17:19 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vbqa4z3ts.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64099>


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 08, 2007 at 11:59:27PM +0000, Junio C Hamano wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> > options flags:
> > ~~~~~~~~~~~~~
> >   PARSE_OPT_NONEG allow the caller to disallow the negated option to ex=
ists.
>=20
> Good addition; writing OPT_CALLBACK was tricky without this when
> I tried to add --with=3D<commit> to git-branch.

  Well, you could do the same by hand, in the callback:

    if (unset)
        return error("go away with your --no-%s", opt->long_name);

  This is correct because only long options can be negated, and if the
callback returns -1 (< 0 actually IIRC, or maybe even !0) then
parse_options assume that you dealt with the error message, and will
just print out the usage and exit(129).

  So it merely offloads something that you could already do the very
same way _when using a callback_.

  It gets more interesting when you want to use an
OPT_INT/_STRING/whatever with an argument that isn't a callback and
don't want for some reason that --no-foo works. Before that change, you
needed a callback, now you don't :)
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHM6cPvGr7W6HudhwRArJ2AKCPtISXmOsoF2/jci72jAD0O0tT5QCfSELI
kTRQ/B6QkmwqEblOIGPUCeE=
=gRGq
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
