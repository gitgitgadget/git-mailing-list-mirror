Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3ED19D09C
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 14:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752588868; cv=none; b=RJ8OcU6ZQYt+MabeaW5v7mJrkG7bB/Yxu1k49xMfUrbc9VviSkKwOP36x82m7dPMJFkw6WvcgQQ/BsrRLsRw2i1MPHuhbZ7RgOTqGux6lOIRHRx6yy3JC9vk52yZp7DLc0jALmgeuegogfhWZc1iFnoF/Gdf4O6/tOPDX+WfirU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752588868; c=relaxed/simple;
	bh=sym9xJIDx4BHjeArC0/D/7qDEOvvMz39GeULrkYJuyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UZTABqEsqWXODM8vwkR7pm0BrgWVwvRJamzZ/ZlLWYIuq0Rw7dkIiraD+PEmgx3uXREgKJqYB/JRwoAHvv7Wnlr4HYQ0YPOUbK+7wBHVFnUdAYmVAD7C2X2vJ5zqOoqAnIKSyxNV/gbXDbkO1u6DKFhokQopvpIttmV5sf3kiUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [IPV6:2603:6011:3f0:6f00::12ac] (unknown [IPv6:2603:6011:3f0:6f00::12ac])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: eschwartz)
	by smtp.gentoo.org (Postfix) with ESMTPSA id C40A5340DBF;
	Tue, 15 Jul 2025 14:14:25 +0000 (UTC)
Message-ID: <2f068703-1825-464c-94da-d20f96ed9591@gentoo.org>
Date: Tue, 15 Jul 2025 10:14:23 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] meson: disable PCRE2 dependency by default in macOS
To: Carlo Arenas <carenas@gmail.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, gitster@pobox.com, sandals@crustytoothpaste.net
References: <20250713122341.17976-1-carenas@gmail.com>
 <20250713174807.32444-1-carenas@gmail.com>
 <2414b962-e843-4ac0-814f-bb4bc7aacda7@gentoo.org> <aHYVdMii_rP5-ywa@pks.im>
 <CAPUEspi2VJ5OYTFvsdZSn9_+rqN=x_o=Uwchw1fJeipvDF3LSw@mail.gmail.com>
 <aHYuS0OgW_mPE34d@pks.im>
 <CAPUEsphA-XadsPU1mkdTQM7qjMKtZP8gJXWwZ8WmFutj8WS_rg@mail.gmail.com>
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
In-Reply-To: <CAPUEsphA-XadsPU1mkdTQM7qjMKtZP8gJXWwZ8WmFutj8WS_rg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------lCrQdIAYFBlWzwiZuRwZxNGa"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------lCrQdIAYFBlWzwiZuRwZxNGa
Content-Type: multipart/mixed; boundary="------------Fs1fRHjRVEBNBBlMpoE31cpe";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@gentoo.org>
To: Carlo Arenas <carenas@gmail.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, gitster@pobox.com, sandals@crustytoothpaste.net
Message-ID: <2f068703-1825-464c-94da-d20f96ed9591@gentoo.org>
Subject: Re: [PATCH v3] meson: disable PCRE2 dependency by default in macOS
References: <20250713122341.17976-1-carenas@gmail.com>
 <20250713174807.32444-1-carenas@gmail.com>
 <2414b962-e843-4ac0-814f-bb4bc7aacda7@gentoo.org> <aHYVdMii_rP5-ywa@pks.im>
 <CAPUEspi2VJ5OYTFvsdZSn9_+rqN=x_o=Uwchw1fJeipvDF3LSw@mail.gmail.com>
 <aHYuS0OgW_mPE34d@pks.im>
 <CAPUEsphA-XadsPU1mkdTQM7qjMKtZP8gJXWwZ8WmFutj8WS_rg@mail.gmail.com>
In-Reply-To: <CAPUEsphA-XadsPU1mkdTQM7qjMKtZP8gJXWwZ8WmFutj8WS_rg@mail.gmail.com>

--------------Fs1fRHjRVEBNBBlMpoE31cpe
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 7/15/25 8:08 AM, Carlo Arenas wrote:
> On Tue, Jul 15, 2025 at 3:32=E2=80=AFAM Patrick Steinhardt <ps@pks.im> =
wrote:
>>
>> On Tue, Jul 15, 2025 at 01:56:44AM -0700, Carlo Arenas wrote:
>>> On Tue, Jul 15, 2025 at 1:46=E2=80=AFAM Patrick Steinhardt <ps@pks.im=
> wrote:

>>>> Agreed. I guess tha only reason why I picked "enabled" here is becau=
se
>>>> we also got a wrapper in "subprojects/". But with this new workaroun=
d in
>>>> place I agree that it is sensible to switch to "auto".
>>>
>>> AFAIK the "wrapper" fallback still kicks in when the feature is "auto=
"
>>
>> It does, yes. But with 'auto' as default it means that we're free to
>> disable PCRE2 if we have detected a broken PCRE2 dependency.
>=20
> My bad, I was mistaken and indeed auto doesn't fallback to the wrap, so=

> this will likely regress in windows if it is not invoked with `-Dpcre2=3D=
enabled`


See
https://mesonbuild.com/Reference-manual_functions.html#dependency_allow_f=
allback

The default is to fallback to the wrap for *required* dependencies
(rather than abort the build). If it's desirable to have "auto" attempt
to automatically enable the feature if

system_found || \
(!wrap_mode_nofallback && (have_internet_for_wrap || \
    have_locally_downloaded_wrap ))


then you can use that "allow_fallback" kwarg.


--=20
Eli Schwartz

--------------Fs1fRHjRVEBNBBlMpoE31cpe--

--------------lCrQdIAYFBlWzwiZuRwZxNGa
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQTnFNnmK0TPZHnXm3qEp9ErcA0vVwUCaHZiPwUDAAAAAAAKCRCEp9ErcA0vV28L
AP9Jy1ApjYrQJbDlecN+xQW5AIJjSCNA2sVIeSDi2AC5ZAD+K1PXdy6evgkQ8gwqiAHu25Hjitzo
ALEuJgAOznNOJAk=
=XwOg
-----END PGP SIGNATURE-----

--------------lCrQdIAYFBlWzwiZuRwZxNGa--
