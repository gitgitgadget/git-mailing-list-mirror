From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] builtin-commit: fix --signoff
Date: Sat, 10 Nov 2007 14:16:56 +0100
Message-ID: <20071110131656.GD25204@artemis.corp>
References: <Pine.LNX.4.64.0711100548071.4362@racer.site> <7vr6iyo4ff.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="MnLPg7ZWsaic7Fhd";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, krh@redhat.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 10 14:17:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqqD5-0003h8-G1
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 14:17:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbXKJNQ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 08:16:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750908AbXKJNQ7
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 08:16:59 -0500
Received: from pan.madism.org ([88.191.52.104]:36476 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750898AbXKJNQ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2007 08:16:58 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 21E71295F6;
	Sat, 10 Nov 2007 14:16:56 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 815931E142; Sat, 10 Nov 2007 14:16:56 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, krh@redhat.com
Content-Disposition: inline
In-Reply-To: <7vr6iyo4ff.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64345>


--MnLPg7ZWsaic7Fhd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 10, 2007 at 09:06:28AM +0000, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>=20
> >  	if (signoff) {
> > ...
> > +		strbuf_init(&sob, 0);
> > +		strbuf_addstr(&sob, sign_off_header);
> > +		strbuf_addstr(&sob, git_committer_info(1));
> > +		p =3D strrchr(sob.buf, '>');
> > +		if (p)
> > +			strbuf_setlen(&sob, p + 1 - sob.buf);
> > +		strbuf_addch(&sob, '\n');
> > +
> > +		for (i =3D sb.len - 1; i > 0 && sb.buf[i - 1] !=3D '\n'; i--)
> > +			; /* do nothing */
> > +		if (prefixcmp(sb.buf + i, sob.buf))
> > +			strbuf_addbuf(&sb, &sob);
> >  	}
>=20
> At this point doesn't this leak sob.buf?

  It does, strbuf_addbuf copies `sob` but doesn't release resources.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--MnLPg7ZWsaic7Fhd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHNa9IvGr7W6HudhwRAhPDAJkBoR7Pd9fUHMxqR3mliebr71ZongCdGoou
DMLaCRIjgPHmBYsk7r3+7L4=
=a6Sq
-----END PGP SIGNATURE-----

--MnLPg7ZWsaic7Fhd--
