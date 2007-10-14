From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Simplify usage string printing
Date: Sun, 14 Oct 2007 18:26:28 +0200
Message-ID: <20071014162628.GG1198@artemis.corp>
References: <1192282153-26684-2-git-send-email-madcoder@debian.org> <1192282153-26684-3-git-send-email-madcoder@debian.org> <1192282153-26684-4-git-send-email-madcoder@debian.org> <1192282153-26684-5-git-send-email-madcoder@debian.org> <1192282153-26684-6-git-send-email-madcoder@debian.org> <1192282153-26684-7-git-send-email-madcoder@debian.org> <1192282153-26684-8-git-send-email-madcoder@debian.org> <1192282153-26684-9-git-send-email-madcoder@debian.org> <1192282153-26684-10-git-send-email-madcoder@debian.org> <20071014140116.GA20970@diku.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="1giRMj6yz/+FOIRq";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Sun Oct 14 18:26:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ih6Ib-0001b9-Bw
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 18:26:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755657AbXJNQ0b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 12:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755556AbXJNQ0b
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 12:26:31 -0400
Received: from pan.madism.org ([88.191.52.104]:58763 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755313AbXJNQ0a (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 12:26:30 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 33EAC24E68;
	Sun, 14 Oct 2007 18:26:29 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 8970D3AD5BE; Sun, 14 Oct 2007 18:26:28 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Jonas Fonseca <fonseca@diku.dk>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <20071014140116.GA20970@diku.dk>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60863>


--1giRMj6yz/+FOIRq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 14, 2007 at 02:01:16PM +0000, Jonas Fonseca wrote:
> Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
> ---
>  builtin-branch.c     |    1 -
>  builtin-update-ref.c |    1 -
>  parse-options.c      |    2 +-
>  3 files changed, 1 insertions(+), 3 deletions(-)
>=20
>  Pierre Habouzit <madcoder@debian.org> wrote Sat, Oct 13, 2007:
>  > Signed-off-by: Pierre Habouzit <madcoder@debian.org>
>  > ---
>  >  builtin-update-ref.c |   71 +++++++++++++++++++++--------------------=
---------
>  >  1 files changed, 30 insertions(+), 41 deletions(-)
>  >=20
>  > diff --git a/builtin-update-ref.c b/builtin-update-ref.c
>  > index fe1f74c..eafb642 100644
>  > --- a/builtin-update-ref.c
>  > +++ b/builtin-update-ref.c
>  > @@ -1,59 +1,48 @@
>  >  #include "cache.h"
>  >  #include "refs.h"
>  >  #include "builtin.h"
>  > +#include "parse-options.h"
>  > =20
>  > -static const char git_update_ref_usage[] =3D
>  > -"git-update-ref [-m <reason>] (-d <refname> <value> | [--no-deref] <r=
efname> <value> [<oldval>])";
>  > +static const char * const git_update_ref_usage[] =3D {
>  > +	"",
>  > +	"git-update-ref [options] -d <refname> <oldval>",
>  > +	"git-update-ref [options]    <refname> <newval> [<oldval>]",
>  > +	NULL
>  > +};
>=20
>  How about something like this to get rid of these empty strings
>  that look strange?
>=20
> 	> ./git update-ref -h
> 	usage: git-update-ref [options] -d <refname> <oldval>
> 	   or: git-update-ref [options]    <refname> <newval> [<oldval>]

  I like the idea, though we may want to have more text to explain some
things about the command, so I'll do something in between that uses or:
until an empty line is met, and just prefix the result with four spaces
else, this way we can have:

usage: git-foo ...
   or: git-foo ...

    Did you know that you can do bar with git-foo ?
    but beware that it cannot do quux.

    -m <reason>           reason of the update
    -d                    deletes the reference
    --no-deref            update <refname> not the one it points to


--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--1giRMj6yz/+FOIRq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHEkM0vGr7W6HudhwRApj4AJ4rskOS/mq1oqo4DvSEOZ5Bw0JCzgCfd6Eu
tj7uDqfGhZdqR9PHFgspRuo=
=EjRF
-----END PGP SIGNATURE-----

--1giRMj6yz/+FOIRq--
