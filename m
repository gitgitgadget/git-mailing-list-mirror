Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885B53D76
	for <git@vger.kernel.org>; Fri, 23 May 2025 21:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748037110; cv=none; b=KDcAwYZ2glsfZINvOLtXpWuH8bhxTb24qUHKYcDEP2AWi8yAsFSEWHeozomNevlM5p6JeWp59Cyk+CwSkljsKVOMNLKBh0JWvE7vOYghKveFsVKRmEaQRoB2Fhe/Vh14sGMeOmqLoN1dzHMlQX9ZRyh25yd/uKI27J1UzoijXmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748037110; c=relaxed/simple;
	bh=ZGwuzp7bTG5P6ckuVJ4lhG7/tK06qZMleIrzz1n75+o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fQusZd8VEiE+WXm1tz1YzRkwFnr5xkB0v6Pn4dcQUZ/QVyVcuzQHjjoYtAZ93219JfrT2FuW0xbMdgXnmkRbOFUNWZRq1HCrv8jokKzfk51wkpn8dYU8OlcrDfW+d0S44e5TichuydoZ/RoNbAmsZvdlAg5tNYg0+tnk3Ie2oO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bsF6OHn7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p2E0cEpF; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bsF6OHn7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p2E0cEpF"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 85EEC11400B0;
	Fri, 23 May 2025 17:51:46 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 23 May 2025 17:51:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1748037106; x=1748123506; bh=5F7DdVn6M6
	dp6Wq0UAVypvVxVxkpCOQPWnepNpD8Eeg=; b=bsF6OHn7euYStOfBRaQSCck5qc
	1itQXChi4jMFg6U6mnqP3CAWMFIr7MlrAAlRvkdCShzo06bACNqKGW0WjzspJ466
	o8X3RCn/vnp70OkbAGfiRA/p+ts1Gq6jTqQqq54iSI9cu1R0NLZhcXAaVfR2h4hT
	YmeyihEBLgz+LtTM+7MVM7lDaYn8xxTO3TRMK61aec3/rTAJQm1rAGFr8FDsydhS
	gOXSsz8Z43Ll59HyfjvCcHG8+Vrli8BJxUmnmKoHETMy1piasMGtqqzZRUIx3Ajx
	ShHg4dH6PH/5iiCGE/1n3EIJ+3FVBdNjAIuNrrnnFiN1JsrZ2D5KrutiM4aQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1748037106; x=1748123506; bh=5F7DdVn6M6dp6Wq0UAVypvVxVxkpCOQPWne
	pNpD8Eeg=; b=p2E0cEpFLPEumKTBI0AdaB4awf/ITtccGEqOU739+zG0boLFaNj
	4GfFsWhKexr+w0Fwp466Ss82r2VOn69aGZTOeK5+/rn7Rfne+EQUV31PekifwGlY
	9P+jQX3DeczCgGDQpR7ULa1AZcAR3Ouv10WnN438dpEi2MXXncm7SM528Rq+aUNB
	2XVMvU6mfXKiu85EIcyRaQlSddSDHVrg9mND8Yovd4sLwCAasJvvMFHDbwF1Z8sp
	HwHFUj3bPt0rgPGqe0+r91FqRcRoYpukp6Q8rXk8mLpGX3QXvRtY7n1S15x/ara7
	PuUCje3y9ZcMENIbR9NioMx1OPsZAN8B1uA==
X-ME-Sender: <xms:8u0waELEqCPYBQB8fQ6aG0imrFLpJZ4cBVxLv6TU4zOHwhkPdGotGQ>
    <xme:8u0waEL4_D_mmG73TQg7FhA7DJ1RU8Whc89JLw0wDnxId5_-eJ6rvZK6ZV6_widc4
    xJI6oKTG7G6L3ydow>
X-ME-Received: <xmr:8u0waEtY-ZWtzU3jS0BiHhM6LGjrruq5Lmb8Eoa5MjjqaAdYQ-2kCYngw4ReLWJKsCHBPYgMpZosMxBRF7ck13YRT35WGgyhAIefkio>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdelleejucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffffk
    fgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceogh
    hithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeeh
    ueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosgho
    gidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehm
    rghrkhestghhrhhomhhiuhhmrdhorhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:8u0waBZmhZSrc6407dbeaDNlBcgNGDxue2kjf-3memXutRCy771HcQ>
    <xmx:8u0waLb_D4MOfIAiEdGYGTSwRmQt2rNtDWak2TKpFtAJsRj_mdFpHg>
    <xmx:8u0waNAAPD6fqgjOPNS1cU848N7HeEpa60NPQNNdAKFt_-_lJsTuLw>
    <xmx:8u0waBbKpPpyrcETBKIWUNFAZ00jWseuFYWdJYhy3hewDpvnTjHW9w>
    <xmx:8u0waDErWiQz5TI_qHSVbZJsegWr4CxAqetBSELtp6s5tB77XuWetAZQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 May 2025 17:51:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Mark Mentovai <mark@chromium.org>,  Git Development
 <git@vger.kernel.org>,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] t7900: use pwd -P in macOS maintenance test
In-Reply-To: <CAPig+cQLG+zveZg73E=TiC5uShhhRXKmK5Z_M8zN3fpGNEN1ng@mail.gmail.com>
	(Eric Sunshine's message of "Fri, 23 May 2025 17:24:38 -0400")
References: <20250523193722.68344-1-mark@chromium.org>
	<CAPig+cRpS=t-wNLxdV_WoKF0Wzy-S1oLUEyS18S9r-4OBQ87VQ@mail.gmail.com>
	<xmqqsekvvz1t.fsf@gitster.g>
	<CAPig+cQLG+zveZg73E=TiC5uShhhRXKmK5Z_M8zN3fpGNEN1ng@mail.gmail.com>
Date: Fri, 23 May 2025 14:51:44 -0700
Message-ID: <xmqq7c27vvv3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Sunshine <sunshine@sunshineco.com> writes:

> Hmm, I'm not sure how that would help this particular case which wants
> to know the path of $HOME:
>
>     pfx=$(cd "$HOME" && pwd -P) &&

We set HOME to TRASH_DIRECTORY during test, so HOME would not be all
that special.

I thought one of the issues was on Windows "-P" in "pwd -P" is a
no-op?  So if you want to fix it locally perhaps

    pfx=$(cd -P "$HOME" && pwd)

but I think the true issue may be that we set up fake HOME using
TRASH_DIRECTORY that is before we canonicalize it with "cd -P".

Would doing something like this (without any other changes we
discussed so far) help?

 t/test-lib.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git c/t/test-lib.sh w/t/test-lib.sh
index af722d383d..92d0db13d7 100644
--- c/t/test-lib.sh
+++ w/t/test-lib.sh
@@ -1577,6 +1577,8 @@ fi
 # Use -P to resolve symlinks in our working directory so that the cwd
 # in subprocesses like git equals our $PWD (for pathname comparisons).
 cd -P "$TRASH_DIRECTORY" || BAIL_OUT "cannot cd -P to \"$TRASH_DIRECTORY\""
+TRASH_DIRECTORY=$(pwd)
+HOME="$TRASH_DIRECTORY"
 
 start_test_output "$0"
 

