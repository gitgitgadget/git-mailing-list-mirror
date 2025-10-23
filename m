Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE18323414
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 13:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761226511; cv=none; b=UX2ArRBZsn++IqCi53Ze3vDkdz1h/Vg9VWuoaArbf80T395F3Knq3O9r84Mk5Hsn96sKDUsL8zASr/8ny5x1TOVDwluxuQnU0Md/ePK0u+u/jlv7dvP/h2rTSQtImAeYWYWUIuu41sgkv696e9Ftr+3+/g4XafPAxr+E2AKpguk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761226511; c=relaxed/simple;
	bh=OB+ocb4BgqU28eEkdtT22qq89VGqAH4p3tm21z0DX4k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E5XCm0q2b85yT/G2lDCutgHx6jfCYTT/YTyK3xURUf9LZpNfzPc8SV+OtGishXYhPCxhcqK2fu9j7JloxrAGBQEKQepLFpJ84gNUNzNZB0DvgEArKwNva+BV5NDGTMoNdUXZt9akgpQIAVe6ztQv0IrF8pZSEOiWZu5BkRRXcvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WYq1qK3Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cucwf/RL; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WYq1qK3Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cucwf/RL"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 19198140020C;
	Thu, 23 Oct 2025 09:35:08 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Thu, 23 Oct 2025 09:35:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761226508; x=1761312908; bh=jlpCWLgusc
	FP3EsB1t6E6PRfbZOVbrW6rXblfkZbXJM=; b=WYq1qK3Z8fwfICjCDu/KtZiPwI
	VAmLJt1XY+N5p7+j5K5j+SI7EeUPHtukZ/YzaLWQBmUA5w59xKf6UhzFNfom+Nuq
	WZF7RJSmtodXP9tZS1yAcCiocwC/3AOY7yYIvrebXveROTCZVap5DPtWGhINsPtN
	TpnU4vZaYzGi8CzZ9cGU8FC4Txule6nKIb1WVq4juoOX25mYuM/m0wxQJ2+qgz4D
	5F/QKUXyCayRuRGJJ1T7ic+pWZAazyE65UFGQK5Jx1nTbymKMjuNs5QFXfMMb2oK
	6BL8MNq7swBRN0hpFZPLc12KIVl/VRTcpekLeMdsb2QdFHoNShaZVMg1xAbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761226508; x=1761312908; bh=jlpCWLguscFP3EsB1t6E6PRfbZOVbrW6rXb
	lfkZbXJM=; b=cucwf/RLjozy3WjzhcDV3Ylxxtg8jkaAUwzz9tlQbwB//huk97h
	r2aXTiv03HD2QS2iCD64xj9ImuOZCcBM+Oo8g2CLTmGnsyyRcDIRkW6+px9Ndtoy
	EJfki1qMRiPl7oXsb/QxB9ocQCq9l62xKt86VytImeIDwRYYRW/e9A0hjwDXcZeS
	gHz1BnhNHF2jfIQRdetYBxy/JaQwkLLEQWzGyYnkWEutHF8Vke2zFJVfROqgoIIt
	TWfIg0ZTNlTx/O7PpuQHdhbqbzo8kVSN94/g6B+OZUod23gG8w4cKs/Zgb+qfAll
	Hs1G/GjU6N1mfXa1NHEmZCQ2lqI4XzxzGXg==
X-ME-Sender: <xms:Cy_6aEqVEGPgnUHgkq6Qjg-Z0ObpjH0IKb8_ghOQiey9gV9mqRmfVg>
    <xme:Cy_6aBjzlPvX5QqXaYUhwjFTBw-WP02q0OU-jH1NNFaV1QjNbbnIXxGskGXw8S-0G
    CbQkPEVVnT6qRTu0NYsXTbYfkGiWJLNs6kfAjEK4RLcbW2s5Y5MCQ>
X-ME-Received: <xmr:Cy_6aBikBX4Iv1KKTRctV2ibIoU6uTEtoT6bU05heTF4GrX9BRHHr4JpBNLbkvPz-GPwZ7BbGpNUwIq8RA9VNCLw6JjYU-ZJG7zm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeeiheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hjrghkvgesiihimhhmvghrmhgrnhdrihhopdhrtghpthhtohephihlughhohhmvgdvugdv
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Cy_6aHiYlVXMObRTxL7sVf7CCrs3QDneOhL2TVDeT5XURXvtEnU3hw>
    <xmx:Cy_6aBJ4Y6t_oNkwsF_H4PzckejsiTHyFHxKQLEF1j2BNM0sitzrVg>
    <xmx:Cy_6aGGlzqfTP2uaaT6G3s7xgfHYwoNSpBA88WcJa10s9T4jLfEK-g>
    <xmx:Cy_6aFTYNgWkO8Oilktgt94KiFnapNrq_OAk4A46jH5X67nQ2QWUGg>
    <xmx:DC_6aD4EtGn3qyaj5wJj_oM-LY99rJbhdPEMHH-dcDWgeubDIpqjfeEp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 09:35:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Jake Zimmerman <jake@zimmerman.io>,  Lidong Yan <yldhome2d2@gmail.com>,
  git@vger.kernel.org
Subject: Re: Regression in `git diff --quiet HEAD` when a new file is staged
In-Reply-To: <20251023120101.GA1123594@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 23 Oct 2025 08:01:01 -0400")
References: <CACJRbWjwOQwJB13CwTfvhV3p+Hbn4KrNM9AtBanGtUS4V_1MbQ@mail.gmail.com>
	<20251017075153.GA4078773@coredump.intra.peff.net>
	<xmqq7bwt1kyf.fsf@gitster.g>
	<20251018094037.GA1060824@coredump.intra.peff.net>
	<xmqqh5vww7xa.fsf@gitster.g>
	<20251021073640.GB259661@coredump.intra.peff.net>
	<xmqqy0p4wcac.fsf@gitster.g>
	<20251022091112.GB853931@coredump.intra.peff.net>
	<xmqqikg6zxui.fsf@gitster.g>
	<20251023120101.GA1123594@coredump.intra.peff.net>
Date: Thu, 23 Oct 2025 06:35:05 -0700
Message-ID: <xmqqms5hwxkm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> That is because you are trying to redirect to /dev/null once at the
> beginning of the loop. But the loop is effectively:
>
>   for each pair
>     check for content changes with diff_flush_patch_quietly();
>     output actual pair data with flush_one_pair();
>
> We want the redirection to /dev/null for the first part of the loop
> body, but not the second. So you have to do the redirection inside the
> loop.

Yeah, my bad.  Lidong noticed the same thing.

> I agree that opening /dev/null over and over is silly. But we can reuse
> the same filehandle for each one. I.e., like:
>
> diff --git a/diff.c b/diff.c
> index dac3ea9e01..e903afcf04 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -6835,11 +6835,11 @@ void diff_flush(struct diff_options *options)
>  		/*
>  		 * make sure diff_Flush_patch_quietly() to be silent.
>  		 */
> -		FILE *saved_file = options->file;
> +		FILE *dev_null = NULL;
>  		int saved_color_moved = options->color_moved;
>  
>  		if (options->flags.diff_from_contents) {
> -			options->file = xfopen("/dev/null", "w");
> +			dev_null = xfopen("/dev/null", "w");
>  			options->color_moved = 0;
>  		}
>  		for (i = 0; i < q->nr; i++) {
> @@ -6848,15 +6848,20 @@ void diff_flush(struct diff_options *options)
>  			if (!check_pair_status(p))
>  				continue;
>  
> -			if (options->flags.diff_from_contents &&
> -			    !diff_flush_patch_quietly(p, options))
> -				continue;
> +			if (options->flags.diff_from_contents) {
> +				FILE *saved_file = options->file;
> +				int r;
> +				options->file = dev_null;
> +				r = diff_flush_patch_quietly(p, options);
> +				options->file = saved_file;
> +				if (!r)
> +					continue;
> +			}
>  
>  			flush_one_pair(p, options);
>  		}
>  		if (options->flags.diff_from_contents) {
> -			fclose(options->file);
> -			options->file = saved_file;
> +			fclose(dev_null);
>  			options->color_moved = saved_color_moved;
>  		}
>  		separator++;
>
> You could even imagine diff_flush_patch_quietly() saving the /dev/null
> descriptor in a static variable and effectively leaking it (or if we
> want to be more structured, cached inside the diff_options struct). And
> then the callers do not have to worry about it at all.

That would be bigger change than a regression fix warrants, so let's
leave it out, but let me use the above to replace my botched
attempt.

Thanks, both of you.

