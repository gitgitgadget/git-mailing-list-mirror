Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B9541F85E
	for <e@80x24.org>; Fri, 13 Jul 2018 18:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731428AbeGMS2S (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 14:28:18 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57356 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731119AbeGMS2R (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 13 Jul 2018 14:28:17 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:5996:38d5:9b31:ef84])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A083B6073B;
        Fri, 13 Jul 2018 18:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1531505553;
        bh=cFSuJo+rvVSaD0mk8NxClVLzMtnLoi3ulrzbbKjkRV4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=TiuIhA+6bVb+j9LXXu9lpObL2n4Zh7wALYNrSmsoiVuEIFeRr9/HUZUriAPnE9k2b
         RUJMJDZYcFGFqM7uCwkBEkjdB2/KQZZtKwBXibV/kKQNlGKNRGDz8k2TFOcfgqyRxt
         hJge/yqbMyMSMpFIt2MKfQp8Xd+yazo7qiHsV8+s+M23pSpfeUBdbDsRJIgpxJRAlj
         3yDTz1wGbSLegSBs/Iv+KylSDZvQpeGiWcTY1KxJXS8k7BUEVV047174cH8di/0gqf
         UzmcPcr+sw1huxJCiJEd25d0VJwkaG6MUpj+gOmTLQ+VY9TDh9Gjjd8PfWKT52LsY7
         A8gp8+YMu8PBxNABxxn2U66RrQ/Ugzg5aES0DRfdC8EqRn00BrglBn2MpNDvlwPOU0
         MCF31rYYbVOxT7oencKOKWAavB7jr2ryI8nqLkTAiJjx8frCyMqIn/OsKxHR5oRtW9
         k1pvefjGJ68gYEq1+kv+lFli93PF2TRmh5VK5BFtsdv9+w/5ILi
Date:   Fri, 13 Jul 2018 18:12:28 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Ben Peart <Ben.Peart@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "peff@peff.net" <peff@peff.net>,
        "stolee@gmail.com" <stolee@gmail.com>
Subject: Re: [PATCH v2] convert log_ref_write_fd() to use strbuf
Message-ID: <20180713181228.GB968742@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "peff@peff.net" <peff@peff.net>,
        "stolee@gmail.com" <stolee@gmail.com>
References: <20180710182000.21404-1-benpeart@microsoft.com>
 <20180710210806.23384-1-benpeart@microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="U+BazGySraz5kW0T"
Content-Disposition: inline
In-Reply-To: <20180710210806.23384-1-benpeart@microsoft.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--U+BazGySraz5kW0T
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 10, 2018 at 09:08:22PM +0000, Ben Peart wrote:
> Since we don't care about how many bytes were written, simplify the return
> value logic.
>=20
> log_ref_write_fd() was written long before strbuf was fleshed out. Remove
> the old manual buffer management code and replace it with strbuf(). Also
> update copy_reflog_msg() which is called only by log_ref_write_fd() to use
> strbuf as it keeps things consistent.
>=20
> Signed-off-by: Ben Peart <Ben.Peart@microsoft.com>

This looks good to me.  Thanks for the patch.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--U+BazGySraz5kW0T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.8 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAltI64wACgkQv1NdgR9S
9oupuA/+JrBSOwR/oC/4XotLBou9UiaDZYBlH3uSgXNzRsY9kB+m3IXpqPP7SJPn
bytHwLnTaVsstgO5Cro264+ybs4fpQRgtiZv3XwoVJ+td1Co0Q5yecKefdr7C4gi
Zuwo830r+0aPzG7piPQEdsHbdY0x5A4/98qZ/s/Y27+jkCPCjs98AabR0B3Rhw+E
vZxkCXmyte3dKeWmY/xU2wwH7eE+13l2J9J1gF/0QTlaESGdxWhjVXw5CevtzLoX
8Y8Z94juSHVDLCK3YLZ2VdFchR6qHQzVuSpo67kLwDqlFgMLVI5qc+snLHtG6QVZ
V0tJCKsWCiGZo2fe1SYPlTF4rCwn1y13d+DAXcecWbARkIlowRPpHvIK1EYt8RYq
MslS4vtDYULRI40I6S+TiqpJJwW6/zsfCGkrtaj16ZC8ohBD+FOTZN4neFUiLh5m
FkzOjnfCYFqRQa7lkUo68mEkAiGf8s25UuSPyY2eTMdnca/FQNIJMQ3qzkZsI/nR
NTTT7yIaiIKtD00K0uIQHfiHJSMttS5yq+yIKl+CeF9giBDTQPWk0kcg1R7Qzsp2
X3mGbiIgaylx3tbi6aWaHAUcJVMaTiuZaSOtw59O/yTAvgkEcggu/k/keHjwudgI
qrn/9ji1CtFZsHmFc4EdOCVIIf9eBRBr/Ro9NVviNxo8qz6z0sk=
=Tomc
-----END PGP SIGNATURE-----

--U+BazGySraz5kW0T--
