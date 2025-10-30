Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4632C30F95A
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 23:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761867496; cv=none; b=iHq93QvXhg+d7HbWbLVWXtGf63rnnCPauk/9FVENKCZDlbeH59kscW42kFDBs83lNbJf3YcCCacALH7eU6+9xwg0viCazkDNFGzyAhlFs723qaOIjpvPol5rsyDbyIMzMZS+VO6Bde63oiViaJ7rQrWP9YbAuRieip7y/c/JCdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761867496; c=relaxed/simple;
	bh=l3QTqJj7pq0iQFQFW9xx2qf0t5wNqXF+uLPhbMpEzio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OWBbukiJMeccrYwiRC0zVckzfSLZ4TWFSCQD0PIYyineR35PTUQOWatFZdwBPnKel5AmIi/tRayL/DeO3RpV2ziHTUBofiH0yWLnqxM3UZP0G4gWixbzXi5YfV16PPs0jA8lqqMlr+uEffqKFoR4agVymNibuCtdYx4nS6+UP/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=i7+dBF2Z; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="i7+dBF2Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1761867492;
	bh=l3QTqJj7pq0iQFQFW9xx2qf0t5wNqXF+uLPhbMpEzio=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=i7+dBF2ZcbKurHyoTbggkGrZICPuKLsmjRvPRK+nB89KS0xAjkr/opIOu+xOZRosj
	 2zEU19aO4r71Y7UE/2vQldAb6z40zeaRsXuEWQz13SYuEKZ1hkQpIlpNa4jwJQ+cHc
	 vcuaB7Jry3wLP8ULZl7FxAid7znbDtqBUjoALsZLQEM5DFw0qGDq75W6Q9OuVgO9AP
	 tR+YIfMoF81qY6K+TPDHvPWgaBxm7HTHyXVBPb5avgBy0VkO1Oc63oFAAU+ftqwuA0
	 ZpO9TIqMGYNFXUpDmHeLMbeG9My42vJdz+QH0IvP22oKjxoIBLnOzR9NIBNIoV8vwn
	 E08EPAA6AO6SrO08gQkv6op9Cz7JqpzkxOIlCdkuWG6kL0ApNgm8m2irZz+/zqoDIr
	 53EG3ow66Tsz6zzsgBROTNar+Z+euKcEZVucpsSuAjhPMlXIb2LDJ3WAhKhwKh+Rs2
	 KllFAS7h0HDxiMzGOXTSnEMbH0zsB605XMILMxr6Ons0hYw//Ts
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:bbe9:68f3:1302:8e3b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 42A6A20036;
	Thu, 30 Oct 2025 23:38:12 +0000 (UTC)
Date: Thu, 30 Oct 2025 23:38:10 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>,
	Ezekiel Newren <ezekielnewren@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/3] rust: generate bindings via cbindgen
Message-ID: <aQP24hFPF5DhaQai@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Ezekiel Newren <ezekielnewren@gmail.com>, git@vger.kernel.org
References: <20251023-b4-pks-rust-cbindgen-v1-0-c19b61b03127@pks.im>
 <20251023-b4-pks-rust-cbindgen-v1-3-c19b61b03127@pks.im>
 <CAH=ZcbADTLvTioBf+LYQej1G0biZM8s3-iJG+BZjnpxj+8NjsA@mail.gmail.com>
 <aPsepOtUf92fqDL-@pks.im>
 <CAH=ZcbBWuS6QVQT4LsxSP-X4GupZwr+NwzXNH2+qZGoufUWDrQ@mail.gmail.com>
 <aP_gy-Rj8MI7zAWd@fruit.crustytoothpaste.net>
 <xmqq8qgvfyq0.fsf@gitster.g>
 <aQM07BQrGJocPKea@pks.im>
 <aQPbMZpYZJQH_Fd6@fruit.crustytoothpaste.net>
 <xmqqldks3vqq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="USlPbHG8oaT9DXYR"
Content-Disposition: inline
In-Reply-To: <xmqqldks3vqq.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--USlPbHG8oaT9DXYR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-10-30 at 21:50:05, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > with my proposal.  I can send a patch to that effect later on.
>=20
> Presumably 1.63 is older than 1.77 so we would need the single-colon
> syntax in the output from build.rs in your series?

Yes, I will include that in v2.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--USlPbHG8oaT9DXYR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaQP24gAKCRB8DEliiIei
gdBFAQCwLean2LF60bkPsggMBChvwVScnosgBT9v0bbviEJ9IwD+MJCSY3WQIfdZ
rExBrBWztXMNX0l4GJDf0IyojSkHHwk=
=eocY
-----END PGP SIGNATURE-----

--USlPbHG8oaT9DXYR--
