From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] builtin-tag: fix fallouts from recent parsopt restriction.
Date: Mon, 17 Dec 2007 22:11:06 +0100
Message-ID: <20071217211106.GC13004@artemis.madism.org>
References: <20071213091055.GA5674@coredump.intra.peff.net> <20071213093536.GC12398@artemis.madism.org> <20071213102636.GD12398@artemis.madism.org> <7vd4t5eq52.fsf@gitster.siamese.dyndns.org> <20071217090749.GC7453@artemis.madism.org> <7vir2xa8z7.fsf@gitster.siamese.dyndns.org> <20071217105834.GG7453@artemis.madism.org> <7v1w9la7o8.fsf@gitster.siamese.dyndns.org> <20071217123307.GK7453@artemis.madism.org> <7vy7bt6qv6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="1SQmhf2mF2YjsYvc";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 22:11:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4NFO-0003UV-05
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 22:11:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757944AbXLQVLL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 16:11:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757312AbXLQVLJ
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 16:11:09 -0500
Received: from pan.madism.org ([88.191.52.104]:58750 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757219AbXLQVLI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 16:11:08 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 74D2E2FEB5;
	Mon, 17 Dec 2007 22:11:07 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id E9D063E1193; Mon, 17 Dec 2007 22:11:06 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vy7bt6qv6.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68622>


--1SQmhf2mF2YjsYvc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 17, 2007 at 07:52:29PM +0000, Junio C Hamano wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> > After having written this mail 4 time already, I came up with an idea I
> > kind of like: like find, we could make {} be a placeholder for the
> > "default" argument. For example:
> >
> >   $ git foo --abbrev {} 10
> >   $ git log -M {} 1
> >   ...
> >
> > {} would have the same semantics as your --long-opt-default. It tells t=
he
> > option parser that "no there isn't anything to grok for that command th=
ank you
> > very much". Of course if for some reason you really want to pass "{}" t=
o the
> > command, the stuck form holds:
> >
> >   $ git foo --long-opt=3D{}
> >   $ git foo -o{}
> >
> > What do you think ?
>=20
> 1. {} means a completely different thing to find ("place the real value
>    here"); there is no similarity.  I would strongly oppose to it.  If

  okay we could make it be '_', but =E2=80=A6

>    you want to invoke opt with default but still want to pass "{}" as an
>    argument unrelated to that opt, you would do "--opt=3D{} {}".  That's
>    double ugly.

Actually that would be --opt {} {} (or --opt _ _) and indeed it's not
very nice (euphemism for it sucks hard).

I like the *-default idea a lot, but it's not really useful if we cannot
fix the single letter switches at the same time. I had the idea to use !
(or any other less shell-magical char) like this: --abbrev! but it
doesn't fly a lot better for single letter switches.

Well maybe it's not worth fighting any longer, we should stick to the
stuck form then :)
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--1SQmhf2mF2YjsYvc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHZuXqvGr7W6HudhwRAre2AKCGOVmmQyVFxqGzhLhnmn2QGi2zzQCeNf4o
RymE10AdBsJvUIbtjvbU5kI=
=E7up
-----END PGP SIGNATURE-----

--1SQmhf2mF2YjsYvc--
