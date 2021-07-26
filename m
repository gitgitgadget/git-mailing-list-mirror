Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36642C4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 22:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B28160F6E
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 22:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbhGZV3B (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 17:29:01 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40478 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232875AbhGZV3B (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 26 Jul 2021 17:29:01 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E417260769;
        Mon, 26 Jul 2021 22:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1627337369;
        bh=UhKmh3Gkph83+R9sZlCnLMIR+Xkwi9Hd32BO4UhbpDU=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=RaFo6gZtfXRh8ZpDvnSinR8UpmtiEBEJYd9Ehz8WOY6z/RqKMoBdtDCE1MsBkzKVR
         TV3Yn8xCLc2gsSDRPydBZ1WonFZ7fvGdrn/DNt9zlpQXAvjbUwEv43MdZDTU9UgeTg
         5/19oO0HgLKLGr1akexy7L81kedFztytiNukmzcEFO8zEKab+n9ZBODvfglTqWQlj4
         fyeNprUe4ZFov1nt5GlozpLg9RI6FeUudB3udKJ+x7oLxkDY7vLW+CfkiTMZQrSXAg
         C6euONB+niqCmxUNwS5Cxg8+TuaUUgYZN1GZlyniiHmbzk1cpsj8trHVctR+6HdvCy
         sEhCZ9HZRzcS+F5HyDMnKhgtRDOUoFyZutZs9O+z4b+iyGvHignXFLPFCr6xdUFaD4
         0e2TwSjTOJNzNgwe1BH36hsb8Nf0YkI/5yMwI8hGM/WPSw3I3r+Dji0do5p1Dov7us
         Yzlwc2pUvWpG8KHuXdFvXPZ1ZZCtm6/d8qMtIHx4JFvdMvftX9x
Date:   Mon, 26 Jul 2021 22:09:22 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Evan Miller <emmiller@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Exit code 255 after large clone (32-bit PowerPC)
Message-ID: <YP8ykvsZie4mPE5o@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Evan Miller <emmiller@gmail.com>, git@vger.kernel.org
References: <D3C1583B-8CC8-434B-8AF5-B9827A7FD037@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zLbPPyh9Ltbh4gxQ"
Content-Disposition: inline
In-Reply-To: <D3C1583B-8CC8-434B-8AF5-B9827A7FD037@gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--zLbPPyh9Ltbh4gxQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-07-26 at 17:54:07, Evan Miller wrote:
> What did you do before the bug happened? (Steps to reproduce your issue)
>=20
> $ git clone -v git@github.com:macports/macports-ports.git
> Cloning into 'macports-ports'...
> remote: Enumerating objects: 1223319, done.
> remote: Counting objects: 100% (685/685), done.
> remote: Compressing objects: 100% (341/341), done.
> remote: Total 1223319 (delta 289), reused 608 (delta 252), pack-reused 12=
22634
> Receiving objects: 100% (1223319/1223319), 244.46 MiB | 1.09 MiB/s, done.
> Connection to github.com closed by remote host.

This message is the relevant detail here.  This means that the
connection was reset, which could be due to the remote host (GitHub),
but is more likely due to a network issue of some sort.  You'll have to
do normal network troubleshooting to see why that might be.

It could very well be related to the fact that you're running a nearly
14-year old operating system, but I just can't say for certain.  It's
not a bug in Git, however.

Even if the data is otherwise transferred successfully, Git will exit
unsuccessfully if this happens, and that will result in your data not
being checked out.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--zLbPPyh9Ltbh4gxQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYP8ykQAKCRB8DEliiIei
gbdFAQDOvNWUZijdTbuu16mSJsXWLLclhMSgXiHk6T6xLCG02wD/XbDNqCnyKwYC
jcoT5ocA16fGXofodqe2Ugfy7vziuAQ=
=0TSL
-----END PGP SIGNATURE-----

--zLbPPyh9Ltbh4gxQ--
