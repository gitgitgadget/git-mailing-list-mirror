Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF5FC433B4
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 19:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14D5D613D7
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 19:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbhDTTvT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 15:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbhDTTvS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 15:51:18 -0400
Received: from smtp.gentoo.org (smtp.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D90C06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 12:50:46 -0700 (PDT)
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by smtp.gentoo.org (Postfix) with ESMTPS id 662EF340E53
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 19:50:44 +0000 (UTC)
Received: (qmail 14045 invoked by uid 10000); 20 Apr 2021 19:50:44 -0000
Date:   Tue, 20 Apr 2021 19:50:44 +0000
From:   "Robin H. Johnson" <robbat2@gentoo.org>
To:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] Document how we do embargoed releases - improving
 mail template
Message-ID: <robbat2-20210420T193302-520335089Z@orbis-terrarum.net>
References: <pull.917.git.1616796767.gitgitgadget@gmail.com>
 <pull.917.v2.git.1617025385.gitgitgadget@gmail.com>
 <565d7982d870fb1b7644a9777aef6be7ee174dba.1617025385.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="P5ceiwCdcSdF8Krd"
Content-Disposition: inline
In-Reply-To: <565d7982d870fb1b7644a9777aef6be7ee174dba.1617025385.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--P5ceiwCdcSdF8Krd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 29, 2021 at 01:43:04PM +0000, Johannes Schindelin via GitGitGad=
get wrote:
> Whenever we fix critical vulnerabilities, we follow some sort of
> protocol (e.g. setting a coordinated release date, keeping the fix under
> embargo until that time, coordinating with packagers and/or hosting
> sites, etc).
>=20
> Similar in spirit to `Documentation/howto/maintain-git.txt`, let's
> formalize the details in a document.
=2E..
> +Notifying the Linux distributions
> +---------------------------------
As one of the Gentoo maintainer for Git, I was wondering if the
embargoed-releases process could be tweaked slightly.

Specifically, in the embargo email, could you please publishing the
exact size & digests of the to-be-released tarballs, esp. the htmldocs &
manpages tarballs.

Gentoo, as a source-based distribution, intends users to download the
upstream tarballs (we mirror them as well), and verify the digests of
the tarballs vs a signed copy of what the digests should be.

This has meant some delay at the end of embargoed releases because we
have to wait for the official files to be available, then update the
build instructions (specifically "Manifest" which contains the matching
digests), and get that out to users.

Fields in of the Gentoo side of the digests:
name, size, digests w/ prefix.

Example:
DIST git-2.31.1.tar.xz 6413368 BLAKE2B ...  SHA512 ...
DIST git-htmldocs-2.31.1.tar.xz 1357592 BLAKE2B ...  SHA512 ...
DIST git-manpages-2.31.1.tar.xz 487784 BLAKE2B ...  SHA512 ...

The minimum set of hash algorithms for this Gentoo code right now is
BLAKE2B, which should be easy to script into the announcement mail via:
openssl dgst -blake2b512 "$FILENAME"

--=20
Robin Hugh Johnson
Gentoo Linux: Dev, Infra Lead, Foundation Treasurer
E-Mail   : robbat2@gentoo.org
GnuPG FP : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
GnuPG FP : 7D0B3CEB E9B85B1F 825BCECF EE05E6F6 A48F6136

--P5ceiwCdcSdF8Krd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iQKTBAABCgB9FiEEveu2pS8Vb98xaNkRGTlfI8WIJsQFAmB/MJJfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldEJE
RUJCNkE1MkYxNTZGREYzMTY4RDkxMTE5Mzk1RjIzQzU4ODI2QzQACgkQGTlfI8WI
JsSm2g//adnTMsYaEOq6IxkCVyCWmMuoNdu53Rz4LTZsYRGEM5cbi+L+QYvBy/NS
JcMojMtGnKn+Oj3IpYskGLIfchq9tdQz2KQg+OYxYbljeZ+b4Mu8/rjOan0bFFOk
iqeHBBNOte9bni1p/zWU9A+oC4pGqaJjhYVNMhytpAqCjLzpSp4tDxO1KuPDlBTx
pLs+HflCZwPjFcZLE0IlTbU0b259rCPmd65TMbFxDFb4duinMFbmYhXgZEWxBARZ
g2xIsckFvMdQfo2l3VbR8WpNuqWGqJk/rD8A8V404Cc0jGYzhlpueTo+DXgjF6Od
l2JpVABU9tCjht+lY/QD0srE7tHPixBbC2P+Ot8CbIh4ANw/k/7WtKW1u17ySe0I
os18XbSjhnAKsLMKf5wRVfEXOPcadBU0iMRWlK9XBIs0T6RQQ7mTgoJs+onrKAgo
uNueAG3QpHrR6K/3HgOK7lWF7C/3dd0q+UlnwHaqRXsPYPdZaSlLBVvi/NL9cyK8
XgxoFOpzouwcZ29LjceSE0yyVADBjQCBKeELppvEQ77qSsv3iH4C2wJWogPF7ML8
2b3+HJj/nL3bwl4DDuM2IE5jL2+UZPtKVYMh28ifmxjWRvxzqACXdbuvAv8ow8b7
Ees1zZfxv6RIaSH2q2YgaBiag5MFuqzw+qNn4R7uxWxe98ZNFNw=
=+Szs
-----END PGP SIGNATURE-----

--P5ceiwCdcSdF8Krd--
