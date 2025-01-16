Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804B729405
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 02:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736993124; cv=none; b=sxT7MiLzC9IwmSvfG/VH5aPFrkoEeO+TGfrOP0BKyPfA1kNPObYRG4vqyxZQ1Ak8yQPAMRLr4OdH6J7n/KQhiLaSNmhZ4sj3Knyp7xIUoPJ8Q6Tl5MdC8AkvFnZZ1j6fLECQ2c5ErrUluRJYvOym9asH+MJ2FeZHX2/C7kmy9ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736993124; c=relaxed/simple;
	bh=oTks0HersSxR03N+n5cz1wkB88+ve9bqSiQcYMEOa7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YXGJeS4YNFpHxsyY8ZTB5EbANw6+OfMhb2rOhGJ60nqfgrnzddVJ6zU4cBK5i214i0C5Gb8LU8L66vs9C2aiznPSkX5vLre7RSo+LcLkuiVgT304rH+l4eJa/Vko/IZheUDm7fVDDSPY18EboJfoUD86ieuqQPOVn1AqFnNbRiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=mAufAekj; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="mAufAekj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1736993120;
	bh=oTks0HersSxR03N+n5cz1wkB88+ve9bqSiQcYMEOa7g=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=mAufAekj+6eBRUuqRCLW0GuXpdFHwsmeKZSu3xQY2w5xL0aRNo+Q2Q+0mkA5I5c0j
	 okkob3u49qh40A6yC+KlxIJ0+YYyN84QzhJYvlF4uLkNuNES0+0CERdb9ekv1hbSxY
	 JN25UPuO+u1Irwd7IsV/a72XzvMJhdb/741tZltVBocrAStMjFnAfa1IDQ2TG/4r77
	 Wqpu/T0qnpDtlV3DPjnSo5EHc8aHmjZKcYbHkgZZjfd1sW1FztvyTJW+solRaClKKp
	 3KqpYJBbLXWqjyCOKBz/okbAKKl4trrA447pZKIeSCzg6qk9dVW3bxDG7zwWS+RpqQ
	 t+yVC/vykq3aKAnOKWvjG6DwXgh9cCw3BTXOrzY5IklBK9Zv7+BITVD7o/6sfDo6ze
	 2T+g7uVRLjAHo9Ihqkvb6hVo9PsDpVoUwtVMmaM56lxXDunzrGQAY9gjS7Z7TzASci
	 J0zZ4lzURq4Vlmimokt7rDyjCdyr1JrrzZi1u6g6LRvJcwoa7Nb
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id E53242003F;
	Thu, 16 Jan 2025 02:05:20 +0000 (UTC)
Date: Thu, 16 Jan 2025 02:05:19 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: Bug in 2.48 with `git refs migrate`
Message-ID: <Z4hpXwtv-ChwAGeG@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
References: <Z4UbkcmJAU1MT-Rs@tapette.crustytoothpaste.net>
 <CAOLa=ZTL9n_DPhNr49XAd6bT838kc09oVx_AH7Pb4o8VK_xQ9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="r+Qq/+gUc4/bAe8D"
Content-Disposition: inline
In-Reply-To: <CAOLa=ZTL9n_DPhNr49XAd6bT838kc09oVx_AH7Pb4o8VK_xQ9w@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--r+Qq/+gUc4/bAe8D
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-01-15 at 11:54:51, Karthik Nayak wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> I'm attaching a patch below which should fixes the issue for me and also
> adding a test to test against the same. I'd be grateful if you could
> also test the patch against the repositoryies you mention.

Fantastic, I'll try to do that tomorrow and get back to you.  I really
appreciate such a prompt response.

> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> index 16550862d3..aaab711bb9 100644
> --- a/refs/refs-internal.h
> +++ b/refs/refs-internal.h
> @@ -203,6 +203,7 @@ struct ref_transaction {
>  	enum ref_transaction_state state;
>  	void *backend_data;
>  	unsigned int flags;
> +	unsigned int max_index;
>  };
>=20
>  /*
> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> index 00d95a9a2f..289496058e 100644
> --- a/refs/reftable-backend.c
> +++ b/refs/reftable-backend.c
> @@ -942,6 +942,7 @@ struct write_transaction_table_arg {
>  	size_t updates_nr;
>  	size_t updates_alloc;
>  	size_t updates_expected;
> +	unsigned int max_index;

I wonder if this and the above should be `uint64_t` instead of `unsigned
int`.  From the file names and the data format, it looks like we
intentionally use a 64-bit integer.  That's good, because I have
unfortunately seen some people who have created giant test repositories
with really unreasonable numbers of commits and I could see us possibly
exceeding a 32-bit integer here.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--r+Qq/+gUc4/bAe8D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ4hpXwAKCRB8DEliiIei
gW44AQDoVySatwpiqpmuh1UM082FLZbM/4S4QSYA+gJznUN3TgEA5ehS+wmaLZTE
hh1QKnfSkhQ0YbnBgnFfn7sP5OHywAw=
=veRF
-----END PGP SIGNATURE-----

--r+Qq/+gUc4/bAe8D--
