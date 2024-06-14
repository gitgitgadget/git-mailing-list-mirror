Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBE2391
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 05:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718342927; cv=none; b=L+eKH5OOG0TCYG+FRx2LJf3WVpLtv20vDpr3eT6aUVTXfoF1PwK02HDyJ8SSnh9jzVdwyOphgAB8h/tDMiC6APHNCYr/9VqaajwZBR6GfIHzCbGxkU1SPahTtjat5Tg4ZQF03NHAiAIrXBKn508GjJh6AFymVfhQ3e7lCDAzqm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718342927; c=relaxed/simple;
	bh=I3hmyds4XfV9FNMkV4phQsarHicLLGwhMOup4+eodBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i6Azd+hZjkAULq+d8+hmAzfkWTEhdbwg4KUWhPlHSVXMaopBbxcHHavZoVrBrf96S1WAi9i7/xSxpzv0dDKj0KwOTHFMn3+Lx7BuFGGO11bMgy75HVoMcTLFCKWMWLaaX/vISeZ4ZPwS3ZnGsMfjD4bJSxt0VBJyFkdagYvegh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jatg3enn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KFn+2A0P; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jatg3enn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KFn+2A0P"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 578EC18000EE;
	Fri, 14 Jun 2024 01:28:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 14 Jun 2024 01:28:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718342923; x=1718429323; bh=/iHt9gL4fL
	NSB4NamHhcdO5hmTLr8gsDHx2Ki8gHbrY=; b=jatg3enn8m9s3UdzlWV1Fw7xbj
	csJwpqS8RipTwz0mMvc9dp12cgTm51eIRhujRDG5/LT0xxRCtb/mAgkj0CrdY2S6
	2jcxwQLHnuwCcrQWlmB8GZsJITflt5Sjf8SDLMhLrxLQTVYjUsUP8w6xrFaDK5Kt
	8GpnRz4Amf+xosM2/UQEqzXgM9ytnhHkYu0C8gF0k/JbS9yxI8EuqQapUfXOYzPy
	A+hkXK2VffB5dnBIDllMA0UutLBW7HifqeRV3gE2gLuTdjhSsK8qv+MCL/GPY1I9
	f7gqy+P6FXatSw4/MPLNHDeQnpSzVYQ2LJQxYWnaSvU1cTWLSkbWCGjeXcGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718342923; x=1718429323; bh=/iHt9gL4fLNSB4NamHhcdO5hmTLr
	8gsDHx2Ki8gHbrY=; b=KFn+2A0Pn9Y1PfDmN55XhiRBNF6ITwgBlHmi/0GSjg60
	ZsbGI2kf9+M1a2zOX+1m9y527Xphz5yV9c+TKuUGLcmz2czlfpVo5/mFKeaakU33
	s1AOFWB5BlSNSYL4SxG9toYjgWICLgq03f1XGbmkRw/E0UxcUpC3k3XGhx+45ueb
	GQJTcMpwIKnBm5v2+EmbKOjnwAGXJsMnt+TD0/UROFEnHj79KjuzUrDkmLrdDgtR
	zXunW1Pns5omsiOZj7SWABQB5tAavuzWjZeA5lXy9fmreUpdzZ0AfskRjvuyTt7G
	0+f7P7805gaSJTShN5FvEPFmDSOpAmxnbMUAblRz+A==
X-ME-Sender: <xms:C9VrZt00dYVo3EUpfqj2D0QOffMWlEUGIvpnYnpruAqiq6_1hgKg3Q>
    <xme:C9VrZkEsGMrV-0Ipxm3dlmZLW4gAwePjVYo0SPav5AkBsIEv_Qf9qJZy9NmuJF0rm
    5PkDnLPi3AC0yHnAQ>
X-ME-Received: <xmr:C9VrZt6VWeU5Z1fE-wN7nqPo7COpWZtwoER-Bd5v6gPLlhzLyCod0BDRTw-SV3fFslxMT2PIu03KnnTsH4ODDgZBwQmydsTHabisTjKo-Ji_EQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedukedgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepteeuvefhhfdufedvgeeiueeileegtdfhgeeftdeuveejjedtgfejhedujeeutddu
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:C9VrZq2vVRX0WB0LKWnRb2X_gMOWjxMKCCMEU_jMmGivX_hF-OhuoA>
    <xmx:C9VrZgH_EEeajOSvdha6D4rcNUWUCuz6XYcVvnllpbl_nm0bmNXjqw>
    <xmx:C9VrZr8VKvsV2uF84ceWVxTTQoMTMTIPvtAhI7fA55q2PZxxeVPUTA>
    <xmx:C9VrZtltJuHHJXSVcdZqcUUUOk5wYxC9Wk8ERiDHqmoO3QR294P2WQ>
    <xmx:C9VrZlOhkvPuyXz8khnvbC8tOQCkeO3usaBnZias34r6ZSuGhF8G_uLh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Jun 2024 01:28:42 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id d99a0d77 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 14 Jun 2024 05:28:26 +0000 (UTC)
Date: Fri, 14 Jun 2024 07:28:39 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org,
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 00/20] Introduce `USE_THE_REPOSITORY_VARIABLE` macro
Message-ID: <ZmvVBwLEb0qofY2m@tanuki>
References: <cover.1718106284.git.ps@pks.im>
 <cover.1718259125.git.ps@pks.im>
 <xmqqcyoklo26.fsf@gitster.g>
 <xmqqfrtgk7ah.fsf@gitster.g>
 <b69449d0-46f4-448e-b80e-002a8b5c4e1f@ramsayjones.plus.com>
 <CAPc5daUpzc+FDTH4-ajjf6ctnchE5Z6mHVvpm0qnbPLup18ykg@mail.gmail.com>
 <9d085d3f-5fdf-4a28-b31c-458ba68ebcd4@ramsayjones.plus.com>
 <xmqqfrtgjs3f.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wvCwA+R/URadku9N"
Content-Disposition: inline
In-Reply-To: <xmqqfrtgjs3f.fsf@gitster.g>


--wvCwA+R/URadku9N
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 05:17:08PM -0700, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
>=20
> > On 14/06/2024 00:18, Junio C Hamano wrote:
> >> On Thu, Jun 13, 2024 at 4:15=E2=80=AFPM Ramsay Jones
> >> <ramsay@ramsayjones.plus.com> wrote:
> >>>
> >>> Hmm, odd; isn't the declaration of 'the_repository' from
> >>> the "repository.h" header file visible at this point?
> >>=20
> >> No. The declaration is guarded with USE_THE_REPOSITORY_VARIABLE CPP ma=
cro
> >> in the header, and repository.c does not define it.
> >>=20
> >
> > Ah, OK. I haven't been following too closely and didn't
> > notice that the declaration in the header file was now
> > conditional. :(
> >
> > But that does beg the question - why is repository.c not
> > defining the USE_THE_REPOSITORY_VARIABLE?
>=20
> I think the goal of the series is to eventually get to the point
> where nobody uses the_repository variable.  If repository.c, which
> consists of a set of service routines that work on a repository
> instance, defined it, showing willingness to implicitly rely on
> the_repository through things like get_oid_hex() (which would rely
> on the_repository->hash_algo), that would go the opposite direction,
> so everything, other than the definition of the_repository variable
> itself that allows other files that still do rely implicitly on the
> variable to link with it, in repository.c would actively want to
> refuse to use services only available to those who define USE_THE_*
> macro.

Exactly, that's why it doesn't declare `USE_THE_REPOSITORY_VARIABLE`.
The macro doesn't only guard use of `the_repository`, but does also
guards other functions that implicitly relies on it, and we do not want
to use these in "repository.c". So even though the added `extern`
declaration is somewhat ugly, I think it is preferable over defining the
macro.

Patrick

--wvCwA+R/URadku9N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZr1QYACgkQVbJhu7ck
PpSFOw/9F+7VoetlvmkDszyvoTpt8RmMHV+u2pEkAxbvcHRX8ic2pq3qqc8tQdZv
mO1LT+5v2zLXGiUh3+PisBGgPAO4R6nFqDUxa3asCluPFDSyzrxy4wpdWrLgSUpK
yvYqD8n8lmGn2KG+aIMokV/TnfxIiuqgwDlOGzC5ME0ofGydeBNdB2WUGcEP+HRS
tvB3DHvrc+utI3SosyDrzqti5gI+TmUHRXkCgcIgZ6EsucQRaCk5jy95Smotxxom
ZgLqlp4hu3PuDPZbcNV/a3MAruZtG1GenSlbxXEdFKDwPbouf+8kRINqfNgO0l1V
pQhAYpGyNv2Kyc36WH+4eN+8d9iq7Lm3cfN1R1nNanZYITclkFHLt5vp8uVrrsGj
/Du8N6JlgoZIvUXl5XUR1rMpsGALeWg6//DXtmSL3T5mGxtXnBwkIUaBtzdl973W
jS61p1Wf/7oqz5KQlEpAL765SF8/viX8+lvn7K7qDlLa/dQ9LhknUmh+NU3qVpt+
JE/FNRDVZW2DkxdGAmyxT+vr1t0C/qne1MhFeVqPP8rLghUUYzHXV6QnnSTnOjFu
Fw6axakWn7U7PnkYzusv8bHQv3uuOUt05laLVMc3kZJO2IGJLzTG4H0Dumdbgnjm
wCycwJDbDqm8L52S5Vtn6Mhn6KVcbyZnnAnn58YbEiEi397q540=
=xy4Y
-----END PGP SIGNATURE-----

--wvCwA+R/URadku9N--
