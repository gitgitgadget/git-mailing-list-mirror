Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFC0C433E1
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 20:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E765A20768
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 20:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="si9E5t1I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgHNUPY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 16:15:24 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41536 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727794AbgHNUPX (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 14 Aug 2020 16:15:23 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3FA1A60456;
        Fri, 14 Aug 2020 20:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1597436092;
        bh=yLBHbKN0x+4L6IR1anCjg3VZxuiGe41Lb27OoCabj1E=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=si9E5t1Iy6ve5SUOaQsA4g/T64U+wfQNG/X6Hb1JIai7zlHuRa5gxUU781AXz1kX9
         LIItrnZ10Ai/tEmqROxaXXTCWmZZ1QqqYVhVLyQA1X/yaOEg2uR0bCAk81Fb/OOrPv
         PZUBnExCZF496dmGvY1IfXc8mtYpV20jqvDl0aqVSP7rAu2wPSIOyWwnNnRZEvUsT3
         gukN1bxEEzdAnS1Bz2cQxlLboHKr6KyTewIjOQriB2lt8OdUynp59X+xswW5DWwJAE
         jC8K45Whg02HIFWThP0daK8F8D4vS77E4a8xHIvroO7kq536FZWmnwksZFUkbPUw1W
         qhuCV0zuG3Jj4F5ovgq5xT2dr4UMJPd5z4u3+Z6ud9X5VAaT7BufbG3qas9JKJ88Lh
         Ky/FI1Jv9Xx2m3aJtaTL/1564naNwAl/uMzgCS7DSa+yachy+UGjpSLMg/9lumpBn3
         M+lUcbbkVhlDOUrLNfN768mHvcwkTY4l0PHEizFxk/1xDMHkyKk
Date:   Fri, 14 Aug 2020 20:14:48 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, martin.agren@gmail.com, me@ttaylorr.com,
        abhishekkumar8222@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 3/3] multi-pack-index: use hash version byte
Message-ID: <20200814201448.GL8085@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, martin.agren@gmail.com, me@ttaylorr.com,
        abhishekkumar8222@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.703.git.1597428440.gitgitgadget@gmail.com>
 <b4645789adf26e46cea721896867135941fb7654.1597428440.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ucfHZChuBC0NsER/"
Content-Disposition: inline
In-Reply-To: <b4645789adf26e46cea721896867135941fb7654.1597428440.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ucfHZChuBC0NsER/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-08-14 at 18:07:20, Derrick Stolee via GitGitGadget wrote:
> diff --git a/midx.c b/midx.c
> index a5fb797ede..0c165a40f5 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -17,7 +17,6 @@
>  #define MIDX_BYTE_HASH_VERSION 5
>  #define MIDX_BYTE_NUM_CHUNKS 6
>  #define MIDX_BYTE_NUM_PACKS 8
> -#define MIDX_HASH_VERSION 1
>  #define MIDX_HEADER_SIZE 12
>  #define MIDX_MIN_SIZE (MIDX_HEADER_SIZE + the_hash_algo->rawsz)
> =20
> @@ -36,6 +35,15 @@
> =20
>  #define PACK_EXPIRED UINT_MAX
> =20
> +static uint8_t oid_version(void)
> +{
> +	if (the_hash_algo->rawsz =3D=3D GIT_SHA1_RAWSZ)
> +		return 1;
> +	if (the_hash_algo->rawsz =3D=3D GIT_SHA256_RAWSZ)
> +		return 2;
> +	die(_("invalid hash version"));
> +}

I think my same response to the last patch applies here.

Beyond the things I mentioned in the last patch and here, I think this
series looks fine.
--=20
brian m. carlson: Houston, Texas, US

--ucfHZChuBC0NsER/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXzbwuAAKCRB8DEliiIei
gWzcAP9GL8kNAYdfSHYzAGLZu35RCF060QpPopgQAq+uw2VcBAEAlqe9hPCBmOW0
J3aVI+ehs8rP16oSsF00Yj9JeiYm/gg=
=HNtK
-----END PGP SIGNATURE-----

--ucfHZChuBC0NsER/--
