Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2ECF235345
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 08:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741767802; cv=none; b=Ip2ARTsj7KSgfh0e42I1sGJe91k7VScaeSBBcv7MrUAdXhay/XTk64uHoA5dMFzoD9XkMja4NX07GH+XWTVBtL3SKi0ebOKe7cGtTTmB77Yj9eE/xqR7+ZHg0A3Nf/p0ECABkNFJm2FRFuySkdD7VBGoWuZ9osYw08guIjm8ggI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741767802; c=relaxed/simple;
	bh=D1bOqDiQEAP4aTeHgUIqG/iWD9mh8jJOWPbNeoAQLes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K1NbG+8+OYrh7doxFKmDluH2TEv925N8gr8ISDbt4uFRjHdDBNfE5yPUxInjiXKewOB+RX4nA6u+Hdv161diBqgbHKQD4BTA0dUGZjnYxQIThemyUzciOKZljQkyZQn30yAMOn894qsfA2T1UxhQIF4c6cp/+IU6PU+m4HZBpjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=A91+TE8d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fKZGJSJn; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="A91+TE8d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fKZGJSJn"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id A04C21140236;
	Wed, 12 Mar 2025 04:23:19 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 12 Mar 2025 04:23:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1741767799; x=1741854199; bh=q2WDnf1xje
	/EBWirtqGMCl93XosgG6DrbtnD5VWd8Xo=; b=A91+TE8d8eClwivA364NjjkMnr
	c+2mjfFeBXVqytObu9q+96cZtOscaBvQ0T4AgvY9VZ9IYjnJa+7LkhKYATGmyO6r
	qMGF8KS5owKauDetfzzBBtl+Wa0/afG5Gw2FNpvpcd0DkdBjKx7R8f7w8mH+NSqU
	uX9zbkvZP5vGe411239QcTaaBUyMOzdP1DwSTiOqk3bpQcbWxMlLgPcCMGwK0foo
	8eeuH7Ul5DyIhUBRZSys2dCoFExL2pQ5bJ+OjY7FXstD2UXnTrJZ3lJSmPyZ/VG1
	jc7W6O+Jl9fBoiqBC6CLmK2kyg4W90cdI0PZ6cG8ysA79Ds7vT64eNp6sgWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741767799; x=1741854199; bh=q2WDnf1xje/EBWirtqGMCl93XosgG6Drbtn
	D5VWd8Xo=; b=fKZGJSJnt/KbNAXYlnY+OrTxnfhRMqr1ZfATYrG3RENVfo0HvVJ
	hlNmfcMVwJf9L9uuP9vv808belkUVQn9kGjfeAQO/BaIPC0l6LZVqYLN1uQXRoEI
	Dk1QzeC7rKcAkz0QUB4x+UbrzZGpAXg9J26Vz9g23TSaSJa+VX/rZv+Xk3pXRgd1
	wCQuVKTNXfwpQsN4b8g3Xsem3WN3mv+Ohpn7l8RhSWIg2fXE2s9zwnsPM66cu2pC
	4NeYl9IEym6TI0lJkHQcosgt93rr6il8Fbh7BbITRxQC+3+3gfxdOdybbbX5ZkkI
	ObhN//vQnau55pa+bBus4+G6LWBzb2uD1+g==
X-ME-Sender: <xms:d0TRZ-KumnzkKIjHaayv6horACZNsH22G7_LvfutWzCUF-BUWpZHGA>
    <xme:d0TRZ2KeSYNpkSSXGOjWeC5QDAv_a5ytYEX5fvADAjLjTONyV_KlIhnLrs0_0OaQg
    tObgs3hbd0yQxP6fA>
X-ME-Received: <xmr:d0TRZ-vTXADKUvjy7F_OoqDCIrTict4TU8pF6f2lSUCmN1a1mEACY0Cz95vpurAa63SFR1UlVvBv_Sz4Tnmuro4EZ8HHsJI9vFrRBW1QX0GQhYzCbQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdegheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgv
    vghtshhonhhifedtudejsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:d0TRZzbJcvmNiglgJUtbJ68ixrdWSOEscVfr0Fw3wDxHSFwZv5-7kQ>
    <xmx:d0TRZ1b0seSLQF-5E9oBNu3mL4F0-9VhlsnxDV_2H3u_R0ieDVk4Vg>
    <xmx:d0TRZ_DoeJVHeYwXrhix_ZF3fdr6dKEzhlAFJBGHm0ct4K4R-qCyAA>
    <xmx:d0TRZ7ZfoJVaX0qes_wzeH2CC-5_XY2XjroJFV-hzM3DKnwOkp4CqQ>
    <xmx:d0TRZ5F8m_33YaOLLfH9yZ62Z0Xha34ICWqBcRJp_Ahzt__ZePhAXh5A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Mar 2025 04:23:18 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 214a0d72 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Mar 2025 08:23:16 +0000 (UTC)
Date: Wed, 12 Mar 2025 09:23:08 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Meet Soni <meetsoni3017@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [GSoC PATCH v2] reftable: return proper error code from
 block_writer_add()
Message-ID: <Z9FEbH48tQ9KxzQV@pks.im>
References: <20250306121324.1315290-1-meetsoni3017@gmail.com>
 <20250308133349.1591331-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250308133349.1591331-1-meetsoni3017@gmail.com>

On Sat, Mar 08, 2025 at 07:03:49PM +0530, Meet Soni wrote:
> diff --git a/reftable/block.c b/reftable/block.c
> index b14a8f1259..89ab8bbc57 100644
> --- a/reftable/block.c
> +++ b/reftable/block.c
> @@ -49,7 +49,7 @@ static int block_writer_register_restart(struct block_writer *w, int n,
>  	if (is_restart)
>  		rlen++;
>  	if (2 + 3 * rlen + n > w->block_size - w->next)
> -		return -1;
> +		return REFTABLE_ENTRY_TOO_BIG_ERROR;
>  	if (is_restart) {
>  		REFTABLE_ALLOC_GROW_OR_NULL(w->restarts, w->restart_len + 1,
>  					    w->restart_cap);
> @@ -97,9 +97,9 @@ uint8_t block_writer_type(struct block_writer *bw)
>  	return bw->block[bw->header_off];
>  }
>  
> -/* Adds the reftable_record to the block. Returns -1 if it does not fit, 0 on
> -   success. Returns REFTABLE_API_ERROR if attempting to write a record with
> -   empty key. */
> +/* Adds the reftable_record to the block. Returns 0 on success and
> + * appropriate error codes on failure.
> + */
>  int block_writer_add(struct block_writer *w, struct reftable_record *rec)
>  {
>  	struct reftable_buf empty = REFTABLE_BUF_INIT;

I'm in favor of touching up the comment's formatting while at it, but if
we do so we should use the correct style, which has the opening and
closing parts on their own line:

    /*
     * Yadda yadda.
     */

> diff --git a/reftable/block.h b/reftable/block.h
> index bef2b8a4c5..0e7c680cf6 100644
> --- a/reftable/block.h
> +++ b/reftable/block.h
> @@ -53,7 +53,7 @@ int block_writer_init(struct block_writer *bw, uint8_t typ, uint8_t *block,
>  /* returns the block type (eg. 'r' for ref records. */
>  uint8_t block_writer_type(struct block_writer *bw);
>  
> -/* appends the record, or -1 if it doesn't fit. */
> +/* attempts to append the record. returns 0 on success or error code on failure. */
>  int block_writer_add(struct block_writer *w, struct reftable_record *rec);
>  
>  /* appends the key restarts, and compress the block if necessary. */

We might also touch up this comment to start with an upper-case "A"
while at it.

> diff --git a/reftable/record.c b/reftable/record.c
> index 8919df8a4d..d9fba8ff38 100644
> --- a/reftable/record.c
> +++ b/reftable/record.c
> diff --git a/reftable/writer.c b/reftable/writer.c
> index f3ab1035d6..5cb9d0bf85 100644
> --- a/reftable/writer.c
> +++ b/reftable/writer.c
> @@ -327,18 +327,11 @@ static int writer_add_record(struct reftable_writer *w,
>  		goto done;
>  
>  	/*
> -	 * Try to add the record to the writer again. If this still fails then
> -	 * the record does not fit into the block size.
> -	 * TODO: it would be great to have `block_writer_add()` return proper
> -	 *       error codes so that we don't have to second-guess the failure
> -	 *       mode here.
> +	 * Try to add the record to the writer again.
>  	 */
>  	err = block_writer_add(w->block_writer, rec);
> -	if (err) {
> -		err = REFTABLE_ENTRY_TOO_BIG_ERROR;
> +	if (err)
>  		goto done;
> -	}

Let's not drop the second sentence of the comment, as it is important to
give context. Also, let's take a step back here and figure out what this
function is doing:

  1. We compute the record data and try to append it to the current
     block. If this succeeds, we can return immediately and are done.

  2. If appending to the current block fails we assume that we have
     failed because the block is full. This is because reftable blocks
     have a specific maximum length that we cannot exceed. We thus
     flush the block and start writing a new one.

  3. We now try to add the same record to the new block again and hope
     that we can now write the record successfully.

The important part that the TODO comment refers to is in (2), indicated
by "assume": we don't actually check what the error is that we've got
from `block_writer_add()`, but simply pretend as if it was
`REFTABLE_ENTRY_TOO_BIG_ERROR`. This means that we'd even re-try writing
the record in case we had for example a memory allocation failure, or an
I/O error, and that is plain wrong.

With your changes we have now started to plumb proper errors through from
`block_writer_add()`. But that doesn't mean we can just drop the comment
and bubble up the error. Instead, we should also be adapting the code in
(2) to do the right thing: we shouldn't _assume_ that the current block
is full, but instead check the error code returned by the first call to
`block_writer_add()`:

  - If it is `REFTABLE_ENTRY_TOO_BIG_ERROR` we indeed should flush the
    current block and try to write a new one.

  - Otherwise we bail out and bubble up the error.

And once we do that, it is fine to remove the comment indeed. It's
somewhat funny because from my point of view the comment is in the wrong
spot: it does correctly point out that _this_ particular callsite is
doing the wrong thing, but it didn't mention that the other callsite
also has the same problem. And that other callsite is more important
from my perspective.

So I'd recommend to split up this commit into two commits:

  - The first commit prepares all transitively called functions as you
    already do.

  - The second commit adapts "reftable/writer.c" and fixes both
    callsites of `block_writer_add()` to do proper error handling.

Patrick
