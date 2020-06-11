Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B6EC433DF
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 23:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFFBE20842
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 23:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="kxuMUlUt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgFKXqU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 19:46:20 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39262 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726305AbgFKXqT (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 11 Jun 2020 19:46:19 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A8E506048A;
        Thu, 11 Jun 2020 23:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1591919178;
        bh=zmf+7UEt/LLjLQPAWFfcZYBZbGaYNZaU0Hpa/EFT7Ts=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=kxuMUlUtKOLTb0O79tW8TchVbkyjXnljpxHPbKZ1njfctjB18XJj7O2EloLfU44BB
         a98RZGIAxWsOCYJfQVfngN5p8w9BcR3zSfiacG3xMaO8/DA7U7dq1pQ2zd0mLz1Ku8
         HmYaTWO/xE82SmuIR3toDkKS/CiRPm0HcWQTCxuOGGFpJYdbYD1vR+Q6NQUkuYZKL8
         EkrwrRDvUIlHNaDgDB44sOQkJTY9ePLJb/bGdzS0rzlm4CnquioWPlGPGScVpRyDnt
         /PTRrhUKdmAGPfD1cHmintAuEaBQddkO48rQM5najm5JMzGqwmJyinWfAnnibhHBzH
         nrMR7DmuTZHLCA3VKYipW7C95o2CZv2+0Vi803Y0K2Ka1V6p2C8mUpXKHImY9vj9aR
         D14zNmvPaU7KnbEp2z9ykPq+1Xpwvu5rTjLMFaOELIPdi6VDGI3lAY4ucca/EIHXbE
         uXaQJ5tR1IestlkRj3qC3qcwwR6l1vDvnyCIiRbiDBGgsy/PHdQ
Date:   Thu, 11 Jun 2020 23:46:11 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Don Goodman-Wilson via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        peff@peff.net, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/9] init: allow overriding the default branch name for
 new repositories
Message-ID: <20200611234611.GA6569@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Don Goodman-Wilson via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        peff@peff.net, Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
 <90912e32da1192cfc3b39a18cb606caa46e85b1c.1591823971.git.gitgitgadget@gmail.com>
 <08e46af3-ff52-8bce-b75a-db8c390c9641@gmail.com>
 <xmqqwo4di49l.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YLwdFo+Xu6B7B0Yp"
Content-Disposition: inline
In-Reply-To: <xmqqwo4di49l.fsf@gitster.c.googlers.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-2-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--YLwdFo+Xu6B7B0Yp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-06-11 at 23:14:46, Junio C Hamano wrote:
> Alban Gruin <alban.gruin@gmail.com> writes:
>=20
> > Why adding yet another environment variable instead of relying only on a
> > config option?  I understand it's for the tests, but can't we add a
> > shell function in test-lib.sh (and friends) that tries to read
> > `GIT_TEST_DEFAULT_BRANCH_NAME', and, if it exists, sets
> > `core.defaultBranchName'?
>=20
> Can you produce such a patch that does it cleanly?  My knee jerk
> reaction is that I would suspect that you end up having to touch
> many places in the t/ scripts, but if you prove otherwise, that
> would certainly be appreciated.
>=20
> And no,=20
>=20
>     git () { command git -c core.defaultBranchName=3Dmaster "$@" }
>=20
> is not an acceptable solution.

I would also be delighted to see such a solution, but my experience with
the SHA-256 work tells me there's unlikely to be one.  We do a lot of
"git init" operations in random places in the test suite and as a
consequence it's very hard to make a change without touching a large
number of tests.

If we were writing things today, perhaps we would use a function (e.g.,
test_init_repo or such) to wrap this case, but we unfortunately didn't
think about that and we're stuck with what we have now unless someone
retrofits the test suite.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--YLwdFo+Xu6B7B0Yp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXuLCQwAKCRB8DEliiIei
gfboAPwPOWvrtndE4Tf6OyE/Dlrn0w0VVNPWD6Wbo2G/I/jVHwD/QkWS8+mUYFKb
f/yZFjgAyHz+el1vM15ysxgSkrQo6Qk=
=SFrp
-----END PGP SIGNATURE-----

--YLwdFo+Xu6B7B0Yp--
