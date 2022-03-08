Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B2FC433EF
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 01:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240358AbiCHBv2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 20:51:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbiCHBv1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 20:51:27 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4B43D1FC
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 17:50:31 -0800 (PST)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 7B3FC5A3B9;
        Tue,  8 Mar 2022 01:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1646704229;
        bh=idKySO8nGKNyCh4y14ajPPRcII4H9Ns5CYwAdo9nSTI=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=0jtx4lbZsofXR3CS/jKYX2VTiwgaAtsv4SCrA1Ci1d+f17ZlYStwGMs3Z5wrIOyAP
         y/Lbc5PqoVX3OOwpmioy831zqHpLrevRqwnR0BRjaHLZidXh3BZ9yAhdQh+E2LmF6V
         UZY66JvKo59couBhc5uSR+lx1s4oU/K/dfABdBnjVYO2AvfhhKFBwQWEpKxr8q1hd/
         uzOrD7q8t6NpEnc3Ae150Vq4jwk4o6UHTYBwAlowQiIfdUx95EMk3Whfph/n8WsFJ4
         emcMBfmhgFenNW5Xj2mCspTdNfi0J7reqhIbGWEtENJLPf7SeSELdfadlUa4ERDSnt
         DUt7aKGECi1CsMH3Hw2DxvctIvF+DM83xjtMHvEDy4iEvfRNv3NJQK7nhfFUooA2Vu
         YiMhkW/yE9JSaRN++fop5DGFaK9RfnvExWqwgvEstevNPomWODxJ5Vf2NZDI+99ry9
         Uwzb4+9O80/PyABL+B1FDJQcBbO71RKTkqYXLM5T84wJiFKfw5K
Date:   Tue, 8 Mar 2022 01:50:27 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jason Yundt <jason@jasonyundt.email>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 2/2] gitweb: remove invalid http-equiv="content-type"
Message-ID: <Yia2Y2zoOjvVdJ9O@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jason Yundt <jason@jasonyundt.email>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
References: <20220307033723.175553-1-jason@jasonyundt.email>
 <20220308010711.61817-3-jason@jasonyundt.email>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aJH+sYXQi/G0lQFE"
Content-Disposition: inline
In-Reply-To: <20220308010711.61817-3-jason@jasonyundt.email>
User-Agent: Mutt/2.1.4 (2021-12-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--aJH+sYXQi/G0lQFE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-03-08 at 01:07:11, Jason Yundt wrote:
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index fbd1c20a23..59457c1004 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -4225,7 +4225,7 @@ sub git_header_html {
>  <!-- git web interface version $version, (C) 2005-2006, Kay Sievers <kay=
=2Esievers\@vrfy.org>, Christian Gierke -->
>  <!-- git core binaries version $git_version -->
>  <head>
> -<meta http-equiv=3D"content-type" content=3D"$content_type; charset=3Dut=
f-8"/>
> +<meta charset=3D"utf-8"/>

I don't actually think this is an improvement.  I don't think it's
necessary, considering we have an XML declaration and the HTTP header,
both of which already say it's UTF-8 and will take precedence over this.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--aJH+sYXQi/G0lQFE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYia2YwAKCRB8DEliiIei
gYaGAQCfx4gVHPeV01a/zm+7Qk/wB+m7nVm0mpHI8EFXyQnDXAD9G/5HC0tH5fFW
UPMS+cvy4QoKjYYzWSfI2imjti3axA0=
=akgj
-----END PGP SIGNATURE-----

--aJH+sYXQi/G0lQFE--
