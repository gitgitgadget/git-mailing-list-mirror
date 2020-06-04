Return-Path: <SRS0=8h89=7R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA16EC433E0
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 23:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D0AD2075B
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 23:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="AA66OcOl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbgFDXlw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Jun 2020 19:41:52 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39002 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725863AbgFDXlw (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 4 Jun 2020 19:41:52 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E03B36077B;
        Thu,  4 Jun 2020 23:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1591314111;
        bh=RQHNRqjLFYI4zA9nLecIUq3iEtrcPCUdOdZCPthW+14=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=AA66OcOlM4k4UOogICqYapRP/q46Ed5KZGr/b6evkvx9LY7pDX6x9JALY4d67/oho
         KehgcQRBo7RO/Ehc+Rn/2htDETXK85BPwDxnBKWBSqSLT8baU0pOaei41jar8R7Mnt
         emdMCHGjONr1aY6pRa4Dttbm/r0+AyuYQGN7t59av+2CDiBpn2jka6hyrSpOVi1xQp
         Yv4RDpSPYd22hnoH9rsJz0s25JRsHqfNqAbeDRPTWN9kOnmRWBcLfvIhpW+RHn4Rca
         M7rnDQJp8syPPKjSyVdmiA+M50+QGAswgxvk6PlrMFUj5036+fsQq2y3ODy/20vtj0
         neTWOOclveAPv/EmJoWF+lzbIcxlUEKV2iJGmr50pM9hJSjedWBwP0I4iwC3eichS+
         GQTAn1PFuzA0QTGDFSEyT4tVkLlTqHBUQEBwk64l48oHAUtRq2DaqEioT+Ku2oeZqd
         GrSxQrHIPGENwdQlJ1g5ymdUSzs9hb8Av+fWvFgzEYkjEYFGwyh
Date:   Thu, 4 Jun 2020 23:41:45 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2020, #01; Wed, 3)
Message-ID: <20200604234145.GA6569@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqlfl3rhl0.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
In-Reply-To: <xmqqlfl3rhl0.fsf@gitster.c.googlers.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-2-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-06-03 at 20:59:39, Junio C Hamano wrote:
> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.  The ones marked with '.' do not appear in any of
> the integration branches, but I am still holding onto them.
>=20
> Git 2.27 has been tagged, and the first batch of topics (including
> the "throw protocol v2 to the experimental group of features" thing)
> have been merged to the 'master' branch.  I'm planning to rewind the
> tip of 'next' in a not-so-distant future.
>=20
> Seeing a handful of regression reports [*] immediately after a
> feature release is made gives me a mixed feeling: people are eager
> enough to help by reporting issues they encounter, but there are not
> enough people who are eager enough to help by testing the tip of
> 'master' before the release.  Are there things we can do to help
> them become early adopters so that they do not have to scramble
> after the release?

For folks that are using Debian, Jonathan Nieder kindly keeps Debian
experimental generally within about a week or so of the latest next
(with the -rc merged into it during that period).  (As of today, the
version is from 2020-05-31.)  This is usually what I use and it's
reasonably stable, so folks who want to test things may find it
convenient to rely on existing packages.

I don't happen to use a lot of these features, so I don't notice any
issues with them, but I have seen issues in the past with other features
and reported them.  Maybe if there are companies with folks who are
using sparse-checkout and similar features it may be helpful to build
and deploy an -rc or two if they have some way of standard deployments
to developer machines (which I admit most places don't).
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXtmGuAAKCRB8DEliiIei
gZfcAP44uqLYTWTIMCtCYbtzfnzLSmLq8o+VzBB99VP3s8UoyAD/aezwhfP1LUaj
Ejq5yeVUd7Ij+/542FetvOE62tiLwQE=
=ZFXr
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
