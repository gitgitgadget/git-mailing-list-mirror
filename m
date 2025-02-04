Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208D22045AC
	for <git@vger.kernel.org>; Tue,  4 Feb 2025 07:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738652467; cv=none; b=NtSKC0fbd9CuFxLVfe2QWoRU3EgxxW0Vv6nqFE8ZMRF3vkFzzNfxo9LLNJBQHGZ6FZqFHWKfZ5wZUvYukjVzR0cWrmqa/84ZsWmLGlnlEIccSYdrfYUV0MbPSVPoaAb9w/oNbgDBBHr10CE/J2jk4eHJN9V1t51MFL2tMWg3oP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738652467; c=relaxed/simple;
	bh=essG9PG3/gbAQpiyed0dm+TQPKPwyi5naD9GjdqlUAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qAiQ+chlNuvSpRSJMP+0cm6ontBy+Q9u6rm3zsDfwpDrzwJxnlApj8sbTNa7+PCwC5db0OjWJmCRumIkLdqcB9MrBhlPsMCKGIOPTISRXFIvVNivU7O3UeZEXDi1LXN/P825NqxNh+DrDwuehA1XtFwPl6VVQAlZFgLkmvS0hMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kQGkehiO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yHXJAMxB; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kQGkehiO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yHXJAMxB"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3068D1140154;
	Tue,  4 Feb 2025 02:01:04 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 04 Feb 2025 02:01:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738652464; x=1738738864; bh=tg5v7vp0Z9
	5qayP1/Rc7twUp4LwR4p7P489jSi4cHO0=; b=kQGkehiOILgakHpVb8569Q1kIv
	Q5Md6QK8q65eS++cB8OnPqjOjg10hyhOKyaW6k2dx9Bb94fGMI/2831f268a+eGm
	bgIwL5xtdppkZn5WCqrD1AewxFiZOXcEDtkV3TzTEWimSCJMO4ni4QY8NmIzlu87
	p2i86F5CfnA+OLvdQRnK6agEyfDfpph9tIpofEmip/3FwMltcU0Fl9rg+Kb/sFcd
	2BJ3fCJ0yDaovvlDF9JrEjSbCPNnP9hEVDnIxIDOCeZ7eOzm4RFwkiGeKeXlELbk
	Mr4PgA72bO3ho0r8iTnm/1lGma0HjsduI7gn7so5EiaTMkAktoAWVuJeHRpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738652464; x=1738738864; bh=tg5v7vp0Z95qayP1/Rc7twUp4LwR4p7P489
	jSi4cHO0=; b=yHXJAMxB6eTuY4qy1hzcrUTDJV1mgpfGTuuLOzDURV6FdLLsb1B
	7Irh3Z24eoojkm/wAfZWGwROCfcgxovn4zPzmHkYSbsCi/fVuc970qwmrwsbU9sl
	3fUPVIsHjnBURlFMNCm2St6TKE81GiajaalLqa5MEdiEotbcgHI2CYH6hW7zMttm
	yJBGHRyzAGTow7N3N2sSAS9K4GuJGayKGxcF6FBowD+ibMVyUs+4QddTjdAMxqpO
	+mBGkwkERaPgO0u3gSGEzQeIgzvRjZXr2JWwOhvUJYSVzDNT1xRqHrjzmNKQqVFo
	tUbPA7y8Hh3Fwt9NTGbCXV8MsBnJFy0SwAw==
X-ME-Sender: <xms:L7uhZ_hNdUH6rjPDY_CXemBuajASIY2Ew9YJtZSnbd3CuHsrhn3Gjg>
    <xme:L7uhZ8AelXtgcZhokOpYcGBxE1qQSR0VE4JRnsnKarbEKw6HL8QH8JS9V_rhzOqgJ
    CqnbrlhGZZN-80lrg>
X-ME-Received: <xmr:L7uhZ_Hvfmh6e_t1NZ0PXH_3eOWhch6coGquvS_NtDMdBgVfYORuLkZGllBsLL42WOEpMrkBZ0dLIHTA70rZqQH2Mucnl4OuJv_8r7QkivNnOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduleekgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhf
    eitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhf
    sehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:L7uhZ8Qbrv4l062bbqUkuJzeuedC6fpfI95rT3Dij18RqJOCTM_uhQ>
    <xmx:MLuhZ8yuB6rcy22Yt2pPUezAzg-MtpGhyLpCErLV-0sqsO98DGoMZQ>
    <xmx:MLuhZy5RR9mxnT6OTduJeMgdVXd2Bydldfa1hm44osYsb00QHumvdg>
    <xmx:MLuhZxx2UsOUrXszq01mg4_JOMNkxG-lagGsudLnAXKdJKhgDaJAqw>
    <xmx:MLuhZ39J1WQRwJwIt2FuimDQN4aip1wEuFTTTzxUWIsBzPQuK0OySCJS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Feb 2025 02:01:03 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 70a865a2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Feb 2025 07:01:02 +0000 (UTC)
Date: Tue, 4 Feb 2025 08:01:01 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] builtin/repack: fix `--keep-unreachable` when there
 are no packs
Message-ID: <Z6G7LTVqw3l-b7lN@pks.im>
References: <20250203-b4-pks-repack-unreachable-objects-wo-packfiles-v1-0-7c4d69c5072c@pks.im>
 <20250203-b4-pks-repack-unreachable-objects-wo-packfiles-v1-2-7c4d69c5072c@pks.im>
 <20250204030157.GC23954@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204030157.GC23954@coredump.intra.peff.net>

On Mon, Feb 03, 2025 at 10:01:57PM -0500, Jeff King wrote:
> On Mon, Feb 03, 2025 at 02:06:55PM +0100, Patrick Steinhardt wrote:
> > Fix the bug by splitting out the "--pack-loose-unreachable" and only
> > making it depend on the second and third condition. Like this, loose
> > unreachable objects will be packed regardless of any preexisting
> > packfiles.
> 
> Makes sense. My only question would be whether there are any gotchas
> inside pack-objects about using --pack-loose-unreachable without
> --keep-unreachable (since the two were up until now always used
> together).
> 
> It was added by e26a8c4721. And looking over that patch, I don't see
> anything that would let the options be used independently. So this seems
> like a good solution.

You probably meant "I don't see anything that would *not* let the
options be used independently." But yeah, they don't seem to require one
another.

> > diff --git a/builtin/repack.c b/builtin/repack.c
> > index 81d13630ea..8194344b04 100644
> > --- a/builtin/repack.c
> > +++ b/builtin/repack.c
> > @@ -1370,9 +1370,12 @@ int cmd_repack(int argc,
> >  					    "--unpack-unreachable");
> >  			} else if (keep_unreachable) {
> >  				strvec_push(&cmd.args, "--keep-unreachable");
> > -				strvec_push(&cmd.args, "--pack-loose-unreachable");
> >  			}
> >  		}
> > +
> > +		if (keep_unreachable && delete_redundant &&
> > +		    !(pack_everything & PACK_CRUFT))
> > +			strvec_push(&cmd.args, "--pack-loose-unreachable");
> 
> One funny thing here is that previously unpack_unreachable took
> precedence over keep_unreachable in the if-else chain. I wondered if we
> could end up invoking pack-objects with both --unpack-unreachable and
> --pack-loose-unreachable, which is nonsense.
> 
> But I think the answer is no, because we forbid --unpack-unreachable/-A
> and --keep-unreachable from both being passed up front.

Yup.

> > -test_expect_failure '--keep-unreachable packs unreachable loose object without existing packs' '
> > +test_expect_success '--keep-unreachable packs unreachable loose object without existing packs' '
> >  	test_when_finished "rm -rf repo" &&
> >  	git init repo &&
> >  	(
> 
> Your test from patch 1 looked reasonable to me. If you fold patch 1 into
> the existing tests in t7701, you might want to adjust it to match the
> techniques those tests use for checking the object (rather than the new
> helpers you added).

Will do.

Thanks!

Patrick
