From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] diff.c: guard config parser from value=NULL
Date: Sun, 10 Feb 2008 20:01:45 +0100
Message-ID: <20080210190145.GB5129@artemis.madism.org>
References: <20080210193534.d11d8b15.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="hQiwHBbRI9kgIhsi";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio Hamano <junkio@cox.net>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Govind Salinas <blix@sophiasuchtig.com>,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun Feb 10 20:02:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOHRa-00079l-4H
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 20:02:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752725AbYBJTBu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 14:01:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752653AbYBJTBu
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 14:01:50 -0500
Received: from pan.madism.org ([88.191.52.104]:60774 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752442AbYBJTBs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 14:01:48 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id F03832E1CF;
	Sun, 10 Feb 2008 20:01:46 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id F1F3951; Sun, 10 Feb 2008 20:01:45 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Junio Hamano <junkio@cox.net>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Govind Salinas <blix@sophiasuchtig.com>,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20080210193534.d11d8b15.chriscool@tuxfamily.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73390>


--hQiwHBbRI9kgIhsi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 10, 2008 at 06:35:34PM +0000, Christian Couder wrote:
> In fact we also guard for value=3D"" as it doesn't make more sense
> for the variables here.
>=20
> We do that by using a new function 'xstrdup_confval' to avoid code
> duplication.
>=20
> By the way this changes a 'strdup' into 'xstrdup'.
>=20
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  diff.c |   23 +++++++++++++----------
>  1 files changed, 13 insertions(+), 10 deletions(-)
>=20
> diff --git a/diff.c b/diff.c
> index 5b8afdc..d51aecb 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -60,6 +60,14 @@ static struct ll_diff_driver {
>  	char *cmd;
>  } *user_diff, **user_diff_tail;
> =20
> +static int xstrdup_confval(const char *dest, const char *var, const char=
 *value)

  Why not calling that "git_config_string" in config.[hc] and be
API-consistent ?

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--hQiwHBbRI9kgIhsi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHr0oZvGr7W6HudhwRAiy3AJ0YT4yoR/gTFs3sJUcInmIwWx6kBQCeKE/+
+svJlYXfyNwObWRcDuADFhE=
=Y1DO
-----END PGP SIGNATURE-----

--hQiwHBbRI9kgIhsi--
