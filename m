Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0418C4502A
	for <git@vger.kernel.org>; Fri, 27 Jun 2025 18:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751050777; cv=none; b=YSINngzcA28NZnIKlTAzMbx9lbKygph05/gn+tG4ckoeSurIOXEuYbgYrqmBxCfRnmdL1kmlUg14HiR3VCf0JYLmY8UYL84JnOFcltswgMIQ26XJKFN+K1FepVIDkfXq9AqKoVdTLwzUeOGPqfoThqUHhr0JY1E4XsglnZLUVPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751050777; c=relaxed/simple;
	bh=y5W5tKv4rsLDcMaOPcxcltpK5z0B+RO7R+nIgbeg9bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FyXx/3TouGTsTaH7TFBU3tH9+/xM2zNhdgm7VF443kHBDpE6gzeeXSCeA/+A/LNfjUbnUNFcnZFpHCNOI4EkV6IzU7iNVF3lwcKTISSOW+FWxQ4j3II+VQc1x6jTCwrBE+jMY8cIDz1qVnZr48Dwi53dPUekpiYz6gRruYp0Yro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=aVPbbQ6s; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="aVPbbQ6s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1751050773;
	bh=y5W5tKv4rsLDcMaOPcxcltpK5z0B+RO7R+nIgbeg9bk=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=aVPbbQ6sw2h/0GJJCjqDnmBq9qvwGsWDlFqhyc48KEgDPSSygBmG7UofjZpavOHqK
	 WiaEkwRUxUaUHHn3HVpq1ThTu7+iY+J+KRYgLH6a5GeLgTPMPqBnxFT+xa2aVPri+S
	 wpHcx6FdeRc5a9jvW57I7tKkvJFiGRDhbMfC6WjlVwLz9S9P5ekZ8tSd4IDIPJpKa6
	 oNJEOnVxN39ohPqdPw/z4kYo1qFu+xaxrn2BwQl+5Gr7PZmblvivEl2yVlK7MPJgye
	 58QZgvbHrLAZHwJBxdDWTRPDKI/TIc8I7pw9rx1Ft38uDdDifsXaenX1TXwu7bd3xw
	 msnqlyCZvNlWBLArttARsrSTvZWkD+fRJmV39lAVfnxdj2aVlOXfTN8Qbg2mdIjgtr
	 lTrez72Ebw87OcehMwwEDOOtbO59l70HFKFeEEkzdIhLAamLuRkAB11psGgnexd5lO
	 xW/TSDYuTgBpFwna14LvrmOb09oATBhJESbSaPe1wKgRNZlqJUv
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:93fe:8e7:9f14:b8a7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id E79712003B;
	Fri, 27 Jun 2025 18:59:33 +0000 (UTC)
Date: Fri, 27 Jun 2025 18:59:32 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: ryenus@gmail.com, git@vger.kernel.org
Subject: Re: Re [bug] pull --prune could not delete references due to lock
 file already exists error
Message-ID: <aF7qFEfPi25_e3bq@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	K Jayatheerth <jayatheerthkulkarni2005@gmail.com>, ryenus@gmail.com,
	git@vger.kernel.org
References: <CAKkAvaw0sZ0sW9o_0NZdnZknS8M34UST3PetaPBQj5wwvJyjBA@mail.gmail.com>
 <20250625141849.78834-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vlKx4nAendcjFL9z"
Content-Disposition: inline
In-Reply-To: <20250625141849.78834-1-jayatheerthkulkarni2005@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--vlKx4nAendcjFL9z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-06-25 at 14:18:49, K Jayatheerth wrote:
> First off thanks for reporting the bug :)
> So I cannot test this bug as my files system is case sensitive
> but to just read the code and give a thought in a direction (Assuming tha=
t the bug is recreatable)

Just so you know, on Linux, you can create a case-insensitive JFS
partition on a loopback device and on macOS, you can create a
case-insensitive APFS or HFS partition in a disk image file that can
then be mounted (I think using `hdiutil` or the directions at [0]).

I have used the former in the rare occasion that I need to test a
case-insensitive file system.

[0] https://support.apple.com/en-ca/guide/disk-utility/dskutl11888/mac
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--vlKx4nAendcjFL9z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.7 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaF7qFAAKCRB8DEliiIei
gXt3APsHjBD95wvU4QugTwUusOGq2AXr/os6wjx+GMYubevL8QEAvDc7WQZS5J9O
XlwS8+Z0OmXd0RDJAPX6AqfFp19DGwg=
=wg6x
-----END PGP SIGNATURE-----

--vlKx4nAendcjFL9z--
