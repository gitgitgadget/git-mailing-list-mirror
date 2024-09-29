Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2BA22611
	for <git@vger.kernel.org>; Sun, 29 Sep 2024 18:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727633430; cv=none; b=kyt+rOV/bdx1oLRa2ZeICH9hdpjthcwrADe9msyP1KepEA6/EsCkdXidQ6unkSOTT8GLDxiYFoeLlLDRnPRJqWNke84FIc1aQqrZPh9M0iGOq55XL6qCTquua3wiJjNtJSqIdLsPKAEkziIQi9t6ZMTvGZuYRM8q+/5nfkbLt9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727633430; c=relaxed/simple;
	bh=PXLFNZ/881fcpvTRTc0WM/tK4l+rvIxBJxuLDKKEzQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LQrfKht+ZuSBjZpM9HfdFarqQ++ssuVIXvQ+ZjulJV9oaLewAciaAGYO+iZ5+/6/TXveVc3cNhJSaixhNPUiJgFS/mpKz13MsGuFFrJZRPHfnHB2d9/I6wsFC8g5QmRu+JO1wxB+HNAx4p/KiedSHqpKPoADMOnTv3G+QoAeoAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Message-ID: <d3900cc3-8a0a-4da1-829b-5bcdd7ebca28@gentoo.org>
Date: Sun, 29 Sep 2024 14:10:24 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ./configure fails to link test program due to missing
 dependencies
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, Patrick Steinhardt <ps@pks.im>,
 Henrik Holst <henrik.holst@outlook.com>,
 "git@vger.kernel.org" <git@vger.kernel.org>,
 Jonathan Nieder <jrnieder@gmail.com>
References: <GV1PR02MB848925A79A9DD733848182D58D662@GV1PR02MB8489.eurprd02.prod.outlook.com>
 <xmqqldzsrhyp.fsf@gitster.g> <ZufjWR6AJM-DIWPR@pks.im>
 <29c5c9c0-aa61-415a-9cfa-d64a6b946a48@gmail.com> <xmqqy13oa8oe.fsf@gitster.g>
 <ZvKsH1Ct-YwBPA_f@pks.im> <b6b131cb-683c-4140-9769-290b622721e1@gentoo.org>
 <ZvOTL0cG8qRY8OXe@pks.im> <1f002f86-9212-4639-8804-898bc62726e5@gentoo.org>
 <ZvOn_wChzEgXtpMd@pks.im> <3a303c6e-35b0-4428-9d23-799b33194330@gmail.com>
 <xmqqv7yil70d.fsf@gitster.g> <39508a38-d98f-3883-3887-971385a3805a@gmx.de>
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
In-Reply-To: <39508a38-d98f-3883-3887-971385a3805a@gmx.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------IQdvhsHZQ89azYnc30A7cA3G"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------IQdvhsHZQ89azYnc30A7cA3G
Content-Type: multipart/mixed; boundary="------------Y9plCsIIBD0mgakFLVnQa0NS";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@gentoo.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, Patrick Steinhardt <ps@pks.im>,
 Henrik Holst <henrik.holst@outlook.com>,
 "git@vger.kernel.org" <git@vger.kernel.org>,
 Jonathan Nieder <jrnieder@gmail.com>
Message-ID: <d3900cc3-8a0a-4da1-829b-5bcdd7ebca28@gentoo.org>
Subject: Re: ./configure fails to link test program due to missing
 dependencies
References: <GV1PR02MB848925A79A9DD733848182D58D662@GV1PR02MB8489.eurprd02.prod.outlook.com>
 <xmqqldzsrhyp.fsf@gitster.g> <ZufjWR6AJM-DIWPR@pks.im>
 <29c5c9c0-aa61-415a-9cfa-d64a6b946a48@gmail.com> <xmqqy13oa8oe.fsf@gitster.g>
 <ZvKsH1Ct-YwBPA_f@pks.im> <b6b131cb-683c-4140-9769-290b622721e1@gentoo.org>
 <ZvOTL0cG8qRY8OXe@pks.im> <1f002f86-9212-4639-8804-898bc62726e5@gentoo.org>
 <ZvOn_wChzEgXtpMd@pks.im> <3a303c6e-35b0-4428-9d23-799b33194330@gmail.com>
 <xmqqv7yil70d.fsf@gitster.g> <39508a38-d98f-3883-3887-971385a3805a@gmx.de>
In-Reply-To: <39508a38-d98f-3883-3887-971385a3805a@gmx.de>

--------------Y9plCsIIBD0mgakFLVnQa0NS
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 9/29/24 1:56 PM, Johannes Schindelin wrote:
> Meson came up as an alternative, so the obvious question is whether it
> could be used conveniently from within Visual Studio. It takes but one
> look at https://mesonbuild.com/Using-with-Visual-Studio.html to see tha=
t
> no, the instructions ask the developed to use a command-line interface,=

> which is the opposite of integrating well with an IDE.
>=20
> In short: If we're serious that we want to stop treating Windows-based
> developers as if they were unwanted here, we'll need to stick to CMake.=


Hi,

I guess you didn't read the previous comments in this thread? Maybe you
should take more than one look. :)


--=20
Eli Schwartz


--------------Y9plCsIIBD0mgakFLVnQa0NS--

--------------IQdvhsHZQ89azYnc30A7cA3G
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQTnFNnmK0TPZHnXm3qEp9ErcA0vVwUCZvmYEAUDAAAAAAAKCRCEp9ErcA0vV9eP
AQDERz3kqtT/n9UdC9RyWE1SWPLvhlno4IME5nYeg3IN/AD/en1Za5KUhsNsBml3Ojvg1zL0AzOH
NINgf4/kaF7/ngI=
=5wuZ
-----END PGP SIGNATURE-----

--------------IQdvhsHZQ89azYnc30A7cA3G--
