Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5F1C433E0
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 21:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 261B122BEF
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 21:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbhAXVei (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jan 2021 16:34:38 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60016 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726351AbhAXVei (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 24 Jan 2021 16:34:38 -0500
Received: from camp.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id BA8DE60D01;
        Sun, 24 Jan 2021 21:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1611524037;
        bh=fF6O1cjWuZNAQDGwGFpE1IXKYIduqmJ9QwBQcfDhgD0=;
        h=Date:From:To:Subject:References:Content-Type:Content-Disposition:
         In-Reply-To:From:Reply-To:Subject:Date:To:CC:Resent-Date:
         Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=bIAMvUFg6IJQfuOvUH36D0iO4PzfrnCp13dRnolNR075wC1DxoX+B9olKTgw1qpHS
         mWsa1PMA+EBRaTsWy4LmSvM1B6nJBg/dNc2w8S1mWVO0yrlR4p307l6b2XglFouUIH
         +tCSOAH02UlaGtZAWnUuJzqV+hD984M4BZDnlmxLobxxt+W05hQbY+yJA0LdwS5bkG
         7uzgQ1+efkN7B6LdAfIM0XcLsVdT6zGC3a+yu+lNDGGPTG5Oz1kuVhijjfjQPcN8bu
         iWfCHwLxMEI/+SYsRZZg4chCFRQ27HCWA3E9uBLsJT+pHUbqz7HfN/h77+XH4t6LI+
         lMSUr0VfgVnIT+xA2/BzH0+9fTbvKqLhrfyp7Ap49YKQ9WFSQSUGMIJbqQNkMTyKGN
         t8mMZAFOVua/rFEKRvDMJy9SIhMiDSGqVrcU8R3URKli0dY8zVpJYloslAwXqrrs3K
         uAFlIlwth7spRU0PHTY+/8Z67amm34Oj4t+OCw0SaCz6JkRt62K
Date:   Sun, 24 Jan 2021 21:33:52 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     brooke@alchemists.io, git@vger.kernel.org
Subject: Re: How to Verify Git GPG Signed Downloads?
Message-ID: <YA3nwFcYz4tbhrlO@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        brooke@alchemists.io, git@vger.kernel.org
References: <B6DFB74D-A722-4DBD-A4B2-562604B21CCB@alchemists.io>
 <022601d6f27a$58a97200$09fc5600$@pdinc.us>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4/xa2m1/XgTUXFF4"
Content-Disposition: inline
In-Reply-To: <022601d6f27a$58a97200$09fc5600$@pdinc.us>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--4/xa2m1/XgTUXFF4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-01-24 at 17:57:13, Jason Pyeron wrote:
> $ gpg --recv-keys 96AFE6CB
> gpg: requesting key 96AFE6CB from hkp server keys.gnupg.net
> gpg: key 713660A7: "Junio C Hamano <gitster@pobox.com>" 59 new signatures
> gpg: key 713660A7: "Junio C Hamano <gitster@pobox.com>" 2 new subkeys
> gpg: no ultimately trusted keys found
> gpg: Total number processed: 1
> gpg:            new subkeys: 2
> gpg:         new signatures: 59
>=20
> $ gpg --verify -v git-2.30.0.tar.sign git-2.30.0.tar.gz
> gpg: Signature made Mon Dec 28 01:12:30 2020 EST using RSA key ID 96AFE6CB
> gpg: NOTE: signature key 96AFE6CB expired Sun Jul 26 13:41:24 2020 EDT
> gpg: NOTE: signature key B3F7CAC9 expired Sun Jul 26 13:41:42 2020 EDT
> gpg: using subkey 96AFE6CB instead of primary key 713660A7
> gpg: NOTE: signature key 96AFE6CB expired Sun Jul 26 13:41:24 2020 EDT
> gpg: NOTE: signature key 96AFE6CB expired Sun Jul 26 13:41:24 2020 EDT
> gpg: NOTE: signature key B3F7CAC9 expired Sun Jul 26 13:41:42 2020 EDT
> gpg: using PGP trust model
> gpg: BAD signature from "Junio C Hamano <gitster@pobox.com>"
> gpg: binary signature, digest algorithm SHA256

The signature is bad because it's over the uncompressed .tar, not the
=2Etar.gz.  There is also a .tar.xz and the signature is the same.  You
therefore need to uncompress it first with gunzip.

> $ gpg --list-keys -v 96AFE6CB
> gpg: using PGP trust model
> gpg: NOTE: signature key 96AFE6CB expired Sun Jul 26 13:41:24 2020 EDT
> gpg: NOTE: signature key B3F7CAC9 expired Sun Jul 26 13:41:42 2020 EDT
> pub   4096R/713660A7 2011-10-01
> uid                  Junio C Hamano <gitster@pobox.com>
> uid                  Junio C Hamano <junio@pobox.com>
> uid                  Junio C Hamano <jch@google.com>
> sub   4096R/96AFE6CB 2011-10-03 [expired: 2020-07-26]
> sub   4096R/833262C4 2011-10-01
> sub   4096R/B3F7CAC9 2014-09-20 [expired: 2020-07-26]
>=20
> It is possible that Junio forgot to push his refreshed public key.

Yes, I think that's the case.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--4/xa2m1/XgTUXFF4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYA3nwAAKCRB8DEliiIei
gS17AQDJKT2rqjJwJjXmD01Cbn/LHok3QCSpNDWuolOqszgB3wEAxPzjczrdDRAK
afQ+7Ib0tBjCRPK2rWL+dKMNDOtR4Q8=
=CQN1
-----END PGP SIGNATURE-----

--4/xa2m1/XgTUXFF4--
