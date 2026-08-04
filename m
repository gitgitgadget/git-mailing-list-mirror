Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C60F308F32
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 21:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785880008; cv=none; b=EGb4oiQJma23jqAO5IGj2lPfrEAoZc6VeYC2uCjrPw9flQm8wF9JInbyT974ToKMvc7rjD2NZDNOsWkIQIHC9I0f4P98dXAkk0mP9QK1ILykFa90YHoxIIvWJ7VAZjR0djEnVbsj/VhV9uPPNjuDmAt9AR1Iy5+XOoXB89f6oHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785880008; c=relaxed/simple;
	bh=DV/K8A8Z9ww1NM5OljOuV8+9qH8v10i4Gd/SqxxxMXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X9iRG8SwwS2QRz4vnLgcns/NpKNIhg55FVgQ9eB+02uZYe6bt/57sqf5zwjZti94wPNzAsdNBExHkrFfFkZMyycOsgz/U1lMn2fCJ+1rJlhXib4/jKd2mjuAUuNRDlkP5qLzaDcthT/2KPrnWyN6i7ZhcQao7oFgHXlMH4bVAGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=dVCOk7Gu; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="dVCOk7Gu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1785879998;
	bh=DV/K8A8Z9ww1NM5OljOuV8+9qH8v10i4Gd/SqxxxMXw=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=dVCOk7GuXoMMUM1ptiBCYY8Qrci8Q2NajdXpYJ20t+XKz7PAjgEwPaNU7Fxvkmba/
	 L9GQ2gpwCHQ5e5lqvdmT9819X4xu5GH+CHboO2cix1pTKcgfJgvWNkJ0qbjGwylop2
	 QC0oH5Q0Wf8fg1c2pnCqCHdL2F4beWmFAjvwSQ3g0FJld5NxDhvfJffXGPITEwKZD4
	 U7WlpMV4pg8akrGxsiLoZZoadgANgGkh4p9OaBKWcbYspl3MGGrqs3C9uIbgBanUlw
	 Ox/FTlTr6Ws1eBosKzIVp9I9L8WFvTu1aycsK0nhJdkrkuICQjS/qHr3RVEkoTurYs
	 3hBLT9VGjpW3A0t3GxKcEDY36R9g/hDvX0YVtqCpj+AXlxlR0INNkYRHPqv37DuFAq
	 empcsvkGct8OABSU/ExmLJbUMwdKXRJXAziCOa+DlsskVTThVq8aScFQY77sRRCtmq
	 5iRSfuUll2uzVGfposOqEG7YYTkyuwxdJLp91SVkIIn7pSPXCX6
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:c925:10f2:5963:c20e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 8FBB520112;
	Tue,  4 Aug 2026 21:46:38 +0000 (UTC)
Date: Tue, 4 Aug 2026 21:46:37 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [RFC PATCH 6/6] hex: allow only lowercase object IDs in breaking
 changes mode
Message-ID: <anJdvLV7-raJK67B@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20260729233215.398654-1-sandals@crustytoothpaste.net>
 <20260729233215.398654-7-sandals@crustytoothpaste.net>
 <xmqqv79vha69.fsf@gitster.g>
 <am_AL9dymrkidizF@fruit.crustytoothpaste.net>
 <xmqqldalvfzx.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xmFW2lwfKe2Avdms"
Content-Disposition: inline
In-Reply-To: <xmqqldalvfzx.fsf@gitster.g>
User-Agent: Mutt/2.4.1 (2026-07-04)

--xmFW2lwfKe2Avdms
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-08-04 at 19:32:18, Junio C Hamano wrote:
> Will queue, but I invite others to chime in.  My practical side says
> we should just take the series as it is much less work for us to
> declare that any incompatibility fallout is the problem of other
> people who have reimplementations of Git, but my more principled
> side feels dirty, just for saying this ;-).

I appreciate that, and I do welcome other viewpoints here.  While I
think this series a good idea (or I wouldn't have sent it, obviously),
it's really up to the project what the right thing is and if the
consensus is that this should be dropped, then we can do that.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--xmFW2lwfKe2Avdms
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmpyXbwJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ7Xo6OVgAZHFvZeSywWHERR08UTCLqGPpJWzumd0pzkW
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAKXiAP4rUFk98x775GLNH0j8Jo1xI21h
SZnQhDJTBoRgnfNMYgEAgYaJwtZdgcUfHAGZ21jP18jE+BVy8eUTIiUzNFKNOAM=
=qLlO
-----END PGP SIGNATURE-----

--xmFW2lwfKe2Avdms--
