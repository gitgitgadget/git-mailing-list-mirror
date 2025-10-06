Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68799A932
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 21:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759785615; cv=none; b=TaSodEUSt3k5hmIU+FZtbE5H130wzzya2Ns1BsTTwnO5gzliL+td1Pckn88AwHBMwqSKqRZea8THg3G5NdIlvJXLO6itQqwvJB/8EMQo90GtTVCWMCGeWnCthimq5+64Zgkq7ovV8bWCAjXUfAARvuhCP4+yAAgseH4gy8rGnGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759785615; c=relaxed/simple;
	bh=//T1xKp47gEC1dykaeMkqzZ2o2ESvOpA/cbbEkHBRuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zq6qMtVju0ogVrDRn5GsCZyVGxSwjId1VtJOfqS55inA2EC6tlnQLVDj4qZu/UxUGzdrQ5w3c8cLf77nkhE3983vRFwRIMIIh9GOQhbvxcL3Vw58UcTWY03C7rN0WLB3fJG1Oa5hG6oxyyRHL5zholi4IyTOZayhxqbTFR/RK2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=AZWrHPVc; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="AZWrHPVc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1759785611;
	bh=//T1xKp47gEC1dykaeMkqzZ2o2ESvOpA/cbbEkHBRuU=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=AZWrHPVcgQcP+V65WiRzr5bEM3F36a969mt8Dfy3aIKPMhafU2QjhsObIZflNzfT4
	 hNaA67CW3kF5STY3oYQNCqzeMPbuEHJ1MrSWvE6Al++TJIGmhtfwMPeqfTHVXRO25j
	 oBqTv7uNk7hbjZtHMu5pppiCtsLWUhGVwa0G2N4o6SS8qVh8kAnZ+ueAyoOY+TYfbM
	 EiYEfPj87IbFxP0FIiZGW0LQgEACdH550Fqf6pKbx9Ghko/RZaC7our8IqblGSUxuc
	 6Y17a0ICh2YyNKkNjlL4PqHsPXqyupUumrBb4YybekshUZdTONyGwjAb5JCoiCzC+S
	 uzzrPutXTeP7xfY6cMtR1h2IfrwA8qkwBLjzoyY4C3eo5gtCIlgjo8P0Vakb/AsG20
	 s9OfEn9M5+HpgPAfzxQ389Dyt3cqAshI6gXX5e2Xo8qtgVmbglwJlhNalU/qu8MOXv
	 UnZYSlkmK1eLLjGjmrF1t6p62hfA7ltTwrbLM8Ph6+hul4rRrTo
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:1cc7:db20:f4a5:abef])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id C3A56200C6;
	Mon,  6 Oct 2025 21:20:11 +0000 (UTC)
Date: Mon, 6 Oct 2025 21:20:10 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: phillip.wood@dunelm.org.uk
Cc: ions via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
	ions <zara.leonardo@gmail.com>
Subject: Re: [PATCH v4] libgit-rs: add get_bool(), get_ulong(), and
 get_pathname() methods
Message-ID: <aOQyioJChUkJOXRb@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	phillip.wood@dunelm.org.uk,
	ions via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
	ions <zara.leonardo@gmail.com>
References: <pull.1977.v3.git.1758945111.gitgitgadget@gmail.com>
 <pull.1977.v4.git.1759221968318.gitgitgadget@gmail.com>
 <0cb55558-a48e-42ac-a80e-a24ee2be55ee@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ShvnO/rbFKqEE0Lp"
Content-Disposition: inline
In-Reply-To: <0cb55558-a48e-42ac-a80e-a24ee2be55ee@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--ShvnO/rbFKqEE0Lp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-10-01 at 10:15:28, Phillip Wood wrote:
> [I've cc'd brian to sanity check my suggestion for handling c_ulong in ru=
st
> 1.63 which lacks std::ffi::c_ulong]
>=20
> As I said before this wont work because C's ulong type is platform depend=
ent
> so you cannot assume it 64 bits wide. Looking at the previous discussion[=
1]
> the reason we have these fallback definitions is because std::ffi::c_int =
etc
> were only added in rust 1.64 and we want to support rust 1.63 as that is =
the
> version shipped by Debian oldstable. I think it would be better to have a
> separate preparatory patch that changes the existing fallbacks to
>=20
> #[cfg(not(has_std__ff__c_char))]
> use std::os::raw::{c_char, c_int};
>=20
> and then this patch can add "c_ulong" to the list.

It's just fine to use `std::os::raw` in general without needing to use
`std::ffi` conditionally.  I'd just default to that until we move away
=66rom Rust 1.63.  That's what I do myself.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--ShvnO/rbFKqEE0Lp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaOQyigAKCRB8DEliiIei
gWm2AQCM8qfM5XN66M3efxke853KucPbx7naKvbindqBfDroNgEAj2JUOwFAz+43
IA0NRd60pBRA9eeF/dEdVdqTJy+JXw8=
=7g7q
-----END PGP SIGNATURE-----

--ShvnO/rbFKqEE0Lp--
