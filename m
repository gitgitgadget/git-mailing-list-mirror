Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A0E25B30D
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 14:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751293227; cv=none; b=DQi85pQcTlA+Esx48C3mVmIQB1acL5YWEg2alyb5AZ0pd27CFpX5RJhtTlyHmWZqS0nwrhd1Jul2BWq06vDCX2H3LQ0skQ2OZ/9To4q0wfNGj0UjxBkcFZPCGqViUAHy9NaY/gYgCsFIkerUakzWMFUJpVGvcMxWehvbetOa6FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751293227; c=relaxed/simple;
	bh=zCJSZZEa5NkJvVNUMJX14BdootngG9zGbxKJIq6dYwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GrtoEUtt8KZ4x3EaPWsDejLz/tWbeISsxRMFpojUMT3D04GxWrfPCzPq+R7eTpctfdncjK5Dv9qhAmboipCbeiXGgE29VDxPlua8HpgzPSfysfZcj2Qfu8h31237h1sdU5unoRJrvw+3RkrsGorUT/6Anbl/Ydb0FDT/SbLatwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=WQj6FSRu; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="WQj6FSRu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1751293218;
	bh=zCJSZZEa5NkJvVNUMJX14BdootngG9zGbxKJIq6dYwQ=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=WQj6FSRuAzqihNKCBM9FwZ8VLjpGqp/JZ5S+UNWXDe8tsgTVpYhPLsIVMZRcWSl3D
	 uD5irGwlnCNWznKBlmi9bdyzathkdZ3qwcaZrZrOZDGWwXAf+qcborty6IN2XY0GFn
	 SjaTx1GnKbG87yiL6xH3x++HIG41Uu90R+xr4FYKwx+T6b8IfgfmloTo1jpRQxB/R2
	 Fe632U+Oh3QcqdkEGE7krOUEqLL/nGZpq0ZJUzvw0kjH/MKhqzXg1mwUQ9smbx7t+X
	 1fHjZQYb1s+W3gBh3S/XhdvumGRf7PXrDzFch1kEoqH3/1x5HYBBuQl28uW4C+aXGq
	 utBwEE8HPypKBBIYGvIpuNM7MrbPfuEKSo/0YKNTHR8PztaqQ4ArBsmbz38IUjm5gF
	 QiOplm5+aPZI+OtX9Y5CFm5RlxkPt+NPK5GrFt+CL0lnE8Q3Sy9d07Uw6jVf1QJvXJ
	 WeBQNxLxQugFneRjbBYxZZZU9PwnPg6/v+CJFe+NXpFmyd2mq1I
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:8741:7f1a:929:ce34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 0070420067;
	Mon, 30 Jun 2025 14:20:17 +0000 (UTC)
Date: Mon, 30 Jun 2025 14:20:16 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>, ryenus@gmail.com,
	git@vger.kernel.org
Subject: Re: Re [bug] pull --prune could not delete references due to lock
 file already exists error
Message-ID: <aGKdICvmKlumU0ru@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Karthik Nayak <karthik.188@gmail.com>,
	K Jayatheerth <jayatheerthkulkarni2005@gmail.com>, ryenus@gmail.com,
	git@vger.kernel.org
References: <CAKkAvaw0sZ0sW9o_0NZdnZknS8M34UST3PetaPBQj5wwvJyjBA@mail.gmail.com>
 <20250625141849.78834-1-jayatheerthkulkarni2005@gmail.com>
 <CAOLa=ZSA273KGPnwZ2aRBU_ybcCTYogBHvUwpa+5CfDOc2bEWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yhpJm85x4vs0V9GP"
Content-Disposition: inline
In-Reply-To: <CAOLa=ZSA273KGPnwZ2aRBU_ybcCTYogBHvUwpa+5CfDOc2bEWg@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--yhpJm85x4vs0V9GP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-06-30 at 13:46:35, Karthik Nayak wrote:
> I can see few solutions overall (including the one you suggested).
>=20
> One solution is to drop duplicates in case insensitive systems, this is
> the shortest and easiest fix for now.
>=20
> Perhaps something like (untested back of the hand code):
>=20
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index cc0a3deb61..bc79d74b82 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1352,10 +1352,16 @@ static int prune_refs(struct display_state
> *display_state,
>  					goto cleanup;
>  			}
>  		} else {
> +			const char *prev;
>  			struct string_list refnames =3D STRING_LIST_INIT_NODUP;
>=20
> -			for (ref =3D stale_refs; ref; ref =3D ref->next)
> +			for (ref =3D stale_refs; ref; ref =3D ref->next) {
> +				if (ignore_case && prev && !strcasecmp(ref->next, prev))
> +					continue;
> +
>  				string_list_append(&refnames, ref->name);
> +				prev =3D ref->name;
> +			}

This won't work in the general case, since the two refs that match case
insensitively aren't guaranteed to be adjacent.  For instance:

    refs/heads/AAAA
    refs/heads/AAAB
    refs/heads/aaaa
    refs/heads/aaab

They'll be in the above order for a bytewise comparison, but the
matching entries won't be adjacent in the list.

Another option is for users on case-insensitive systems to use reftable,
which won't have the same problems as the file-based backend and will
preserve case properly.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--yhpJm85x4vs0V9GP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.7 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaGKdIAAKCRB8DEliiIei
gS/zAQD8cpHvcK9G4/gyXtWhHY8kWCR6sdF48chxnet+5Rk55gD/ZO/uGDD8Y21v
go+5FYNJbmOfllNMETEvw63ao1wqZw0=
=snVo
-----END PGP SIGNATURE-----

--yhpJm85x4vs0V9GP--
