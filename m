Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4820039FF4
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 07:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WDgymNYC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="5rMUu57n"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 199783200B6D;
	Wed, 10 Jan 2024 02:17:55 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 10 Jan 2024 02:17:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704871074; x=1704957474; bh=b9k+laiV7H
	5o/XL1L6dksDnDF0wAxjOqier4pFR1HvU=; b=WDgymNYCnbKCVv0hy8ayzSa2aC
	bDEHGcjNwBPOgXI7Q1Pr77J09r8NHjoyMavDiQWhSWZFxjpp3z0LwMr5KQIkjZVh
	EdXldgxPvRlL2gB0n3Xr08EFMEL/RQ/8xC0XLqscarad4GMjqKFUHSryX+179xPs
	NDetoLm5MN7aaUOWhnbAbTyggdJsouYcdT7bpqZ4bau+IuTAIp1uRZ+VlzzNWvMN
	NEKdErQKrimHC2jPaWI9BVXLm7zGk9rUZ+HQ1kUGFnR1hub+pJUsauDJms0AigGB
	WvCta2wN9ywFg7GdEll3F9uc9wHYkIqIJ/oc7A5jHXUmf2XOHuAko7w1nvEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704871074; x=1704957474; bh=b9k+laiV7H5o/XL1L6dksDnDF0wA
	xjOqier4pFR1HvU=; b=5rMUu57n9n3d5XF9LfTfRByZz7Rl8u7Sfw48KnBHuweC
	V7Vj+wglmslPRcKFNJsv1MaRuXGsKlrbnBK68dCHnuJS/x/S7AE83bKfL8nMB5fQ
	q8p6mk6Uld/y4JPdLn5u7vifeU/v62x/5N5loxaO20K4eDsamns1WXKfJLiQcZm2
	RfUhiyB+/cgwy+visG0LoGiNxrC5vj1bVWWPJShVpM1KpZYieac5f9KvD5/E8v4I
	oSyTWOLRi/ez74p/LerdgbVB9e+edW3PsDkIl7bz0nRp7wC6hLstyjfpA20qBlX6
	cAiR1Q1BiteOs5YmcF3O2g8Z+qzwNPezZ1QDYf2AXQ==
X-ME-Sender: <xms:okSeZWP2wE9cSTB0NN-AnwqBQBU4AiQUVmOYzTZL3zXtdXlO35wawQ>
    <xme:okSeZU_2v5cZVay6291VB62O7gHHVX9IorYGSuN_cUXFAjHCZ3d94W3HYsBPyG0sE
    h_r4YU3PncfyifDLQ>
X-ME-Received: <xmr:okSeZdQxO57c-x2n4o4eHJFatwz_z5N4FDSdAZyaOBNuiWO2Hbss2zTxhPjzBCYo5PnK27IrNCE0vxi4OZf9SrMQGwAoezCI6ENiks9wL9OdAvQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeitddguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedt
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:okSeZWsbTJoIjYojjR_-etTp08ngJj7aVK05PyML61Bx-30vBp5YNg>
    <xmx:okSeZeeS8V9t8ws5ySLVh0xfvH2O8dVjBm1-ANeGl3-9Sg7a0fu0JQ>
    <xmx:okSeZa2ysSNN2GIsSnXzbGgJxzR--ZWRfdsPFw2CSnq6sTgrTcEsHg>
    <xmx:okSeZWk1hTHpSQHKFG-_qD79Z_oqb1x9_wg6PI5hOFl4O-5nG5ZpaA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jan 2024 02:17:53 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 091116c1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Jan 2024 07:15:13 +0000 (UTC)
Date: Wed, 10 Jan 2024 08:17:51 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/6] t1300: mark tests to require default repo format
Message-ID: <ZZ5EnxtMg0wLyAm9@tanuki>
References: <cover.1704802213.git.ps@pks.im>
 <ec1b5bdd176e6a3f093b76b732fd9e960a7880ca.1704802213.git.ps@pks.im>
 <CAPig+cRdDSMACzB6mEfwbijLHHSJuQ_Tk8ggNkvFxEd1aSqw2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3UG6j55LuLT+97SQ"
Content-Disposition: inline
In-Reply-To: <CAPig+cRdDSMACzB6mEfwbijLHHSJuQ_Tk8ggNkvFxEd1aSqw2A@mail.gmail.com>


--3UG6j55LuLT+97SQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 09, 2024 at 02:35:29PM -0500, Eric Sunshine wrote:
> On Tue, Jan 9, 2024 at 7:17=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wro=
te:
> > The t1300 test suite exercises the git-config(1) tool. To do so we
> > overwrite ".git/config" to contain custom contents. While this is easy
> > enough to do, it may create problems when using a non-default repository
> > format because we also overwrite the repository format version as well
> > as any potential extensions.
> >
> > Mark these tests with the DEFAULT_REPO_FORMAT prerequisite to avoid the
> > problem. An alternative would be to carry over mandatory config keys
> > into the rewritten config file. But the effort does not seem worth it
> > given that the system under test is git-config(1), which is at a lower
> > level than the repository format.
>=20
> If I'm understanding correctly, with the approach taken by this patch,
> won't we undesirably lose some git-config test coverage if the
> file-based backend is ever retired, or if tests specific to it are
> ever disabled by default? As such, it seems like the alternative "fix"
> you mention above would be preferable to ensure that coverage of
> git-config doesn't get diluted.
>=20
> Or am I misunderstanding something?

A valid remark indeed, even though this is thinking quite far into the
future. I'll investigate how much of a pain it would be to instead "do
the right thing" and retain the repositroy format version as well as
extensions.

Patrick

--3UG6j55LuLT+97SQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWeRJ4ACgkQVbJhu7ck
PpTCSw//aRaQ96Jlnd15wJPvvNbQY15r8fFN5QylICKH9IC05csshgFJEjOh51y7
sbjFw0z40uJkWTgVbQ4Bn0r1kNGeHfQt7gZkIC0znYJbhgqb36sabP8cpo45HyqL
LU0UPj8mkAJClWufWdKlfZpf0RBe5SIYZ+tYrrJT1UODkF0ZIStMZkYPkIYSbFNf
HJgqrR5oLBUeLSRSnss4R+/1T7g52FiToGNJZrfRKWCuoBNJVFRf1Bzrux7Y9fn/
dbRTj0SftWIUtuB+QsKzvtiOJy9eVbxBP+uRw4QmTjX+cWuMkR7A3dYf8PKcwgLU
XImWtfyszvT0MVontyalZvUqinG857Aq7Ybo9ltbVIx9bxCwGaZGhVrVgy4HxkwW
f98RCrSdPjIevnhfB8+1qeZ6hkWQLWWL3meKklzxqrruvDvmkLlc4bD894pJW+cN
uEKzOfssp9VL1D+AH4wrmeWQ4uPl6m2u2KU88rmMGVz+bM0HYD75qgOGxGeiLoxP
XhKuvFDp1q1DVwS4c8UVc7QKfLccqYGuiKET6W3iDXoAgucQ5iQxyRXIj4MKYqF2
hOmRyooucOYomtdM7Td3gV11YLKNp+vcdhvekB5tciRQMSjkWdnXS4oAa5h3yFP2
H2/qphXnKojEb3wFiL7TtthPHlOkfKn5IWASMX5XABQk3iQUMR0=
=9gui
-----END PGP SIGNATURE-----

--3UG6j55LuLT+97SQ--
