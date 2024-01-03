Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CB7182A4
	for <git@vger.kernel.org>; Wed,  3 Jan 2024 08:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IqDvrTL1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gxpmnvUm"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 7BC355C0081;
	Wed,  3 Jan 2024 03:52:38 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 03 Jan 2024 03:52:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704271958; x=1704358358; bh=/mOXt/Q2CH
	9oaFG2ww7hE6wPXkhX0ARjV3RATADdhLM=; b=IqDvrTL1DhLSBJIFV0OL0aCtxU
	BoEnelEvNZkaeX8arxDRIwRlFgZDrCQUPeusyAN1E1D9CM/vBwhBCq4ZeaBthZqq
	5ZvG4b/U2bmu2cVmB8WsmoFjY6B13BFVc/tXpMAOPJGVquA/yISbG4P1AmhiSp50
	nVXj+SsPbVu9eG7nc1HWUq3mA8Tbv/YX36PGPmZy6gdBDJehGKP+qyypp7HGJDrP
	I6utnPY95073VjyG7giqXLGtGAgu66AsTbklhVQE7nJnrWtCW3WSHQg0QE8Mxt7+
	8C9rs0nncV3JO5m/+jEZD9IFPSjY8e7Z44YkQy4HntxAEIEvepMb6TN7t4dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704271958; x=1704358358; bh=/mOXt/Q2CH9oaFG2ww7hE6wPXkhX
	0ARjV3RATADdhLM=; b=gxpmnvUmm8OiGfSsBE1xQcc81IKIQrX5J9BqOLBAqOpp
	w16j8UT2i6sC6Ow37V2w2uJqQmPxfyN5BOyvpwI0cMYk0pbr3jCpXJsgMsue1b0R
	k/B+R7YzM3R2GkDuLAa/cDaW6hdBu1/9MxrKsAC60ZZXLglpaASK7rCVgXboTbjw
	jOHRezTs9O4pRsD47Kcrj2FbUsqRPYCQC6VfhrMMe2uXDd+rol8jWhREFjw5hfdU
	B8s/2yw7bWYku49CTVIC3/aVU+AQIEVK/aTD7qpFl1HPCk/b1SLFqMrgYVuvhNe5
	/3nho73yoqoHhZL9IxcI9oDM76Ya3UWjGLT3qrLBZQ==
X-ME-Sender: <xms:ViCVZQhbKjcO1OYD2gZ6n-WuTJDM9ru8eQ0KvxhkXe1u5DBAqG2VvQ>
    <xme:ViCVZZAOKK4iN7EbKg3sdu_oe-CY_-4fKYzbwnInyC2cRZKJS8b3iIUcyovNwYtJl
    ih_FhXJv-4RbkjtLw>
X-ME-Received: <xmr:ViCVZYHrQ2ijKijrxj96Qm6ebqgC3moP1CdYPVIzQIWLBLWym7ZByUyGg291yIhWb87sKpJyJ2yPtGdpdgGJ8D6p5v5dN513BJdOOeRYDZpBEQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeggedguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:ViCVZRSYUKi8uctzgYXoqtbfJuG6H2pH7n0KfbpaZcawxBKHP_EcSw>
    <xmx:ViCVZdx8ptkMQIqJt16OOT3EBz5RVxapwaSGroje2BIosaW7PC4B8g>
    <xmx:ViCVZf5tx6NAncLZn_KGHGzxj82UaxSWxJwTYPH1QDuiki702ErW9A>
    <xmx:ViCVZV9VZIdATtBBxn3l-4Lln37sqaaEt6M7SSVvi41sVxlBr8sfjA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jan 2024 03:52:37 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cb1cef97 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Jan 2024 08:50:09 +0000 (UTC)
Date: Wed, 3 Jan 2024 09:52:33 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	christian.couder@gmail.com
Subject: Re: [PATCH 2/2] ref-filter: support filtering of operational refs
Message-ID: <ZZUgUUlB8A-rhep5@tanuki>
References: <20231221170715.110565-1-karthik.188@gmail.com>
 <20231221170715.110565-3-karthik.188@gmail.com>
 <xmqqzfy3l270.fsf@gitster.g>
 <CAOLa=ZRedfBUjukbN8dFT9CZETe4pz1UR+eWfJwORWuMHSk0Rw@mail.gmail.com>
 <xmqqsf3oj3u8.fsf@gitster.g>
 <CAOLa=ZTPxWXnZ8kpBB7=cybNfdEv6d6O37Em7Vpmcw=enpY1_w@mail.gmail.com>
 <ZZRaOhK869S1Sg1h@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ps6hXz//6n3rctWg"
Content-Disposition: inline
In-Reply-To: <ZZRaOhK869S1Sg1h@nand.local>


--Ps6hXz//6n3rctWg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 02, 2024 at 01:47:22PM -0500, Taylor Blau wrote:
> On Tue, Jan 02, 2024 at 07:18:48AM -0800, Karthik Nayak wrote:
> > > As "git for-each-ref" takes pattern that is prefix match, e.g.,
> > >
> > >     $ git for-each-ref refs/remotes/
> > >
> > > shows everything like refs/remotes/origin/main that begins with
> > > refs/remotes/, I wonder if
> > >
> > >     $ git for-each-ref ""
> > >
> > > should mean what you are asking for.  After all, "git for-each-ref"
> > > does *not* take "--branches" and others like "git log" family to
> > > limit its operation to subhierarchy of "refs/" to begin with.
> >
> > But I don't think using an empty pattern is the best way to go forward.
> > This would break the pattern matching feature. For instance, what if the
> > user wanted to print all refs, but pattern match "*_HEAD"?
> >
> > Would that be
> >
> >       $ git for-each-ref "" "*_HEAD"
> >
> > I think this would be confusing, since the first pattern is now acting
> > as an option, since its not really filtering rather its changing the
> > search space.
> >
> > Maybe "--all-refs" or "--all-ref-types" instead?
>=20
> I tend to agree that the special empty pattern would be a good shorthand
> for listing all references underneath refs/, including any top-level
> psuedo-refs.
>=20
> But I don't think that I quite follow what Karthik is saying here.
> for-each-ref returns the union of references that match the given
> pattern(s), not their intersection. So if you wanted to list just the
> psudo-refs ending in '_HEAD', you'd do:
>=20
>   $ git for-each-ref "*_HEAD"
>=20
> I think if you wanted to list all pseudo-refs, calling the option
> `--pseudo-refs` seems reasonable. But if you want to list some subset of
> psueod-refs matching a given pattern, you should specify that pattern
> directly.

Where I think this proposal falls short is if you have refs outside of
the "refs/" hierarchy. Granted, this is nothing that should usually
happen nowadays. But I think we should safeguard us for the future:

  - There may be bugs in the reftable backend that allow for such refs
    to be created.

  - We may even eventually end up saying that it's valid for refs to not
    start with "refs/". I consider this to be mostly an artifact of how
    the files backend works, so it is not entirely unreasonable for us
    to eventually lift the restriction for the reftable backend.

I do not want to push for the second bullet point anytime soon, nor do I
have any plans to do so in the future. But regardless of that I would
really love to have a way to ask the ref backend for _any_ reference
that it knows of, regardless of its prefix. Otherwise it becomes next to
impossible for a user to learn about what the reftable binary-format
actually contains. So I think that the current focus on pseudo-refs is
too short-sighted, and would want to aim for a more complete solution to
this problem.

This could be in the form of a `--all-refs` flag that gets translated
into a new `DO_FOR_EACH_REF_ALL_REFS` bit, which would indicate to the
ref backend to also enumerate refs outside of the "refs/" hierarchy.
This is orthogonal to the already existing `--all` pseudo-opt, because
`--all` would only ever enumerate refs inside of the "refs/" hierarchy.

Patrick

--Ps6hXz//6n3rctWg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWVIFAACgkQVbJhu7ck
PpSImRAAg/FD91UW+07H6G3pLmDzl8H8NMbJ+zxbkb1wtqcVBXtJwqElyCH9j1BL
2YxGGmbVXtIKHOX8iwlxvP7NHoqIhCdFpoQfqBn2svsewXWRqdGYiH7h57PDisrO
ypcbPVT1z9kxl8WKHpvPywXAOKW+E2BnUocGJMafM+wmeslvGrq7zULqLo+Pu+rf
fdUuY8HPGiIVp2IXq9muJv3JRZ1qhO5UpzzT0dWwmugk4CpclRDngMHzJZ2HJvhz
KOSMH4+T10/LqxLh/eOhtwf4um2rDjC0ewM4KFt6AFhVhs5eIrW2FGoLOEFYDsDI
mCXWFVJgBvEnjfKIzuizcfVPzEvvnLAqrp/qxLDf5yi84YX3M86U/4HzWvxsDefF
d4D1udywTUGF68sf3AoRpjBEPIHxuJ4ehP7qmGZhgpt1i3jWi4rAW1vHtVBSVyo4
LeREJoco1mzwmNFwrL0yLKk12PXIS3d/rCOcGO2lvi+7S+5MxXj0bKt6mdOpAeY/
VBd4UzVcczuzly9BJkiemSV7OOyQiRhyeeYWc+hstQyiMjQmxc14H7QmT9CKeXUg
iayRYNUpd5jpbVI3/k6QQ78qSsOcyxSmqfa2A8toEjKheyOm0KC9dPqDONwcSgat
EFOeyYBz208x7mPYRKko5jHD9yHjM5Bm/lL+8AAuC2D5pXCxjrE=
=oe/u
-----END PGP SIGNATURE-----

--Ps6hXz//6n3rctWg--
