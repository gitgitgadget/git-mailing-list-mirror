Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792534024;
	b=kLnbc+7xr2JlR+xba2+5cX6FFiVMMHRcdcHv1k0rFbgCXEO2ctzQinBYULBjp7Rc4ice
	 UIoFUXybkHhc5hRiPQKcSlNKpZx0d4xkfh+IUunu3dVZXseFb2/PmUMAQuAgC3aM+8nm/
	 zj0CV3rrkF2eVVhaEAsIHAHkUoZDPI68kgaAA9MFP4mQr9GRnb2zrsaTdRBVJGtbqNLaF
	 RLqxaOwqhPOcpD13O7OE805LEL3seQ8agj4/FDz1YukZQc0Or+Jivb4oFnRFBKg4g7A64
	 gM/bv0iNN8OXLXTVRZtYVJeqa5VcHgdrX6FqYkEih3ooxlqwG0baD9+3h0slIyDl6sA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792534024;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=UUy8rMmnGlvW3/gUSs6zhHwXp24LPHhd6TAofyIoR28=;
	b=PyOzCBCKSVrBf59sLjB2fhM9Z5br3JOQeARdayDiqFcwOOFE6F/esEJKmAoc80m4F/Bl
	 VG9VRNCQI5eaPgE9y/TCDyN1XhESxdHWSGtaldgsG3fyJAZeU799TlcLshsJvOQS70OId
	 nzoixkoA+mFmfrdb7nEqCsjdkdxBsJr7rUZ5LJgVQj16+LkWPuOR63iOAxHtgRfmid3Xj
	 2j7PVkBOgWxw9fJ5Dlj7QHyVp07gyBorl9crDMCmgn9gxSbOEDt0WaYZq/5D1iilKJy+Z
	 vmfFEFVG01XG1UWmGQvQYCwt6N3nakXqn3/jeaiz/Lc36WjDrcIGabkNZk8qyzD36BA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=ZXk8KuHM;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=bLqSDjRU;
	arc=none smtp.remote-ip=103.168.172.152
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE86606A31B
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 22:07:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBE86606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=ZXk8KuHM;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=bLqSDjRU
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E9C0214000A7
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 18:07:02 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 20 Oct 2026 18:07:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792534022; x=1792620422; bh=UUy8rMmnGl
	vW3/gUSs6zhHwXp24LPHhd6TAofyIoR28=; b=ZXk8KuHM54sX8yy0zG39YOqaVp
	cvG3KHHeKLRqMOWYFXHlpyb23zmHUOp5w3y99oSTxYi6UNy5MyP06ly8agnCMKTa
	l0bjQb8zmWlWo0nSEcA4wLDAFLHg/9JTn7laNiFiNi1SIKZCkMR2XrbZ6jp8qRxv
	nZc2I0xwOgbrbVLFZTAR2NUfo4dha2fuQmBhifsz3DcMwh0oWsHk7D9U/ADvWQPy
	tmvHZTmfYtnlZ9i0jWvVmtySHYPsL+Sg9nLgp1vwhIQjCBB+b0L+h+gLtEO+z76h
	c3Jcz0l44BRQ6vvEENDp2Pn1c7i329VwNEGkjJ81rbnLoADT1kH1k5k18/rg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792534022; x=1792620422; bh=UUy8rMmnGlvW3/gUSs6zhHwXp24LPHhd6TA
	ofyIoR28=; b=bLqSDjRUP5rC85J5RLiawoc8gxiJv7wXbmmnClqRxlvd+R0mDF2
	qVrut8DaSvZ2E4zTWfboWTXqliHhZjOyQ1gj6v5frDtaIIhZAkirql66V4hl9Mhd
	EwPbkUnZyX8i2stTrLtGg4T3lRqDU6abKP4lCPOmLk5bcAj76HDvVrrT524Bz9uN
	3Vlcp8LSeK7tRHEII3bSz0SQhOdWKuP38lIKl7Dvqhy7fX/LmP+YjYUB/TuI72at
	xHZLIGy2NxdEAOJHaJTp8Ws6HCdjrbNOR9QQcOCB/fkBFcpSxvrN4sx/ZrbSVewI
	uc3Zzc25QDup9io52v09TE0Qn0JKigy43tA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792534022; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:JRAwrzH4K8Mfpy6zCVXHir2GRaiOP47QnQwBTvz2zmutosM
	KDZ3xAc4fKhx+PQwjfwkPE8JB7h3j4z3v5oz/PJoRzqCXiGIB/2cjJ3IYIzIw+uz
	M/SlEQelxkcNaucPjpvtQWWjDWaX50brWzk1evIpm3dJ1hE7RBC+mTBCnbEWmCVm
	Mz5+CEJeaxJ8KLVTF6U6p+SWnOBlX7Zc5nMgd2Ra1bcVh/0lskgqYbNHVIzpi34S
	dfK/8uy6tTZoyiWwjhMqU6WmkB1BrFx0li3o7BjfldPAn6sviwB4hnJVXMULiHG4
	hkBFaqIr8k9rbBFqN6W0HSk+/tFZ875tx5ivk3Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:U5Nlizj/uyRqUJsa3qH6sY3UTk+Im8ddjlbiYvNoitk=:toYnFUxpMLRS13iTOuZivYFo/pMY9ngDbgtJOLW2ESU=;
X-ME-Sender: <xms:BubXahK0trK_zXgZjtBkI4qoLNIeRg6IN2wSZL5UBR8-HCDT_SWr6A>
    <xme:BubXakKYWT3-gziN9nRFEj0WVZcrSG-Z8hoWZtPKEBRWl0s4mqjUd0D_nTPyRVzDP
    gNYdcX5qG_uM2KyBNccuG8wcL5ElHcwqBvHghKY7nC0lUrbJFJgSyI>
X-ME-Received: <xmr:BubXausts6QfpBG5yYbsITigIjw7WAcmA0ivdoMyFa15tptA2nGkLlfu29bBh_XiD8t6CK_Qo-7hcxUIKQEzeeMINV1BBRCSvapQ>
X-ME-Proxy-Cause: dmFkZTETH8uAZQIcwbyLt6rVYdw21Nzd5Ria3H0i6t/VzUVxPItZfpRI3VA4oeMqAZ+XFn
    9QfLPis8AywS8zM4wXggY00tzXgFHdTXlbY7I6+qzLmlU/5VldZVKBqkJjAJ2xSh1Vp57A
    Vn69l6zIFMrFAiwSD4yoESVUy9h5e1OT71eshZO7F0eg4pepubPaJD+JYFuYoGhcLhorpD
    79y/v1//mbrBvwev+9bRt/u6ZhoaffFloxPz279h7DRXiZpokOzW6Q41uS/LcB1g5qfYdx
    IldqXkBp1Kjo8vWUK2q3xP7Dkmx9ure5FpMZBVuA4FMFiUg2ULLihubzk14X9toi4/jRQc
    xaiTrBpbNIgU5/8sMhPRakx1c72/HUrEDD6JQVB/4nJZ3Gzq9BibjurmHIG30THCSjlGFb
    fYAOywTm6BB972mqMDCOKB8mtRddhflMOD5Lmi6Bzk6ZjwbrR2Uh5g6w1W7N6Tt2PvKNpb
    OWOBIzNydGNdD4fD7u8ni9mKIs4wWg6c8AyNVlJRmD975MuvHLqoYvTFXo90zTIc1UCcJN
    FFYHXo3rc+FAtp/q+A/KVP+IgXjU3hcVORDu30VdGs/b8svWmapwbWyTkt6kFBf3v6Sxzr
    cHiiPKMQut70Vt5HIyyUIali9GzQyXKdm8mu291UmtrEQs+WslMTD02+TOvw
X-ME-Proxy: <xmx:BubXahS9TxOJpqo3YlCfW22oKX9gkEb-CaaRC5ZrEKE5dhllOfBHIA>
    <xmx:BubXakOvhDDWm0cxfVY9xcN_zEc_EW8x8kqaJS7u_sYNp41Q_24Fzw>
    <xmx:BubXamYfT9h4SO-5MVXSQ2UHcZfL4djJhdDh_cEFzr311ABjZLbKRg>
    <xmx:BubXauwV2R0_j-6tQU0BY6vkZW-BdflWVLPGaCISoFle0J4f4mEhNw>
    <xmx:BubXapP2ZnWNKXB39Pc0Quj8qeO46dUBM5l4S5Fk4CuDW5RXJyfvCD_5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Oct 2026 18:07:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?B?6YeN55Sw5LiA6IGW?=
 <kazumasa.shigeta@kanamei.com>
Subject: Re: [PATCH v3 5/7] stash create: rework temporary index creation
In-Reply-To: <de5e0c196a9ff241861f5598ac9f6bc5c960f6ec.1792509606.git.phillip.wood@dunelm.org.uk>
	(Phillip Wood's message of "Tue, 20 Oct 2026 16:20:40 +0100")
References: <cover.1791218125.git.phillip.wood@dunelm.org.uk>
	<cover.1792509606.git.phillip.wood@dunelm.org.uk>
	<de5e0c196a9ff241861f5598ac9f6bc5c960f6ec.1792509606.git.phillip.wood@dunelm.org.uk>
Date: Tue, 20 Oct 2026 15:07:00 -0700
Message-ID: <xmqqse20rpq3.fsf@gitster.g>
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

Phillip Wood <phillip.wood123@gmail.com> writes:

> In order to use create_index_from_tree() we need to add a new
> parameter to control whether the index is reset, as the new caller
> needs to merge the index rather than reset it so that we still detect
> intent-to-add entries.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  builtin/stash.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)

This is the most interesting step in the series.  The patch itself
is very small, but it frees us from flipping the in-core index and
its side effects.  Nicely done.

> diff --git a/builtin/stash.c b/builtin/stash.c
> index b4fe7465e4..ddeb5a5d2a 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -374,7 +374,7 @@ static int reset_tree(struct object_id *i_tree, int update, int reset)
>  }
>  
>  static int create_index_from_tree(const struct object_id *tree_id,
> -				  const char *index_path)
> +				  const char *index_path, bool reset)
>  {
>  	int nr_trees = 1;
>  	int ret = 0;
> @@ -403,7 +403,7 @@ static int create_index_from_tree(const struct object_id *tree_id,
>  	opts.src_index = the_repository->index;
>  	opts.dst_index = &dst_istate;
>  	opts.merge = 1;
> -	opts.reset = UNPACK_RESET_PROTECT_UNTRACKED;
> +	opts.reset = reset ? UNPACK_RESET_PROTECT_UNTRACKED : 0;
>  	opts.fn = oneway_merge;
>  
>  	if (unpack_trees(nr_trees, t, &opts)) {
> @@ -1399,7 +1399,7 @@ static enum create_result stash_patch(struct stash_info *info,
>  		goto done;
>  	}
>  
> -	if (create_index_from_tree(head_tree, stash_index_path.buf)) {
> +	if (create_index_from_tree(head_tree, stash_index_path.buf, true)) {
>  		ret = CREATE_ERROR;
>  		goto done;
>  	}
> @@ -1458,22 +1458,15 @@ static int stash_working_tree(struct stash_info *info, const struct pathspec *ps
>  	repo_init_revisions(the_repository, &rev, NULL);
>  	copy_pathspec(&rev.prune_data, ps);
>  
> -	set_alternate_index_output(stash_index_path.buf);
> -	if (reset_tree(&info->i_tree, 0, 0)) {
> +	if (create_index_from_tree(&info->i_tree, stash_index_path.buf, false)) {
>  		ret = -1;
>  		goto done;
>  	}
> -	set_alternate_index_output(NULL);
>  
>  	rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
>  	rev.diffopt.format_callback = add_diff_to_buf;
>  	rev.diffopt.format_callback_data = &diff_output;
>  
> -	if (repo_read_index_preload(the_repository, &rev.diffopt.pathspec, 0) < 0) {
> -		ret = -1;
> -		goto done;
> -	}
> -
>  	add_pending_object(&rev, parse_object(the_repository, &info->b_commit),
>  			   "");
>  	run_diff_index(&rev, 0);
