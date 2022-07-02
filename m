Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63FEC433EF
	for <git@archiver.kernel.org>; Sat,  2 Jul 2022 07:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbiGBHhY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Jul 2022 03:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbiGBHhX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jul 2022 03:37:23 -0400
X-Greylist: delayed 400 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 02 Jul 2022 00:37:20 PDT
Received: from cressida.uberspace.de (cressida.uberspace.de [185.26.156.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8121CB32
        for <git@vger.kernel.org>; Sat,  2 Jul 2022 00:37:19 -0700 (PDT)
Received: (qmail 14622 invoked by uid 989); 2 Jul 2022 07:30:37 -0000
Authentication-Results: cressida.uberspace.de;
        auth=pass (plain)
Date:   Sat, 02 Jul 2022 09:30:18 +0200
From:   Matthias Beyer <mail@beyermatthias.de>
Subject: cherry-pick with --no-rerere-autoupdate does still rerere?
To:     git@vger.kernel.org
MIME-Version: 1.0
User-Agent: astroid/0.16.0 (https://github.com/astroidmail/astroid)
Message-Id: <1656746869.11nc2qu6dn.astroid@takeshi.none>
Content-Type: multipart/signed; protocol="application/pgp-signature";
        micalg=pgp-sha256; boundary="=-Lkw5tWQHEZaUhvolVhR5"
X-Rspamd-Bar: ---
X-Rspamd-Report: MIME_GOOD(-0.2) SIGNED_PGP(-2) SUBJECT_ENDS_QUESTION(1) BAYES_HAM(-2.467757)
X-Rspamd-Score: -3.667757
Received: from unknown (HELO unkown) (::1)
        by cressida.uberspace.de (Haraka/2.8.28) with ESMTPSA; Sat, 02 Jul 2022 09:30:37 +0200
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--=-Lkw5tWQHEZaUhvolVhR5
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

I just experienced a `git cherry-pick <commit> --no-rerere-autoupdate` wher=
e the
conflict still got automatically resolved from rerere.

Is this a known bug, or am I doing something wrong?

    $ git cherry-pick 61c16c9 --no-rerere-autoupdate
    Auto-merging crates/common/tedge_utils/src/file.rs
    CONFLICT (content): Merge conflict in crates/common/tedge_utils/src/fil=
e.rs
    error: could not apply 61c16c9cd... Fix (style): Do not use dedicated s=
tatement for return value
    hint: After resolving the conflicts, mark them with
    hint: "git add/rm <pathspec>", then run
    hint: "git cherry-pick --continue".
    hint: You can instead skip this commit with "git cherry-pick --skip".
    hint: To abort and get back to the state before "git cherry-pick",
    hint: run "git cherry-pick --abort".
    Resolved 'crates/common/tedge_utils/src/file.rs' using previous resolut=
ion.

Using

    $ git --version
    git version 2.36.0

Best,
Matthias

--=20
Mit freundlichen Gr=C3=BC=C3=9Fen,
Kind regards,
Matthias Beyer

--=-Lkw5tWQHEZaUhvolVhR5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEUJGUus1GMTrRclzcEKWX9Kitz80FAmK/9AoACgkQEKWX9Kit
z820LA//UAUJ3/H2gPmxGPrH/8JiqPDfI1SIMscrRaPeJ5FRBVqcYfpBd/O2qXTE
HgjevmuUK0lVYoiO3gPn45J3Bwzjk2iMXtLmrLAlTB7TNLkiVawYHvL3lC1301ow
J/+T3TFyOfSMob6GpmhQ5FxHEW3gREnaV3v3F7vZcAt92SAxUeDyTMSTO5EAlwld
GSv/XHp900UZxsAcimEfNU5g9OfDO+4U0Lo5IDxD8jlPQysDWKFZ6bRq487vL5x/
h5mQe4VcugE52JMj0PErhPHU4u0b4FC+6Ijof7sCTe8/U25zAwpp3CHg+wwZnPxs
eT6tSiU006uQo80Qwhj/ScqRrKgcjjH7Y8L9kVT3s5qf5cSN+Xm13zg29BdhlkrI
6S43PcT/NzAQN21QKtRUqhnTr5n7MMCupE9zSqIN/FWV9P91KS5aGHfjqbY0pp7c
Uc1xAGbTTWwQixkb+fkOv6sbmNZGFyYQUoCiimOHtINw2TdDNSjsXGGo+3GxD+CI
he8HwZfNU5MnAh8EylgL9dLD9abd+6huimxnQ8IZ8dYAW2BuGEvvMkiqStbr+rLe
4pLKWSPNHiMM9asQoXjRnu3T9y6LOAsnfSXDqb4CcKEilpmN9ZCnKT9W80WE8yaU
CBUrQBJ2zh5HNk4Oao4NdfqwK4IkNn/IUCUnErlDUKdUEd3G8I0=
=03L6
-----END PGP SIGNATURE-----

--=-Lkw5tWQHEZaUhvolVhR5--
