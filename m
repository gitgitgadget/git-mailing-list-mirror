Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBACA25484F
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 23:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742945362; cv=none; b=Sj2ukivX5I211k5h0RmY0WPxhp3l7zSKl/5lCVgwHhTryHbZi4OioA8Da8jUVunmcx5TlY1sQSQ7ojLl6sfHMnt8JLGfZnA3vVzAvwWc49YguFiKWyUvyzHfZ+TZp47A+4VYjoLsEtrglCCc2/WwVv+Uy3vHeHd6cq3t6KuTJuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742945362; c=relaxed/simple;
	bh=1X2JzuctG5SgFPuAZxGgVPrM+uVXAmRXrwbiOBY9OrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QWrWRwPjSV4H/hvcHum+sgSyVN4SUmqDwVnv151U/sVd6WEPCMOsuVKS4HrU5CzKNIlVcsiHfQ0c5B//3XVf4ojXKXmxx5EPGk+dW126/1JbdahgqSwuC9SR9zPHLa2BH32/1zylRGe7eDRbseYBGc2CmNSp0XxO1P8SDaaaqY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [IPV6:2603:6011:3f0:6f00::12ac] (unknown [IPv6:2603:6011:3f0:6f00::12ac])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: eschwartz)
	by smtp.gentoo.org (Postfix) with ESMTPSA id C677934319A;
	Tue, 25 Mar 2025 23:29:19 +0000 (UTC)
Message-ID: <68d381cd-3803-47a7-b7b1-8ef09b73a48a@gentoo.org>
Date: Tue, 25 Mar 2025 19:29:17 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] meson: disable coccinelle configuration when building
 from a tarball
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
 Sam James <sam@gentoo.org>
References: <20250325200542.197687-1-eschwartz@gentoo.org>
 <20250325200920.198057-1-eschwartz@gentoo.org> <xmqqpli4lmsi.fsf@gitster.g>
Content-Language: en-US
From: Eli Schwartz <eschwartz@gentoo.org>
Autocrypt: addr=eschwartz@gentoo.org; keydata=
 xjMEZmeRNBYJKwYBBAHaRw8BAQdAYNZ7pUDWhx1i2f3p6L2ZLu4FcY18UoeGC04Gq/khqwfN
 I0VsaSBTY2h3YXJ0eiA8ZXNjaHdhcnR6QGdlbnRvby5vcmc+wpYEExYKAD4WIQTvUdMIsc4j
 CIi+DYTqQj6ToWND8QUCZoRL+gIbAwUJBKKGAAULCQgHAwUVCgkICwUWAgMBAAIeBQIXgAAK
 CRDqQj6ToWND8aB5AP9r4kB691nNtNwKkdRiOdl7/k6WYzokvHvDamXxRJ0I+gEAjZqR5V8y
 mfR3fy2Z+r2Joeqdt3CIv5IwPs64spBvigLOOARmZ5E0EgorBgEEAZdVAQUBAQdATT46Z06b
 1X9xjXFCYFxmq/Tj3tSEKZInDWTpoHQp4l8DAQgHwn4EGBYKACYWIQTvUdMIsc4jCIi+DYTq
 Qj6ToWND8QUCZmeRNAIbDAUJBKKGAAAKCRDqQj6ToWND8a2RAP40KPfbfoiZAJW5boFmFJ3G
 TUBDJRh9CWHyaPqq2PN+0wD/R07oLzfnJUN209mzi9TuTuHjeZybysyqXSw4MAxkMAY=
In-Reply-To: <xmqqpli4lmsi.fsf@gitster.g>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------JPM09Pr4wWCogCwZxyIV74Gr"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------JPM09Pr4wWCogCwZxyIV74Gr
Content-Type: multipart/mixed; boundary="------------E0f9V1xoQCxshDygRNK95wlh";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@gentoo.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
 Sam James <sam@gentoo.org>
Message-ID: <68d381cd-3803-47a7-b7b1-8ef09b73a48a@gentoo.org>
Subject: Re: [PATCH v2] meson: disable coccinelle configuration when building
 from a tarball
References: <20250325200542.197687-1-eschwartz@gentoo.org>
 <20250325200920.198057-1-eschwartz@gentoo.org> <xmqqpli4lmsi.fsf@gitster.g>
In-Reply-To: <xmqqpli4lmsi.fsf@gitster.g>

--------------E0f9V1xoQCxshDygRNK95wlh
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 3/25/25 7:21 PM, Junio C Hamano wrote:
> Eli Schwartz <eschwartz@gentoo.org> writes:
>=20
>> presence indicated a desire to use it on this source tree. Instead, we=

>> can expand the conditional to check for both `spatch` and the `.git`
>> file or directory.
>=20
> Good thinking.  I very much appreciate that you allowed .git to be a
> regular file, as well as a directory.
>=20
> Will queue.  Thanks.


As a heavy user of worktrees this topic is certainly on my mind. :D


--=20
Eli Schwartz

--------------E0f9V1xoQCxshDygRNK95wlh--

--------------JPM09Pr4wWCogCwZxyIV74Gr
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQTnFNnmK0TPZHnXm3qEp9ErcA0vVwUCZ+M8TQUDAAAAAAAKCRCEp9ErcA0vV7YH
AQD/u+Zo+u6LBnKztUfrqP9StHc353ikI9cbChXwJN1AeQEAzBpp26oMMUwPfS1AP6hdhHa2US5C
bPCYd7RNmF6EPQs=
=UW7I
-----END PGP SIGNATURE-----

--------------JPM09Pr4wWCogCwZxyIV74Gr--
