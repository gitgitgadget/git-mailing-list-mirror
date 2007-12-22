From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: 1.5.4-rc2 plans
Date: Sat, 22 Dec 2007 18:03:15 +0100
Message-ID: <20071222170315.GB23262@artemis.madism.org>
References: <7vwsr8lwf7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="zx4FCpZtqtKETZ7O";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 22 18:03:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J67lO-000258-MB
	for gcvg-git-2@gmane.org; Sat, 22 Dec 2007 18:03:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752579AbXLVRDZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2007 12:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752221AbXLVRDZ
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Dec 2007 12:03:25 -0500
Received: from pan.madism.org ([88.191.52.104]:47534 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752087AbXLVRDY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2007 12:03:24 -0500
Received: from madism.org (unknown [62.147.220.92])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 2F60672F;
	Sat, 22 Dec 2007 18:03:22 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 6D86114AF7A; Sat, 22 Dec 2007 18:03:15 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vwsr8lwf7.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69143>


--zx4FCpZtqtKETZ7O
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On ven, d=C3=A9c 21, 2007 at 12:32:28 +0000, Junio C Hamano wrote:
> I've tagged -rc1 last night.  The changes are mostly fixes.  There are
> some remaining issues I'd like to see fixed/decided before 1.5.4.
>=20
> One important issue is to identify and fix regressions since 1.5.3
> series.  No "rewrite scripted git-foo completely in C" can be regression
> free, and we had quite a few internal changes during 1.5.4 cycle (not
> just rewrite to C, but C level uses new and improved API such as strbuf
> and parse-options).  Currently I am aware of these regressions:
>=20
>  * handling of options, "--abbrev 10 HEAD", "--abbrev=3D10 HEAD" and
>    "--abbrev HEAD".  The last one does not work for commands that use
>    parse-options.  Pierre is on top of this, I hope.

  About that, I know we talked about the -default thing and so on, I'm
not sure we should hurry that for 1.5.4 for the following reasons:

  * I grepped through the source and the _sole_ instance of
    parse-options enabled option arguments are  --abbrev ones for now
    (even in the shell scripts migrated to git rev-parse --parseopt).

  * Not adding *-default and lax parsing for optional arguments is _not_
    a regression for the migrated commands.

  * I don't want to urge that because well, I still have the hope we
    could come up with something even better.

  So I'd argue in favor of that:
  + push the patch that forces the stuck forms (that I already posted)
    for 1.5.4.
  + prepare a series in pu with *-default post 1.5.4 to evaluate this
    and see what people think.

  Most of the function with optional arguments are the git diff ones,
and we'll see about them post 1.5.4 anyways.
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--zx4FCpZtqtKETZ7O
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHbUNTvGr7W6HudhwRAmIaAJwPHMIO4AEXatZXpDSDfxJx6N40PACeP+W3
nAK5iUqPg+a9xF6lyTzXEyw=
=SXdP
-----END PGP SIGNATURE-----

--zx4FCpZtqtKETZ7O--
