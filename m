Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F99924BBF0
	for <git@vger.kernel.org>; Sat, 17 Jan 2026 18:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768673749; cv=none; b=CjEIqugdZbkYx4U82/y57AQP5waKqyxOWQhq37+m0gT0GT2QBxGtg+wW4ZnazlRTkL3ejNx3g3vJzz6glQ/V/hfNHu9WJKlAzjcZcc5PTeDqTXkOkeAwl1iy2SSBsBSD85s7IK3t8kIwWgYKqEp+NUeMatpnZKy+KS6kCTflc/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768673749; c=relaxed/simple;
	bh=p/qfF3J2Er76CJBczl6kdOL2lG8MrCCXw6bDbkcrowE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dHLND3+DDWJpxgZkjZKfEte/nELYgrjPphoNGcd0yinHo9tOTRYc2j7QNcExt8cq6DTRBYThxKAHL1HyY2CJt3W0Tb9wwId6pKH5ILe50EUk+vKqv8BGo7hyg0ACa/uQ63KDIiPB9SN4VDpx1h0seHGFZ+PxhaqYTd4Q/XkByA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gajS+cG8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=t1m12KyA; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gajS+cG8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t1m12KyA"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8D8D0140037B;
	Sat, 17 Jan 2026 13:15:43 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Sat, 17 Jan 2026 13:15:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768673743; x=1768760143; bh=LlxDr8xAkz
	rlD5pG3tUAvZplO1N45QrNSjjWVF0GfTA=; b=gajS+cG8ZeTw3V79UuwRZrBtXB
	wkuZB5VeiIR8sMESAbJP+XOdVfKt4hzaAnmJ1E/KFWG2P3HimuTzgTEGtXR4RAYx
	FHpB/9Xy0O08Ffa7QR9zZe6lorCheQFaxnxIgK63BmqbRnpG+z9rTLGDWHkfr9j9
	QWdln0MrjiHRWtru/8sPCfSux0HJ6fZOw86KnmjIlFQWBrhA6rC877a5Hj0v6VLs
	6thCvOfpI1NonEmwi8wAnNoJk85ZAYiwumgLhTSRF2k4u4JQc59DUjzARHDfpK/+
	+CdgtRitotJW1jCxqR4so6d/QAQcUkOeTqg+ohSVBz74SOqtPPPagWXzWbxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768673743; x=1768760143; bh=LlxDr8xAkzrlD5pG3tUAvZplO1N45QrNSjj
	WVF0GfTA=; b=t1m12KyAVdLj8Sg3BNxzXwCjpNklidC/qB2HV8C0Mp82d6PBmtm
	d/vXi60OpYNKpzjC8SEHStvvPgAxC6nsTFJKxCuVgP9rzqDCIJzKF3nCjGIdV7Fl
	pII0hbyb6apqPUUDLRs8/lfrZ7GMeR+893DcofPMFdYbsUdbY0uA7lHAIUNDGcag
	fHbtZIJo9wteCMqY4DKusgV4yyhKGY4w4/nPwQ5QJtMDHfbl9YV+iKRaqUvVQZ7i
	V3jlB5bS8y/31w6AMddK/CJyRtAhtyjRStfz5Hr7wyzqWtohT3Z/9Lup54FFvk+l
	rniADi417vh3RmvMV4tH++f9PPBN1fWN7SA==
X-ME-Sender: <xms:z9FraY3jH3epSgf_VXj9bCnIqNjo5J0NExgYbvEGc0iYIfprdgSwQg>
    <xme:z9FraaiI0hxsPU_u22QU9OhYaQ0z4_XENnpcotdqpnWkqpCj8B8Ir6hHX6YWSKyGS
    NlB4KXJl5_PYMWRrit5EeR8fJmwcP7QJjblss0q9MyNa5m6MHpWvg>
X-ME-Received: <xmr:z9FraeQnyUvkmhxv1eUnjVrfZpceXxk62TfpuqsvvIhpqKEWLzV0VTG6uUZ1InfYx8cGfsolVztqS5DEHX2fQup7E_Hsb2n5B0fPNrg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufedvheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrfedvtdeh
    udehfeegudeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:z9FrabhXd2UKdlYHUeGkCP1u4xKgP7gjAwKppMZJBkUYDm9mDsJ8Lw>
    <xmx:z9Frae4koURHH9wGIVSEdRDg3KD3VIoNsoEEVgNMGOwrOUM5ZMEg4w>
    <xmx:z9FraYAOxHmlQnaPInALrOzG_9quQAzQyxrzAIQx3z4iha8dx9QOOA>
    <xmx:z9FraVY2VMlHb7tpW0DBd7zicL9P0KwM70sQHSMPcIT37fq8mdb1Jg>
    <xmx:z9FraeiUmvptyrxpUDsf__w0i8D3sn1qt5GizNy8uj0MwiAiQIC9Vbz1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 17 Jan 2026 13:15:43 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <a3205153416@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v1] t2203: avoid masking exit codes in git status
In-Reply-To: <20260117175847.334666-1-a3205153416@gmail.com> (Tian Yuchen's
	message of "Sun, 18 Jan 2026 01:58:47 +0800")
References: <20260117175847.334666-1-a3205153416@gmail.com>
Date: Sat, 17 Jan 2026 10:15:41 -0800
Message-ID: <xmqqy0lw5cmq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <a3205153416@gmail.com> writes:

>  test_expect_success 'git status' '
> -	git status --porcelain | grep -v actual >actual &&
> +	git status --porcelain >tmp &&
> +	grep -v -e actual -e tmp tmp >actual &&

Looking at other parts of this patch makes me wonder if we can get
away by filtering lines that match "^?" out, instead of explicitly
naming 'actual' and 'tmp'.  It seems that the entire t2203 file does
not care about untraacked files at all (in other words, there is no
"expect" file that expects a line with '^?' in it), so rewriting the
above (and everything that this patch touches) to use something like

	git status --porcelain -uno >actual

makes the intent clear (i.e., we do not care about untracked files)
and simpler (i.e., we do not need "grep -v" to filter), wouldn't it?

>  	cat >expect <<-\EOF &&
>  	DA 1.t
>  	A  elif
> @@ -26,7 +27,8 @@ test_expect_success 'git status' '
>  '
>  
>  test_expect_success 'git status with porcelain v2' '
> -	git status --porcelain=v2 | grep -v "^?" >actual &&
> +	git status --porcelain=v2 >tmp &&
> +	grep -v "^?" tmp >actual &&
>  	nam1=$(echo 1 | git hash-object --stdin) &&
>  	nam2=$(git hash-object elif) &&
>  	cat >expect <<-EOF &&
> @@ -171,17 +173,20 @@ test_expect_success 'rename detection finds the right names' '
>  		mv first third &&
>  		git add -N third &&
>  
> -		git status | grep -v "^?" >actual.1 &&
> +		git status >tmp &&
> +		grep -v "^?" tmp >actual.1 &&
>  		test_grep "renamed: *first -> third" actual.1 &&
>  
> -		git status --porcelain | grep -v "^?" >actual.2 &&
> +		git status --porcelain >tmp &&
> +		grep -v "^?" tmp >actual.2 &&
>  		cat >expected.2 <<-\EOF &&
>  		 R first -> third
>  		EOF
>  		test_cmp expected.2 actual.2 &&
>  
>  		hash=$(git hash-object third) &&
> -		git status --porcelain=v2 | grep -v "^?" >actual.3 &&
> +		git status --porcelain=v2 >tmp &&
> +		grep -v "^?" tmp >actual.3 &&
>  		cat >expected.3 <<-EOF &&
>  		2 .R N... 100644 100644 100644 $hash $hash R100 third	first
>  		EOF
> @@ -211,11 +216,13 @@ test_expect_success 'double rename detection in status' '
>  		mv second third &&
>  		git add -N third &&
>  
> -		git status | grep -v "^?" >actual.1 &&
> +		git status >tmp &&
> +		grep -v "^?" tmp >actual.1 &&
>  		test_grep "renamed: *first -> second" actual.1 &&
>  		test_grep "renamed: *second -> third" actual.1 &&
>  
> -		git status --porcelain | grep -v "^?" >actual.2 &&
> +		git status --porcelain >tmp &&
> +		grep -v "^?" tmp >actual.2 &&
>  		cat >expected.2 <<-\EOF &&
>  		R  first -> second
>  		 R second -> third
> @@ -223,7 +230,8 @@ test_expect_success 'double rename detection in status' '
>  		test_cmp expected.2 actual.2 &&
>  
>  		hash=$(git hash-object third) &&
> -		git status --porcelain=v2 | grep -v "^?" >actual.3 &&
> +		git status --porcelain=v2 >tmp &&
> +		grep -v "^?" tmp >actual.3 &&
>  		cat >expected.3 <<-EOF &&
>  		2 R. N... 100644 100644 100644 $hash $hash R100 second	first
>  		2 .R N... 100644 100644 100644 $hash $hash R100 third	second
>
> base-commit: 7264e61d87e58b9d0f5e6424c47c11e9657dfb75
