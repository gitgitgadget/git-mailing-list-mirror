Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C9111CA7
	for <git@vger.kernel.org>; Mon, 18 Dec 2023 08:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MgyJd6oe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mBQA8MqE"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id C3AA75C010C;
	Mon, 18 Dec 2023 03:24:38 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 18 Dec 2023 03:24:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1702887878; x=1702974278; bh=b5qgF3no70
	RJbp+jayLq8O2qRp9W8FYDBcyNMdiU4Gk=; b=MgyJd6oeUSK105XMeIAJiL4uFG
	WGmmRnyftcXSWzg0RovxAu7UXhym3PuxdAozHUWEFXhnq9ejGdDFbrkH9onURFhr
	ZmJ29paogP7b/EotqEs4LXSRTjhhQ378oXL2mhKn3RQ7RmuOAZ4h4zCHd0l7l0ce
	DSbmUooCYym7sTW4N2Rka46b4mbIHGMGt/3x++F8hZfYzqlUqFwBtEtjXWgImVrn
	acKr/bJd7Fi5FmEwS09WHH4LHfjB+JwexT72VvQbXNPdtVJNi1Z1PZjgZYEA62PS
	D15GJhLv95+OxYL8iaH/hPf6jTnkp1GyMEyyy+RbAYQocHdFlv1E3tHE5z1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1702887878; x=1702974278; bh=b5qgF3no70RJbp+jayLq8O2qRp9W
	8FYDBcyNMdiU4Gk=; b=mBQA8MqEIwSzhGWfZ8vjrx9pAhgPyRALWuHSGXD5fH5w
	ETgP0kuzE093QDH3p41CVBNPiQYd7lWK2qsRT8YDsw1wGhVwB6Lk8/BroKY5OyqQ
	T0HGah8WyE/e7RfwU7iE9YPCocMy1/lsgEju23o2z6+oHzsb7k4x8oEtEUHR7IFK
	2Ia0W4Qabyo3ZaiibX0+gmxQazhfhYGj1xJZV60u3KaDw+8n696HRZbAKRwE1tcz
	jfWjLajkLGc05EBzTNF53kPM81cPL954znOGTDQ1eqtj0CZVQ5oomxwGr8l27gxu
	c466MNXOx7zSVbEqHSFgo7oxoPvpowqQDtHSGFBMnw==
X-ME-Sender: <xms:xgGAZeaeD1OZFmk8zf5v_XJujef4UecCHHCGxvjQzpEKSwvmGZ2Q9Q>
    <xme:xgGAZRZoZ56dQRYGGnafOXEtq8nFmXa8I5WQYqF3Adjx-hc4Vo9o8UkVP29vMYAPF
    ti3B3TYaZOEKjVDXQ>
X-ME-Received: <xmr:xgGAZY9tM1ktxWX7Z13XvLP8GG4CyAkrmyEfrMnBBNZaUURRQ4v5Fi8KyxAtpQWp7YrtJ1-JjPURb10cZRuI-BAd8hx58o2VE5YgJx0KZeW4EDc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtjedguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtdorredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeehfefhuedtvedtfeeiteeugefgfeelgeelveehffeukeelfefhieekteevudfh
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:xgGAZQqMC3Zm09T-ubKt4IR-j7U0axpDbEWVPGeY_UDI0fbSfODJ5g>
    <xmx:xgGAZZpgN6Q1WNTs_0VW-AJa0eH8QLYlJD_ROD5yuuLEJ2vEz3kGEg>
    <xmx:xgGAZeQZPcdzgvM7oc7qHeL8m55ifFDHwc9922chVOjZ1uiRxjjdXg>
    <xmx:xgGAZQ0nMOmaPtQkZsSGYWxevlgk3wlsBGzR2IBXcFDApUl6uHDn6w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Dec 2023 03:24:37 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e0988555 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 18 Dec 2023 08:22:45 +0000 (UTC)
Date: Mon, 18 Dec 2023 09:24:34 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Andy Koppe <andy.koppe@gmail.com>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/5] make room for "special ref"
Message-ID: <ZYABwulbgbAwDewD@tanuki>
References: <20231215203245.3622299-1-gitster@pobox.com>
 <xmqq5y0zkvqx.fsf@gitster.g>
 <321b8084-fddb-4b5d-86af-7f88cb3edf7b@ramsayjones.plus.com>
 <132a3daf-23fa-4575-a77f-bdf0a96fb5d8@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mwaWFDRAs4QXd9ix"
Content-Disposition: inline
In-Reply-To: <132a3daf-23fa-4575-a77f-bdf0a96fb5d8@gmail.com>


--mwaWFDRAs4QXd9ix
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 16, 2023 at 10:20:09AM +0000, Andy Koppe wrote:
> On 15/12/2023 22:44, Ramsay Jones wrote:
> > On 15/12/2023 21:21, Junio C Hamano wrote:
>=20
> > > If somebody is reading FETCH_HEAD and acting on its contents (rather
> > > than merely consuming it as a ref of the first object), perhaps
> > > feeding it to "git fmt-merge-msg", they will be broken by such a
> > > change (indeed, our own "git pull" will be broken by the change to
> > > "git fetch", and the second bullet point above is about fixing the
> > > exact fallout from it), but I am not sure if that is a use case worth
> > > worrying about.
> >=20
> > Yes, I was going to suggest exactly this, after Patrick pointed out
> > that there were only two 'special psuedo-refs' (I had a vague feeling
> > there were some more than that) FETCH_HEAD and MERGE_HEAD.
>=20
> According to the pseudoref entry of gitglossary, CHERRY_PICK_HEAD also
> stores additional data (which would imply that REVERT_HEAD does too).
> Looking at CHERRY_PICK_HEAD during a pick though, I only see a single has=
h,
> even when picking multiple commits.

Both CHERRY_PICK_HEAD and REVERT_HEAD are only ever updated via the refs
API, so neither of them ever contains anything other than a normal ref.
I guess we should update the glossary accordingly.

Patrick

--mwaWFDRAs4QXd9ix
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWAAcEACgkQVbJhu7ck
PpQ19w//SbwGyUTQPidgmxMqjhCMEo5nMfMHicGu+nf1d7Hlxf8RJQD64Q++miHa
BHRi0XUAt8R56CiLHyAHSCOyxk5S9zHaDg54FFoRrwXoBkz1xTQyHQO4gYs/SI9i
CoXAjPryhMN+MVf82VLwFOBjfpNr8tp46my8NNmXD4a2nVI2Zgb9IYTWWNNoYVbu
DvCbb0ujNHuyofpzXnZ/JNu5b23F6yQ6bPW6VXrUXZktG3DqeIPlLD3gu6u3u1UQ
ek/ghf0kqa/a8m4g2BQEW0qBw1JYkieSuQU30piJC7bP8RR9eAMQ4+4s0Pp+udyP
iF5TLSb6mTA1wMbufrY9i6OC6ZJ299SXoFE23bim2iCmSqgyJB9e+j66oBkHyQTH
lFsAeOl8DZQ1xQXJpBNG2q6rCiY7pPMm4GiT8vxSPJEUoeJz7WraYwQ6ug/4LP15
TCrYWXKIljQnEY1LS2NEEmZyqPHjmwHW4pTcFxhACioYBX/wcohMR5XTaPEOBrfJ
82SyXbC93G3XmZ54Xae9lXsY4qIi8SjJ8XwviQnAmWixENrS003Wq1GshxS4kwMz
QqkArNWQfFCO06LI/hQ5BcgbsG/+KhuY1EziPmOrX/N2g7lN6cHL0w5AZ3v4JCVm
FstmWy1Zc1WVEuV4sycUWj8lFhoYvm8VXeTTwZkS9hEYwMmkkro=
=8bff
-----END PGP SIGNATURE-----

--mwaWFDRAs4QXd9ix--
