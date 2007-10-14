From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] parse-options: Allow abbreviated options when unambiguous
Date: Sun, 14 Oct 2007 20:08:15 +0200
Message-ID: <20071014180815.GK1198@artemis.corp>
References: <1192282153-26684-1-git-send-email-madcoder@debian.org> <20071014091855.GA17397@soma> <20071014095755.GF1198@artemis.corp> <Pine.LNX.4.64.0710141751530.25221@racer.site> <Pine.LNX.4.64.0710141901450.25221@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="rnP2AJ7yb1j09OW/";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Oct 14 20:09:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ih7t6-0000bg-CK
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 20:08:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758275AbXJNSIS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 14:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758262AbXJNSIS
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 14:08:18 -0400
Received: from pan.madism.org ([88.191.52.104]:44050 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758186AbXJNSIR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 14:08:17 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 37FFF24F20;
	Sun, 14 Oct 2007 20:08:16 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 850AF3A23A1; Sun, 14 Oct 2007 20:08:15 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710141901450.25221@racer.site>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60887>


--rnP2AJ7yb1j09OW/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 14, 2007 at 06:02:33PM +0000, Johannes Schindelin wrote:
> Hi,
>=20
> On Sun, 14 Oct 2007, Johannes Schindelin wrote:
>=20
> > When there is an option "--amend", the option parser now recognizes=20
> > "--am" for that option, provided that there is no other option beginnin=
g=20
> > with "--am".
>=20
> And an amend for ultra-abbreviated options (as you noticed on IRC):
>=20
> diff --git a/parse-options.c b/parse-options.c
> index afc6c89..acabb98 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -137,6 +137,11 @@ is_abbreviated:
>  				abbrev_flags =3D flags;
>  				continue;
>  			}
> +			/* negated and abbreviated very much? */
> +			if (!prefixcmp("no-", arg)) {
> +				flags |=3D OPT_UNSET;
> +				goto is_abbreviated;
> +			}
>  			/* negated? */
>  			if (strncmp(arg, "no-", 3))
>  				continue;

  squashed on top on the previous, and pushed to my ph/parseopt branch.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--rnP2AJ7yb1j09OW/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHElsPvGr7W6HudhwRAjB6AJ9KTEFjtSKkqOZwsC6roydZC++5KgCeIBKu
NBn2gYApQpQHo/qO/rDj5zE=
=nyEl
-----END PGP SIGNATURE-----

--rnP2AJ7yb1j09OW/--
