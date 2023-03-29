Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B7A8C6FD18
	for <git@archiver.kernel.org>; Wed, 29 Mar 2023 00:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjC2A5v (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 20:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjC2A5t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 20:57:49 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7861989
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 17:57:48 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 5FE145B342;
        Wed, 29 Mar 2023 00:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1680051467;
        bh=kqVMp/eRIgpWiAqB6QaNYA/n9lwF6alswNoHUMBETN0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=joNxsHtrMr+3G2bEqcxylnIErx+68GCe/HvlofrIvKypzcXLu9pg6AU6M5fzY9CGE
         DnjSQEgttFJbyeksPq0h7Y6MyGQ6g5IJuUQqpPE+YxwMUciywQpXN7KQlll16a4guw
         U4xjOP0e02+teKTCgT6UNQCu6Zbbo27DcLcOhuO4FywT9bU6IYAVH7U0KHGX2tWUma
         oft5NSdvXJpAt5cLcecHXBCbLjfnmy76k2J1nlSH00ICfYrOtPtpx0Us6nZtrjGvy+
         Ueae8yrjPNFxzTDeLVohwKDmC074oloB/D4G11RIr8poT6WEtAH54WgYvelXQ4tzby
         nAywIvuQX8Fq7kBeNMKUNHXDe2FzhykCdfXrioimpDfgOmfg7ZAuGm70j2wmqh3vi0
         YAHScA2SEFkNQgsfU4rQTgez+lXpBHMOrFg0/lYpjlKFSxKOt8rDIJfvVewCLHUnt/
         1/7NxG7/1hoToonYiL9QunP2sfRP0w6Vd5ZIFAhc5O2j40Ee6Gc
Date:   Wed, 29 Mar 2023 00:57:45 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 0/6] test: make the test suite work with zsh
Message-ID: <ZCONCVC2ITBJWoBA@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <20230328173932.3614601-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/ykOs2QRIbZ5uVod"
Content-Disposition: inline
In-Reply-To: <20230328173932.3614601-1-felipe.contreras@gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--/ykOs2QRIbZ5uVod
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-03-28 at 17:39:26, Felipe Contreras wrote:
> It's not difficult to make the testing library work for zsh, so I did tha=
t in
> the first patch.
>=20
> The rest of the patches are basically to deal with some variables that are
> special in zsh, workaround a bug, and a minor discrepancy.

There was a point at which the tests worked entirely in sh mode with
zsh.  I know because I fixed a handful of tests there, ending with
c64368e3a2a47, and I patched zsh to run all commands in a pipeline in a
subshell in sh mode to fix the remaining tests.

If I symlink zsh (zsh 5.9 (x86_64-debian-linux-gnu)) to sh in a
temporary directory and use it in SHELL_PATH, I get only the following
failures:

  t4046-diff-unmerged.sh                           (Wstat: 256 (exited 1) T=
ests: 6 Failed: 5)
    Failed tests:  2-6
    Non-zero exit status: 1
  t7609-mergetool--lib.sh                          (Wstat: 256 (exited 1) T=
ests: 1 Failed: 1)
    Failed test:  1
    Non-zero exit status: 1

I haven't investigated further.

I don't care a lot of other folks want to make zsh run the testsuite in
zsh mode, but I'd think that using sh mode would be simpler and less
likely to break in general, and would avoid us needing to carry a lot of
patches to work around various variables that are special in zsh mode.
It would also be easier to potentially test in the testsuite as well.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--/ykOs2QRIbZ5uVod
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZCONCQAKCRB8DEliiIei
gS+rAQDukHXiPZVe87B1DL0y4+vc2TWiIaw/FwYbTxMkeQ/HWgD6A+8Rhcl8b5zk
6ttxxwtvBTswC5yC7OBIefedZIoDZwo=
=v2/6
-----END PGP SIGNATURE-----

--/ykOs2QRIbZ5uVod--
