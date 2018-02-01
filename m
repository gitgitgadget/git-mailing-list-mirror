Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0042A1F404
	for <e@80x24.org>; Thu,  1 Feb 2018 01:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756027AbeBABZJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 20:25:09 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58526 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756024AbeBABZJ (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 31 Jan 2018 20:25:09 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1ADFE6096E;
        Thu,  1 Feb 2018 01:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1517448307;
        bh=MPNwd9/z5BWHboQObgjW17qq41d8sg5CFqzTlJEuolc=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=rS/UGIOzRz9fpHwLRWYH70FonGU7Kr/11EMcVfmVndDXe3gixgsLABifuZMPIUeb8
         jyJtaSOOHfegfyxlf+z6NnkDa1qDpGt1RPmfq6K7ErNOaCo5IhpIw/UM6eUp/7al3J
         CbHq7wJpaZ3C7krPGcnYy4nsa94NkHlmsNrBUURk7iII5Ggtw5zuGnmpqSXy9gxP1t
         +jZP9AVIbEqMmpMGZgMpxbScWXfm9xBBUTwD9yk+hFrqrhVsjasoszv360Wsm5YPFa
         ipj8Az9brxXim1avtUFo8GHy7Yy/3Y5lRX2jVhPWhLlV6mNB+31yPI9C62VY5wT8j8
         d47CfCSvz38jUM2PBUa0dSV1L0IL27eGhhq5h3cOy++vb90MggX5sgP8P9dkOIUJhk
         Kt8sT72wt7eGm0CSxFqkGlLMs6YoxgsJTiaKibTusQUQGEXIZdHCbKa73BNKwQZxi6
         sT2KcslB/dhzeEY6ixURiWqwMmdnjst8kLRIzfb12lNlmOAPT8M
Date:   Thu, 1 Feb 2018 01:25:01 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [RFC PATCH 0/2] alternate hash test
Message-ID: <20180201012501.GQ431130@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
References: <20180128170639.216397-1-sandals@crustytoothpaste.net>
 <CAGZ79kbvWPDKPbe2pzHgvfKS+kToVmFtijsmshzX30uuk3pqkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5AmtYbcgdBTTPS58"
Content-Disposition: inline
In-Reply-To: <CAGZ79kbvWPDKPbe2pzHgvfKS+kToVmFtijsmshzX30uuk3pqkA@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-rc8-amd64)
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--5AmtYbcgdBTTPS58
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2018 at 05:04:52PM -0800, Stefan Beller wrote:
> Thanks for writing this, I chose a slightly different approach at
> https://public-inbox.org/git/20170728171817.21458-2-sbeller@google.com/
> which might be quicker for local testing.

I'm actually going to rework the patches to be much more similar to
that.  I've been convinced that's an easier approach to the series, and
I like the simplicity.

My goal is not only to identify failing tests, but to exercise the hash
algorithm logic so that we find any hidden dependencies outside of that
code.  For example, I noticed some of our Perl scripts have hard-coded
empty-tree object IDs in them, which obviously will need to be fixed.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--5AmtYbcgdBTTPS58
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.4 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlpybG0ACgkQv1NdgR9S
9our4xAAykGnVKc9sm7HbQSD2X5t6yJ/Se99ytXy5vzV7SOx5uV/8egIiPx4iRAU
UnQ7J5oxjsbSC2aY8hQm7TJgecngxGwl6tGG9gFX47YJSn/0/03NQmNXtZjHB9Zt
hg/MtGC6AJbC6ZyyJRXohb1S3VS7QFwZcxlwirC1MVdTK2msQ7KfkdheOb1TArjS
seZAT930rS9yRWITxj++Gv9F1Q/ngrvtRtHpFX5DyVCzR0gLHcGEWQPh5VnV3x1/
lSwsLg75PJYZJOI9Cj8LOJWqAbTLh+CCJLkLfhWACXcLUli9jGMernne446gTU3e
3C6yQhaWhdGsrSFhUwBNChdtTAR3Pvk/qLmXkJXT1MsuK4IPz/f7P0ZUH1xA8EZq
DpXlDAksOErRKFTGvZ+nUaRIY9tQNiMn4egINPG6mfrBMGWyy7r07IWmaomFWOVN
7j5ae31lVVtJDUQbsSqERmfzCE3BukyjEMMUTWQKGmfepM7FLradNVLnMk+toavL
nziwg3YYJ+vtDER+W2aXpTO/rM975TzzGJPBFw2vXDmojzaZBthRWapwG++UlVY7
IxtSIeLlVVyC841CE8yBVNi7Zjs0Kdbv/48RUy1rEFgmcVAIbL+CH8Eq5d23raiS
P71sxCxuaakF9lwgrv8TDcUJt5wi1oB+5z7UiFjmmoLamrFAY4I=
=/WnV
-----END PGP SIGNATURE-----

--5AmtYbcgdBTTPS58--
