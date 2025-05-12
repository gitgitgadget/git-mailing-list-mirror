Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F1A171CD
	for <git@vger.kernel.org>; Mon, 12 May 2025 21:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747084780; cv=none; b=LpSUnjfFLM85rSRzXu8y8dQRLGQU0HbkKdoZffHhumg4lAs1BpLEdU4ngc2WIaonZGMJdIzjyvJ/wHHSQJPhW91q3fKJ110Al3n3cA/ix4KN2LBJV8dClDS4i5kvPrCyshh4qbaK3jYM8/y9n2MxeUiG8gcH8nPL21RDw0mn/wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747084780; c=relaxed/simple;
	bh=WCvpaoXrjkcm9IlNN0NCi8zU5ZO511uZC13X5pjy15M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QgsEfqu50d2qjF9lCrw5xmhANFKpQPLYdldlp7BDFU/ru4NbMHwMHcaxpxkCfNTP6w0BkFREFYYMyETwwcu6eee6bPW1l0Y+WQ1Hidt4CB14obYKSAnx0h6D0aV37e1yDry9jGni9FH9Z0gCRIPw/8r7OHrUJf3/bOuUurvNcvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=bxbAiBJh; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="bxbAiBJh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1747084775;
	bh=WCvpaoXrjkcm9IlNN0NCi8zU5ZO511uZC13X5pjy15M=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=bxbAiBJhN2l6iDGA2EhHW+RvqrcS0FzeBuWXk8W3eU5YahZ7UicM3eZKBSkyCj271
	 yYRixDzfLicodCq6MLyb1zTAuA0YArGN4PxSpft0k8n9C476nf5sah5u2phtIR2Zon
	 WLc1W130MzRFFT8F3ncn/4Se5SvKEGouvNC/MKuDn+Hkk+wwiHAwg64Dv9tOM/UOLE
	 RNGrFV84pPaXUeYm8fiFVlS91OLvvgHQ8zyat/8Uv0TVVTeYEu3f0hPCad+ifJP3sT
	 PjlLNvAarHByjKljdaufZT0MsrbbUrw7dQ4iOu+Y7YgETA6CgWfzCdhLsE3FIPXR3l
	 Q/YAxQVI38ISorinYUUwjpTxiZbghCNAPCm+LxiYYv8I81cehX8FukIrQ/TdMWsnfw
	 Xx5EJG5OlT9j5M7odgZOPUNY0uuvmn+5BnRhOdGxGOZgIU58zWLH4u5Pj54B57Iy6C
	 q+qB2E2xdkIHN6n9F0OWxSnJlvrUhv9X8dkGqisUCFfSrYfs5B7
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:df25:78ac:1a43:dee8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id A388F2010F;
	Mon, 12 May 2025 21:19:35 +0000 (UTC)
Date: Mon, 12 May 2025 21:19:34 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v5 4/4] builtin/stash: provide a way to import stashes
 from a ref
Message-ID: <aCJl5gr_ebxvRhiD@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>
References: <20250508234458.3665894-1-sandals@crustytoothpaste.net>
 <20250508234458.3665894-5-sandals@crustytoothpaste.net>
 <20250510172107.GA601540@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x0eTXAI0EWRw6lsN"
Content-Disposition: inline
In-Reply-To: <20250510172107.GA601540@coredump.intra.peff.net>
User-Agent: Mutt/2.2.13 (2024-03-09)


--x0eTXAI0EWRw6lsN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-05-10 at 17:21:07, Jeff King wrote:
> I noticed because I have a patch series from last summer tightening
> these rules (it got derailed by some conflicting work, and I've been
> meaning to pick it back up). I can certainly adjust these tests as part
> of that series, but if you're re-rolling anyway, it might be nice to do
> it now.

I've fixed these in my branch and will include them in v6.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--x0eTXAI0EWRw6lsN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmgiZeUJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZzgJbkx6rreXhp1lQMusfwnNue11lKjuDnv/JCn+2yxV
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAOtDAP46mMfa8mHe/BvpRGVg8CflsE6i
OQJ8SrEvOV7F4WzqpAD+NClA2gJT1DCSaPMFn3u+uAHUVYIGyhoxC1u2EGOe+go=
=Bxt5
-----END PGP SIGNATURE-----

--x0eTXAI0EWRw6lsN--
