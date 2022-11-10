Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4748AC4332F
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 02:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbiKJCkn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 21:40:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbiKJCkk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 21:40:40 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3266E14029
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 18:40:39 -0800 (PST)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 14ADE5A1AC;
        Thu, 10 Nov 2022 02:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1668048038;
        bh=tDwQdxOIFl7xIFi4WvPyUanParovkeZin3q2xgB9c+0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=V77r367FjiJhBj6k6Ky0MiXwvLVuVixEq84Rw71LXtkxTuuoUX+dQTo8/3gX5p7fT
         mTcK33l0U97Aioxti1W5RFl5SCd9u+UFgo6xFnI1W1K0T444t4qPDB3PZ5mTblh/8G
         iancIyD8tMjpnm8GUCgaTb1AQAkbQoxPqYBwcps1gY6wQDLmEFfAbI7n7uO7ZN/+EE
         54++sjwJUV2CI19udWJ9TPZPyINTj/juDAVau7Yf1bVOWaPlXXi7oDrNlANDwgq4lw
         w8KLeLkJeVSjVEnkqKwYy1sgcDtV6mYlTl29Yx+9li+Dz6cfwFaPPhrO7fA2AnF53T
         nWADQs9KVnl1uIJNgKjMSc5UFS2JbDbDanf2X7rv9+5sXIXKTPWCB8C9DOU76N8xmK
         vKChOCIkW662kH69ITXEvgDVS9hZ8wJQZ6mQAMcpKpP7bTZWWRdgkAdZJMxjdS0Ait
         /0cj21uL37pkCTYRRMYRR9AZ6k640ej2Ka/PrSczsfqN8HU5JH7
Date:   Thu, 10 Nov 2022 02:40:36 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/3] chainlint: sidestep impoverished macOS "terminfo"
Message-ID: <Y2xkpJj4jLqfsggL@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <pull.1413.git.1668013114.gitgitgadget@gmail.com>
 <b85b28e5a6beea97c149f0b9de6ba8d0a4a7c1f9.1668013114.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VQv64hsEzh5RBGz7"
Content-Disposition: inline
In-Reply-To: <b85b28e5a6beea97c149f0b9de6ba8d0a4a7c1f9.1668013114.git.gitgitgadget@gmail.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--VQv64hsEzh5RBGz7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-11-09 at 16:58:32, Eric Sunshine via GitGitGadget wrote:
> From: Eric Sunshine <sunshine@sunshineco.com>
>=20
> Although the macOS Terminal.app is "xterm"-compatible, its corresponding
> "terminfo" entry neglects to mention capabilities which Terminal.app
> actually supports (such as "dim text"). This oversight on Apple's part
> ends up penalizing users of "good citizen" console programs which
> consult "terminfo" to tailor their output based upon reported terminal
> capabilities (as opposed to programs which assume that the terminal
> supports ANSI codes).
>=20
> Sidestep this Apple problem by imbuing get_colors() with specific
> knowledge of "xterm" capabilities rather than trusting "terminfo" to
> report them correctly. Although hard-coding such knowledge is ugly,
> "xterm" support is nearly ubiquitous these days, and Git itself sets
> precedence by assuming support for ANSI color codes. For non-"xterm",
> fall back to querying "terminfo" via `tput` as usual.

Given the regex below, I think the question here is actually whether
XTerm itself supports these in all its variants (my Debian system lists
approximately 90 of them), many of which are quite old.  While I don't
expect most of them to see common use, given the interest some people
have in retrocomputing, I don't think we can exclude the possibility of
seeing people use esoteric xterm variants over an SSH (or, perhaps less
pleasantly, telnet) connection.

Terminal.app actually has its own set of terminal types, nsterm*, which
are properly used here instead, although I realize that most people
prefer the xterm* options for compatibility and ease of use.  However,
that kind of behaviour does result in breakage when the canonical
terminal for that type (in this case XTerm) implements new features that
aren't supported in other implementations.

Perhaps, instead of auditing all 90 terminal types, we should tighten
this to xterm, xterm-256color, and xterm-direct[0]?  That should cover
the vast majority of use cases in the real world today, including most
users of macOS and Terminal.app, while avoiding breaking some older
variants (e.g., xterm-old lacks setaf).

> +	if ($ENV{TERM} =3D~ /\bxterm\b/) {
> +		%COLORS =3D (bold  =3D> "\e[1m",
> +			   rev   =3D> "\e[7m",
> +			   reset =3D> "\e[0m",
> +			   blue  =3D> "\e[34m",
> +			   green =3D> "\e[32m",
> +			   red   =3D> "\e[31m");
> +		return \%COLORS;
> +	}

[0] *-direct is what's typically used by ncurses for true colour
variants.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--VQv64hsEzh5RBGz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCY2xkpAAKCRB8DEliiIei
geovAQDu1kf/9LURaE/S7B2krwML0b8UOQxV3y/tzIz1vSWz3wD/cFIVU+T5bWbo
MY/JAxbvjV+/9GeZykMoiclqw3Sn5wQ=
=jCb3
-----END PGP SIGNATURE-----

--VQv64hsEzh5RBGz7--
