Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=172.105.7.114
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793829959;
	b=NE3wuqCeoN6WDFurdPb50+UZ3RpsZ2tzDxRJZf79GchcXiI3ofG4JwrJLUpwLHVfZFbb
	 3C7Rh152sw1rC+ag01CtuBU7SJOoITITDh7owrxYbwPiH9P9DKoxP/h6D++du5iEA4yRL
	 ZQDx4W/FeP2/+GnYYL8zpt1dXgSS6hNbERGldBXKYkforbBpJhPJoz+xCVEGhWxlOGmoG
	 DStXAphosvsDgAnOT6IG4yt4TG+BwNj/ch79JTltNaev18QDCHQhbTEp/ESoCJpu9OSqT
	 4w1VGDoC9RXB9fZb0PHGtgpuoFJRBT+s3dR/iJyeNcfYBXtlL/nf9SOb78LirP/6pbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793829959;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent;
	bh=BTPyjbT4uva0pqZjUTUXL5utzniKm0aUAEHXaNGLRSk=;
	b=mAFa5HTnVDJ4ieepfbwftk5f/Q0WwA1FZ+ZACmzWNshEmFFTwMTqbbH+aOSOS+/XM0K2
	 CgfRliYI211tQXw4EW35GQmj90PD6dTl1wJiG8tAgnDzC53KtFUNvGV9oug9fTshnRavx
	 GIOQvc3ND1K8O5sC1EQx4KgM6PP0yGbP+5IJvVkedfg8ODVNctYouenNPvKK8eEq9Ic8x
	 shNlcFpvyvkEnDhWUTnd9wd8NSLJdDy6N92ilVT4wkwGkD2E0M9Wxx0ZviqOYs6PgJOKO
	 rhKfGdOkJ3QivUiDQxD86PLI2I83b6/wbVwh9d1GvQGuCa5bcXXpowBNxLyLaXortwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=crustytoothpaste.net;
	spf=pass smtp.mailfrom=crustytoothpaste.net;
	dkim=pass header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.a=rsa-sha256 header.s=default header.b=esKqKGUE;
	arc=none smtp.remote-ip=172.105.7.114
Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E840B606CA37
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 22:05:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E840B606CA37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key, unprotected) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.a=rsa-sha256 header.s=default header.b=esKqKGUE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1793829951;
	bh=ne5YXscipw4rRDgLlUJx21T01HjxmtnS3L+S0zfdVEY=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=esKqKGUEewaTpgySqt33PG0Y+35JAtu2eaBqO2h2kEXtPZeOiVPOpt7N2z38ACjgK
	 2tQ2tGX34SH6fJJ3zPOjCXMlKCBbKJHOvO1D1MXCZ+lcLfAwItZohFBkM7yh7+DwpC
	 0udBybW95+Sf1GScfqjNNaaV0X3EDkVNHmjHHtIEbyjNrI0Vow5yqmR/KXd6wHAGNa
	 yJ/MGfeZn2udgEYGaCvKzyA2K0tdAJ8NF41tK/ZjDjOh9pYjUQmlhbKmpwjbwidpmI
	 4T98EfHlTXjlbfHoeoILniug7me/dyFocqy+uX0jELAF4rm3Hgl6iCN4+Ci0gpk+IF
	 Jxy87GHqJ+VpcHzyPSK/q1MMcDLzwxXPyEK4d/XQLtHM0ujtasnGgjGnyIMh1lz83n
	 sxZUr2D346wxDdi4GTqFjR79p3+sBnK83kHeuKTeuIT591M/YVtoXWz6ZKbyxSZdt8
	 fMkoVfjbvnmZNpZ+pidOSodJoE7pLOfU2tEf0FFmyraXWHtUAyB
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:e583:5f34:4c85:81fa])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 7D95520069;
	Wed,  4 Nov 2026 22:05:51 +0000 (UTC)
Date: Wed, 4 Nov 2026 22:05:50 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Ravi Mistry via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>,
	Patrick Steinhardt <ps@pks.im>, Ravi Mistry <rmistry@google.com>
Subject: Re: [PATCH v2 2/4] http: add exponential backoff without Retry-After
Message-ID: <auusPUaYRmUBDsdI@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Ravi Mistry via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org,
	Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>,
	Patrick Steinhardt <ps@pks.im>, Ravi Mistry <rmistry@google.com>
References: <pull.2287.git.1793462224.gitgitgadget@gmail.com>
 <pull.2287.v2.git.1793732247.gitgitgadget@gmail.com>
 <fe1e847dede7579da911b5a9ba16c806b5332723.1793732247.git.gitgitgadget@gmail.com>
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
	protocol="application/pgp-signature"; boundary="/lPWL3vq1S/IIFnB"
Content-Disposition: inline
In-Reply-To: <fe1e847dede7579da911b5a9ba16c806b5332723.1793732247.git.gitgitgadget@gmail.com>
User-Agent: Mutt/2.4.1 (2026-07-04)

--/lPWL3vq1S/IIFnB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-11-03 at 18:57:25, Ravi Mistry via GitGitGadget wrote:
> From: Ravi Mistry <rmistry@google.com>
>=20
> When a server returns HTTP 429 without a Retry-After header, Git waits
> the same fixed http.retryAfter delay on every retry. If that delay is
> short (e.g., 1s), Git burns through all of its retries in just a few
> seconds before a busy server can recover. If that delay is long, even a
> brief glitch has to wait a long time on the first retry.
>=20
> Pass the 1-based retry attempt count to handle_rate_limit_retry() and
> double http.retryAfter on each subsequent retry (1s, 2s, 4s, ..., via
> http.retryAfter * 2^(attempt - 1)), clamping the delay at
> http.maxRetryTime. This keeps the first retry fast while giving the
> server more time to recover on later attempts, matching curl's own
> --retry behavior (while keeping http.retryAfter's existing default of 0
> for immediate retries when unconfigured). When the server provides an
> explicit Retry-After header, continue to honor the server-provided delay
> (or fail fast if it exceeds http.maxRetryTime).

We should not immediately retry on a 429 response, even if that's the
behaviour we have now.  The server told us we were being too aggressive,
so the exact thing we should not do is to continue making requests.  As
a server operator, I definitely don't want this behaviour; instead, we
should pick something sensible if no Retry-After is given, such as 30
seconds.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA
Speaking for myself only

--/lPWL3vq1S/IIFnB
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmrrrD0JEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ4OUnPvaVE10ltsZuSkOUYsAXAOv8ct8L2fPmddwgEof
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAPEHAQCNh62/6dft6ivlU9F2ny9M2MSm
xQKOF9yqQsCkwVCTDAD8DL49I8SL9T41JIW9GUXPBeVHTa1tvn+egd1hVotbeQE=
=kjjU
-----END PGP SIGNATURE-----

--/lPWL3vq1S/IIFnB--
