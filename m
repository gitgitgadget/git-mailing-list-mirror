From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Invert numbers and names in the git-shortlog summary  mode.
Date: Tue, 11 Dec 2007 16:24:12 +0100
Message-ID: <20071211152412.GB15448@artemis.madism.org>
References: <20071207093439.GA21896@elte.hu> <200712080636.12982.chriscool@tuxfamily.org> <20071211092446.GA4703@elte.hu> <20071211092916.GF30948@artemis.madism.org> <m3ve75sfn3.fsf@roke.D-201> <20071211115914.GJ30948@artemis.madism.org> <20071211122539.GA13945@sigill.intra.peff.net> <20071211140508.GA12204@elte.hu> <20071211144351.GA15448@artemis.madism.org> <20071211145709.GB19427@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="eJnRUKwClWJh1Khz";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Tue Dec 11 16:25:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J26yd-0000Q1-T1
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 16:24:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751998AbXLKPYP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 10:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751966AbXLKPYP
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 10:24:15 -0500
Received: from pan.madism.org ([88.191.52.104]:49080 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751328AbXLKPYO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 10:24:14 -0500
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 76D87285E2;
	Tue, 11 Dec 2007 16:24:13 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id AAD922B141C; Tue, 11 Dec 2007 16:24:12 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Ingo Molnar <mingo@elte.hu>, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <20071211145709.GB19427@elte.hu>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67871>


--eJnRUKwClWJh1Khz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 11, 2007 at 02:57:09PM +0000, Ingo Molnar wrote:
>=20
> * Pierre Habouzit <madcoder@debian.org> wrote:
>=20
> >     Agreed, here is the patch that does that, and a sample output is:
> >=20
> >         $ git shortlog -n -s -e HEAD -- builtin-commit.c
> >             11	Junio C Hamano <gitster@pobox.com>
> >              6	Johannes Schindelin <Johannes.Schindelin@gmx.de>
> >              6	Kristian H=C3=B8gsberg <krh@redhat.com>
> >              2	Jeff King <peff@peff.net>
> >              1	Alex Riesen <raa.lkml@gmail.com>
> >              1	Pierre Habouzit <madcoder@debian.org>
> >              1	Shawn Bohrer <shawn.bohrer@gmail.com>
> >              1	Wincent Colaiuta <win@wincent.com>
>=20
> great - this looks really neat!
>=20
> btw., stupid question: why are the git-shortlog command line arguments=20
> different from git-log? I got used to things like:
>=20
>   git-log kernel/
>=20
> so for me it would be natural to just do:
>=20
>   git-shortlog -n -s kernel/
>=20
> but this currently produces this output:
>=20
>   $ git-shortlog -n -s kernel/
>   (reading log to summarize from standard input)
>=20
> which is quite a bit confusing to someone who'd like to keep as few=20
> details of command line arguments in his head as possible :-)

Because git-shortlog insists on you passing a reference first, HEAD is
not implicit if you pass something that looks like a path first. This is
arguably wrong. What you meant here is:

$ git-shortlog -n -s HEAD kernel/

The reason IIRC is that git-shortlog once only read things on stdin, and
this keeps backward compatbility to `git-shortlog` without any
arguments.

Sometimes history hurts :) I don't think there is much we can do on a
short timescale. Maybe the old way can be slowly deprecated, and then
git-shortlog will be able to act like git-log.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--eJnRUKwClWJh1Khz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHXqucvGr7W6HudhwRAqJiAJ41Yx/05u4qfCp/t+z+IZrzlmCTugCfRc2e
Lq0zCJwHKVRmcfZeduFoXgE=
=k1L5
-----END PGP SIGNATURE-----

--eJnRUKwClWJh1Khz--
