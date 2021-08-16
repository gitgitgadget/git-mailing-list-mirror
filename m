Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8FBC4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 21:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD06460F41
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 21:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbhHPVvm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 17:51:42 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:44350 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229987AbhHPVvl (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 16 Aug 2021 17:51:41 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6F15760752;
        Mon, 16 Aug 2021 21:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1629150639;
        bh=aHtMuPqug7ML+svk0KVAJR9p8UDwXCSBtV4VtSrInlM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=KRv9ZSkdjk5zGm3jNV0IcWQwR5BNKkaX83KN6eoLWBBaoLewAWPtsvgCmV16ZrEK2
         Ql3CJYKMxhQwZaOaoSMeT0nCJRsk1jU5cXvlCXJu6C+tL3BFzuH81U/SoWqIynYhHv
         Zf1ML8WbbllZLBevE8ZKRqeG+7R+QoWXnEZT/udrjcU9QlW/Z2hdBhleVqeHn/UE47
         Q8jckJr5ZJXrgBvdCrjeNXWjR8d/5vHVcn455wZBYd8D5k9n6wqGN1VvFg41RKc8rA
         eiSWCvEZXm81IPwsGbd4uMLUUULrctCqvDmzNYWlhmaQ9k2RcrSzPleWKk8QSyjIOc
         yZsyFBgnAAX87TQzrQvsR2iWGNy4DLCg6Q2iQNApP6cO108jGD8j186LSPUJYA6d9O
         wSW6D6NilkgXr04PeglVyF9gnUsG/zt2jCb8jXjV2ZRHOdKlMZAbjsFbnJvnhhcPcq
         Zqsad1ywwhG4ZyoCo7KX/CCYExTmZQfHfIyo3jqkBlhI6kux39s
Date:   Mon, 16 Aug 2021 21:50:35 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     "Russell, Scott" <Scott.Russell2@ncr.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git clone corrupts file.
Message-ID: <YRrdq5VAp3o35+Fb@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        "Russell, Scott" <Scott.Russell2@ncr.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <BN6PR15MB1426E50F03A0530CA9140F98CBFA9@BN6PR15MB1426.namprd15.prod.outlook.com>
 <BN6PR15MB14261C40E614CC11416388B4CBFA9@BN6PR15MB1426.namprd15.prod.outlook.com>
 <BN6PR15MB14264C9A96F4B5F6B01FA7FACBFA9@BN6PR15MB1426.namprd15.prod.outlook.com>
 <YRbya0UO2+PvOjL5@camp.crustytoothpaste.net>
 <BN6PR15MB1426E99386269CCBDA888D51CBFD9@BN6PR15MB1426.namprd15.prod.outlook.com>
 <YRqYD+SszvhhySwl@coredump.intra.peff.net>
 <YRqzmC5ubd0TEWL/@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SI0QB7nfVOzc+lBM"
Content-Disposition: inline
In-Reply-To: <YRqzmC5ubd0TEWL/@coredump.intra.peff.net>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--SI0QB7nfVOzc+lBM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-08-16 at 18:51:04, Jeff King wrote:
> On Mon, Aug 16, 2021 at 12:53:36PM -0400, Jeff King wrote:
>=20
> > But an alternative workflow, if you really want UTF-16 in the working
> > tree, is to convert between UTF-8 and UTF-16 as the files go in and out
> > o the working tree. There's no built-in support for that, but you could
> > do it with a custom clean/smudge filter. That would let Git store UTF-8
> > internally, do diffs, etc.
>=20
> Oh, by the way, I totally forgot that we added an internal version of
> this, which is easier to configure and much more efficient. See the
> "working-tree-encoding" attribute in "git help attributes".
>=20
> Just in case you do want to go that route.

The specific information you need is located in the Git FAQ[0], but
roughly, you would probably want something like this:

*.h text lf=3Dcrlf working-tree-encoding=3DUTF-16LE-BOM

That means that when checked out, the file will be in the format that
legacy Windows programs prefer (CRLF with little-endian UTF-16 with a
BOM), but will be stored internally in Git with LF and UTF-8.  That will
make things like git diff work much better, but still permit things to
be in the working tree as you wish.

If you really don't want those to be modified at all, then you'd want to
write this:

*.h -text

However, Git will consider these files to be binary, since they are, and
git diff won't work on them without a textconv filter.

[0] https://git-scm.com/docs/gitfaq#windows-text-binary
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--SI0QB7nfVOzc+lBM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYRrdqQAKCRB8DEliiIei
gdiuAP9hiwQFAuPz7VjtTF/zXWcI9tF3OeJ2oWhycyTKePPW3AEApWlug1umsJGt
Lvx0TjeFmF0a2SPD5qyiXjUn7t91zwc=
=9jSu
-----END PGP SIGNATURE-----

--SI0QB7nfVOzc+lBM--
