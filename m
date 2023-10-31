Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDC910A00
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 07:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WTiiEoXC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d7r/wCxR"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE1CF5
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 00:46:37 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 3E8A332009D7;
	Tue, 31 Oct 2023 03:46:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 31 Oct 2023 03:46:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698738393; x=1698824793; bh=Tv
	/fvWIvfYnw399K2LxrY0lVHqJCIrCi6vJYy7V5Ey0=; b=WTiiEoXCzD1Q05B9+k
	9y051I+m3VTDXbYxbAjY95VK+mAXo4Pf7oeVSsxrYupj2W0bHMcYdIjgC2Cg0YSa
	1m6IUQsEhGGPnE133J4AkOxNHwcKCWH7plr82kICerojuqyOtySlJwLLhFwv2VKN
	YcWM4W/hEM/nGFGisT6BKBSqpZikKoxPzjBwAq6qIhDULJUqmS2u0yD+DQCmzX2i
	DjrZs9GpSD4z/QG0JacbzguB05WdrgX7BZywkzUVoMyryIMFMBjAos2NBhnZYMks
	yriMRBGBF76vUKSmHVjIorXu+b26E6O8mjk2oBz2PhAHl1GeTHxXPYYitfyB6XGB
	254A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698738393; x=1698824793; bh=Tv/fvWIvfYnw3
	99K2LxrY0lVHqJCIrCi6vJYy7V5Ey0=; b=d7r/wCxRa9zVLU14AaJrUk3E5y4Mw
	IdFlL3TIbOU3J1Bi1k5W38syKxYTRwH8YQvhGlgVoEPgMqTPP1CqCnYn0ni/7Eft
	3zurf4kRFnPFDAXamVrXWTTYE2UhlXh66XeVX8vMsa8mT46yKv6fi+2eg/PSNT8R
	Wh984UrXRdma30hUdqVire3L9Qg8GKIEXcD5+81BZjxnZm5RmbecB17C+3cedG9U
	gKpyru917j+gzdXfrb4FXhS7m1+NOBrjT1UCi7Mz5Yu8zcUDB5g1AQ5pV7dG3iKJ
	0PR4mv1zIgFTMlKYmgkkfbY9Z8toX5rfs11AnIgiOEogFDFxIzeghgHRw==
X-ME-Sender: <xms:2bBAZVwf-0_WL9fgBjIxe3-TFQn-i23dyenWYstSEAO3UQzYh-BbIw>
    <xme:2bBAZVQe36SrQaA6qIyGGvmMlw6gReDvJhzZ1s1mxvj6djad-VM20e8nW_DaEnRXs
    vX7iRNYJl9aOJUacA>
X-ME-Received: <xmr:2bBAZfW5D20I8BVeql8OiMWeTGQ5TVwXD2mDwgYeYdl9vtXac_GS_KQJ9dShIyj-CNDrBBSiE-PSqDDXTd1WgTBKUO2Z1uuuUP_CSarxY5sIxH8e>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtuddguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:2bBAZXi3g7mClPPTJdmpcF1wYdQRw0wD9Zz7G5BkV-OgvEpZ9MPIZQ>
    <xmx:2bBAZXCyzsKQ8HnmZMShXxnmqtj2WZMmuJqVfNr69LWR-fcNbgwjuQ>
    <xmx:2bBAZQI2ecYgdtT2qsn2UYFT42WPqR0Ux6bVgvMKdFWg9roGaoF2bQ>
    <xmx:2bBAZapAPAcU9wMMjYvjFaxa5Fm941iHf2cqdomc5IvHec1VXQGwjg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Oct 2023 03:46:32 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 35e07211 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 31 Oct 2023 07:46:23 +0000 (UTC)
Date: Tue, 31 Oct 2023 08:46:28 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/5] ci: add GitLab CI definition
Message-ID: <ZUCw1B6oQaDWKx3O@tanuki>
References: <cover.1698305961.git.ps@pks.im>
 <ZT/P5Bl9lD9V6ID9@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RJ2mC2E2non/HcyL"
Content-Disposition: inline
In-Reply-To: <ZT/P5Bl9lD9V6ID9@nand.local>


--RJ2mC2E2non/HcyL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 11:46:44AM -0400, Taylor Blau wrote:
> On Thu, Oct 26, 2023 at 09:59:59AM +0200, Patrick Steinhardt wrote:
> > And this is exactly what this patch series does: it adds GitLab-specific
> > knowledge to our CI scripts and adds a CI definition that builds on top
> > of those scripts. This is rather straight forward, as the scripts
> > already know to discern Azure Pipelines and GitHub Actions, and adding
> > a third item to this list feels quite natural. And by building on top of
> > the preexisting infra, the actual ".gitlab-ci.yml" is really quite
> > small.
> >
> > I acknowledge that the Git project may not be willing to fully support
> > GitLab CI, and that's fine with me. If we want to further stress that
> > point then I'd also be perfectly happy to move the definitions into the
> > "contrib/" directory -- it would still be a huge win for our workflow.
> > In any case, I'm happy to keep on maintaining the intgeration with
> > GitLab CI, and if things break I'll do my best to fix them fast.
>=20
> I don't have any strong opinions here, but my preference would probably
> be to keep any GitLab-specific CI configuration limited to "contrib", if
> it lands in the tree at all.

As mentioned, I would not mind at all if we wanted to instead carry this
as part of "contrib/".

> We already have a rather complicated CI setup on GitHub, which I think
> we generally consider authoritative in terms of determining whether "CI"
> is green. I know we have some Azure remnants in "ci", but I'm not aware
> of any of the details there.
>=20
> So I have some hesitation about trying to mirror this rather complicated
> set of build rules in another CI environment. My primary concern would
> be that the two might fall out of sync and a series that is green on
> GitHub would be red on GitLab, or vice-versa. Importantly, this can
> happen even without changes to the build definitions, since (AFAICT)
> both forges distribute new images automatically, so the set of packages
> installed in GitHub may not exactly match what's in GitLab (and
> vice-versa).

Yup, that's a valid concern. As mentioned, this patch series does not
have the intent to make GitLab CI a second authoritative CI platform.
GitHub Actions should remain the source of truth of whether a pipeline
passes or not. Most importantly, I do not want to require the maintainer
to now watch both pipelines on GitHub and GitLab. This might be another
indicator that the pipeline should rather be in "contrib/", so that
people don't start to treat it as authoritative.

> My other concern is that we're doubling the cost of any new changes to
> our CI definition. Perhaps this is more of an academic concern, but I
> think my fear would be that one or the other would fall behind on in
> implementation leading to further divergence between the two.
>=20
> I think having the new CI definition live in "contrib" somewhat
> addresses the "which CI is authoritative?" problem, but that it doesn't
> address the "we have two of these" problem.

I do see that this requires us to be a bit more careful with future
changes to our CI definitions. But I think the additional work that this
creates is really very limited. Except for the `.gitlab-ci.yml`, there
are only 54 lines specific to GitLab in our CI scripts now, which I
think should be rather manageable.

I also think that it is sensible to ensure that our CI scripts are as
agnostic to the CI platform as possible, as it ensures that we continue
to be agile here in the future if we are ever forced to switch due to
whatever reason. In the best case, our CI scripts would allow a user to
also easily run the tests locally via e.g. Docker. We're not there yet,
but this patch series is a good step into that direction already.

Last but not least, I actually think that having multiple supported CI
platforms also has the benefit that people can more readily set it up
for themselves. In theory, this has the potential to broaden the set of
people willing to contribute to our `ci/` scripts, which would in the
end also benefit GitHub Actions.

In my opinion, this benefit is demonstrated by this patch series
already: besides all the changes that aim to prepare for GitLab CI,
there are also patches that deduplicate code and improve test coverage
for Alpine Linux. These changes likely wouldn't have happened if it
wasn't for the GitLab CI.

> So my preference would probably to have this live out of Junio's tree,
> but I'm curious to hear what others think.

I understand your points, and especially the point about not having a
second authoritative CI platform. I'm very much on the same page as you
are here, and would be happy to move the definitions to "contrib/" if
you want me to.

But I think we should also see the potential benefit of having a second
CI platform, as it enables a more diverse set of people to contribute.
which can ultimately end up benefitting our CI infra for both GitHub
Actions and GitLab CI.

Patrick

--RJ2mC2E2non/HcyL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVAsNMACgkQVbJhu7ck
PpScLA//fWBwQ/ALKGga2Rgw29BSgWPO+pMt8RgVgtUDVhRGCqCnSWdIoraOcbZO
58rOM/7hEUlx2J/kO/jKAufbt0vWmNAoLe1KDGeEmZX9bC7EPvrKjLjD1+EBcwsJ
SMwIqdLbdgResNS30L7l6DpdAr20SOvgXdzhwyDv69SebViupZ9yY8bf7yDOVAT6
eU5JtoB5kDtQ4TAKPvbpxkInIy5ibCpDk39J8y/PBNuHAUCQ1/ilpBUdJcKV7VVy
VVF+C1M8MjP488iuHs2gCL/0OBwy09cHDIMSs1XdVKfm/bPgKdalOLxSSPzFwR1d
1h7doiVG3ARWUDWDCRmsaAv/RjlJLgo06vtkK2E0XjijBaAlVwlhG5Wo/zgIELyH
Udwa9w2LypXp5AonWTbdbst8im15qxmbHsCXaFMtBcBvE/PXWK9nnHYkoxAXrwug
5DbOrL+xnQ5tEjU91+BmDKEnLJ/udJ82dWJc2Au1bR8mBOn0soVTW42+NMAPmaqp
O5MTRTpAxqSQNcBG+2b75i6T+EP9cl1j7Ok0OZXcgpY9XWv00aJHxudyZwxoBgzZ
wrQ0HfAQt1+iSZPA7oJYFdEeef5vAcpnlnN2349XF02Hjhuqyt+r3KwyP3XJkR/8
Xl6JW1JpCvUqw/gG3A3dp00le+OapEwrHvsyzgn0aAlIjUTf1D4=
=yvx8
-----END PGP SIGNATURE-----

--RJ2mC2E2non/HcyL--
