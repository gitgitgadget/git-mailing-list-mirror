Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9198B329E44
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 21:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761860405; cv=none; b=mmNQXOrpQBE1WlSbrHOetZXGt9/lCsDEAcfqdidOFaPzrQawlzvmOHRcpMz/Ic6dwYD+jJfBsJUdQp9vIuy2HrMCd9VqJotq7i3mogrc60X5NbM2b0m6ZJgER7ufQfUnjzMllHS6sheBwoGFZI6vfW8iVEHSH+uQZM49yq+jHGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761860405; c=relaxed/simple;
	bh=b43rBqWh/g4tG/1jcWEkaxjp31t0z7Z4nN0hDwJT7BQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M96Q7oF/ENbdkKfe7f6xvN+hKj6WBHGU5AT/Xb+i3yH8KQbJfjM52BwYoWQLxoMsW5J+s1qr0LghhI9zhY5wMATc/9kiskunEAadl7tL4DQDFMM3/uNh//7Kdo0/foitY4ABA0zcnv1BEV4f5oNONav7dHQCEB0hbC3sQOG/BFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=wEzS/jBg; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="wEzS/jBg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1761860402;
	bh=b43rBqWh/g4tG/1jcWEkaxjp31t0z7Z4nN0hDwJT7BQ=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=wEzS/jBgE0fmxo5eGg4C9EYVLjhlUjrM1IHDmGzBIjMHS96G1RG89rChEiDl/n1C/
	 IWhDwdtR2dfZu9lrNRuBEklbJIBWDoQf3mx+Hw4Ab2p275goCEqPOxL0X6rvBFO6nS
	 6clf3c5dpm30nESPDCNwnc2Bze71zy8nBaxQhJAdi/3bKkx5FIRug37KJ4bXP0fABF
	 V1tkvEoJfKwKigf0mGxfAMbGFrLmqjubYMOk0e+U2210zdTXb7aUx4h8reM2jdfxpC
	 twGkeoXt5qjneMTe6pzrfuK+V3mEsPEm38XKXUx4QYK35VJ30m5nW74hUHBYILq1BU
	 6w8y2jCxgXZdlFFFEPg7gpZkwb6+Hjpe5wQo+hHXu4zAQ7SrGRgn4xiEHZd1qOP8WW
	 2b+ICmuK+HDGa7GfVAJpio+HidiIVVdj3CzFf5HoWW0fzv1ezfpw4LLuocytJL+I+7
	 Hik6EV4DWYeLOo67mFj0eDwjuYozQzITPhvFvnMAjlpP7TRnEcq
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:bbe9:68f3:1302:8e3b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 8CA5F20036;
	Thu, 30 Oct 2025 21:40:02 +0000 (UTC)
Date: Thu, 30 Oct 2025 21:40:01 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/3] rust: generate bindings via cbindgen
Message-ID: <aQPbMZpYZJQH_Fd6@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>, git@vger.kernel.org
References: <20251023-b4-pks-rust-cbindgen-v1-0-c19b61b03127@pks.im>
 <20251023-b4-pks-rust-cbindgen-v1-3-c19b61b03127@pks.im>
 <CAH=ZcbADTLvTioBf+LYQej1G0biZM8s3-iJG+BZjnpxj+8NjsA@mail.gmail.com>
 <aPsepOtUf92fqDL-@pks.im>
 <CAH=ZcbBWuS6QVQT4LsxSP-X4GupZwr+NwzXNH2+qZGoufUWDrQ@mail.gmail.com>
 <aP_gy-Rj8MI7zAWd@fruit.crustytoothpaste.net>
 <xmqq8qgvfyq0.fsf@gitster.g>
 <aQM07BQrGJocPKea@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dW9lrdp7ysa4VzuD"
Content-Disposition: inline
In-Reply-To: <aQM07BQrGJocPKea@pks.im>
User-Agent: Mutt/2.2.13 (2024-03-09)


--dW9lrdp7ysa4VzuD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-10-30 at 09:50:36, Patrick Steinhardt wrote:
> For now that Rust version is 1.49, and that's enforced by our CI. The
> reason for this specific version is that it's the target version for the
> gcc-rs folks, so it may help currently-unsupported platforms to get
> support earlier.

As I mentioned a couple of times, gcc-rs uses the standard library of
Rust 1.49 since that's what it's targeting, and as a result it will not
support any platforms that Rust 1.49 didn't support since there isn't
standard library support for those platforms in that version.  It's like
trying to use a 2009 version of glibc and expecting it to work on
RISC-V, which was released in 2010=E2=80=94it simply won't.

That's why I was very clear at the Contributor's Summit that the message
we must send to platforms that do not have Rust is that they need to
port LLVM and target Rust that way, since that is the surest path to
success and to being able to get the necessary standard library changes
for things to work properly.  gcc-rs may be a viable solution in the
future, but it is not now, and absent substantial advances and an
order-of-magnitude faster development, it is unlikely to meet that
standard in time for Git 3.0.

So given that, I would propose that we target Rust 1.63 in conjunction
with my proposal.  I can send a patch to that effect later on.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--dW9lrdp7ysa4VzuD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaQPbMAAKCRB8DEliiIei
gYJLAQDFNDKoiliKuQJMK8kWWRxJlES8HSIEOZ9DM4I5wK+t3AD+P/c35eT8x4Sa
ea+2UB6kRaMAr1JSvZPj35nsyUbXmQw=
=K0QD
-----END PGP SIGNATURE-----

--dW9lrdp7ysa4VzuD--
