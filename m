Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9F46AAC
	for <git@vger.kernel.org>; Mon, 15 Jan 2024 08:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UCMOEj15";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="drY0aOCJ"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id D7C975C00E9;
	Mon, 15 Jan 2024 03:43:18 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 15 Jan 2024 03:43:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1705308198; x=1705394598; bh=wHs1gGNwY5
	BajWsx4oDLPNdDApCfuvCF6yL5rkhUPjo=; b=UCMOEj15/VeRBHvXpNK+MrtP39
	zVFXMcwHfXBCT2Y3YM4XqJKOYIEqNjXCbegOsba4hyZcNSQYA+Wze4H6V2khOvl8
	52IyJNO/xN21RHmuZnLNNs+wGyiRAjId9R+RRscz1sXkx/ph410JqEXywNvMvEVG
	jIBF5rEktxrGFyzIWTz08PayI7ceSHX2uJm3m3RmbcVinRxG1dta5JIHDuzv58k8
	+Pe/5LT65rYh+whqykQcv+qA5FkORiSeUSqGhCdefeo74dx0ofi4PT7y9/2E/Zdr
	Z26PDT9oBaXuf2EeJiDY88QhUYqSCeb54hCjQPTSZa4HWjLCp/DKSuon8ERA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705308198; x=1705394598; bh=wHs1gGNwY5BajWsx4oDLPNdDApCf
	uvCF6yL5rkhUPjo=; b=drY0aOCJPi7cxYxzZtJ58hoigPnKoyr/ujPGBYxc0jFX
	5caBWyHZLAPkBYkzcXqsjCz9+FJK7T2ugU9v9b2RkReE0WoA1K8YJ7K4pNJ3WBKj
	YCed4dtIK4w56zzBeLp5dttw/gakDzpRO9x1xSF9bnK9nzGrDgufrwxAQfIc+m6u
	HHV+Ic6wrOyBIW3Q1tfAqtrTnjV9DWd6GqEpqUA620O71y4VWtTeLOPal7GJbtaM
	LKC+2k8OuE5pcwUnmMoBqGYyfXEofM9ukpiAe5rlgxTf/rskyJto4+PrCWFj9s9g
	NrDXBEwjE4vQcRpBSdc9LllssQbjICHV/ACSWB89tQ==
X-ME-Sender: <xms:JvCkZYC0hI0406D_OqtTjP4N141eGdlxu-nq9rdh9i7QJfvLKrQENg>
    <xme:JvCkZaj2oSl3B1OG91SOF5RkJB8c1f1voFTJqPLSL22kRc-7Bky42FSED44kfMq6t
    joHGLg7k8BiT8Mu3g>
X-ME-Received: <xmr:JvCkZblN0UdhwqQOnsV21WhLvLPmyZsuM_AZOEA86iCwCe8LCtv3jkJe-tS40RsxOm0db-Jpg8E2YjVABudte-rtt3rS1_TF9zGY6MjDumazbg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejtddguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtdorredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeljefftddufeekudekueelveelhfeuheeufeegueekteeujeelteeuleetleeg
    ffenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:JvCkZey5YfnLglNqpbTNlsdga48-LvKJADNS2pEpmhJ5yH-ER49utA>
    <xmx:JvCkZdT1eUVuGsFnAVAkny8NWqK17E6hS41iiSHIzj8StlZ7uc8XOA>
    <xmx:JvCkZZa_ICCM4BgsFBWLPuqx9vLketzmNPqhc9jIu53aZHR86A5PTA>
    <xmx:JvCkZfdBjTs6RKjAlZ30ebUq2RIh_4tvb0jaA2vCEDspQgoFsa1rwQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jan 2024 03:43:17 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 921100f5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 15 Jan 2024 08:40:26 +0000 (UTC)
Date: Mon, 15 Jan 2024 09:43:13 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Benji Kay via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Benji Kay <okaybenji@gmail.com>
Subject: Re: [PATCH] push: improve consistency of output when "up to date"
Message-ID: <ZaTwIUBKNhuAmrLX@tanuki>
References: <pull.1638.git.1705008449995.gitgitgadget@gmail.com>
 <CAPig+cRr0V2ecnmxk1H_yF24dwSFA6niPxYXGH0MZ+wGP9m9UA@mail.gmail.com>
 <xmqqjzofec0e.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rn77Y3nosK2V5sig"
Content-Disposition: inline
In-Reply-To: <xmqqjzofec0e.fsf@gitster.g>


--rn77Y3nosK2V5sig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 02:33:21PM -0800, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>=20
> > Thanks. This particular change is proposed periodically...
> >
> >> diff --git a/transport.c b/transport.c
> >> @@ -1467,7 +1467,7 @@ int transport_push(struct repository *r,
> >>         else if (!quiet && !ret && !transport_refs_pushed(remote_refs))
> >> -               fprintf(stderr, "Everything up-to-date\n");
> >> +               fprintf(stderr, "Everything up to date.\n");
> >
> > ... but has not been considered desirable.
> >
> > See, for instance, this email thread explaining the rationale for
> > avoiding such a change:
> > https://lore.kernel.org/git/pull.1298.git.1658908927714.gitgitgadget@gm=
ail.com/T/
>=20
> Looking at the "grep" hits:
>=20
> $ git grep -e 'up-to-date.*"' \*.c
> builtin/rm.c:	OPT__FORCE(&force, N_("override the up-to-date check"), PAR=
SE_OPT_NOCOMPLETE),
> builtin/send-pack.c:		fprintf(stderr, "Everything up-to-date\n");
> http-push.c:				fprintf(stderr, "'%s': up-to-date\n", ref->name);
> http-push.c:				      "Maybe you are not up-to-date and "
> transport.c:		fprintf(stderr, "Everything up-to-date\n");
>=20
> it is true that these are not marked for translation, which should
> be a clue enough that we want them to be exactly the way they are
> spelled.  However, they are going to the standard error stream.  Is
> it reasonable to expect third-party tools scraping it to find the
> string "up-to-date"?

I would say it's not entirely reasonable:

  - These are strings that users see frequently, and if they are not
    proficient in the English language I think it actually regresses
    their user experience.

  - The way this string is written would never lead me, as a script
    developer, to think that this is a message that should be parsed by
    my script. It's simply too user-focussed to make me think so.

  - Last but not least, I think it's not entirely unreasonable to ask
    script developers to use e.g. LANG=3DC when they expect strings to be
    stable.

Also, with the introduction of `git push --porcelain`, I think there is
even less reason to keep such user-visible strings intact. Any machine
that wants to parse output of git-push(1) should use `--porcelain`
instead in my opinion.

Patrick

--rn77Y3nosK2V5sig
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWk8CEACgkQVbJhu7ck
PpQm8RAAgHhSZ0m90HNCrAd/U3hzBO33z5AuN/drUdj0JTHteb/e9iRw7s3VFk71
1P9j+XXqe5i3IgUfjmIe0k9eoLBJE0EaXyZlSQvG8wLI7oR7DwVJ7YEdm8M9Pk8F
iuFc34m08zQBLvXTOMdmxxJNcg+0qU5KE5+4gJw3Y10zlXG62HWZVBCwX/YE/tFx
EXJzLwyk/FTJQl5WzXSLQcm/W5Q4RW0TIenI7obR9N9FKOeFuoqPyPMIvLhkwS1p
9HueckVwXDIne6A+0zcd3zHnOy/kyRomr4oN5Gk4AEToe4fVqtfl1/2FVt4AIVG4
knFBWlPb73lLdfnqYQyI6pQnbqzT6abjSQIDbbJubvM+qtET2gq+y9rN+mBcSsNu
lbJzATN5oYnY5C6/iDePX0L+sC8YC8HqIDJy7sMmLc0ylIkpjpU4qgnlW1Navw2S
qtmE8U/Ketg3YEBnrwWbgKTrQa46qFoiLbSdhhfIrwWn+494gMOHI1GBPiXTJBRb
g1EsbtP2YAA6MqRJA7eM7bWL4hrXBYW8ZlSlHU+l0lx44UJlpqwJP6TH1vw6oM4l
e2Llnh8hEPN+UoO9qDY57KHOte535Iliw8lYgFXKqhVV8IfuVdaIP7fZeciJpK3d
04KtP2Yuv5F4Ups+GvoiyzLZHyoaMTwc4ivg1dqAlkhF6yNVC2k=
=hEXO
-----END PGP SIGNATURE-----

--rn77Y3nosK2V5sig--
