Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D2F3BD25D
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 22:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775860521; cv=none; b=ounfjDwhjAClGRUznnGubl4qakVB+jQUE7XqxVz7KqwdJBTdr0N84a+p0aJIog9rrlxhAMIA7xIUngNGGTnpx/JV7HL4A4BPF9ltgCY0eddWERwXRbQIhyZd3vTUi8tz/OWnaeXKbDwZzhUO2pzQsFOYcKC5ywMHeeJWIv2wATI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775860521; c=relaxed/simple;
	bh=5MH00MpFhbj2OkFCMMkeugKeBOoVl4ZFrShazCTvRWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PO3dhAp0oj1X99BGbshBlHRASRHlZosPwh0poLTxCXLtNWDzgXQ+7AeIRFce4aTxNMZdUaFTeDcLuYoe5kQTds23/Hdw8GtIyouo/9N1OGWo76Pndhwlwnz7lY5xaWMzO8I5EKkDhaIy73lApVek1kf6oCe1Mbv2Fwkgo/YM1Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=EoMu1Hu0; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="EoMu1Hu0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1775860519;
	bh=5MH00MpFhbj2OkFCMMkeugKeBOoVl4ZFrShazCTvRWk=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=EoMu1Hu0hxNN3k35tljv3LxTTS0Crp3FhxqGp8JyhMQacmyCfyevSfM4D7GTrhJbg
	 iR4EOaSfa4Ee/np9laTO/8yhM1O3mJ2gKI183fWNxApuaYdTSDNNiZlVBVBnQUf140
	 /m5U6RpvrYu/VlNJoZXosl6+s7XB84U3tPW49TW8oHK1XK19gdT7vQKeeGPLJUWb9F
	 PgdSoQfoVuJ+SBz4Cxvb8HHSeZV1UT08adRvYJis58y/neP52CpF8prvrCcOWL+aMo
	 SPyH//CFSJctEDuQ/SSRWrCcTt4bl03yJDBjTPgZaHg84TpEGmMubLIvngb6zJiyPb
	 TuLd2Y7au1MgoznhgxwBokq8z3qyOmpCUI7nuR+7ZePTYalQ6tEpAk6Nef10KCAT5V
	 Z9L2UujW2+QqQavvBUqYF+wkdpXigA7dv/3TIOccizaRW82ujXHSL3FxDpJo5/N8X6
	 yDoj2m68v2SeYuB8h8MGUxzmTj0qTm9t9foYq1Is8LvAR79JM+e
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:690:ed17:613c:3cb7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 41CA920039;
	Fri, 10 Apr 2026 22:35:19 +0000 (UTC)
Date: Fri, 10 Apr 2026 22:35:18 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH v2 0/4] Enable Rust by default
Message-ID: <adl7JnCX5ndoAQNt@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>,
	Ezekiel Newren <ezekielnewren@gmail.com>
References: <20260409224434.1861422-1-sandals@crustytoothpaste.net>
 <4efc4133-3726-4b9d-8f06-03c07d48af99@gmail.com>
 <adlXscAv57Xd7p01@fruit.crustytoothpaste.net>
 <xmqqpl46o980.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MBfx9p38twSLTpaG"
Content-Disposition: inline
In-Reply-To: <xmqqpl46o980.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--MBfx9p38twSLTpaG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Huh?  I actually was hoping that we would tag 2.95 when everybody
> feels that 3.0 is on the horizon, and if we are lucky jump directly
> to 3.0 (while leaving us room to issue 4 extra 2.XX releases if the
> timeline turns out to be too aggressve after we got such an
> agreement and 2.95 turns out to be premature).
>=20
> You are saying that we'd skip 2.56 and jump directly to 3.0 at the
> end of September?  I do not recall seeing any discussion, let alone
> a concensus (rough or not) with such a short timeframe.

What I recall having seen suggested on the list is that we were thinking
one of the 2.5x releases would be the last release before 3.0 (I think
maybe somewhere in the Rust discussion), but I don't think we actually
discussed it in any detail.  We did definitely discuss the 1=E2=80=932 year
timeframe at the September 2024 Berlin Contributor Summit, though, which
has been my guide for getting things ready for Git 3.0.

I think your proposal here sounds more sensible, though, and possibly
nicer for downstreams since 2.95 reads more like "getting ready for 3.0"
than 2.55.

Anyway, we should probably start a separate thread to discuss plans for
the 3.0 release and what we think is missing for that.  That would be
more discoverable than hiding it here.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--MBfx9p38twSLTpaG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmnZeyUJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ1eBZmZvvazJoPKRxix3oelDKzB1tHs/TZ2jItQRJTCn
FiEECCzmip28ZfuD0cORfAxJYoiHooEAANBMAQDeEuKfjzLJcsn4kiNCAhhDSIUT
5zFfFc3n5BxO9EmIJwEA8KX0kzMxSDjnLJoJk9IMlR5UYjCPhYdP8YHtt2HYWgo=
=zJsh
-----END PGP SIGNATURE-----

--MBfx9p38twSLTpaG--
