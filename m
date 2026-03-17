Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB8726F293
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 16:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773763693; cv=none; b=uAdsj1Phj0fDIb0k/EN/YRrtGOV5KQZeOWf3aYgj2GxHP7U/Jxcamj6Vuyp8PSDFH/9t7LmhvGe6KyGr3sgwlTEjojeQpnjY/pycrrOGXe4EQNuPvAMjtcPIRjkgdUcYkzO+VzHMal05ch690z5VbNY5osoTozIpYKvmzVBgER0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773763693; c=relaxed/simple;
	bh=aWDwaZKDzz8iGGBbbDxIhZn61zk1fUWut/78Xxee3oQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=txceEUZTvgHCKO7kUtPuyMSFXO8O9lB7FZtwLsmLrKQoCdZ2p8vPAr3JT4vdv4zfJ42SWMv6BcNfs2ahabopzgUqgpsC6Knhqb5dNre8MW5su3sGL60pY6yfqucJCHs2WyekhIlu3KEcbeLfCUmnZpSc4TPdTCUdAuQlJK3kBH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WZ2LeTAv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PeZkaPId; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WZ2LeTAv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PeZkaPId"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id CAC681D00212;
	Tue, 17 Mar 2026 12:08:10 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 17 Mar 2026 12:08:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773763690; x=1773850090; bh=JGuyv+neu4
	Xau/Xd+LZHfPP/d4VeIVgPmLbsjRyc9m0=; b=WZ2LeTAvqjNQ85VVfM16qL/iEs
	MSmk9PC+39lWa/4W38gdq4aOFuCnI0PpcvxuAZ3fkgPeVLc0oD7uheFGepNxfpvG
	OchRCe3Uy22U7kKR8yjBqRtcnDbEdsZ4mKVeW1lkOndp2Sr24sAYTcE7u+9goaYH
	h63d8vHq6SENaVhU2FQdJ42wS9ttYRDtmUE5Kx6xC1zJrKLJX/CHRBqeAxF8adgp
	8gzWEpqgdLSFioXEA+C2qCVpjvc+FTy6oK2Jpu3xRSqlpNk6QeCD7juHIix696dA
	O7Z9F8h7mUdph6OUI/Fhbjc8fhb/lMvHYBLYc5Mf7IgVEIEEMp5e94M1mBCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773763690; x=1773850090; bh=JGuyv+neu4Xau/Xd+LZHfPP/d4VeIVgPmLb
	sjRyc9m0=; b=PeZkaPIdvVm2zxJa+We2uXBf+V4PIycu5IZtPVbgzv3RevP33ui
	8iROG9v4sIVs4GjT3QtPYV7IfmRnO46GPQQMqrluY6LQ3AerHrlTDzX+BJ0kKN2c
	T/rX3Oj6UJ7Xihh/yGCk4AmhrcRasArb7L0DbNgL76cQ2f9y0HwjhKPvSxktqDEB
	BsE/pYcNZSS1ABLsY0Dpf/zdn/+4eNPqGmge0gFLzKSTMJZ37DK2BmS5ZO9e4frJ
	xxXYOoRPxq76UGwW81NYNNytFOPZoBdqkgzB6JcL0elcr3pUfWGVkPD6kwzYDmB/
	f9L02x7KLlc1XZ/iydJFge7307dz/W42Zdg==
X-ME-Sender: <xms:any5aYOGcVbFh_g1sQ4u_FAKP2tPBpXv1UoibmfkbbNXR6u2fMvGZg>
    <xme:any5aWbvxRkUBUT7ZW9lIu7q1hf3VYEaplNNfS1nG2AMpNeY4Al-SBhPm_lpO02Hn
    A_9GRhc1gfYfJw_8Q7npCkYP-Ok6SMSCQgqnQjznf11GT7dVdz8hTg>
X-ME-Received: <xmr:any5acqa4igJS7M3VaXNXxbU1rZJ3gIi3JAUZo-u4RI5Mj74ONDj1OEa6bn08GHk2D9C9iMjYXKFPYlAIMaK29Rm--vKSfLs1A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdduieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhgvrhhrhiifrghnghdukeefseihrghhohhordgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:any5aabnj8YylJIG6fKIfgsOVpPO2VVrZNOdTctye9B7W0tLR7kxCQ>
    <xmx:any5aURBzsAKkeDo9dVgquDhk2BZEvEmlfbaoWjwmvQ92lqGBxS-fA>
    <xmx:any5aR5jtpOhdNkFuDXdtTroN2q2-e50v4mY96qAyOITQ08rSejX0Q>
    <xmx:any5aZwxMJPa7kMW_NcVGZ3fotY9ZSjU-xJbdgL9FPn6FXqRPUDwrg>
    <xmx:any5aZUdBp7AnCczKICNcDCYr0fEdlb1UzZHibJAZnoQRyHTj1pgPZxB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Mar 2026 12:08:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jialong Wang <jerrywang183@yahoo.com>
Cc: git@vger.kernel.org
Subject: Re: [GSoC PATCH] apply: report input location in binary and garbage
 patch errors
In-Reply-To: <20260317002235.6121-1-jerrywang183@yahoo.com> (Jialong Wang's
	message of "Mon, 16 Mar 2026 20:22:35 -0400")
References: <20260317002235.6121-1-jerrywang183.ref@yahoo.com>
	<20260317002235.6121-1-jerrywang183@yahoo.com>
Date: Tue, 17 Mar 2026 09:08:08 -0700
Message-ID: <xmqq5x6umobb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jialong Wang <jerrywang183@yahoo.com> writes:

> diff --git a/t/t4100-apply-stat.sh b/t/t4100-apply-stat.sh
> index b3d93d8ed6..8393076469 100755
> --- a/t/t4100-apply-stat.sh
> +++ b/t/t4100-apply-stat.sh
> @@ -125,4 +125,16 @@ test_expect_success 'applying a patch with an invalid mode reports the input' '
>  	EOF
>  	test_cmp expect err
>  '
> +
> +test_expect_success 'applying a patch with only garbage reports the input' '
> +	cat >garbage.patch <<-\EOF &&
> +	diff --git a/f b/f
> +	--- a/f
> +	+++ b/f
> +	this is garbage
> +	EOF
> +	test_must_fail git apply garbage.patch 2>err &&
> +	echo "error: patch with only garbage at garbage.patch:4" >expect &&
> +	test_cmp expect err
> +'
>  test_done

What is this patch based on?  Can we have a consolidated either a
single patch or a series of patches that form a single topic?

> diff --git a/t/t4103-apply-binary.sh b/t/t4103-apply-binary.sh
> index 8e302a5a57..f2d41e06bc 100755
> --- a/t/t4103-apply-binary.sh
> +++ b/t/t4103-apply-binary.sh
> @@ -179,6 +179,24 @@ test_expect_success PERL_TEST_HELPERS 'reject truncated binary diff' '
>  	" <patch >patch.trunc &&
>  
>  	do_reset &&
> -	test_must_fail git apply patch.trunc
> +	test_must_fail git apply patch.trunc 2>err &&
> +	line=$(awk "END { print NR + 1 }" patch.trunc) &&
> +	grep "error: corrupt binary patch at patch.trunc:$line: " err
> +'
> +
> +test_expect_success 'reject unrecognized binary diff' '
> +	cat >patch.bad <<-\EOF &&
> +	diff --git a/f b/f
> +	new file mode 100644
> +	index 0000000..7898192
> +	GIT binary patch
> +	bogus
> +	EOF
> +	test_must_fail git apply patch.bad 2>err &&
> +	cat >expect <<-\EOF &&
> +	error: unrecognized binary patch at patch.bad:4
> +	error: No valid patches in input (allow with "--allow-empty")
> +	EOF
> +	test_cmp expect err
>  '
>  test_done
