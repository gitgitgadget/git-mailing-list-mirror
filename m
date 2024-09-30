Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A461917D7
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 13:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727704655; cv=none; b=lPjnjcPgmbV7O+JYmpMFCa1DgOSoQ0kbH8tM/fNO1qAc4uInTHEzgjixWkcQH40TzMtKnxRQhIhaZhzedvb2qR3ZZ6xLx5TGXt8+D9s6PTzbEjV8RI1X2Q3cePz5ItJ7YKfE8XO7oe7gPkKtca+g3oOlzihuhvY65j7S8PdOTzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727704655; c=relaxed/simple;
	bh=/ltfTOAUVqJETGLafzVQ+nJP+akzPR1hgQOGqV28tuw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z4FsOmdcQ2WDglM6zIKhYL3OybyazkIgBtl74gUgtHRO7VAnsfbJPMbaBHDOHAZc5h9utkWuF3psoMvWNXBuaE41aaTx5YAKs+mdUxcbby765FTyngOBD5tOs6lXawBICRlsEljMbJwvME27Y/qVEvPKuQEYqcFkrEwFlFHyrr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Message-ID: <157253c6-36f8-43ab-ad17-c6c8811bd5a9@gentoo.org>
Date: Mon, 30 Sep 2024 09:57:25 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ./configure fails to link test program due to missing
 dependencies
To: phillip.wood@dunelm.org.uk,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, Henrik Holst <henrik.holst@outlook.com>,
 "git@vger.kernel.org" <git@vger.kernel.org>,
 Jonathan Nieder <jrnieder@gmail.com>
References: <GV1PR02MB848925A79A9DD733848182D58D662@GV1PR02MB8489.eurprd02.prod.outlook.com>
 <xmqqldzsrhyp.fsf@gitster.g> <ZufjWR6AJM-DIWPR@pks.im>
 <29c5c9c0-aa61-415a-9cfa-d64a6b946a48@gmail.com> <xmqqy13oa8oe.fsf@gitster.g>
 <ZvKsH1Ct-YwBPA_f@pks.im> <b6b131cb-683c-4140-9769-290b622721e1@gentoo.org>
 <ZvOTL0cG8qRY8OXe@pks.im> <1f002f86-9212-4639-8804-898bc62726e5@gentoo.org>
 <ZvOn_wChzEgXtpMd@pks.im> <3a303c6e-35b0-4428-9d23-799b33194330@gmail.com>
 <xmqqv7yil70d.fsf@gitster.g> <39508a38-d98f-3883-3887-971385a3805a@gmx.de>
 <d3900cc3-8a0a-4da1-829b-5bcdd7ebca28@gentoo.org>
 <a43fa510-9a96-4b92-8107-0c00209d5161@gmail.com>
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
In-Reply-To: <a43fa510-9a96-4b92-8107-0c00209d5161@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------0iX6fhSIz01u24v8qbfL2b2t"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------0iX6fhSIz01u24v8qbfL2b2t
Content-Type: multipart/mixed; boundary="------------eqdMTmV86eJUqIZ0SFC4n7VA";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@gentoo.org>
To: phillip.wood@dunelm.org.uk,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, Henrik Holst <henrik.holst@outlook.com>,
 "git@vger.kernel.org" <git@vger.kernel.org>,
 Jonathan Nieder <jrnieder@gmail.com>
Message-ID: <157253c6-36f8-43ab-ad17-c6c8811bd5a9@gentoo.org>
Subject: Re: ./configure fails to link test program due to missing
 dependencies
References: <GV1PR02MB848925A79A9DD733848182D58D662@GV1PR02MB8489.eurprd02.prod.outlook.com>
 <xmqqldzsrhyp.fsf@gitster.g> <ZufjWR6AJM-DIWPR@pks.im>
 <29c5c9c0-aa61-415a-9cfa-d64a6b946a48@gmail.com> <xmqqy13oa8oe.fsf@gitster.g>
 <ZvKsH1Ct-YwBPA_f@pks.im> <b6b131cb-683c-4140-9769-290b622721e1@gentoo.org>
 <ZvOTL0cG8qRY8OXe@pks.im> <1f002f86-9212-4639-8804-898bc62726e5@gentoo.org>
 <ZvOn_wChzEgXtpMd@pks.im> <3a303c6e-35b0-4428-9d23-799b33194330@gmail.com>
 <xmqqv7yil70d.fsf@gitster.g> <39508a38-d98f-3883-3887-971385a3805a@gmx.de>
 <d3900cc3-8a0a-4da1-829b-5bcdd7ebca28@gentoo.org>
 <a43fa510-9a96-4b92-8107-0c00209d5161@gmail.com>
In-Reply-To: <a43fa510-9a96-4b92-8107-0c00209d5161@gmail.com>

--------------eqdMTmV86eJUqIZ0SFC4n7VA
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 9/30/24 4:50 AM, Phillip Wood wrote:
> We cannot expect everyone who wants to build git using meson in Visual
> Studio to read this thread and find the message that mentions installin=
g
> a plugin. It is much more likely that they, like Johannes, will find th=
e
> documentation on the meson website and conclude they need to run some
> commands on the commandline. That's a problem with the documentation,
> not the person reading it. Even if they do find the plugin [1] it is no=
t
> clear that it helps - no where does it say "this enables you to build
> software with meson", instead it talks about syntax highlighting, code
> snippets and linting for meson files.


Sure. And I'm happy to (help) improve the documentation. I've already
pushed a fix to the page Johannes linked, since it was many years out of
date (???) and didn't reflect the fact that meson will automatically
detect the Visual Studio toolset for you.

(Note that since meson will "automatically do the right thing" here,
that means it is practical for a plugin to run meson under the hood for
you... much like how cmake plugins handle things.)


As far as reading this thread goes, though, I assume that in such a
future, people who want to build git using meson in Visual Studio would
be optimally served by a slight reorganization to ./INSTALL to provide
guidance on where to find meson and what plugin to use, which provides
an additional entrypoint for clarification. :)


--=20
Eli Schwartz


--------------eqdMTmV86eJUqIZ0SFC4n7VA--

--------------0iX6fhSIz01u24v8qbfL2b2t
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQTnFNnmK0TPZHnXm3qEp9ErcA0vVwUCZvquRQUDAAAAAAAKCRCEp9ErcA0vV2nf
AQCp/kUpSEy080GrLqEq0IDd7PFdVfT0b4hryfOW+kFbnQEAz+lsGj2WDx2yMcKWGxz5/5MBFlSR
B3mLPyq6ZM+QkAE=
=gfGf
-----END PGP SIGNATURE-----

--------------0iX6fhSIz01u24v8qbfL2b2t--
