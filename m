Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38558C07E96
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 17:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A9D961625
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 17:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbhGHREq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Jul 2021 13:04:46 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38564 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229580AbhGHREq (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 8 Jul 2021 13:04:46 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id AB1396044E;
        Thu,  8 Jul 2021 17:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1625763693;
        bh=+++C0DWwfBrUbCDJPlBvLDXDfL2Z1xModDHx79ePqx0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=uSFmpQguXeK7XqgjI31EGeL38IPWPTn0GoKgs2jQOHaTsvvYt9oxEkPPyeiS4Tgv9
         2fF91cUnbMBEaxsmNQAsPp+M579tzLZ/gd/9wf8RRAsf6c7KSXez2unncz4lftD+Rb
         dH2L5RXtFLN9zid+bIHemuAKSyS7cDi1MO/AMgjgPnHU7whbSk4k1MNcwSdfu0qT1p
         tAd3wQi7bmtxxbEV4lx7eg7oPrSUEyjHRwAzQqvdI41X8xRhkCE34H/GabnGejb9xO
         eEPoWZxYnHB1pdyz4nTQN68y+Pt2j0EWdoh4YIN8qa3mtcMs2vsnu3YGPiptMCnPim
         Sk/9zEaxJrgN857Ygt5TtyrPsy+kjHNZXJRiBJiQ5+vMleiNWuFK1z504Shyrrsce1
         0/dMLF/s34fnCGKNoTNioK43c9R8Ygo4QFZfZTQgVscQO+PWkjsiPKVKSqjADAabGV
         YxgfDhYeoc/rrabmKCp1x7XMyzK+PP/+z6Hxr2ZjFUe31XBIiqs
Date:   Thu, 8 Jul 2021 17:01:28 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH] revision: allow pseudo options after --end-of-options
Message-ID: <YOcvaFL7+6qcIOUa@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jiang Xin <worldhello.net@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
References: <20210708150316.10855-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vg7WZT31QIepS3gY"
Content-Disposition: inline
In-Reply-To: <20210708150316.10855-1-worldhello.net@gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--vg7WZT31QIepS3gY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-07-08 at 15:03:16, Jiang Xin wrote:
> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>=20
> Options and revisions can be seperated by the option "--end-of-options"
> by introducing commit 19e8789b23 (revision: allow --end-of-options to
> end option parsing, 2019-08-06).  The following command will show
> revisions which have changes on file "bar" on a branch named "--foo":
>=20
>     git rev-list --oneline --end-of-options --foo -- bar
>=20
> If we want to see revisions between two revisions (rev1 and rev2), we
> can use the following command:
>=20
>     git rev-list --oneline --end-of-options rev1..rev2 --
>=20
> We know that "rev1..rev2" is a shorthand for "rev2 --not rev1", but
> we can not use the longer expression with option "--not" after the
> "--end-of-options" option.  This is because the parser will not consume
> revision pseudo options after seeing "--end-of-option".
>=20
> Allow parsing revision pseudo options after "--end-of-options", the
> following command is valid:
>=20
>     git rev-list --oneline --end-of-options rev2 --not rev2 --

I don't think we want to do this.  The goal of --end-of-options is to
prevent parsing all future items as options, so if someone specifies a
revision starting with a dash, we don't end up with it being interpreted
as an option.

Removing this constraint could end up resulting in potential security
issues, which this option was introduced to protect against.

If you want to specify this form, you can write this:

  git rev-list --oneline refs/heads/rev2 --not refs/heads/rev1
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--vg7WZT31QIepS3gY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYOcvZwAKCRB8DEliiIei
gYWzAP9u9srHfo40K0VMTUHBXd21zu6l/yETSGQbyBU0pzzCngEAkzwXtWCp0Z7q
jmH8HJe5LTXXByAYUvi6l1dh6YyF6gQ=
=S92s
-----END PGP SIGNATURE-----

--vg7WZT31QIepS3gY--
