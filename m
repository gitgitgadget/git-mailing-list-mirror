Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DDE11F453
	for <e@80x24.org>; Fri, 25 Jan 2019 01:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbfAYBxS (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 20:53:18 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33284 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727983AbfAYBxS (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 24 Jan 2019 20:53:18 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:c162:ac20:e47c:bd21])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9F3336042D;
        Fri, 25 Jan 2019 01:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1548381195;
        bh=m6JCwSI1+XkpVYdIy6yEAu+Gu5AoiQKmSaaGGLZafAI=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=e+DmsRpsuHxy6JkDNHGYPZ4zjZS+Gr94sNmagzdAcyzy8JIojdwkGJ6/3vAWcIalu
         Ye/7OQWJ1tdMDkzPqveHxU/8SDIdoT9GnZQNlxmbeTtrNtM/JYDdV6x6BHKcAC0y7m
         VqgcL4BoOlDcLPIpZaJhcuF4TfNYyFZd2i1p2AO2Cf4mH/nJeYtnsglW34Iqk9GJqQ
         HfHE3aVyA+N/+itDC5uy+kSVhjZCT31CGhTXs65e7L712um60uajo6YUCX/akmvVAk
         oa9ZNjlR3LDCiUiYtBGLfjlysnhHrsV889E6C/KEQqn39bo+dkmxYzheffCLrISMuc
         zO39Euvo1u1Eia/Gfp1wCb3n1zKujDgy3gSnfJnemG+3LtPeXrXoNUNYgk6/S8n80W
         XVqHPt9lxFWO+WXdvdGOZuaxJQk3eSK3eQl6lWbfjPPHU1EZ6/Gnn4Y30Sx/CQ3T8j
         7AbySHwbmshUIh5dgbATYyvKssT45INmIQkKQSfQs6hcg7Itprk
Date:   Fri, 25 Jan 2019 01:53:11 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/9] drop some unused parameters
Message-ID: <20190125015310.GT423984@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20190124131104.GA24017@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xbjSOCWVZ1q9zj4g"
Content-Disposition: inline
In-Reply-To: <20190124131104.GA24017@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--xbjSOCWVZ1q9zj4g
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 24, 2019 at 08:11:05AM -0500, Jeff King wrote:
> I've mentioned before that I have a series which compiles cleanly with
> -Wunused-parameters. I split this work roughly into three groups:
>=20
>   1. Patches that fix bugs (i.e., we should have been using the
>      parameter but didn't).
>=20
>   2. Patches that drop unused parameters (i.e., code cleanup).
>=20
>   3. Patches that annotate undroppable parameters (e.g., ones that are
>      present due to a callback interface).
>=20
> All of the patches from group 1 have been merged already. So this series
> starts us off on group 2. There are about 50 patches in that group.
> Given that none of them are urgent, I plan to feed them in batches to
> avoid overwhelming reviewers. I'm also ordering them to avoid conflicts
> with other topics in flight (this batch has no conflicts with 'next',
> and only one minor textual conflict with 'pu').

All of these patches seemed straightforward. I did see a few where there
may have originally been some consistency benefit to keeping parameters
(always passing file name to *_to_worktree, for example), but I'm fine
dropping them if it means we can get better development help from the
compiler.

I am also, for the record, in favor of ignoring the effects of
relativity for the purposes of Git. :)
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--xbjSOCWVZ1q9zj4g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlxKbAYACgkQv1NdgR9S
9ot8nxAAvX0HWk/KUKkCy+3UgCZpq3v8IXQ1O1vheKDRW0c/kvVx6TKOhuJYARSW
g0pZYIrXlO9yPt7g2/ev1Y47nOOaPz+hjbCBaXAndZwZcqCie9DUGU7G9FEH13We
gHlzhzsY3WfL0WM9n44iQwh8LZCnujfUVPTxXZFfd9S5Dq0iXzMD3K1F+AeOCDIn
rqnRQEfMcpE0NhaBhO/MxX/aT+5HKKAa5vJDhNBaJI/o8m80KQzwpEcqlc7oKLxW
AJyfHXJRToFVqs/HudJuj6v8SW7TnvoT+ybNNZRt1LWd/TwnVuXb882rXcdKq8Tp
w4X51WOc97qA0gnrlm8POYa/VYIZ8BjoQKyWkLbW+d69qnv9k0AU7HEn16BdkSGT
oe29GtKHaI5J2NVhUTcOFiZc+6p8LFvLQh4TrxGZyYbAeA55G8Q4MKQJr6wtKf1w
GLru+Mg/Bbc1tTTMDCQioDuYh3LdbXYW2HjcLLiEUTEMXzQTtwJtJPzEpu1nHw+o
afDMNYYDtxfHACy5cvVS8Fgdnzt1vBcEZ+Z69o6g/57BK8GRjamd8kuCWhYGhMLq
fzUL6bdW/X909vxgPzRE6/HUl8Klld3yYnhB9B2yKwVk6Kv+YDWBqqzCtZ7T1YRO
+l2ezanm4VWS74YWBkX3pszrmFyPX3/uifZ7/IiUtygVnw61sLM=
=YD5E
-----END PGP SIGNATURE-----

--xbjSOCWVZ1q9zj4g--
