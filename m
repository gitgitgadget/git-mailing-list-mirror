Return-Path: <SRS0=cWmm=5W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B03F2C2BA17
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 03:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72A7F20738
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 03:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="BLhe3klU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgDFDEv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Apr 2020 23:04:51 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:51572 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726436AbgDFDEv (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 5 Apr 2020 23:04:51 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B5C9760734;
        Mon,  6 Apr 2020 03:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1586142290;
        bh=P0dcGpyYqhKV5HarHqUK8KzWASOWEytgfGi5k/6n4jk=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=BLhe3klUViFA6lDwJY8q7cl89wTwDL26FPggxY2XXDwWloKSC04ZO1P+vNsT9czGD
         Q7dIW9Ke1Z/1FP/wdm00ORx8ysl99egWQoNwqioX0iaDtz9P4AqLh+Yzh4PaVfh/an
         RU76vBxWu9QPXeqkHEiclDrQJ5z12NrZCyjPNnXJAafzTH7Xn6udPgjVB2jQdBXTRh
         K4cLub9q4Q6U4U5q2tZmn9f7knCVUW0Sz+dv+463s6mCCBFYhSLN8NKdZtmOecgFqr
         Bl0gEyVLqZjVzy3YPK2O+lNrAyycGDLGd9xgwTRK3HQSFjWYQXcQf/TlGtY6uaMQAF
         wOGL6G+JHaEjgb6n0hqKSxR3om/EpURKp6u+q6cT2TEu6auBCRlOx036J9pC4UDu55
         JqtHZZntcCmR1W8905lj6jdg2Y/v0xY4etOGUWsHwIVAra77Ty5TGAeMg7SBp2wxYL
         3CG7QTZZqcvMQusoLfUezf2sw/BWENU3o1+Wazk3fPcycpZTLsg
Date:   Mon, 6 Apr 2020 03:04:44 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Emma Brooks <me@pluvano.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] format-patch: teach --no-encode-headers
Message-ID: <20200406030444.GG6369@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Emma Brooks <me@pluvano.com>, git@vger.kernel.org,
        Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>
References: <20200405231109.8249-1-me@pluvano.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2NLGdgz3UMHa/lqP"
Content-Disposition: inline
In-Reply-To: <20200405231109.8249-1-me@pluvano.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.4.0-4-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--2NLGdgz3UMHa/lqP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-04-05 at 23:11:09, Emma Brooks wrote:
> When commit subjects or authors have non-ASCII characters, git
> format-patch Q-encodes them so they can be safely sent over email.
> However, if the patch transfer method is something other than email (web
> review tools, sneakernet), this only serves to make the patch metadata
> harder to read without first applying it (unless you can decode RFC 2047
> in your head). git am as well as some email software supports
> non-Q-encoded mail as described in RFC 6531.

Do we always output UTF-8 in this case, or do we sometimes output other
encodings if the user has specified one for the commit message?  Do we
know how git send-email handles such a message if it receives one?

I know it isn't your intention to work with git send-email in this
patch, but it would be nice to know whether there's additional value in
someone sending a followup patch to make git send-email use SMTPUTF8 if
that's necessary.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--2NLGdgz3UMHa/lqP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXoqcSwAKCRB8DEliiIei
gWn+AP4wGR34bGnBIbrHncVxZ9fq9rMzGXl/5+4aYGI9CPeKUQD/a0RFA4qSOCfJ
IAthQF/wqdk4CvAAK4Uog4Euyz6eXgc=
=McLT
-----END PGP SIGNATURE-----

--2NLGdgz3UMHa/lqP--
