Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99F433BBCF
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 07:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782718401; cv=none; b=kvdAGtQHRcfs3dsojbZCEGoCpFWeHKMHFGQMZHZh62b7J9k6BV+Lc15UwgQRuXxPqImhXQ051HhkyufQDpfDxYxiW4ZY4ePU4uHXokRBFeT/DwZNE72JCjMBOr65Ib93+t8bNElZSlwI+KlGFOIiw//SIdRrc7WgTEqDNSIgSBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782718401; c=relaxed/simple;
	bh=fUgBmO5eu84AJPvh/TgRAqKYPr7x2KX27mxL/Y9FQL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F+1gKeWa0t0KvyYRj5onblqcM02KNkZL/WdoKnZ15Ge5oPIgK3VZ1C9yZFOvrTWS8o8IZ2p7IYSp+AmZQJAPxO57eqzs8XNogahWLFWd/Gn2dQKJSjT38TPFS7fF7PFdhCt8mDQahjZxMN7BU0lgYPS0VpaFPDNP+9KQ/MjPdlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ig/uya/J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DK/lug0U; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ig/uya/J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DK/lug0U"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id BBE051D0007C;
	Mon, 29 Jun 2026 03:33:11 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 29 Jun 2026 03:33:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782718391; x=1782804791; bh=sXfUsvyYFT
	Gz/deU54bawMSs9y04FLrvGSBGoT7QzBU=; b=ig/uya/Jk6DSk8ThsnxYy1oEWQ
	rxQ/DgNnhLBiF2IJlL8Bl3QgdTgzjKzUiHYiY3WXZDTGXM9YdPbHdLYajCxvB3jQ
	X4hPc2KEq2ev3spz7mag6vkjP76HywkKfI2haDfJ2xq7Ch70wddUwc5sRiWjxEtS
	xGhkjtx1t/sLQKYmc9XVKjrQGWKRoXPauVAEixhfHmetyX1O2av7QSwMTHE31xiq
	cGmhlf6Ga71WVwc7Ml80VWpakGkMnO0vRKaBuH6yR1Xl8cCy9LA9ZkGulr72L+cD
	QVANXDUo5GRVojYMivhhfaYn/lMZVH+iAAN+ia9TbEL7KrZmCatI+Tam6M1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782718391; x=1782804791; bh=sXfUsvyYFTGz/deU54bawMSs9y04FLrvGSB
	GoT7QzBU=; b=DK/lug0Uy7M2axCl9f2vVGPIJk63jin/ixuSVbc+LrWfPCnfUGL
	XQAdq74kS83cPgPNceLz/8M6kSZznSh+d6ecC2/jcQbZpqN5thNidysvkjqJnEhy
	bdnd9cruiTo2HWq4SxCKDD/etrtzrjvyy89LDzGwpwSmHEZKwGxXy4tfuu+lKji8
	lXtKRmUovgps8dydWIzL3I79Au0fvY+ztYIpOT6TwPGHUf3VwPnFSZnydiWhhsTt
	UpuIOxCxSjwt6qaq4GOqgqplIME1vtLYxKEP78KPW9J6c6KWNBA6cKUfD0AV8B3i
	Cb+9K9SVCnLY7BBinb88OrWEP3sSMYD65iw==
X-ME-Sender: <xms:tx9CapbdYgQOavB95FNmAeEowYkDXqKmBWBktRtQjrCgKKy9-fazLw>
    <xme:tx9Canbdo27LnoO4S0x3uYtjRQlRI2_K62je7B1oXz6Qro7ayA79GNcajlV6p8G2B
    GmOozyloQKy_BXNVJSQzhPCdZEfMqlUHp-vZVejmcJbKvlP5xp9OQ>
X-ME-Received: <xmr:tx9Cag9dbz-HTl3QmUVWmTuq4AOgyfSPaj-TzW_uYazm-R-DpIXdlYkQwBG1wJ3hcgVXun6zVpaX35VDjbvOVQq9boDlgp6b0xPMEsZ4FfnI>
X-ME-Proxy-Cause: dmFkZTF3A97Qho2zD2ZXuQjdkPnerCzV8oFIZ6Cvk0p1erv91jd2feePXRlKQvcvACpWre
    duq7cSpuHLMeXU+iLv878dTuAHV1HDhk1ujDjqA+/gXozN91JIkykCon7BxtA0RSZAA56T
    Uw6G2Rx8RA/mDeUOj5C8zNDzTuy+a3aTDN1aGcP3nTWkQDyHzS8AUZWIlpNqzd0mxEEIBO
    Lqs9euzdkdR/7QIoFPGco0Ilp0qLEea430aKviQ6OLLKkj9w6eaga8X6rCsHvKhxl2QZmi
    cxshvwLf7w8GyW7b8uoVtQXY0O1zoLC42gu1lMeIGvw+eWGmrm0k+taDlH5wGUNookcqBm
    ByxvoRXzdWSPsi2NRF0npfVOTKaAv1zxQyQIa8wFVCrNuatTn0mKE21qjbszuIV83Sgdrv
    9gyVs4wSajk5nudS/bkFXBA24PdEooCRwJV1rUHLy6CVyQQI0ROqFIKW+FtaMVVQQMHxDc
    9+Ia8HxzTbRmcVBD9ON6UwuRHUEX09c0DFMlz/Qnrd8GbgX/liLExjVGD09WnRiNi+FrR7
    gabQtCAxY4QLxZtzUz59FYP8VZcYkg7qPZU07oiyzc5iXFlcGXlA6Qi2j7vsuUgGxIHM24
    FmGbyBLhnS1f3Bx8c/WrnBPfQu8nAaqdTLBK84Mu+4/ePCBeypxCsf4Dq3Tg
X-ME-Proxy: <xmx:tx9Camgn-rT1kCUPSJgwEgrl3HGYXhd2mUelbwA6vryZu_xOpgVkcw>
    <xmx:tx9CagdtC_-6qSH3HxmGuVkZRofQkwnZdagg-15mAISPCxuwOXvE_Q>
    <xmx:tx9CatoD3L7jAT-xnVFKO4THV_Pb_OVh7bAqCzDmfRI9_kKlyq9DaQ>
    <xmx:tx9CalCTBhBXB4JX3qG-OXr6GFl_hQNu-dCWGYOVSPunpz1HiqU26w>
    <xmx:tx9Cau4XSDCdoWJwCvdQ5E8yXOLWhIwD6L4eLEn7C3mf3nmm_WdA0LIj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 03:33:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4c784b60 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Jun 2026 07:33:08 +0000 (UTC)
Date: Mon, 29 Jun 2026 09:33:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Michael Montalbo <mmontalbo@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] fixing expensive http test timeouts
Message-ID: <akIfsaVMB_S6kfJQ@pks.im>
References: <20260621213407.GC2297179@coredump.intra.peff.net>
 <aji9MOE-NTHKXYqn@pks.im>
 <ajkEzhdqzmAePk_P@pks.im>
 <ajkGkB2ckf3p43QR@pks.im>
 <ajkOoRhqaAcy6gBg@pks.im>
 <CAC2QwmJA2TH6BmO0O61qRYvV2pqURUk0dTXpkJtb9e-TZNZDZQ@mail.gmail.com>
 <20260626051657.GB3138423@coredump.intra.peff.net>
 <aj5ZaZK7xylfs4Xw@pks.im>
 <CAC2QwmLkHUymvtYbjY8aQO9_VogvaSXdbb1_DSZtcBttGfN0tg@mail.gmail.com>
 <20260628075716.GA3525066@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260628075716.GA3525066@coredump.intra.peff.net>

On Sun, Jun 28, 2026 at 03:57:16AM -0400, Jeff King wrote:
> On Fri, Jun 26, 2026 at 04:26:28PM -0700, Michael Montalbo wrote:
> 
> > I think Peff and Patrick's suggestion to just increase the Apache timeout
> > makes sense. I ran some experiments using a really long timeout with an
> > artificially slowed down CI runner and all the jobs made progress
> > (if slowly) without stalling, and eventually completed successfully:
> > 
> > https://github.com/mmontalbo/git/actions/runs/28267019651
> > 
> > I haven't spent a lot of time trying to figure out what the right timeout
> > value should be. An hour definitely seems like overkill, with something
> > on the order of 5-10 minutes seeming more reasonable, but I don't
> > have a principled number.
> 
> Here are some patches to keep things moving along. I arbitrarily picked
> 10 minutes, because multiplying the 1-minute default by 10 felt right. ;)
> 
> The first one just bumps the timeout and should make our problems go
> away. The other two are optimizations, but I'm on the fence on whether
> the final patch is worth it.
> 
> Thanks again for all of the digging.
> 
>   [1/3]: t/lib-httpd: bump apache timeout
>   [2/3]: t5551: put many-tags case into its own repo
>   [3/3]: t5551: pack refs after creating many tags

By the way, the only reason why we at GitLab haven't been feeling the
pain is that we only enable GIT_TEST_LONG for GitHub. So I was wondering
whether we want to have something like the below patch on top.

Patrick

diff --git a/ci/lib.sh b/ci/lib.sh
index b939110a6e..57801586aa 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -215,6 +215,14 @@ then
 	test macos != "$CI_OS_NAME" || CI_OS_NAME=osx
 	CI_REPO_SLUG="$GITHUB_REPOSITORY"
 	CI_JOB_ID="$GITHUB_RUN_ID"
+
+	case "$GITHUB_EVENT_NAME" in
+	pull_request)
+		CI_EVENT=pull_request;;
+	push)
+		CI_EVENT=push;;
+	esac
+
 	CC="${CC_PACKAGE:-${CC:-gcc}}"
 	DONT_SKIP_TAGS=t
 	handle_failed_tests () {
@@ -239,6 +247,13 @@ then
 	CI_BRANCH="$CI_COMMIT_REF_NAME"
 	CI_COMMIT="$CI_COMMIT_SHA"
 
+	case "$CI_PIPELINE_SOURCE" in
+	merge_request_event)
+		CI_EVENT=pull_request;;
+	push)
+		CI_EVENT=push;;
+	esac
+
 	case "$OS,$CI_JOB_IMAGE" in
 	Windows_NT,*)
 		CI_OS_NAME=windows
@@ -319,7 +334,7 @@ export SKIP_DASHED_BUILT_INS=YesPlease
 # enable "expensive" tests for PR events.
 # In order to catch bugs introduced at integration time by mismerges,
 # enable the long tests for pushes to the integration branches as well.
-case "$GITHUB_EVENT_NAME,$CI_BRANCH" in
+case "$CI_EVENT,$CI_BRANCH" in
 pull_request,*|push,*next*|push,*master*|push,*main*|push,*maint*)
 	export GIT_TEST_LONG=YesPlease
 	;;

