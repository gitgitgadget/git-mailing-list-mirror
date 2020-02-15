Return-Path: <SRS0=Fd5/=4D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E1BC35242
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 03:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 847E72082F
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 03:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="HbRUNNyC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbgBOC4t (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 21:56:49 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33098 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726861AbgBOC4t (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 14 Feb 2020 21:56:49 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 79FF060791;
        Sat, 15 Feb 2020 02:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1581735407;
        bh=imAzQZC1dN1akqiPCKpMbuBJIhE5hYI9ur2SQF7ySAE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=HbRUNNyC7DgBi7SPvm9xIy7gBkFKVBYAMlQhCZEz2BAaJ2tdziPSW4Dagt54fFB3P
         vTgOZ3TWKERALQL8Mh62478sQLWrIriyuP/c9watoE2UlaaeK5H/xddJ607YEJUvyw
         g8cTfyEu/zQytkSZfa+YsKt85xa6DqymYZXH5yOqsWjZtQhJmCMX6GtY45IsW5jQpl
         HVtVgmYq1qhmidHMMyOakliuQ/abC0ROD6YXjkkrDPh4PdoGuGAw/3V4APOgNrk/tp
         hHkY7X2oOlacBVA7a1Vo3OWzrs6Eb4VQzLN13iiuP9wHTAEYJrcEFldDDpv879mG9K
         1pFlYoxc4ZhhZVggSliSATVJTZ0s65DkO+HHo9m7y31uXuYxkPGIrfILDa2L4Pmx0I
         p4RFIzqAqe1rI1RE/K2nHpxPr/MTuf0zCEEJDtAvFj0de4jPO5FjJ/36IYLwKYX15a
         9ylreMMtNzte8Wgrl3Yn2s661L/3McRlgQ4M4MABhVDH137+b6+
Date:   Sat, 15 Feb 2020 02:56:42 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH v2] prefix_path: show gitdir when arg is outside repo
Message-ID: <20200215025642.GC6134@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
References: <20200214232933.243520-1-emilyshaffer@google.com>
 <20200215010013.190528-1-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WfZ7S8PLGjBY9Voh"
Content-Disposition: inline
In-Reply-To: <20200215010013.190528-1-emilyshaffer@google.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.4.0-4-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--WfZ7S8PLGjBY9Voh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-02-15 at 01:00:13, Emily Shaffer wrote:
> When developing a script, it can be painful to understand why Git thinks
> something is outside the current repo, if the current repo isn't what
> the user thinks it is. Since this can be tricky to diagnose, especially
> in cases like submodules or nested worktrees, let's give the user a hint
> about which repository is offended about that path.
>=20
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>

This looks good to me.  Thanks for this improvement.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--WfZ7S8PLGjBY9Voh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl5HXeoACgkQv1NdgR9S
9ot8SQ/+IiIfbi9XgN8513cxywHRX7zf83nIsn27So5adVht8lvPApzbTVytegMt
34xtbUMWxJskCupfCNM3uhrRt41+obCDIlen/+/qnzt9UdWfFOr6V9qiBxX0XMow
jYTK7RgkKHaCcuaosaCcqoTqK8fCMFsPcpkiLaUrgyBLbbgAxYJtTu7jR0jKNQPm
cGAA2CIuK+Fdg06P1QJtqIwSe6qLTkYqyM0suL5nc1EBLt9ATk57699jo2SggjRz
YyrBFZFpSRvMlq9iDA9gyveK+W6H//MLkEmBHrFbSiG1tY+raisx8v4L1bIWz/+u
EDICujCoJkaoVZU0mnJaOzHpP/k1sD7gYCvIhIUwbe/+XEniZXCAdOoslclDQzH0
yy96Y8UQdhsrFU1146sCyphezXFV1eDhKGSwDpjuVh8mBnXOm7uhYe7/YyycEh5u
PEXz9kuO0t08Y07ZBtgrr7GHeTVFotcd93oc6qKP/yUQ00fVfUHYX5c8I4vn2Evu
IrH0RCbM0GUzG6QSNgwow3fhdpdqFBIWC5Zw/cLVCPMps/ik0keSFJ5vi2UODlmC
fM7ElqBfRyP34Y8I1Ti6jHHyeGic7lpzJ5vhKBNd7xwtL6Q9RTK1dBynAPtjPjwO
MkVf8IgLEvUN2z9ALkKwS4sF4yB9GfgftP4fM1fL3px0WY+PIU4=
=dCKv
-----END PGP SIGNATURE-----

--WfZ7S8PLGjBY9Voh--
