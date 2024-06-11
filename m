Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7239D154430
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 23:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718147882; cv=none; b=NKxqfAujSPZlCLbUZFTrfaKDUHF2/klt5wjADtZYIFkbVe7LrlYZVEfco3h4WetN22ZxuB4kWBcuXdQ1eujkj6CcshgCcoa7QsgM3jd88gVN6zHvE7s8CNxH0LpwPHyFIL7fHbS+lzp3G8ylSX30O2Tlb80sfyMs11FzWFIUqUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718147882; c=relaxed/simple;
	bh=sNJNAoHQZbeeXsAqyClxENHGEmGyXdFAGzgPSikJats=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+iaPQ6dWkFsJJ/47ZXhUuaZ+Xfhk7YtB+XEj8iVRAL5jaMGgmuye1Bv9fIVJzlZx62ncw3enqlJ+b4oiAbGarQBFETUEny1uqdjFUu57Uoiv43398yfqDJ376rRp8aiFkFa9fUGt3L3lyUNvaHkVt45UOBqrXR8TBf0MJfvv/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=MqDgWwUS; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="MqDgWwUS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1718147879;
	bh=sNJNAoHQZbeeXsAqyClxENHGEmGyXdFAGzgPSikJats=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=MqDgWwUSip0JPY3MsCE49+5s3W8f5ckgBw3UIlEshw8K8yhXx3rCYi76wl8ArGhX6
	 EcoxXy5Tyw82H4mAC2SAkN6h4P8Anm60/MUAoVOjfIcLoeR1IlirpeE9rvJjRWlNmi
	 c0MBDSvXIH8kt2U2VeHgQnh0NtWzdezZ37BrRs6DgCx/XXEpR1LXGq3hfigbCNW+ZQ
	 vX5ugbvJBFb7jUVOhKt9qktEITrW1gJTj7tLU9cLKLQYUXQRLP3UeZSfCgDsBL8f3K
	 ICOJ3hhUFXZpszYsLv/g4h7ySZhYW6eHDv6oMxLZTs0PkG5i4U52SiRL7iAB5zysoK
	 lWdeGAb7JXOfnuaJZomuQXigRxu9NvzJEqLyhfZxCFBxr+5WjCzHkpi+FZQ8JmVLM5
	 kfkMLC9ojxMO+Xp2/XjiyY6i2tAnBRtEVLavZzRmY2cwbTkrLuYz9N9Bh1X/KI/ee/
	 zQ9dOdzGW6Xej91ubXEz3AU/FndE/vKCfsyAm03C6CWFqZywQLr
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 634432639C;
	Tue, 11 Jun 2024 23:17:59 +0000 (UTC)
Date: Tue, 11 Jun 2024 23:17:57 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 19/21] t/helper: remove dependency on `the_repository` in
 "oidtree"
Message-ID: <ZmjbJU1Rnnx0ggHt@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <cover.1718106284.git.ps@pks.im>
 <339d668da837ab5b4b11399ece4efaf5bc27d313.1718106285.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZWYe5C+cJOGP1PRV"
Content-Disposition: inline
In-Reply-To: <339d668da837ab5b4b11399ece4efaf5bc27d313.1718106285.git.ps@pks.im>
User-Agent: Mutt/2.2.12 (2023-09-09)


--ZWYe5C+cJOGP1PRV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-06-11 at 11:59:01, Patrick Steinhardt wrote:
> diff --git a/t/helper/test-oidtree.c b/t/helper/test-oidtree.c
> index c7a1d4c642..04ec24cc84 100644
> --- a/t/helper/test-oidtree.c
> +++ b/t/helper/test-oidtree.c
> @@ -1,7 +1,6 @@
>  #include "test-tool.h"
>  #include "hex.h"
>  #include "oidtree.h"
> -#include "setup.h"
>  #include "strbuf.h"
> =20
>  static enum cb_next print_oid(const struct object_id *oid, void *data UN=
USED)
> @@ -14,11 +13,9 @@ int cmd__oidtree(int argc UNUSED, const char **argv UN=
USED)
>  {
>  	struct oidtree ot;
>  	struct strbuf line =3D STRBUF_INIT;
> -	int nongit_ok;
>  	int algo =3D GIT_HASH_UNKNOWN;
> =20
>  	oidtree_init(&ot);
> -	setup_git_directory_gently(&nongit_ok);
> =20
>  	while (strbuf_getline(&line, stdin) !=3D EOF) {
>  		const char *arg;
> @@ -30,7 +27,7 @@ int cmd__oidtree(int argc UNUSED, const char **argv UNU=
SED)
>  			algo =3D oid.algo;
>  			oidtree_insert(&ot, &oid);
>  		} else if (skip_prefix(line.buf, "contains ", &arg)) {
> -			if (get_oid_hex(arg, &oid))
> +			if (get_oid_hex_any(arg, &oid) =3D=3D GIT_HASH_UNKNOWN)
>  				die("contains not a hexadecimal oid: %s", arg);

This is not a problem in your code, but this might read more naturally
as "does not contain a hexadecimal oid" or "contains no hexadecimal
oid".
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--ZWYe5C+cJOGP1PRV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZmjbJQAKCRB8DEliiIei
gU2QAQC5N5PkzBdR2nDk7UKV7G3jeJH+8+sOTmcmKS+TfSyZqgEAvSA1Crrgmczs
21AsaXqrRmjQwgiq/hL8uiGyh/YitAE=
=Jwny
-----END PGP SIGNATURE-----

--ZWYe5C+cJOGP1PRV--
