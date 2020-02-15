Return-Path: <SRS0=Fd5/=4D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D928C3F68F
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 00:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51076217F4
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 00:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="ZGOYi6iG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbgBOACg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 19:02:36 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:32990 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727455AbgBOACg (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 14 Feb 2020 19:02:36 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2E16960791;
        Sat, 15 Feb 2020 00:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1581724955;
        bh=LC6UYZd3TUfWyRbf3yZPdYoy1QUCGI4pFGTW/MMlOXs=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=ZGOYi6iGYHscPDtvYEpFhCS0R7J4sDSL4tZfdRh2ZP2qD+FReKKUx14FSQw5SkGqn
         BvPhdVTPH0OeYhq6G8Ly6BTY5x7axH+FLgbru5JnOiwKY0tfn1RK7NKkJ0EKiHSgOh
         ytWXUqG+zbStdcn2JZkgkNzyxPe9+HVCNex0qs5hewQwXyJMGFFpWUMCus/V0lhflV
         M5tyhnKjIZCX9ChctpOKMHdy5z2jkqlOvIN+wC35agcJWNSxykHIfyUAIWhOHDUze/
         LiCtL787Ez89H1GipHZfH0457ChdSyF/1i80lye6w0yLLEaT3cwT38OWMBQt4LmVTJ
         g/+Biqpv9NeLClXIWo6wK1bAjXowF+27lsFS8VRhLgbZp7kFkuKYRU8pbxdh4/UO/r
         3Ntn/JnZLZa5bgOSW64TV9DDyBaODREyo/Vqan2Pc0t//Rx/9t7mv7akb5LQlHRsy5
         r3JoBQwInncjoqkdGte/i5Pf454sMgV8O7QsUE+Q2CLOpkvAt+R
Date:   Sat, 15 Feb 2020 00:02:30 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     emilyshaffer@google.com
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] prefix_path: show gitdir when arg is outside repo
Message-ID: <20200215000230.GA6134@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        emilyshaffer@google.com, git@vger.kernel.org
References: <20200214232933.243520-1-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
In-Reply-To: <20200214232933.243520-1-emilyshaffer@google.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.4.0-4-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-02-14 at 23:29:33, emilyshaffer@google.com wrote:
> From: Emily Shaffer <emilyshaffer@google.com>
>=20
> When developing a script, it can be painful to understand why Git thinks
> something is outside the current repo, if the current repo isn't what
> the user thinks it is. Since this can be tricky to diagnose, especially
> in cases like submodules or nested worktrees, let's give the user a hint
> about which repository is offended about that path.
>=20
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
> This one comes from a user feature request. This user is running some
> Git client commands on a build machine somewhere and finding it hard to
> reason about the cause of the "outside repo" error.
>=20
> I see two arguments:
>=20
> For:
>  - A user checking their own `pwd` might still not come to the same
>    conclusion Git does about the current repo, if their filesystem is in
>    some weird state
>  - This warning is intended for human eyes (die(), stderr) so it's reason=
able
>    to give some info to make the human's life easier
>=20
> Against:
>  - It's chatty, especially given the absolute directory. This may be a
>    pretty common mistake ('git add' with thumbfingers?) so it could be
>    chatty, frequently - not great.
>    (Sidebar: Just including the relative directory is really not very
>    useful - since you're still left thinking, "relative to where?")

I'm very much in favor of this patch.  I recently ran into a similar
problem with Git LFS with path canonicalization and having both paths in
the error message made it immediately obvious what the problem was.

> diff --git a/pathspec.c b/pathspec.c
> index 128f27fcb7..5d661df5cf 100644
> --- a/pathspec.c
> +++ b/pathspec.c
> @@ -439,7 +439,8 @@ static void init_pathspec_item(struct pathspec_item *=
item, unsigned flags,
>  		match =3D prefix_path_gently(prefix, prefixlen,
>  					   &prefixlen, copyfrom);
>  		if (!match)
> -			die(_("%s: '%s' is outside repository"), elt, copyfrom);
> +			die(_("%s: '%s' is outside repository at '%s'"), elt,
> +			    copyfrom, absolute_path(get_git_dir()));

Do we want the top level directory in these two spots instead of the git
directory?  I suspect that might be more helpful, since it looks like
we're dealing with working tree files.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl5HNRYACgkQv1NdgR9S
9ouPJg/9EXAr57pivavtg73JZpgQIMHOllPmIRJgeDCgLVrQdFxVYxhh4qNXrI4C
3TikW8QFkjwPjCTeljNvcjG8n9YL0G2VE2e1WcH3i3UXZLsCvyrBmgn+DySs23cQ
XeUTOJzL2An+E2PD+RE0geB5zRX2Cg0zb7kDAblzm1ZbpK/ESb9JrT9FnTcAXWVj
sGFvSARPM50JVvlf1LmBE1tDHfAkVykRrMh/9ThHsPZ3sYot06wMLDbSr36vQK0R
oDhHRLI5gAKsG8lUFS2e66A+2wNv1Ca3zFGwiGBF99PLrSTjPzGxB2QGqguyllDN
RxnQg1Ea4Uzg2S9lN895AzlUYA1b8pWxQzKTNKiK2USBilE+Rt8lPtnQAIJYrIuy
MuIBNUAq6TF/T6h6zYpoW8JQqqK2H+ZLnWLLEvpRbJyaQwFpzKJdk6wotejxnJLu
dHt+mZUn7xxh3UDbdMrEbxOsaHwT+C4NommuuuPq/0ZODoGcS8AApfGLaExUzeV8
WdUkI49S2a1sdT5GxKavzgUtkkEJXfKx5+6JWeVJvFXhL4KsvyCtFMRJFbth+0Oh
0jnZTN2jFxQNhPeiMN8np+OdwPcmahlaahdlGH937DLGKOj2lpowTMSec8Bigd/u
+lmuTbG2ds3jiymJeTgKaEMCR6HP9DlPKUtGRi2vIyrWKzRSn+8=
=Bdas
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
