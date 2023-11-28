Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tiJofdHo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xnjyDizl"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E666BD4B
	for <git@vger.kernel.org>; Tue, 28 Nov 2023 04:33:51 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id E703D3200BE0;
	Tue, 28 Nov 2023 07:33:50 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 28 Nov 2023 07:33:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1701174830; x=1701261230; bh=o6
	QX0OEp7PFa4I8GB2OAFFUHrElFlt/3OlXrL9szi4g=; b=tiJofdHoAeZT/UPinK
	CnJEfg6btxVEHdgkC5QOYmANFej+IyfyqGwRUDdMsfaIriTHdGAto29/I58UY7pV
	wtWlPHIwGSBY9ImbKMmH3ZwblyBV+bq2hFHRnbg5XAyCjLVbthw4ELBUNf3EV7TX
	dSt1IY9RzVjhmHvBFWdG9GJsKdmEfkWnEpWOt6tbvUVxIRosYzrRu6hwtRXcParq
	m4vXLfeZ3cl+ByYiki4QmkK1/DYBDI/7ZZOgwOUvHTGQoEX28CZ2qfdYPwbe5h7+
	AnxaNXb0mVBT0lF+qqus19gXPZ18XbjXwqjRLHh4f1c6Xu5EWXXaf5ZWWS4m0jNK
	o+Zw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701174830; x=1701261230; bh=o6QX0OEp7PFa4
	I8GB2OAFFUHrElFlt/3OlXrL9szi4g=; b=xnjyDizl/8gmSSGIljTOafNhQYMSH
	96abrf7hqSh0qB9PA90ZLu/TqTibuCscOHMcy05ZUNdwYXVBKNtunOF84lWFnt4L
	mP179JLhNSA+t7fR8DeZ31T881tkEDhDRBjPaOpmYpUzCGGBK2+VGbpUmJh4pG/Z
	lMqJ1N/0K9RMpQMtCLePgbidj2TVuMbBhaD/3jy3sbIAmrtLq/4TPN8kaFJ21mOn
	mn3stkj0vKH0SmpGU4cQ/TFhcpOyog11wkgQU3rPuzs5y8U3oYDB8ql8wQLwCFFS
	McdM58IRZSMf3NSk2IGo13fF96xD750Nejm2bO5Ku7/uHy6f6oQVGZmYA==
X-ME-Sender: <xms:Ld5lZeCn8px8xQTHcGlvBfkpd0BSf6RkhHxkwugQnXp0nF3yQucaCg>
    <xme:Ld5lZYjWmiCoeZYlBFPNoKmvml9I2DS8Shw7EOvLcExOcKVhAngTsOzRdUOj2k0p6
    gbJiYtIPZaAP7iLZw>
X-ME-Received: <xmr:Ld5lZRnga6uLpa1PsqOTTJH1QoCF9KlsbYYg0Sv7twFooo2sN561c_CFn4X1sKYW-mQMwQmW8Fg7WXmWQ4b0yBu_CnuRgZ3MiuPh7Vmps8lsqg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeifedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtroertddtjeenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepvdeuteeukefgvdfhvddtudejiefhffeggeeiffdtudfhleeijeelkeffhedtheeu
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:Ld5lZcxMNHI7MC2aZZVqe5B77LaYsYF6Z8N1DR6RffkxXePEFxnMmA>
    <xmx:Ld5lZTS_l4339cAZ6nCym_N5Ep68MdMcZERYNp0rm1GvNHXKHGACXg>
    <xmx:Ld5lZXa9O3yBKU88O4D6EBRgQae6hRdMkeOGSxKlRANDBQrbZ_gKqA>
    <xmx:Lt5lZdcbFrD1spZW2YOYUHfKTk_Bvm0DZPrhX9Sn26CFKO-7949xMw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Nov 2023 07:33:48 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0d79f994 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 Nov 2023 12:32:38 +0000 (UTC)
Date: Tue, 28 Nov 2023 13:33:45 +0100
From: Patrick Steinhardt <ps@pks.im>
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	=?iso-8859-1?Q?Jean-No=EBl?= Avila <jn.avila@free.fr>,
	Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH] i18n: factorize even more 'incompatible options' messages
Message-ID: <ZWXeKYHOCbwEOvnR@tanuki>
References: <e6eb12e4-bb63-473c-9c2f-965a4d5981ad@web.de>
 <CAPig+cR5PKkyC24LkOU4+yzng1xeBOBbADTBHXH61xkAR7kymw@mail.gmail.com>
 <d1f28272-635d-4638-b0f4-76d64013b0d5@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tQ+ge/bC+sOOGmhV"
Content-Disposition: inline
In-Reply-To: <d1f28272-635d-4638-b0f4-76d64013b0d5@web.de>


--tQ+ge/bC+sOOGmhV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 06:39:41PM +0100, Ren=C3=A9 Scharfe wrote:
> Am 26.11.23 um 18:49 schrieb Eric Sunshine:
> > On Sun, Nov 26, 2023 at 6:57=E2=80=AFAM Ren=C3=A9 Scharfe <l.s.r@web.de=
> wrote:
> >> Continue the work of 12909b6b8a (i18n: turn "options are incompatible"
> >> into "cannot be used together", 2022-01-05) and a699367bb8 (i18n:
> >> factorize more 'incompatible options' messages, 2022-01-31) to use the
> >> same parameterized error message for reporting incompatible command li=
ne
> >> options.  This reduces the number of strings to translate and makes the
> >> UI slightly more consistent.
> >
> > Thanks for tackling this.
> >
> > A couple additional instances recently slipped into `show-ref.c` which
> > were caught during review[1,2] but nevertheless made it to
> > "master"[3,4]. This patch, of course, doesn't need to address those,
> > but if rerolling for some other reason, perhaps they can be included,
> > as well(?).

Ah, I wasn't aware of these new wrappers, either. The below patch looks
good to me, thanks for the fixup.

Patrick

> > [1]: https://lore.kernel.org/git/CAPig+cSrp7vZuy7D_ENHKZKZzF4OSmCtfYNHP=
GMtS1Hj6gArDw@mail.gmail.com/
> > [2]: https://lore.kernel.org/git/CAPig+cRTOMie0rUf=3DMhbo9e2EXf-_2kQyMe=
qpB9OCRB1MZZ1rw@mail.gmail.com/
> > [3]: 199970e72f (builtin/show-ref: ensure mutual exclusiveness of
> > subcommands, 2023-10-31)
> > [4]: 9080a7f178 (builtin/show-ref: add new mode to check for reference
> > existence, 2023-10-31)
>=20
> [4] changes the message added by [3], so that's one instance, right?
>=20
> --- >8 ---
> Subject: [PATCH] show-ref: use die_for_incompatible_opt3()
>=20
> Use the standard message for reporting the use of multiple mutually
> exclusive options by calling die_for_incompatible_opt3() instead of
> rolling our own.  This has the benefits of showing only the actually
> given options, reducing the number of strings to translate and making
> the UI slightly more consistent.
>=20
> Adjust the test to no longer insist on a specific order of the
> reported options, as this implementation detail does not affect the
> usefulness of the error message.
>=20
> Reported-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  builtin/show-ref.c  |  6 +++---
>  t/t1403-show-ref.sh | 16 +++++++++-------
>  2 files changed, 12 insertions(+), 10 deletions(-)
>=20
> diff --git a/builtin/show-ref.c b/builtin/show-ref.c
> index 7aac525a87..59d2291cbf 100644
> --- a/builtin/show-ref.c
> +++ b/builtin/show-ref.c
> @@ -315,9 +315,9 @@ int cmd_show_ref(int argc, const char **argv, const c=
har *prefix)
>  	argc =3D parse_options(argc, argv, prefix, show_ref_options,
>  			     show_ref_usage, 0);
>=20
> -	if ((!!exclude_existing_opts.enabled + !!verify + !!exists) > 1)
> -		die(_("only one of '%s', '%s' or '%s' can be given"),
> -		    "--exclude-existing", "--verify", "--exists");
> +	die_for_incompatible_opt3(exclude_existing_opts.enabled, "--exclude-exi=
sting",
> +				  verify, "--verify",
> +				  exists, "--exists");
>=20
>  	if (exclude_existing_opts.enabled)
>  		return cmd_show_ref__exclude_existing(&exclude_existing_opts);
> diff --git a/t/t1403-show-ref.sh b/t/t1403-show-ref.sh
> index b50ae6fcf1..d477689e33 100755
> --- a/t/t1403-show-ref.sh
> +++ b/t/t1403-show-ref.sh
> @@ -197,18 +197,20 @@ test_expect_success 'show-ref --verify with danglin=
g ref' '
>  '
>=20
>  test_expect_success 'show-ref sub-modes are mutually exclusive' '
> -	cat >expect <<-EOF &&
> -	fatal: only one of ${SQ}--exclude-existing${SQ}, ${SQ}--verify${SQ} or =
${SQ}--exists${SQ} can be given
> -	EOF
> -
>  	test_must_fail git show-ref --verify --exclude-existing 2>err &&
> -	test_cmp expect err &&
> +	grep "verify" err &&
> +	grep "exclude-existing" err &&
> +	grep "cannot be used together" err &&
>=20
>  	test_must_fail git show-ref --verify --exists 2>err &&
> -	test_cmp expect err &&
> +	grep "verify" err &&
> +	grep "exists" err &&
> +	grep "cannot be used together" err &&
>=20
>  	test_must_fail git show-ref --exclude-existing --exists 2>err &&
> -	test_cmp expect err
> +	grep "exclude-existing" err &&
> +	grep "exists" err &&
> +	grep "cannot be used together" err
>  '
>=20
>  test_expect_success '--exists with existing reference' '
> --
> 2.43.0

--tQ+ge/bC+sOOGmhV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVl3iQACgkQVbJhu7ck
PpQFNA//Uyy3Qzuh5I7kNtPFEaZXQ8ItC2Re5RZkSnWyY5ZwYDFwvYWluAPPjySI
+hA2e2InX15RJQlzZIuwC+trDeTLkrVODNKat5Q7OLA/rja2eI2jlTEIpDE3Ec/8
Qt6x7lvJV1QRAyf7EO/BvctfZyoqIr/Tw7o8yjCout7aRyvryoKyRRDJhzw7oVle
PNh+0jm9/ohLQscmcuXJgPoiEr01B2K0IvuBYFpbqWLvq0UzF5oHiE/+jS/Kn/Cq
0FZnAoq98CDjOEtCtXiIZqNxQuAWDkFu+xOGlXwhYWnkRIt0jhME0/yjJEG28cSO
Rgfez8KMPS3q67W06AyiBsbN1eVfQAohYHv3zf1Jo09c8H0D4IWxrZxA1Hoq3Q62
sgv1F83qC58QGtFNbM95p4aSsGvs7RUwwZMHStmEpC2vRtU0lkNb1aG7pDvqbhTr
Xy7XAuhORENg2dILMDZpWlvvFTIKC4iBoZbZ/Rh2Dlq6iCZ8uwwlHUa/3gTlEIPf
OhBBEToVQ8jKzSKkabttdMSFTTyMXTFg6WrLMz5vEV7VPha4LTB9hWTQZ3+sjmBG
5qz4ewrHx9MA66JInNgeGxf98L6+s5xl5WDnHWiuMsyQWYRtDgAYxEIzBZEbKUSI
9K/CTXH5yEeRhmTJz3ewcGEGiNiRpDv1nYz1344nBXab90MYVIY=
=z97O
-----END PGP SIGNATURE-----

--tQ+ge/bC+sOOGmhV--
