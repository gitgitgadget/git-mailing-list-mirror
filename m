Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C673878F40
	for <git@vger.kernel.org>; Fri,  9 May 2025 20:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746821808; cv=none; b=sXKC2zujOpVIoHmvvAxJaUWlRYEURLEUaKEHXSCaLkbU13wP1+Lbh3v4wRV/frX/THdToXqem60+0kD8qHaUAcCb5paJvpJVLuZKgRlc3HibLRzynzzU+SrB7aY2cBo8T8gJEw9GqlPrczjgoMJfKOCY9fX9t7ScBey+T6vW6kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746821808; c=relaxed/simple;
	bh=jB9mkyCo8KbH6PxcWKZzPZG03Sq9zI9euMC7d/sw06Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p58XPRHpC3fQK6NkBfUdnoipAzsSHdGGpMm1rcPSc44TsyysPuBBDO82O9QUnOS0vaCrtEs2Ae6433fcZyI6b4jpnEkMWYwXHhYdNGUx02GXYaYvjOEMEUhsvhQljno6T0wcv+g3tXQsGcTmrm9n/cRxcyJwGbIgcFe34y5l9fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=TLx0mmiH; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="TLx0mmiH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1746821805;
	bh=jB9mkyCo8KbH6PxcWKZzPZG03Sq9zI9euMC7d/sw06Q=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=TLx0mmiH5alxsvYnS32NWI3zKGP1Bkimml4l1pOsd7ujlZ+cWIu/5t1upsWgyWhmS
	 nVseDte0drrRMFG3btyx6q0s3mocOto/HARBAFNelMIZUBf4eHoLVGGxQBsKRoBWfo
	 fGvnv2/fjhDG7NYCKDhf/aeuRU5YPooUsMZxtwOZMeAnt37zaadyxEt/gHTFqdi4mK
	 b6uVdKknyqu7D1X4/vbR5IgVdUS5DBrj3u7ryCGod+xZQE9CU0HGlxz+2Ci20mkDmd
	 SYGM2Dg1FLLz/1BN/uYvsp5/gIm6W3qo9g06h6aq5yyw+r9RS9X1Mv4+nBe00fvuyg
	 lPUDBnc78uv8cyMJyPSRFv832vkJ9mQByClxsDuPTWcUvYajOU3RRCxCbz4NF1StJn
	 GSuVY94RO7AAn02r8CStcvlfMc++OqcTLv0K4bRoDh6ME0TQ2ycBcLkOoNGkq4VBZm
	 N/uYfgyJnkCRaLt3FzWmEdoqk9guQgxbQYjNibzktevNFjTLpaG
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:df25:78ac:1a43:dee8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id BAA7F200C6;
	Fri,  9 May 2025 20:16:45 +0000 (UTC)
Date: Fri, 9 May 2025 20:16:44 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v5 0/4] Importing and exporting stashes to refs
Message-ID: <aB5irPERgQx20HJ3@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Phillip Wood <phillip.wood123@gmail.com>
References: <20250508234458.3665894-1-sandals@crustytoothpaste.net>
 <xmqq8qn64mho.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bir0Ounl11/x5IgX"
Content-Disposition: inline
In-Reply-To: <xmqq8qn64mho.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--bir0Ounl11/x5IgX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-05-09 at 01:10:59, Junio C Hamano wrote:
> Thanks for resurrecting the thread.  Once this part gets sorted out
> and the outside-reflog representation of stash becomes stable, the
> next logical step would be to teach the "git stash create" and
> friends to directly work on the new format, perhaps?  But first
> things first---export+import would certainly be a logical first
> step.

That could certainly be a follow-up, yes.  I don't currently have any
plans to do that, but of course someone else could or I could be
convinced that it's something I should pick up.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--bir0Ounl11/x5IgX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmgeYqwJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ2/KFqw/6zuDkBG8WHm1Y9aVV9es55ga9Wm5wrgs1ln+
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAD9YAQDbrb1DLk6bnfK1Br5TWpYdEZ2d
BWlbI2QlZ4nMRleLXwEApb+3Gbdr3QphKYG98oLh4dbyVQeUeYSI9IDe9fhNGQY=
=DPv9
-----END PGP SIGNATURE-----

--bir0Ounl11/x5IgX--
