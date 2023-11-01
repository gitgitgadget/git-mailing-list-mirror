Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B8411C86
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 11:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ESix88Yw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N+qsxwwV"
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D9CF7
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 04:56:49 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 2EAA25C04AD;
	Wed,  1 Nov 2023 07:56:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 01 Nov 2023 07:56:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698839809; x=1698926209; bh=nJ
	StPfSmYy/lF9F/5TP2seFUmBUZ48nPJTP8Is21hek=; b=ESix88YwHOXBOc/DOH
	6rPZ6kOihlt+hjvkZ70woK71QaV907fgeD28aoatfDqb4tXycbzT9lN5+BjlBLAG
	kN1N4uSea+Gs6HV2/6uGKm06B0HMK6ZoSBbkrxmhDGjbjM+AfHOnO0UW0c3jA01J
	tTaX+szg/WWEZYO5j7jXaJhreQ8m+lUKvW3LHK6RvSy+xViBY6zz8+awI4lv9Mlr
	idPtMb6E8qPy+LnejdsjoVTRIr9fNcZxgp5yIEJkN+WsOn5BvGHD67D9S36C/5P3
	2zrX8FmTpWTluJaE/K8uGue1Dbd5Wxy1XYsYac++TvtQ2nPenpFO/GfVqwZ7xI5W
	+xzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698839809; x=1698926209; bh=nJStPfSmYy/lF
	9F/5TP2seFUmBUZ48nPJTP8Is21hek=; b=N+qsxwwVDyzLeGTvfvkvwtSwFSAwQ
	cCsVX6TVNth/lv0EyKgfrGmgQ3Xzk5Ig9v7jJ/UVXFCIRCk5sMN4VFksGZdEJfC1
	n/PZe0bcpbRCijMClSqyuqgiBbNoNxi9Hf/1bmn2ksoB27SIFI59wMQleKyKrXIK
	6xmkNFhgW1h4Y9tPJpxEmIRJ03sqiWgIn2/wOOlZ62TZQXj9TIOhZp6b+C5V/ba6
	4dWA1u0r+Ik1TogXt4R/AOX8sQh5sL5EVQ0dStrEQo7hry3EabhUETcKLDPb5lxD
	rVhL9+RSRWbQTVUMfyv7LhM0dVMfCjPw06LwJ1TJb1TEk40dv6cM4Un7g==
X-ME-Sender: <xms:AD1CZYZVVRLgro590ePYxgA2XEUaiaXoWcaPxmxTBkr9wVDbZREpog>
    <xme:AD1CZTbqqcwBeIFreAs_VkI1Auyxx88zuuqOJa4fKDZe33lbdatZn0-HMc-FNAdyc
    UBILCHqBtJvgg_eXQ>
X-ME-Received: <xmr:AD1CZS-V7YHlcTOLQ-JjocmphbwE6XxX2NegKGjCrEfnAxeJNakCkIKpfOnCLOl1K_TVq-isall8Hu6KGbA8dwwJ04bGevD8vd3mVDSDtUG_pg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtgedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddunecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeefvdelfeeuteegiedtkeehleffkeekgf
    ffudfhuddvfefftdehkeeihfekjeekheenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:AD1CZSoraFQcDX3U2KmpY02AA9vwnNI5Rcv5Qd_GeNVILr9eqmZH8g>
    <xmx:AD1CZTrhHfraahKgvpxRGveS51e9hPUmjMvjWpT1VrID-Dv0o0Xbvg>
    <xmx:AD1CZQSeccVmcHTQ3NVAJNBaB06u6EVZHvVqZeTTgPHU9dI2W2Grrg>
    <xmx:AT1CZcCxpQJHHw6oNiOn9DZATpRO73yPGanOGRvZCn9enfKicnRuog>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Nov 2023 07:56:47 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 21809bc1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 1 Nov 2023 11:56:35 +0000 (UTC)
Date: Wed, 1 Nov 2023 12:56:43 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/5] ci: add GitLab CI definition
Message-ID: <ZUI8-z2luCAC-XtB@tanuki>
References: <cover.1698305961.git.ps@pks.im>
 <ZT/P5Bl9lD9V6ID9@nand.local>
 <ZUCw1B6oQaDWKx3O@tanuki>
 <xmqqttq6xr9k.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zw4ALuATlJei2ut9"
Content-Disposition: inline
In-Reply-To: <xmqqttq6xr9k.fsf@gitster.g>


--zw4ALuATlJei2ut9
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 01, 2023 at 09:15:51AM +0900, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> >> So I have some hesitation about trying to mirror this rather complicat=
ed
> >> set of build rules in another CI environment. My primary concern would
> >> be that the two might fall out of sync and a series that is green on
> >> GitHub would be red on GitLab, or vice-versa. Importantly, this can
> >> happen even without changes to the build definitions, since (AFAICT)
> >> both forges distribute new images automatically, so the set of packages
> >> installed in GitHub may not exactly match what's in GitLab (and
> >> vice-versa).
> >
> > Yup, that's a valid concern.
>=20
> Is it?
>=20
> I rather na=EFvely think different set of build options and tools
> running the tests would mean we gain wider test coverage.  Even with
> the current setup that relies on whatever GitHub offers, we already
> see "this version passes all tests except for the job on macOS" and
> "the version that was passing yesterday is not broken today---perhas
> the image of the test environment has been updated and we need to
> adjust to it" every once in a while.
>=20
> > As mentioned, this patch series does not have the intent to make
> > GitLab CI a second authoritative CI platform.  GitHub Actions
> > should remain the source of truth of whether a pipeline passes or
> > not.
>=20
> I am not sure I follow.  Often we take a version that happened to
> have failed Actions tests when we know the reason of the failure
> has nothing to do with the new code.  From time to time people help
> to make CI tests less flakey, but flakes are expected.
>=20
> > Most importantly, I do not want to require the maintainer
> > to now watch both pipelines on GitHub and GitLab.
>=20
> I don't even make tests by GitHub Actions force me to do anything,
> so there is no worry here.

Okay.

> > This might be another indicator that the pipeline should rather be
> > in "contrib/", so that people don't start to treat it as
> > authoritative.
>=20
> Let me step back and as more basic questions.
>=20
>  - What do you mean by "authoritative"?  For an authoritative CI
>    test, contributors whose changes do not pass it should take it as
>    a sign that their changes need more work?  If so, isn't it a
>    natural expectation and a good thing?  Unless you expect the CI
>    tests to be extra flakey, that is.

I was assuming that GitHub Actions was considered to be "the" CI
platform of the Git project. But with your explanations above I think
that assumption may not necessarily hold, or at least not to the extent
I assumed.

>  - Are there reasons why you do not trust the CI tests at GitLab
>    more than those run at GitHub?

No. Based on the above assumption I was simply treading carefully here.
Most importantly, I didn't want to create the impression that either:

    - "Now you have to watch two pipelines", doubling the effort that CI
      infrastructure creates for you as a maintainer.

    - "I want to eventually replace GitHub Actions".

This carefulness probably also comes from the fact that GitLab and
GitHub are direct competitors, so I was trying to preempt any kind of
implied agenda here. There is none, I just want to make sure that it
becomes easier for us at GitLab and other potential contributors that
use GitLab to contribute to Git.

Hope that makes sense.

> > Last but not least, I actually think that having multiple supported CI
> > platforms also has the benefit that people can more readily set it up
> > for themselves. In theory, this has the potential to broaden the set of
> > people willing to contribute to our `ci/` scripts, which would in the
> > end also benefit GitHub Actions.
>=20
> Yes, assuming that we can do so without much cutting and pasting but
> with a clear sharing of the infrastructure code, and the multiple
> supported CI environments are not too flakey, I am with this rather
> na=EFve worldview that the more we have the merrier we would be.
>=20
> > I understand your points, and especially the point about not having a
> > second authoritative CI platform. I'm very much on the same page as you
> > are here, and would be happy to move the definitions to "contrib/" if
> > you want me to.
> >
> > But I think we should also see the potential benefit of having a second
> > CI platform, as it enables a more diverse set of people to contribute.
> > which can ultimately end up benefitting our CI infra for both GitHub
> > Actions and GitLab CI.
>=20
> I do *not* want to add new things, if we were to use them ourselves,
> to "contrib/".  We have passed that stage long time ago that keeping
> everything in my tree gives wider exposure and foster cooperation.

Fair enough.

Thanks for taking the time to make your thoughts clearer to me!

Patrick

--zw4ALuATlJei2ut9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVCPPoACgkQVbJhu7ck
PpS7Rw//QuC6E6xfuQu+FrB9LIck8E9vyZf+gFVXxSmqptMkag4vr2xfWeqRUDZo
nlZWubOa/FGHGZAPWTe6hMRRXFy8ghr7Zp9Zxk0Tge9IPdVr6OqiCPOJgbkY3JuH
erllD4UAjoVUwX1OQSUgSzaRsW+XTWOWg9aGlAtReQWpgWssaGY9tvzvBNWq+cuh
LmDhiIplsEYVEcG+wnhl8e7tIPj+d2zYIFjbhfajLeL9ZTh/UpGHVvSsNMFIG8dI
JNwG7DqAS3teVGip1RKISi70Ito/vGbDL2wmAJ90FOfROsKe1Pc0F3YRu4a0OmBT
IJOWWFuVuGjxdtWe/Qqyy+uIVXI3hDHurpPNXwMvMlfuUe6Vta+68XJ2atDYAUGx
FX4rSaeZIK8BirAyKqjkhlVGUYz6R+kIaHuLUXxn4vKuJykPrwn4Qf35Txf6dhDK
jTrStcAF8Tt4DccUa1sHC5xccXkjpulzcjr/j9+6G/mV+Qc+t3qAhD2m32q4Mk3M
Lmi9yw2JQMVKCQhzgqxATVMiXXNsUdHKFrlbya6GQRa0tDmHm8qn5jy4UD54EHVz
bN7rITlD7RqjBBYh2ZHFVoN0ChbCNpCP2sJ5zRBm+eE7XiMhW9jwt11U5v0fQxbH
LloE2ZbCwV3eQ0ae0SbTYTUzMqpt5pvff9+xra+GczZgiBRB/DM=
=4ptC
-----END PGP SIGNATURE-----

--zw4ALuATlJei2ut9--
