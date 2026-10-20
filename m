Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=172.105.7.114
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792456239;
	b=kamAh+rMUa0UN3QBbiHj+cCB2qAEvbOYPuiyqZ3/VcPeDyu88KTTKrqMsuTqHv2S2NDI
	 JAVLOLQWIuA3yTGONk3zsm7pwRtZNpZcOQazQ9FyaQQvdPiqadEfzyGc8fCDVsSaWi3vu
	 xPRY0qpQSK4SSfSZsl7n0htT4GmwkJDhfg7w6Pr6MfvPX0oqvbXVKJAtkI7rWzcMBko8Q
	 RFCjyrWWBjIKBCMCYO3VCzba5460h0dDjM3f2QSttzakYJGQJ0M37DC5nH5DilRfx0BUg
	 uSgctFlnQMgLEhP9NNGTggfhMeeH1l5BDcsi9OnzKLlwnFRoSUzAIlbMgfaloedeuFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792456239;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent;
	bh=OZgBTO49wUdrV8KkhOD8+Dp087DWEqIsSao3Sido5is=;
	b=kZJFmZ4ZjTqT6TKFd0v2oW9xtvs2OrHVRbIAHXle7+1W2Nkmph8dX8j9WIgI/bnUQ+KL
	 ebu0agOUQlR/TM0T8137jPEZotqPuzFF6/wlqFKX5YJghVK8Qy7T7yS/4BaHaW2J4XH1A
	 st36bt83Eb8sOKwsg3G82GQ7jUaL1jKcZkRN57uBT//SHEL1lVlHbYbD5bUUwZNDvjTdO
	 As9pjjOR8s393+O2wPeobuYi7nMP6TI0HbcuDhJYh7GPZMDX+j5NBoBiqWT5/hFSsxUPD
	 u0OeQDGmqwtBHWrE5ot3pezeLTfvsX9OIJI8HESZRpd+rSBXl5X5TPwTHu1Jy06/Xyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=crustytoothpaste.net;
	spf=pass smtp.mailfrom=crustytoothpaste.net;
	dkim=pass header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.a=rsa-sha256 header.s=default header.b=TUwLXAxo;
	arc=none smtp.remote-ip=172.105.7.114
Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE720606A31B
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 00:30:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE720606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key, unprotected) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.a=rsa-sha256 header.s=default header.b=TUwLXAxo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1792456232;
	bh=PPYaKr/m4l7AF6ocpbeJxkRrbVkiLLVdNj+/NNVToI0=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=TUwLXAxoFlQVkWAmmEyiaZlA579zCWyyPXN3zGq7TJqby/OhBVkG5vgc97IUGdts1
	 mXYjvTItLfOS69IXtBBBnpdQi2pH3IVGETtWvvylvZeiGhhVC1GetzRp408EBwZH3y
	 2ZDP+eqlN99Do4wbYAJlPMu+fYzI8UvykATwLw1pJOQatZGcF8OT1KQgy5mAdBc/Jo
	 2VP2wWXX1fsU/VoNAm5A/vwQjoGvEC1hap3cmkKomYgmWTzAGv24/T28DY0i1VccO3
	 Zn5wkzSnNce3mKKmlcOIgxedvVoMah6Aho06QqjVscPQnsfjED5p6sQ1FWjKPoRsfp
	 A3UixI+MA0EaDEM49evf3JVEqrkJWTTIf8gxBYHVuiUf6f0jecvWlfUILqBMefzpa/
	 1ACEa0gzE+y34mvQsjewCe77h/wXxj0cQRLjdyYKit5xjVCRPbsAHgtYignMykbwLz
	 hWgNaToxHJgvPXbZ67y44QgZgWvtQiA2hLFDxPuerJ99YzgITNz
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:7fd6:c7db:c427:a310])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 0B690200FF;
	Tue, 20 Oct 2026 00:30:32 +0000 (UTC)
Date: Tue, 20 Oct 2026 00:30:30 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Todd Zullinger <tmz@pobox.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2] github-ci: update macos jobs to macos-15
Message-ID: <ata2Jg5_0Q6HnN8u@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Todd Zullinger <tmz@pobox.com>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
References: <xmqqfqy5clgz.fsf@gitster.g>
 <20261019194152.907881-1-gitster@pobox.com>
 <20261019234724.H0mV3jqQ@teonanacatl.net>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ELq52gSQryeHpxh+"
Content-Disposition: inline
In-Reply-To: <20261019234724.H0mV3jqQ@teonanacatl.net>
User-Agent: Mutt/2.4.1 (2026-07-04)

--ELq52gSQryeHpxh+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-10-19 at 23:47:24, Todd Zullinger wrote:
> I know very, very little about macOS (in general and with
> respect to Github CI)...
>=20
> Is it worth using `macos-latest` instead of `macos-26` and
> letting those jobs move along with the current macOS runner
> as it changes?
>=20
> The documentation=C2=B9 links `macos-latest` to `macos-26` at the
> moment, AFAICT.
>=20
> I don't know if that moves to the next release too quickly
> to be useful to Git or not.  If not, maybe using that will
> be a more convenient way to get macOS coverage where we
> don't have a strong preference for the version?

I believe macOS releases once a year, so I expect that the macOS version
for GitHub Actions will update about once a year as well and that one
version a year will be removed.

Using `macos-latest` would be the easiest way to keep up to date, but it
would also mean that we wouldn't test older OS features.  As far as
POSIX features, it's likely that macOS will stick pretty closely to the
standard because until very recently, it was UNIX certified, so that may
not be a practical concern.

I don't have a very strong opinion about what we should do one way or
the other.  I would be much more likely to want to test across different
versions of Linux, its C libraries, and compilers because there's much
more divergence there in terms of potentially breaking changes and a
much longer lifespan of OS versions.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--ELq52gSQryeHpxh+
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmrWtiYJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZzWK3dEEHbXtpgDvPGx8+BLcq2rXuRfsWx12llupPH6g
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAHUAAQCYSTRongkcSY0woWb+5Ax9XsU8
xxxC5J3Tzle5E+9ZswD+KVSarGtSEOBtIBEqNy56lvkadNASc1iqfzwTZ45PAQo=
=Q0n4
-----END PGP SIGNATURE-----

--ELq52gSQryeHpxh+--
