Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525EA17FF
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 06:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="O9+UBQFQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TgGb1QAT"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C588DE
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 23:34:45 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id D937D5C025D;
	Tue, 24 Oct 2023 02:34:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 24 Oct 2023 02:34:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698129284; x=1698215684; bh=U7
	Q/i6wmgknMO+J1ID8C4M3Pft/vNHV/ZY5bdi3j/HI=; b=O9+UBQFQ6hlpNEdxLM
	lokQ+r0Pl8ZWLgJd42gyRnFOgwpIMcBsvbXuOJJFMpDJSMt6jWiC7QMvfOley8oN
	ymAZC1s7XBSTlAAYj5BtF+NR+tupzV+HShyimRjAHETeNXm75iyddujRl4gQs9d6
	7HnBpwTtuURn3OaYrpUZd68Rnnu/pEvpQw8uPquf8/qv3V5jnxB8brlvkAJSokic
	2RYKczXcJLKQZ6YBtrCnGtSLKIgPoOnqCWtBDJ5aUdsaGBhpl+HxhQaYsmGgj9EH
	V51AxsMS1jjEv0EaRyHqCpywCMPdShqkvhBBdnYiUgJV8y3wmTlfDpUb2bOfSAFc
	Co+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698129284; x=1698215684; bh=U7Q/i6wmgknMO
	+J1ID8C4M3Pft/vNHV/ZY5bdi3j/HI=; b=TgGb1QAT5tgCYdmCIgUBRycUlO3xU
	yE1Ox+1Jx9vEtmuKh8+C06b8CMa5PPsTVF4i8GsOmPRdadSeok1Uo0dlrWlqsBKF
	vAeXaY2YhJFmhz2QXvK9MIpK7CM4O+oX54cBSG6S97+wPi2JpaCcvAQKr7eqbYBI
	cdxftXUuqPgJhySa0Iljf+X4DNKCtmJNqnCVUYdFWPydjpWdMdqnoXjgkULGi2a8
	qQ7k9KTMGZLfPcEHgeJ+1kqAkJoMO119QOZ6JYyG5ZQt1L0YgFO+nN6hMP5KYc0k
	qyuc8c74vfGN1kUWe/gjCPLMQbqpTN0l+giClQCxMFFk4wWShDXw161Ig==
X-ME-Sender: <xms:hGU3ZeJR0ilYRgCn_C07SK0pKR_ALgrXz9XHjoEUCBn1mKsSyslHBA>
    <xme:hGU3ZWIFbITM3E-x9o9MT-rk1nsJ2Z_69sV7pV0k1irXt5ZBypS6d4uSlnRSV5Ma2
    w-2FaDMQu5QSxa1bw>
X-ME-Received: <xmr:hGU3ZeuujFhKJHKZejAwMK7nudFBveDMWxqBYiYP-OqiiW4WzGAwdOUn3ZNewjFjwdHNU6hyA3GF_-1qiia8f4F1dBRH1fNiPy3Dn_RyWgmpztA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeejgddutdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:hGU3ZTYIlWhMw8LdCW0DFDxHecKxg5iVqybom9ljX46YtGHD5eAm3Q>
    <xmx:hGU3ZVbH4A6eLAsxQ_SLFAoSqZEt8fAb1ls5UgQNIRAomtc83E7m0w>
    <xmx:hGU3ZfC_-iCxMEe4wIBsEVYqGdy988_-R7sL1cDE2v-FBJk6ZBgBbQ>
    <xmx:hGU3ZUXadsTBQkD8kkbaf_wfnVPLXnLG1wdSCu8acXl410E-eFP_9A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Oct 2023 02:34:43 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0f596d7e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Oct 2023 06:34:37 +0000 (UTC)
Date: Tue, 24 Oct 2023 08:34:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 4/7] bulk-checkin: implement `SOURCE_INCORE` mode for
 `bulk_checkin_source`
Message-ID: <ZTdlgEaRLpdSjB1n@tanuki>
References: <cover.1697736516.git.me@ttaylorr.com>
 <e427fe6ad383cc238c13f313dc9f11eab37a3840.1697736516.git.me@ttaylorr.com>
 <ZTY6kTZT-ni16usH@tanuki>
 <20231023185842.GE1537181@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="n8C8ckaXblLPeDw5"
Content-Disposition: inline
In-Reply-To: <20231023185842.GE1537181@coredump.intra.peff.net>


--n8C8ckaXblLPeDw5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 02:58:42PM -0400, Jeff King wrote:
> On Mon, Oct 23, 2023 at 11:19:13AM +0200, Patrick Steinhardt wrote:
>=20
> > > +	case SOURCE_INCORE:
> > > +		assert(source->read <=3D source->size);
> >=20
> > Is there any guideline around when to use `assert()` vs `BUG()`? I think
> > that this assertion here is quite critical, because when it does not
> > hold we can end up performing out-of-bounds reads and writes. But as
> > asserts are typically missing in non-debug builds, this safeguard would
> > not do anything for our end users, right?
>=20
> I don't think we have a written guideline. My philosophy is: always use
> BUG(), because you will never be surprised that the assertion was not
> compiled in (and I think compiling without assertions is almost
> certainly premature optimization, especially given the way we tend to
> use them).
>=20
> -Peff

I'm inclined to agree with your philosophy. Makes me wonder whether we
should write a Coccinelle rule to catch this. But a quick-and-dirty grep
in our codebase shows that such a rule would cause quite a lot of churn:

$ git grep BUG\( | wc -l
677
$ git grep assert\( | wc -l
549

Probably not worth it.

Patrick

--n8C8ckaXblLPeDw5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU3ZXsACgkQVbJhu7ck
PpTkGg/9HnaSTVdcl1KR3/Xkio+C9YR1skWO0PiiAmLh24LmL6aXMQ7Ebw/Wq0Yd
XY8gjfbxD4iiwKJS7KcJp/3OrDLXkm8cbsW450ynbLUmP6jlp9yj/yRdC7YBZpJi
sAnh8ZWsk9xphoO7hBQSHqvqkURwMlGuEkbDlhvUfL4g2JM0dFDu3OobwO3HVv70
uIP+7TtfKuWMj3KfHJTQjA7KUCxipzxe7oXQTYEEKZFZbTpfaZ4dxcog8va0a44N
p5ciuQcWdTpW05da5cgtUJA6YHifYaHBa7krBXp1TXbo6sCkzK+c9RL3W5ALUggJ
kPpgUhaBQyxvsPT3S2URrw//wZNMY0BKJJWKl++GYQpudTUlfr5ITx/kmdfwavov
1T79JzJUVo4j1nqDXN/D/mYUQbNziLjM+/3YBezR+rZfo2xPqSEHoCxT5rg/XASA
QQCFIDvM7dC5BxYEEHykAKyknm+qlO3qavGW/U+6NKfoqJJWb1Ph9RUczCAKVPIv
PInW762hGiEKHvGtiE0k4vNlLF3EFoUI86cMEKWNyeD5TonzW3QywPgFFEw8VkKH
HP6dc1Ehd+6SQcVAWfdjDpgwx+8h1/3U3YDfeLUvT8AH//7gjzG/2lqRHCOsvWdG
Namp3EQnTOW7KhJDp1bpKM8ebfIPnWGM+mDnK8cjHTgXMyHGKeA=
=nVEW
-----END PGP SIGNATURE-----

--n8C8ckaXblLPeDw5--
