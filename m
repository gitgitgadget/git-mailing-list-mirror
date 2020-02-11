Return-Path: <SRS0=9mHE=37=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DFA1C35242
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 23:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BFC92070A
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 23:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="y0Dzi4jG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbgBKXkI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Feb 2020 18:40:08 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:59084 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728117AbgBKXkH (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 11 Feb 2020 18:40:07 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A59E36048E;
        Tue, 11 Feb 2020 23:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1581464406;
        bh=+QAw/JEzH/bzWRIBsnqjHjZ1GStboXNCeN4ScE5+x8s=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=y0Dzi4jGxPTxhKOTHwtY533f9+OPJJVbUL2k9eE1X8UC5DJIGdGX+ZFyJut8HX/fJ
         SP5HPUHkEjmbmfwRqb6FtQqibievB/rc3ZfS2fDbUFlK9rXhb+EbeykkHG/FPe+o5d
         qqZkpQE61vLLRCWO8cpB7/lPBc6MKH7W1Olkv8c4hX8UQeouAY7sa9BFOXx3RKQ8JA
         1idSXbE/d38ycjBhXT+HrIi/i/2L8XNpFrmcJenXx51JaUHMbp/pf8avY434gDScod
         YFucoQMcSGifgWRtP7Tj8a2G4oeIS5a/REGM8mQeAJUIM1otkEO48j76lDxF9JrGEZ
         GsRa5unxw35FwuCm1jMrymdZq58XMcWU+1zHZVBkmAp3poR0tFVW6MvNApd80klpMY
         +iL/3kVp/8hvi3qpDQwVjHJ/ZVLsVUM2+wvMmYxT02ZaRSc03OH7CYhoKzkSksrKvS
         cAo5DHrNNnO3lbj85w7wZ+giRiAXYW3GB6v3lfazid+J3JcwEeE
Date:   Tue, 11 Feb 2020 23:40:00 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v4 4/5] Add reftable library
Message-ID: <20200211234000.GA6464@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
References: <pull.539.v3.git.1580848060.gitgitgadget@gmail.com>
 <pull.539.v4.git.1581029756.gitgitgadget@gmail.com>
 <02d2ca8b878a67a3334b222725645dd035b4289c.1581029756.git.gitgitgadget@gmail.com>
 <20200207001612.GF6573@camp.crustytoothpaste.net>
 <CAFQ2z_P+sdd5+46Ov_CO8ae4j_3aA4ahdVR5D_K1qKSQ-q+OcQ@mail.gmail.com>
 <20200211000520.GA6454@camp.crustytoothpaste.net>
 <CAFQ2z_N1sYh1TBzKue5y0039xQ+F6BBEUcFYCXS_OKjoxJ7v_g@mail.gmail.com>
 <xmqqwo8tw0ec.fsf@gitster-ct.c.googlers.com>
 <CAFQ2z_P-nK4OSb-CWwm2Fqh=kc3H4PsHu6K8Zxh_HRW9_-Z2yQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
In-Reply-To: <CAFQ2z_P-nK4OSb-CWwm2Fqh=kc3H4PsHu6K8Zxh_HRW9_-Z2yQ@mail.gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.4.0-3-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-02-11 at 16:40:56, Han-Wen Nienhuys wrote:
> I can see a future where we have a different format that allows for
> more metadata so we can encode the hash size separately. But maybe
> that can be for format v3 and up.
>=20
> Let's do format v2 =3D format v1 but with 32-byte hashes.

The way we've preferred to do this in Git is to write a four-byte hash
identifier into the file, but we have legacy concerns here, so I think
switching to v2 for SHA-256 is fine.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl5DO1AACgkQv1NdgR9S
9ovDng/8DiJCo++KgoOUGvCZPZi2MRkzQUTGeWgVgmHl9hd9v6ZOY5WBxxucV7Vy
JIcyo/0wZFYS6tmHs7/fLxUQ7XCBVVk7pQdUJ3xDRn1pjOVEdMvUZ4PVn8VgJD0L
F53TnARKj1BUPBixC2xBnck+VWqc5wpS1DXP+ttpP/oNqIds2qXkf7hpo4OdipEo
wHuGoykX0VwkkJGHW5dmJ2hV0NGiTmm9zzhKpzlnheXNq/cvRKBYAPoTcR3CX9t9
STUr+HRewz0o7DxsjAj/Tzi1GxlFWORv/SKV/5Wut3ytvcX2D/PPXRurd0XVezyf
nkSrB4Hd/9Mjo7Y/i+nF9H0k3rirEQ3ofkPJNN68BAI3ipsAukFs7YTKRswKVZ/F
boSAtSrA+VphK2vXas+HZ0C31HEvYCQIdlaYcHyBjdOSjTiw7Z2pup5boUmvycjG
TlKWpnvk+OK82eO6hilEqMOOZjYgCyZ/Sxv2QgmgV9JBonV9WOMs0rBbiO39ENdE
e0lNv6K8QRpkFeXvjkGr9xCosO08vyPWhlku23ARxb0nHM8+OPuAI5BX8P6ivpCA
I23pFUaHL6WCQk/B7Q1la0uhXrye+4RUB9FYRIuiQ74+LjNboUgHA9pSGri388jp
gXpfTHz7e+WPks798XAfYLJd49/t4SsNIlg5dg+iwnF4em7nUpE=
=1jEY
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
