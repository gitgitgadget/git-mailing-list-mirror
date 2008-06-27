From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH 12/13] Build in merge
Date: Fri, 27 Jun 2008 14:54:43 +0200
Message-ID: <20080627125443.GK29404@genesis.frugalware.org>
References: <cover.1214066798.git.vmiklos@frugalware.org> <0b7ea424b3d5ea18a5a8660c6aead51adcc6a40f.1214066799.git.vmiklos@frugalware.org> <57d8a308fae0012174ed4388baccf1bde8515f2f.1214066799.git.vmiklos@frugalware.org> <5cae08d3bf2852a8bbd8dc8cdf741cb4bdfa237e.1214066799.git.vmiklos@frugalware.org> <d5d80c5a068c76810edfa9c0c68de500f02780a0.1214066799.git.vmiklos@frugalware.org> <486270D5.5050204@free.fr> <20080627010609.GJ29404@genesis.frugalware.org> <4864C8F8.9020501@free.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Nb3jGxDy0mpN3+XV"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Olivier Marin <dkr+ml.git@free.fr>
X-From: git-owner@vger.kernel.org Fri Jun 27 14:55:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCDUV-0002eE-O9
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 14:55:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753437AbYF0Mys (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 08:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753418AbYF0Mys
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 08:54:48 -0400
Received: from virgo.iok.hu ([193.202.89.103]:36032 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753332AbYF0Myr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 08:54:47 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id DFAE91B250E;
	Fri, 27 Jun 2008 14:54:45 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 8EF9744668;
	Fri, 27 Jun 2008 14:28:09 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id A76AB1778012; Fri, 27 Jun 2008 14:54:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4864C8F8.9020501@free.fr>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86546>


--Nb3jGxDy0mpN3+XV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2008 at 01:03:20PM +0200, Olivier Marin <dkr+ml.git@free.fr=
> wrote:
> Absolutely. And also color.ui. The following patch should do the trick:
>=20
> diff --git a/builtin-merge.c b/builtin-merge.c
> index 98adca5..cf557f7 100644
> --- a/builtin-merge.c
> +++ b/builtin-merge.c
> @@ -7,6 +7,7 @@
>   */
> =20
>  #include "cache.h"
> +#include "color.h"
>  #include "parse-options.h"
>  #include "builtin.h"
>  #include "run-command.h"
> @@ -712,6 +713,9 @@ int cmd_merge(int argc, const char **argv, const char=
 *prefix)
>         git_config(git_merge_config, NULL);
>         git_config(git_diff_ui_config, NULL);
> =20
> +       if (diff_use_color_default =3D=3D -1)
> +               diff_use_color_default =3D git_use_color_default;
> +
>         argc =3D parse_options(argc, argv, builtin_merge_options,
>                         builtin_merge_usage, 0);

Have you tried this?

First, you need to call git_get_colorbool_config(), second this won't
respect diff.color, while my patch does.

Thanks.

--Nb3jGxDy0mpN3+XV
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhk4xMACgkQe81tAgORUJbuhACfZZD9GRPIwVmKq4sEmzboua+e
rUIAn25dh4DqK0Tv3q21h5lS78Xz/u37
=WHgs
-----END PGP SIGNATURE-----

--Nb3jGxDy0mpN3+XV--
