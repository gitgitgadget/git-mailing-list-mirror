Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793985851;
	b=nhNcyqOy0TOvs5e2iElOsKStf/YjRZuDxXnJKAWuK4QUT2nnaO5+r4vTqNoqciT8kn3N
	 rfcPmVjuHUdwAb3qFxqvTxRiT/uzSjdCWNs7GyRxKUfK33jMlVdaS6AeikPhvzUrrR+s4
	 NjXZnpP5ernk4bnX3M1iaZin7exRCuoM6fdTIL5SOe9/JWKlhT9TbEIHgfETPUbh8b8Xa
	 qE6LQLRDGH7Se0gUcxC+X8TGkfAfzft5dVl3PGwMxSj0IkO3ejkK2tARdfRKGwHM2wuR4
	 6SQMkXORXiWvhbY3Xfxdn0sp1eUR49rhsJggZgHPNTjJ75upYm+FRrIPSs74V13lobA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793985851;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=jbazdm46v/mu7W9l0tDqIPPZmc61fZoGWe/ZGxXecOA=;
	b=h+a7h+0yh2iaj5wYGCS2oFwdAu4UpNI2uuwqnTYqut0zfsQ3UNp8l6Eo13ix5l8XepjT
	 CiiVX1t/H+VRwl+J8OHYqoGR670j1AwAgfkmXyVaYBloxGeNLRN2PVQ6JiRiVWj4Qwk7x
	 sXnDG3vfDFBc7EkD/BBrl8+EiRtmyUJX/TdzKB7/fwx5M5FFogEFoc9iVsCQs3nuoitn8
	 TASn2trfAyUTS0PoxN41HX0xKgDJyAQO9AhPCKvBabkipbWyxARnoVBRQrsrl8BJaMY97
	 USBD24AoUOJAePbNzBeRcnC/5OjzME0jFgM0BsKkgoN3OJyMXbf8w47JmRYrrcmkEhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b="X/EHnZPT";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=qYHnrvx3;
	arc=none smtp.remote-ip=202.12.124.158
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EFE606A326
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 17:24:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82EFE606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=X/EHnZPT;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=qYHnrvx3
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CDB0C7A00A7
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 12:24:09 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 06 Nov 2026 12:24:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793985849; x=1794072249; bh=jbazdm46v/
	mu7W9l0tDqIPPZmc61fZoGWe/ZGxXecOA=; b=X/EHnZPTg4+giBS60W6+N2UfpA
	p3rSC2c3yH/WYPAYXn2T4RHPxeFT16AB76o/Ql/udMlbaNnicEh027Kwa3tzTITA
	IqzH1NLv8+Q4ttbDALGGPTW1dEs+pP3alooUmfjLvGeUz/72rfF+TXzL79dy9nWE
	YdgwOY9lyrEQBvc4wDAmKPBGMVQ/V3keUg8LUd9mOv6eu/K26puT+uDe+uqYflv1
	MIDDOGZB1lrBJEHrqoSlDyLMwxSAdRc7lOTgkpB/mvKPP+jg/ZEUccBLQP2RAnS+
	wLAlpBwPBIbhuozvOBX287+q4RvHNcLl2jmIxn/CJWiHPgx3h4gQLujh0z2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793985849; x=1794072249; bh=jbazdm46v/mu7W9l0tDqIPPZmc61fZoGWe/
	ZGxXecOA=; b=qYHnrvx3ejARA0ruoxAoB+HGWSScB1J0WV9OD9lEF/EQiq8bW23
	RBUUP3n5CNkc19DBMyuZ2zGPvM1vPsF/74C6LDjKlGOm6Dkj7+XBUfwy59TqNHoH
	nfMreDx/Te4E1ec6RV6qXHjRIyPW8PKeYxdpkqYbP8BoMxzByv4Sq03Dc0FT13jZ
	df9EdwJe8oT/RPPPAm9y3sNBBst9kei2DPxGCtzuWbxNSDUtHeQvPuWdKYF5JszS
	vVILSCGy+gidqCrmLmcLNzj+LA/nFTD4ZAT+GtUY5mtvT5FHlAqFdDLGFxWIjtOZ
	U9fdfln0t0Zu6d6kuAkcgRh4T/lllXWB22A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793985849; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:SOhEfToAGysypFZ1WK41Xnu7XrWV85FLQUZgY4h7qT5pwS3
	G5gw23mOlhr54w+gqUuv78HDfDQF9OR0MFwZ6MT4yP7wOVr9d9o21jlyGB7Y417G
	8IEzQrfJmZBSUWBGDgmPC251HQZoMi3R275/2AC+Bv2jxg4hJqM7Uw57tlrLJJyY
	zaiS4+M3ZNmTnfQx9TA0hWZ2G0ND5FNa3/1QBg5JQWSFZi4W6UL2TYnPXGHMDUG2
	W4PmAW7MLTYFubR1kbmF52DJkU/xqt2KLQ4HvrrShkuhRZV7YFKWCob03gCw32Av
	8sfeN0JsxWX7Wtdn1re1W1CnyRmUQuUlezFQ7mA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:/VQtlSL4EpMkXJypi2tC6uxm6u+mPbAG6NAdCO8Dp6A=:uewPuBMv26ioGx6y/VeCPjre8/ypB7f4FEmwkrNBRQA=;
X-ME-Sender: <xms:OQ3uavvELTeDxAuFoq5lkaXNQmPjfwTqFgNIrDaxlJhIQUHA_r3LmA>
    <xme:OQ3uanchCUJ0I9aE0lT6l8SVsjty8UMHiIw8EAtTiHn-MfJ7uYRwUMf4hKw6fHuyk
    5_giJ783pJurE8QzedAfogZ3E05d2Iov-klwz57cqiMn9Kqlp-6GS95>
X-ME-Received: <xmr:OQ3uanw3kst0dCO_EyffLQ6jIaw5vVtfRz7tDsyHShfdVqXEI9BMNtAgwRdcwhA3V7T824bBHgDbLmOCO3Nmj7YR9rF_2DCu-Vp5>
X-ME-Proxy-Cause: dmFkZTG3n/fmCl8dbAIXEPODCXNcr6e0Vr0lpqSyy3nszzzMdku5XzOnDZTlmCqBuPRjkh
    x+1AwqxdhP5ESzPzmrn6X+CamndNXjmsU8/Zq5JlXKY+fLwqjFSd50ZWTYixS468/R5bOe
    3JyBp9ZHTovpjpv0soJ0ZdS8Y+xkUvdqEId+UsEF3RynCyVTvMiSsX3reUI8fX3zaYjMts
    /7PCVQ+ahxHudiDvxH3IC8fghq1pEMg77DaB0pULLxO7I9QEbAr2tAd+k/SGNtNTHe3o14
    9wcvOcO7MQOdAG/QhYUklmW1ladK4gEz7FNeh/Dm1cHSBqR64VLDeMz0g/MWN2IHh9/Ks6
    gRo3fwLnXS832OdQzoCSS1Alw2vAKQ985emHm8KU1Yr2Rlj4D3BqBM//KBURnh0PT2RRRv
    90JGE//5lgfrg8jfIjn25wFGPZiwu2MhhMA4vvucmyizP7HDXLA6puxoTp4+XVLnPn1jEM
    ZfJ5umBsKUqXLeLzVKDbeOPdULTF7ySfXVccV99Qmzk9OgRrM6ypyrrdCCu86R9z/qOx1Z
    L1259QfsufXZIePtRtKJyJOpmZqw94IWoyAdQcnq7zwYv39mmj1gfHwBQshIXcpJScCm6p
    rJMvr163kM93tKSMtWY3utTdBbU1h0pl5HctVzeHehqHT1K8HRveBw5Ilyrw
X-ME-Proxy: <xmx:OQ3uatEVi5Lq_HCSgoAYw-jswIJb0oP1OHPWD2ZBWNauTZvb3tbEow>
    <xmx:OQ3uarxFv2J3D0m82-PU5OR4DtC3_j06UtJt_-4o4vilZYop5hXdtw>
    <xmx:OQ3uauvm_YNJ7xiGxi4IB4QfSKMN7wFfctzyy2TOZWJv62B-CjEUCg>
    <xmx:OQ3uao2HIYOdc7DgUqzsGfh5sUZ5byF3gQAAik3vnHTfhn0EJ-Zyag>
    <xmx:OQ3ualv41YMVNzeynhxyhOXj9XCOQqjs3QER5u_awlj94uxRg-LtxPqz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 12:24:09 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/7] ci: build optimized binaries with Meson
In-Reply-To: <20261106-pks-gitlab-ci-speedups-v1-3-1fa0374c7287@pks.im>
	(Patrick Steinhardt's message of "Fri, 06 Nov 2026 11:30:03 +0100")
References: <20261106-pks-gitlab-ci-speedups-v1-0-1fa0374c7287@pks.im>
	<20261106-pks-gitlab-ci-speedups-v1-3-1fa0374c7287@pks.im>
Date: Fri, 06 Nov 2026 09:24:07 -0800
Message-ID: <xmqq5wy9lvpk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Speed up executing the tests by using the "debugoptimized" build type
> instead. This reduces the runtime of "fedora-breaking-changes-meson"
> from 2100 to 1000 seconds. Other Linux- and macOS-based jobs benefit as
> well, but they only speed up by around ~10%.

That is an impressive improvement.

> On Windows though this is a bit more muddy, as the build step gets
> almost two minutes slower, whereas tests only run ~10% faster. Combined
> though the total run time is roughly the same before and after this
> change.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  .gitlab-ci.yml            | 2 +-
>  ci/run-build-and-tests.sh | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 036d2f3c7f2..df82cd3a5df 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -189,7 +189,7 @@ build:msvc-meson:
>    extends: .msvc-meson
>    stage: build
>    script:
> -    - meson setup build --vsenv -Dperl=disabled -Dbackend_max_links=1 -Dcredential_helpers=wincred -Dtest_output_directory="$TEST_OUTPUT_DIRECTORY"
> +    - meson setup build --vsenv --buildtype=debugoptimized -Dperl=disabled -Dbackend_max_links=1 -Dcredential_helpers=wincred -Dtest_output_directory="$TEST_OUTPUT_DIRECTORY"
>      - meson compile -C build
>    artifacts:
>      paths:
> diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
> index 68b91e31439..fd8136af342 100755
> --- a/ci/run-build-and-tests.sh
> +++ b/ci/run-build-and-tests.sh
> @@ -55,6 +55,7 @@ case "$jobname" in
>  		--fatal-meson-warnings \
>  		--warnlevel 2 --werror \
>  		--wrap-mode nofallback \
> +		--buildtype=debugoptimized \
>  		-Dfuzzers=true \
>  		-Dtest_output_directory="${TEST_OUTPUT_DIRECTORY:-$(pwd)/t}" \
>  		$MESONFLAGS
