Received: from mx1.ddevault.org (mx1.ddevault.org [172.233.46.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3E9277CBE
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 07:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.233.46.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751872331; cv=none; b=IIQfQm1PLhNd3sKSZLda8N7RJPpjWO0UEB6gL/DuVJJ7PPipUBwYgqldnAIuUhTh2iuU5DV3KnhlHybVvRF7nGM2z1vzjcoJS2XfCU2w5Zq3PnIl2bcO4vLneVey4scXnq/J6iDUohZF3lat6gwXa0U2T2rzFKBOdGf+M/abmEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751872331; c=relaxed/simple;
	bh=Iq/ty7cEkoiaBIdAJNdBwdFYAWw+31O3ri7IR9BJlTM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=YZE0xczXrcGnItMCKvXR5SiiwfHOBoSlLu7yOnKPWUXLrowTZqPjL7AhJHChRSWiDNt1JuVU16JqZE5XpqtDi3yLWYn8EV8wpWguDSBxUWgllV3qQ0h0CzL9eHBIXJzqXoe4n7nCsP7785nXsO1GKX8Pu/ogASX+nyhoiTjQz8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ddevault.org; spf=pass smtp.mailfrom=ddevault.org; dkim=pass (2048-bit key) header.d=ddevault.org header.i=@ddevault.org header.b=1kJtLc6O; arc=none smtp.client-ip=172.233.46.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ddevault.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddevault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ddevault.org header.i=@ddevault.org header.b="1kJtLc6O"
DKIM-Signature: a=rsa-sha256; bh=Iq/ty7cEkoiaBIdAJNdBwdFYAWw+31O3ri7IR9BJlTM=;
 c=relaxed/relaxed; d=ddevault.org;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@ddevault.org; s=default; t=1751872325; v=1; x=1752304325;
 b=1kJtLc6OgTaIGsTTEKE27pMil9I1dv1Ax/+/B17RWpzJTLupT5TtsqGj9TOhBWhyB03MzuTB
 VJ1SiZAM/AP49VnVqUTjlYjqAW8b4oquVVEeJlmUvMlwJPB1fW0nzPDuUev6vz+XCI4q+2VAWAl
 nZ2QfyAMZfBYb+nuxNKzssQC9LrImNy1WtdS9k3EPkz2SLECKGekrIyw3aayNVvrToB+n6yG0v0
 PeHVMWHBOfvDSMEXIeX4wdFhnu0sJQdK6TyrHjGUlMl01EhhsNwcqCKx9lH6A+p6UjtkVpgU6E7
 JMi4G3/JDSm1th0t/HdJXsTUXCgkvq6/7XGWFMys7OfBQ==
Received: by mx1.ddevault.org (envelope-sender <drew@ddevault.org>) with
 ESMTPS id ddff5ef6; Mon, 07 Jul 2025 07:12:05 +0000
Received: by taiga (Postfix, from userid 1000)
	id EF4B170206F2; Mon, 07 Jul 2025 09:12:04 +0200 (CEST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=f5464bf135f76a793858bb44bd4e9a80a70e4bda6d8164fd0aabc73fb485;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Mon, 07 Jul 2025 09:12:04 +0200
Message-Id: <DB5MWRN5WUCZ.1DZ2SZ6WT3981@ddevault.org>
Subject: Re: [PATCH v2 1/2] pretty: add X-Change-ID to mail formats
From: "Drew DeVault" <drew@ddevault.org>
To: "Martin von Zweigbergk" <martinvonz@google.com>, "Junio C Hamano"
 <gitster@pobox.com>
Cc: "Aditya Garg" <gargaditya08@live.com>, <git@vger.kernel.org>, "Patrick
 Steinhardt" <ps@pks.im>, "Andy Koppe" <andy.koppe@gmail.com>, "Remo
 Senekowitsch" <remo@buenzli.dev>, "Jeff King" <peff@peff.net>
X-Mailer: aerc 0.20.1-64-g7cb8e0e7ce24-dirty
References: <20250703113505.11889-1-drew@ddevault.org>
 <PN3PR01MB9597069B8CF014BFE01B53F3B84CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM> <DB4WQTRHWZN3.3VG20AZDK8VN@ddevault.org> <xmqqfrf8ait6.fsf@gitster.g> <xmqqfrf88s28.fsf@gitster.g> <CAESOdVAGEBCYOnFGUFojRk=6s=7RHc0i2jzuOVdBd91dXsCTEQ@mail.gmail.com>
In-Reply-To: <CAESOdVAGEBCYOnFGUFojRk=6s=7RHc0i2jzuOVdBd91dXsCTEQ@mail.gmail.com>

--f5464bf135f76a793858bb44bd4e9a80a70e4bda6d8164fd0aabc73fb485
Content-Type: multipart/mixed;
 boundary=90660a5eea18371f42aa8edbfe2577f18444544c7b9b6d8f1ba82555ec86

--90660a5eea18371f42aa8edbfe2577f18444544c7b9b6d8f1ba82555ec86
Content-Type: multipart/alternative;
 boundary=023a7b9735601a961567bd32d4e3c1c21e1f69ad73f7fa5470dfc4a75f2c

--023a7b9735601a961567bd32d4e3c1c21e1f69ad73f7fa5470dfc4a75f2c
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Content-Type: text/plain; charset=UTF-8

On Mon Jul 7, 2025 at 8:57 AM CEST, Martin von Zweigbergk wrote:
> +1
>
> Does this also apply to commit signatures? I just created a signed
> commit and checked what `git format-patch` produces. I was a bit
> surprised to see that it doesn't seem to show up anywhere. Is it not
> supported or did I miss some flag or config?

There is, to the best of my understanding, no serious effort being made
towards causing commit signatures to survive the git-format-patch/git-am
process. There's also some confusion that often occurs here because
commit signatures are unrelated to PGP signatures and it is not possible
to make either system meaningfully aware of the other.

>> > In such a case, I fully agree that embedding in an e-mail header
>> > would be the way to go.
>
> Is it another option to put it somewhere in the body? Could we fit
> additional headers (e.g. signatures and third-party ones) somewhere
> between the `---` line and the additional diff? Or how about after the
> final `--` line? I haven't checked the specification. I just saw these
> lines in the `git format-patch` output.

I really think that it would be much wiser of us to put it in the email
headers, which already exist as a well-defined structured data format
for this purpose, rather than introduce something like commit trailers
to the timely commentary section.

--023a7b9735601a961567bd32d4e3c1c21e1f69ad73f7fa5470dfc4a75f2c--

--90660a5eea18371f42aa8edbfe2577f18444544c7b9b6d8f1ba82555ec86
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=42F3F1862E3CC4B8.asc
Content-Type: application/pgp-keys; charset=UTF-8

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgptRE1FWjdZOWt4WUpLd1lCQkFI
YVJ3OEJBUWRBL3BQeTZYK25OTDVUMlFhSktFTTA4eE4vS3o3d0ZUQVpvSDVZCnJpVjl4MW0wSUVS
eVpYY2dSR1ZXWVhWc2RDQThaSEpsZDBCa1pHVjJZWFZzZEM1dmNtYytpSk1FRXhZS0FEc0MKR3dN
RkN3a0lCd0lDSWdJR0ZRb0pDQXNDQkJZQ0F3RUNIZ2NDRjRBV0lRU2Z0ZWMzM0NXeW5ZN3NScEZD
OC9HRwpManpFdUFVQ1o3WTl3d0FLQ1JCQzgvR0dManpFdU1FRUFQOURIKzFMZ3ZUcVpETFo4YmFi
QjVDZHA1eTBaVytRClR4NzhtaDFMOGpKZDZnRUFzc21nc0ltY3JadjRhZFAyVVc1UlU1QkhDZTlL
VWR4MER5VjgzUXdsRkFTNE9BUm4KdGoyVEVnb3JCZ0VFQVpkVkFRVUJBUWRBR0FIOWRsYUNPTm9Y
cG1RZ0hvUWdZSTJ0UytWTTNtelU4STJQeVZZUQoxR1VEQVFnSGlIZ0VHQllLQUNBQ0d3d1dJUVNm
dGVjMzNDV3luWTdzUnBGQzgvR0dManpFdUFVQ1o3WTkxZ0FLCkNSQkM4L0dHTGp6RXVIY25BUDR5
ak9pTTB5cWtTVDZ5WHpEVVd6ZTdCOUltMjRGOEhWeCt3TnFjRGFEdGNBRC8KZktRaHowU0NQaWJs
TzZsYzdNRlV2bGFPejJ2ODdVcFVZUmh6UGRnUXF3az0KPWVtcmIKLS0tLS1FTkQgUEdQIFBVQkxJ
QyBLRVkgQkxPQ0stLS0tLQo=
--90660a5eea18371f42aa8edbfe2577f18444544c7b9b6d8f1ba82555ec86--

--f5464bf135f76a793858bb44bd4e9a80a70e4bda6d8164fd0aabc73fb485
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSftec33CWynY7sRpFC8/GGLjzEuAUCaGtzRAAKCRBC8/GGLjzE
uB4HAQCNvO4tkAaQ8WyS7KADurxXolYfWtw7FIWwDGzOCppfoAEAn9EotoKwm2AN
7vWlyGQ9MIsTTFLGq1L49HfMomcjUQE=
=dMtJ
-----END PGP SIGNATURE-----

--f5464bf135f76a793858bb44bd4e9a80a70e4bda6d8164fd0aabc73fb485--
