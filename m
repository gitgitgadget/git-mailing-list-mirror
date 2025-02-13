Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A8F2063E2
	for <git@vger.kernel.org>; Thu, 13 Feb 2025 06:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739426905; cv=none; b=aVP2ep07NKJjsWjOQFL3sGxnW32POAb8VzYfwb9h/2D5SZUNZONFeYEXDc8erGOWd3SqG24QZeobUdEG3q4+ajiQSLpy6rCS2yeY8/0tdMXZBgR6p0WW6EzhaGm02YeI6TmltcpM2z0qO1i0dL7QA4v0/zM0N+HFg/QNSCnEKRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739426905; c=relaxed/simple;
	bh=m52gZxH45gu4gxVt3qqur3Q0dsxqcDDbSgne5Lka6R8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PcK5ntZ/PgKjZEYkGJPiD7qcSZ7wgQUXQikWv8INVAgVqrFL0xfS5Qxv9n8MXYzOKNoWYIzlKSugL6GlAVLQsnascCLQRB9I+Bp8on72SArwIDOQVUPWL6lIZjluNIWq5qqUzbIp0eR1oua8kU/S6lV8+qFYVVXWoTs0cVLygys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=k2goeGI9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BsFzhxwU; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="k2goeGI9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BsFzhxwU"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 6BB86114014B;
	Thu, 13 Feb 2025 01:08:22 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 13 Feb 2025 01:08:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1739426902; x=1739513302; bh=tmbr9/tXCl
	boNUsPAahwr0F51v4xbb53sgL/9T2kNZA=; b=k2goeGI9U1H8mIgT0GDNHpyHcq
	4FXAewh5+1y6SucmImbhAVCU57HaEwWKDSKRQg0nUODgbycVNNIfXFfrjbznwInf
	zJJP+N4OsIZIFJBE0xmATuO/j7QUOI+ZBbyyPm3brT7TbqBHWFEHZ+dIPNOqKJf8
	AU88VgS5682h/nW1gKrQ/AHeElRzo0njl5WZK6lotkQAqAvNYHYGlQxH+RV9ywVn
	m3LvF2EihLioHWfW4XVaA2PLps+q8KvuIERHvvmHbC9G92fXfroHivOsiKFcEmoh
	T2i4W+XlxoUiOkZrTq0uoae+xFL98uO2v1bJK2U+k3UDSPFsEGPy7OJxWMww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739426902; x=1739513302; bh=tmbr9/tXClboNUsPAahwr0F51v4xbb53sgL
	/9T2kNZA=; b=BsFzhxwU3HWNMIkbwUUg+2v0q24Y3qiGueb0yrStMfdKI6ReXHn
	S94vDofbI08QF+8BALgHghztT/P7llTo+2HJKRmLmB1torAXRJdSa4Qf06XEBHb0
	TIG/g30ga3daodXL8T0rsuTXbtghyng1Cc6fomg5Bw+HDeDBZhKU/x2dy96vIvBf
	aCsM6ARMryfFuB8n/t7P0uNh/TV0OafDqg+ZTsONyJknxZzfY4Ib6FVbGrUFucEX
	THO0LSZtEPIyHdsD9cbzm0DJMnaSMEZ+6K5d5e6l8Wfuv+oW0fizeiMMxQ3feFv2
	UriglPBF71th5cN35wBjF8y82NTCAVUbnEg==
X-ME-Sender: <xms:VoytZ1FRpdSQjF-lzS4THpIk1A1ARrpV7aRvcYD2c_TIqMImwJoeJQ>
    <xme:VoytZ6WBFI4PMcZso1U0_37HI5nMUv7_jZ8rqOlw0iuiDH-r_OHcERweLaMCMIF5I
    s5XGAxBR0tJmfI0rw>
X-ME-Received: <xmr:VoytZ3LJsXylDiHasJwBVdJb7Vd1fvBwl7JqNbOIhmpuk9B9Y0CBVm5mW07E9oAWLosx7wguTv_4u7azD8i4kRTS_gD57aI9Q6fBjjC-3aECPQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegiedtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehjvghl
    lhihrdiihhgrohdrgedvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnse
    hgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:VoytZ7Gdqqh8xgRrH0UXHOLtOflegEDZYP4WEBe7ytjhmqbTOY-xuw>
    <xmx:VoytZ7XuwTM5qwnr1f8Jf9SimVq9ibNx2JSR0gQx_5ZzcaU2b42oGg>
    <xmx:VoytZ2Pdy8uaDOJ_h-uYDzVIUcYOR0QNHGybvToaHRJRHwq--tVYbQ>
    <xmx:VoytZ63GlVLMjAwJZYjvl-xODXfTPdeqtk1tOPg00d3Z0O1L32yXAw>
    <xmx:VoytZxyepiqk3wCRf-D3DEgJ8CnzG78BXXj6gXUXLjGovPcnSOEto4XL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Feb 2025 01:08:21 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 16e666e7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 13 Feb 2025 06:08:18 +0000 (UTC)
Date: Thu, 13 Feb 2025 07:08:13 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Zejun Zhao <jelly.zhao.42@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, newren@gmail.com
Subject: Re: [GSOC][PATCH v2 2/6] apply: change some variables from `int` to
 `size_t`
Message-ID: <Z62MTZXQD3Wa47Jz@pks.im>
References: <20250205014055.737190-1-jelly.zhao.42@gmail.com>
 <20250209081216.241350-1-jelly.zhao.42@gmail.com>
 <20250209081216.241350-3-jelly.zhao.42@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250209081216.241350-3-jelly.zhao.42@gmail.com>

On Sun, Feb 09, 2025 at 08:12:12AM +0000, Zejun Zhao wrote:
> Some assigned variables are mistyped as `int`, including
> 
>   - those whose values come from a system function returning `size_t`,
> 
>   - those that are used for array indexing,
> 
>   - those that represent length/size/distance,
> 
> some of which will trigger -Wsign-comparison warnings.
> 
> Change some of them to `size_t`/`unsigned`.
> 
> Signed-off-by: Zejun Zhao <jelly.zhao.42@gmail.com>
> ---
>  apply.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/apply.c b/apply.c
> index 831b338155..b4ae74a5fb 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -1087,7 +1087,7 @@ static int gitdiff_index(struct gitdiff_data *state,
>  	 * and optional space with octal mode.
>  	 */
>  	const char *ptr, *eol;
> -	int len;
> +	size_t len;
>  	const unsigned hexsz = the_hash_algo->hexsz;
>  
>  	ptr = strchr(line, '.');

This is storing the result of `ptr - line`, which will be a positive
integer. It's later passed to `memcpy()`, which expects a `size_t`.

> @@ -2320,7 +2320,8 @@ static void update_pre_post_images(struct image *preimage,
>  {
>  	struct image fixed_preimage = IMAGE_INIT;
>  	size_t insert_pos = 0;
> -	int i, ctx, reduced;
> +	int i, reduced;
> +	size_t ctx;
>  	const char *fixed;
>  
>  	/*

`ctx` is indexing an array and counts against `preimage->line_nr`, which
is a `size_t`, too.

> @@ -2492,7 +2493,7 @@ static int match_fragment(struct apply_state *state,
>  	struct strbuf fixed = STRBUF_INIT;
>  	char *fixed_buf;
>  	size_t fixed_len;
> -	int preimage_limit;
> +	size_t preimage_limit;
>  	int ret;
>  
>  	if (preimage->line_nr + current_lno <= img->line_nr) {

This one stores `struct image::line_nr`, which is a `size_t`.

> @@ -2706,7 +2707,7 @@ static int find_pos(struct apply_state *state,
>  {
>  	int i;
>  	unsigned long backwards, forwards, current;
> -	int backwards_lno, forwards_lno, current_lno;
> +	size_t backwards_lno, forwards_lno, current_lno;
>  
>  	/*
>  	 * When running with --allow-overlap, it is possible that a hunk is

These are a bit curious, as they store `line`, which is itself an `int`
parameter. As far as I understand, the only caller is also only ever
passing a positive integer here.

> @@ -2791,7 +2792,7 @@ static int find_pos(struct apply_state *state,
>   */
>  static void update_image(struct apply_state *state,
>  			 struct image *img,
> -			 int applied_pos,
> +			 size_t applied_pos,
>  			 struct image *preimage,
>  			 struct image *postimage)
>  {
> @@ -2803,7 +2804,7 @@ static void update_image(struct apply_state *state,
>  	size_t remove_count, insert_count, applied_at = 0;
>  	size_t result_alloc;
>  	char *result;
> -	int preimage_limit;
> +	size_t preimage_limit;
>  
>  	/*
>  	 * If we are removing blank lines at the end of img,

The caller makes sure that the function only gets called  when the
parameter is a positive integer.

> @@ -4288,19 +4289,19 @@ static void summary_patch_list(struct patch *patch)
>  
>  static void patch_stats(struct apply_state *state, struct patch *patch)
>  {
> -	int lines = patch->lines_added + patch->lines_deleted;
> +	unsigned lines = patch->lines_added + patch->lines_deleted;

This one is curious again, as the type of these variables is an `int`.
This should likely be adapted in tandem if they cannot be negative.

Patrick
