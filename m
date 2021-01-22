Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB2AC433E0
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 18:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15B782076E
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 18:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbhAVSbg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 13:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728586AbhAVSYv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 13:24:51 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB54CC06121D
        for <git@vger.kernel.org>; Fri, 22 Jan 2021 10:20:52 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l313D-0008Po-GJ; Fri, 22 Jan 2021 19:20:51 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l313C-0003HJ-Qk; Fri, 22 Jan 2021 19:20:50 +0100
Date:   Fri, 22 Jan 2021 19:20:50 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 3/3] range-diff(docs): explain how to specify commit
 ranges
Message-ID: <20210122182050.xyzkvlctb4kiin7a@pengutronix.de>
References: <pull.841.git.1611267638.gitgitgadget@gmail.com>
 <041456b6e73b3a88097d0cc06056eb43d35d42c6.1611267638.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="agphy5tzrug36qdk"
Content-Disposition: inline
In-Reply-To: <041456b6e73b3a88097d0cc06056eb43d35d42c6.1611267638.git.gitgitgadget@gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--agphy5tzrug36qdk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 21, 2021 at 10:20:38PM +0000, Johannes Schindelin via GitGitGad=
get wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>=20
> There are three forms, depending whether the user specifies one, two or
> three non-option arguments. We've never actually explained how this
> works in the manual, so let's explain it.
>=20
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  Documentation/git-range-diff.txt | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/Documentation/git-range-diff.txt b/Documentation/git-range-d=
iff.txt
> index 9701c1e5fdd..76359baf26d 100644
> --- a/Documentation/git-range-diff.txt
> +++ b/Documentation/git-range-diff.txt
> @@ -28,6 +28,19 @@ Finally, the list of matching commits is shown in the =
order of the
>  second commit range, with unmatched commits being inserted just after
>  all of their ancestors have been shown.
> =20
> +There are three ways to specify the commit ranges:
> +
> +- `<range1> <range2>`: Either commit range can be of the form
> +  `<base>..<rev>`, `<rev>^!` or `<rev>^-<n>`. See `SPECIFYING RANGES`
> +  in linkgit:gitrevisions[7] for more details.
> +
> +- `<rev1>...<rev2>`. This resembles the symmetric ranges mentioned in
> +  the `SPECIFYING RANGES` section of linkgit:gitrevisions[7], and is
> +  equivalent to `<base>..<rev1> <base>..<rev2>` where `<base>` is the
> +  merge base as obtained via `git merge-base <rev1> <rev2>`.
> +
> +- `<base> <rev1> <rev2>`: This is equivalent to `<base>..<rev1>
> +  <base>..<rev2>`.

git-log takes a range, too. There you can specify a single rev (with the
semantic to list all commits from this rev up (or down?) to the root).
So <rev> means implicitly <rev>^=E2=88=9E..<rev> for git-log.

Does it make sense to implement this here, too? Maybe this even allows
sharing some more code?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--agphy5tzrug36qdk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmALF38ACgkQwfwUeK3K
7AljkwgAnPEXPUx9iDKY/YDJfFRIgGC5VYordHiEtImEgAqCG5pWdWoAaBpLlJzj
YfjdKueYyYUCLRaf6a/NvleBNwc5zXbbPuZbHz83yz7z9AXiGHRY5bTvWZn1g65E
7BcwYSeww/PcTFs6WKt6EKWC1io2Uu3WZ/hz2wJ/GBjpb9q0RabDmgRcg6/enCWW
yaMnBLKoB1hDp0D37KaK1AmL6PTIfwGzp4mk4r3qHx3/y+4Z7UZwtIK3/JA8HR14
bNocJgH3Esm80HFyFx24AI079LwShKaTMVsZssUN7N2cmU3iHBfhz+8qIcoZh+Se
8qPRVfy1XoELyj2hX6FEZ4Ezx5Kjgg==
=FLzw
-----END PGP SIGNATURE-----

--agphy5tzrug36qdk--
