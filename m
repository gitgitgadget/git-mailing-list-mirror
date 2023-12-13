Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nC6CqvHQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WVMGt1kq"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E65AD
	for <git@vger.kernel.org>; Tue, 12 Dec 2023 23:20:28 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id C26CB3200A51;
	Wed, 13 Dec 2023 02:20:27 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 13 Dec 2023 02:20:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1702452027; x=1702538427; bh=UAWEYCB8wT
	3/ynJfrM81K1173a6VPAhih3NQKKJ7AR8=; b=nC6CqvHQ2iA9lOhJOx9bSdNb4X
	U/m/gtyrnCbfxeffZN15Bp3Ioz4HLRzlsAH75gpTNfGJDfmgufSxckfFF9bzdNuh
	4hAMU1t1343lsW+Vm1xwVDcUVtSvas3rOxUDQ1bTo4wpwJrNm7dKNNsD59ODILTN
	z7T+fJndyyoNUY+9ZjHtVqXw5SozL2Jgwg8bXIEGqa3CbP8xPnkyxXaoa7kGuwGf
	pZHcp/3/JRyH9f2hjQ2WNUOCvDbkRvoXGveLTw/n4grgsaDRtZ2JFAfzmeO/yquH
	+ckvPmOA9eVjBXGK27etQ9p1SY1xtnIY+KKylEH4mCdXQVxP+sq3Z2Et5ciQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1702452027; x=1702538427; bh=UAWEYCB8wT3/ynJfrM81K1173a6V
	PAhih3NQKKJ7AR8=; b=WVMGt1kqSoCKJSXNeAqALYmx2y4iJBIkXMAfK3lffPai
	S6CgXOpR4aimT75L0lyHdeZgFjTvczip2dGo/DrsveXDBW5ZrM+zwhl/E6xYY983
	SwzbvXvpB27kfwBK264XvSHRivTELV1sIff7hmHaARZgUtKatNz2NwfbcKp81Q0p
	oIHfW+pt9oSeD0CrGBd+WPYEAdqc4ndt0g0MJ4BTchiqRKIzYLx4KGCA7MfmZ16U
	DbSOVS5vWbw/+Sc25pXyMUc2O5WrcLziqAgj+lLaz4qJXnNEEnXSGC6G597Azihy
	IGltLaFehe7Q72FuwC2CNEUgLHFtdztrRe6kn4zR1w==
X-ME-Sender: <xms:O1t5ZW-Ij5JnlPgF3GywSTL_zIoMOM32oZlHvo_NEfDOGuTK_zIDPg>
    <xme:O1t5ZWvt-quzzsbUh3uCnnZTv9HLJsguP4zZhQ_RAiGyxYJ02Za704bI_QFyJ28i1
    Xyg3Jf6O7sQL85f2w>
X-ME-Received: <xmr:O1t5ZcCQKUvO_1kIoPlgoRGsAK-kubVJklcyFoOFw18Bu-7GGh1Q476H4gHb1l_EcddEZRxD3V99aUXAgkstP-zHgMh8MtQZ0qBkHeabuZ7VrA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelhedguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:O1t5ZeeNoo7KA-tpZP2aJcXPRCCq86-3g02EmT8bfUxXW3AiB67P0A>
    <xmx:O1t5ZbO56yUJT-JZ6MLqt4cyS2rJuXc_d-rWeRGL6qPLXpKOfPrvMA>
    <xmx:O1t5ZYl_H9qWr3TAphUr_q7rRf7pZ0EgdzTQY3NKOMm_k5ocbOnKcQ>
    <xmx:O1t5ZR3P0G88eiz_lQ1UPSSH2gZyM59fkjJkrYlm3jNzp4M7aKaYwA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Dec 2023 02:20:26 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 408290e1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 13 Dec 2023 07:18:44 +0000 (UTC)
Date: Wed, 13 Dec 2023 08:20:22 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] tests: prefer host Git to verify chainlint self-checks
Message-ID: <ZXlbNlG28e1sAYPU@tanuki>
References: <4112adbe467c14a8f22a87ea41aa4705f8760cf6.1702380646.git.ps@pks.im>
 <xmqq8r5zrzg1.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fUaWtiVHrG9BTp26"
Content-Disposition: inline
In-Reply-To: <xmqq8r5zrzg1.fsf@gitster.g>


--fUaWtiVHrG9BTp26
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 11:30:22AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > To accomodate for cases where the host system has no Git installation we
> > use the locally-compiled version of Git. This can result in problems
> > though when the Git project's repository is using extensions that the
> > locally-compiled version of Git doesn't understand. It will refuse to
> > run and thus cause the checks to fail.
> >
> > Fix this issue by prefering the host's Git resolved via PATH. If it
> > doesn't exist, then we fall back to the locally-compiled Git version and
> > diff as before.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >
> > I've started to dogfood the reftable backend on my local machine and
> > have converted many repositories to use the reftable backend. This
> > surfaced the described issue because the repository now sets up the
> > "extensions.refStorage" extension, and thus "check-chainlint" fails
> > depending on which versions of Git I'm trying to compile and test.
>=20
> I do not think "prefer host Git" is necessarily a good idea; falling
> back to use host Git is perfectly fine, of course.

Why is that, though? We already use host Git in other parts of our build
infra, and the options we pass to git-diff(1) have been around for ages:

  - `--no-pager` was introduced in 463a849d00 (Add and document a global
    --no-pager option for git., 2007-08-19).

  - `--no-index` is around since at least fcfa33ec90 (diff: make more
    cases implicit --no-index, 2007-02-25).

  - `-w` is around since 0d21efa51c (Teach diff about -b and -w flags,
    2006-06-14).

So all options have pretty much been there since forever. Which means
that if the host has Git around, and the Git version is at least v1.5.3,
then it also understands all options.

Furthermore, we are accessing the Git repository that the user has set
up with host Git in the first place, so I'd think even conceptually it
is the correct thing to do.

Patrick

--fUaWtiVHrG9BTp26
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmV5WzYACgkQVbJhu7ck
PpSf8w/8DAYDSggmBjdqcHK9PthIYFuzz/C6wOy+8dB7DcF0R7uVIWuK4zIbP6J2
JVzahprfc3thYi9RcXB+pIlV8YZfpgu1dYdLmBIcOLm1kL+Un+sPl+gWWHAiNb8j
+ENfmTagO5Dz0HJdiGvkJQbgrHJHFskLFUgAlU+A8Zjyj0gW29g+Jhu1two4kzLu
JzkCMY4avFhGmjWHeHXPf04+T9nlKuorK33oicCxNV5XRcSTTo5itNCceppkaay6
+aBjV37IPfEiDI9ezEUyANaAqu1hGXH61i//9JwEezSIo3HXuu3DaTVAqBNE0kwf
p13BSsOOiMpuSgpphOCRkG6upaRQocq0J2ZdoPoasLFeWG2yygHWfY2krIhL3nC9
s9mbDD1FjWlbgE2NSnMBnHIHpnGVitvB7IqbCSFwuk+9LlymopLHLArqxDvDb5Pr
0xRJkWCSxcgrAM4G0QFXG/2gtowE/eu8KWak6FMPBYL8kexFztP52G4VAep8LfEq
LJQj3QvRy/UzXcLffxiz6vIwFSiDbjGBzvVgFZWy8zkkSSznY1wnaifdEbuBC10s
iaIZM5BzO015fAw8bPJpYlLXYJaFARV4H41dyqk+r4yNSadV5eH+VJ9qVyfD9ExP
qQLBsui0IzBhD1zLI14G9dEbsmyuxgM1sUz58TPE8JOItVFmJqA=
=cL1J
-----END PGP SIGNATURE-----

--fUaWtiVHrG9BTp26--
