Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967EC1FC7F9
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 17:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741280646; cv=none; b=e+Jdr5dli9kqWxaQ7pAQ10P8rmkLvBO4R0OufWi0jKe0BoSF32OJumDSEif45xvd+NYjP2jj3m8eXq6eaBry6dsIpQlPlNt7/iwpna7/sRkSr0Tm031AJ2OgB3NJR/XU8fHI50cEzm5cF30BQwbsadwfmu8Dk6Gu+P6ICUKSlX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741280646; c=relaxed/simple;
	bh=adlLeyQAxe7ASZcMLEQTS8YNXEH3a0Rs+SB7UjcBOYc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Nw9eVCLSfO5FxcYLfEv+cQeWrDFTrZhqNRpjd3OvvYR1KGcapYAIm+xjP71OD52z51BNjzxPk31RKIS8u3dLhlvBnbYRlH1wCCcnwTdfuWMArFEnOUosMZivb0FV7uz5ALIidI1sU2AHC4ZLcjIrWlRbghgPGoFIcPYeDPmye+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UXBXr2iR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ty6JwSWP; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UXBXr2iR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ty6JwSWP"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id A882A138113E;
	Thu,  6 Mar 2025 12:04:03 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Thu, 06 Mar 2025 12:04:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741280643; x=1741367043; bh=FOHa6gyxJ3
	S/BIEDdOyuV0K810gwoNXUQXjP5RfZP4s=; b=UXBXr2iRqCx3LrcyiSo8jkJoeU
	4ws5uAz8/LjUK+Mu5LLSZZPWz/I9YAIv6NzZm+G62jesUx42xuh3foYfEhNBtRWk
	hLAxHxl6BfAHMbQ0ZBLP2fYDi0AHbADaGWPCuPpreqbBJFJ6YhYtl0Uf8tdodtYc
	9oMvjInRO8DQda2EeD3k/kxrHZviIloljcK/qf7U6O/IuGWKMqbCdmDJKsyfFzEk
	2GdsAdWagmAjK/xA2uO0csHvlXzx8dAo3MTk751XUT2wH+4N0P91kNJJ4tfnD5Bu
	Mv7qdzIUqM/Qss4VIoZjigxBIPASgCUl8ibohbwv6yWBFWyu7uDaOspEMriA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741280643; x=1741367043; bh=FOHa6gyxJ3S/BIEDdOyuV0K810gwoNXUQXj
	P5RfZP4s=; b=ty6JwSWPeyAcvchRgt0E9P/27MkIEeVo90SNs2kzB3zGUWidNFD
	1hr9yrVn91rAHddSiqym5n8lEjVCC532YiAQKLVv85/8kwtGiCMk29VZbFGLsNxi
	Rzkz0lN5cSpfR49bdgZLMGiUR3pJIwqY38l0rdF4d3EYt1OhjHoOiBzSw1kDecXI
	9cPmbqNjoXpqXwbeTR+/itS3Ds4xPCc/MKZAZZT2ncDanVbvVSjpVWE3p6FiD8vL
	Sgo4qycOouaqOre3vPMxNkJ9Sn9xX/DE6RuPcq9JQEXD2dvLSPxsuFvyNIzgM2Vp
	tFuL5Az57bUvrnnlX1EgEPQJj5QZckTB9pA==
X-ME-Sender: <xms:g9XJZw20X23sBWnut7_HW826E04grF4MQZ-abFSS5GxVRWfpq652-Q>
    <xme:g9XJZ7FzdRc_AIewFfria_Fv0GasODxn_S1EhrEJ1IbXzK6ALUp73taZGVvY9IPaO
    SfEKrRxFbTbmYCAww>
X-ME-Received: <xmr:g9XJZ46gf5-IbKX9ZhnOw5EfbNDwciNVpTFOdxseuoSs1sEjx09M_5dmQaUdWRJHSjEd6HiDisDRqHcPZ6wCa4Fxh6SHgw43G-UX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdekfedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvvghtshhonh
    hifedtudejsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohephhgrnh
    ifvghnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:g9XJZ51cYv_Vb6TEvPMS6RwO5gkkQYQoyHAV5H7Tv-9AGefS4rR8TQ>
    <xmx:g9XJZzFBFt-BWpR1tJGaSbtey8-rgEjQBmQ9Ar4kcxDXLokXKOcRxw>
    <xmx:g9XJZy9kHhPlW6ZBisNlb4mrMk68jB4aXl3hzwehIx2_vdvRfuoHHw>
    <xmx:g9XJZ4lz5AGbNealfFnZjsAcXnHF-AyEg1hWBrmWcONuicC_TXEwTA>
    <xmx:g9XJZ0O7AmF_CY28dRKmT6G_5KOKTWhfhDenTIJhVdXmNwzsUCkQgFhA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Mar 2025 12:04:02 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Meet Soni <meetsoni3017@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Han-Wen Nienhuys
 <hanwen@google.com>
Subject: Re: [GSoC PATCH] reftable: return proper error code from
 block_writer_add()
In-Reply-To: <20250306121324.1315290-1-meetsoni3017@gmail.com> (Meet Soni's
	message of "Thu, 6 Mar 2025 17:43:24 +0530")
References: <20250306121324.1315290-1-meetsoni3017@gmail.com>
Date: Thu, 06 Mar 2025 09:04:01 -0800
Message-ID: <xmqqsenqhz0e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Meet Soni <meetsoni3017@gmail.com> writes:

> Previously, block_writer_add() used to return generic -1, which forced
> an assumption about the error type.
>
> Replace generic -1 returns in block_writer_add() and related functions
> with defined error codes.

What's missing from this proposed log message is an audit of the
callers to tell readers that this change is safe and expected by the
callers.  IOW, are there callers that start to behave differently
when they see ENTRY_TOO_BIG instead of -1, for example?

> Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
> ---
> This patch attempts to avoid making an assumption regarding error codes
> returned by block_writer_add().
>  reftable/block.c  |  9 +++++----
>  reftable/record.c | 16 +++++++++++-----
>  reftable/writer.c |  8 +-------
>  3 files changed, 17 insertions(+), 16 deletions(-)
>
> diff --git a/reftable/block.c b/reftable/block.c
> index b14a8f1259..50fbac801a 100644
> --- a/reftable/block.c
> +++ b/reftable/block.c
> @@ -49,7 +49,7 @@ static int block_writer_register_restart(struct block_writer *w, int n,
>  	if (is_restart)
>  		rlen++;
>  	if (2 + 3 * rlen + n > w->block_size - w->next)
> -		return -1;
> +		return REFTABLE_ENTRY_TOO_BIG_ERROR;

So this makes block_writer_register_restart() to return -11 instead
of -1; the sole caller of the function is block_writer_add() that
begins like so:

        /* Adds the reftable_record to the block. Returns -1 if it does not fit, 0 on
           success. Returns REFTABLE_API_ERROR if attempting to write a record with
           empty key. */
        int block_writer_add(struct block_writer *w, struct reftable_record *rec)
        {

Needless to say, the comment before the function needs to be
adjusted together with the above hunk (and others).  But more
importantly, are existing callers of this function now expected to
adjust to the change in behaviour when they receive the return value
of this function?  It used to be sufficient for them to deal with
-1, 0 or API_ERROR, but now they are required to handle other errors
(like the one that comes back from reftable_encode_key().  Do they
already handle these new error codes just fine?  Have you traced the
code paths to see how they react to them?

> @@ -115,8 +115,9 @@ int block_writer_add(struct block_writer *w, struct reftable_record *rec)
>  	int err;
>  
>  	err = reftable_record_key(rec, &w->scratch);
> -	if (err < 0)
> +	if (err < 0) {
>  		goto done;
> +	}

This is unwarranted, isn't it?

> @@ -126,14 +127,14 @@ int block_writer_add(struct block_writer *w, struct reftable_record *rec)
>  	n = reftable_encode_key(&is_restart, out, last, w->scratch,
>  				reftable_record_val_type(rec));
>  	if (n < 0) {
> -		err = -1;
> +		err = n;
>  		goto done;
>  	}

Here, block_writer_add() starts returning new error codes to its
callers that it never returned.

>  	string_view_consume(&out, n);
>  
>  	n = reftable_record_encode(rec, out, w->hash_size);
>  	if (n < 0) {
> -		err = -1;
> +		err = n;
>  		goto done;
>  	}

Ditto.

Note that I am not saying that it is a bad idea to make the error
codes more specific so that the callers can tell them apart.  I am
only saying that the patch that makes such a change must also make
sure that the callers are prepared to handle error coes that they
have never seen from the current callee.

The same applies to the remainder of the patch.

Thanks.
