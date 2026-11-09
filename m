Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794215914;
	b=BsTktxRyzoaKiMGn8wL/oDFCNCkHaQBvoxzrvzpMMnOezSWCj/6+nFrmKolWUm7etRtR
	 54ir+7M9MWNU7kWvRRxyBA5m6GwmscxDhle9LGQGt/ocMox05SCcJXJaSV6NNulhFGb2S
	 KTj2zaNBop+ebqyROqoJIGIqJJCWUI0jV+u6FQ9v8OV9tpUwHEryw98oylPqdHnVt5aUs
	 9Zb/I9eyoUnFTMDnUBaNoxIbntow5tmCx4vOQjZHMr7QeJjbvRPqS0ttlcnPjCAhJ6vEL
	 612cIRW9Fv1eUm3RdeZin/Gs83gcr7Ty30xSFLPoQNEuh2M0OLKks4vYewsoop5M4Lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794215914;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=K4o09JNiHnAtUHcTRAvBmlyj/z0jVT6mwFkTnHD5Yqk=;
	b=MreL0aLss2TjzLOlgLeTb8WyMKH121llbAncG9aWjwCqfuRGYTsdLNd1R6CX0uh9tKgQ
	 ZoUVrhJx5P/Wq33UV9PQ/Db+il9Ka9SrYHsh2WAWnzZ/LkD5IgPKwx2ITJ/Oddcb5lhWR
	 qbMCizam2xZVjGS7cybkhXQ+D5hmPMJJVZKum+ylUrduArBnzjGrcZsErT/YqzSBylNNc
	 Xg9LpY3npb+wJG/WxVuIatM/VKj3MOGkfP29Xxt36tQjjScEHPAghVNobNGeGUcAtS/9+
	 a1xrfiMkRJS5N0ORTW1A76q8RIpb7iTVKasRx/RYk9TuSxywyG+ObBlsP72U3BD9zjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=ZaI6CUAO;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="D6/zV2ph";
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CA5606A321
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 09:18:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69CA5606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=ZaI6CUAO;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=D6/zV2ph
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 978177A013E
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 04:18:32 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 09 Nov 2026 04:18:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1794215911; x=1794302311; bh=K4o09JNiHn
	AtUHcTRAvBmlyj/z0jVT6mwFkTnHD5Yqk=; b=ZaI6CUAOL6OMtBaRleeo0Tamy7
	K6dHtuSNTaqVw2Z8ZcsQ/J/CsUmmTXoerCLB7wjd2vePyQhBj59oko117x0oMERN
	vfszuZoyOhC6Id4oJ2KTNg8sc6FeY73i31XSW3PiSsceP8ht1cOjuov7ECD1mS0A
	RxougGRaaYgOAYHyKJdKgCVJ978mE+CL9tZv1P9LgBXRWzvQxtSr6sTN9eQj+y/e
	rvDv4FF42aeqtyKpdJPTGLA77R4ILat4ER3cLlWKLybrTRQC9QQJkChiL4UMCeoa
	ivm/EufrIKwB0/X2jSlxspkulhR/u2uBRn2OKH9gzhTRRUG/SBEVjoZF6X1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794215911; x=1794302311; bh=K4o09JNiHnAtUHcTRAvBmlyj/z0jVT6mwFk
	TnHD5Yqk=; b=D6/zV2phzx8eBZLpxhOFTn5xbuiMhOUfYj7bRFDbglF/lCurxvX
	khfp3xiz0fBwCxOuwv9MiYnjUIII06Ma2vn2kfyjYmcJEKJ891EzuQXQ1YPsIdP2
	ikKd/Mt6sSHPzv7eQ22BeWoKKs8ABsIpr4eSCcXOrddpaWfYwpUbAKd52YwvoZA6
	SqNOlcdyJoc8GhTrVvmt4iEb6vSomVgUYOLTSGDIbGaqzJnNMZmHzrSE+HrbbAtB
	7F/vTxJ5ij1PNCDU/0MQzo12wsR2f1HRAVC7Kv2s0Cg8EJV4BPfRysZ5BcWWuq4M
	qq94fEXUt79yhznn/sui+bKDzrjDzKW50yA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794215911; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:g6ZYtnFVJicVxtB5LcTMikRN+i4F+6QPvQZs+g0hpwdcaQe
	vGLHvNiMnc8axY81J6HMNAc+hE7FxNaba2qw/EkbBUhh9mlOw+rmb7R9dauMiNJ0
	GQR73GIewEiOzLRdwaSF6woGpapr0E1EKT5lOHdjSodDQqXysi3EFcT90EEB7+PP
	4qu+DqqmA81s+9uMHJvCW72XvpB/tEiZLh54VRJYczeOYr5d1vKqh49gqntd5CE4
	FW25RyL7XkGP8BUx+XuPLj3N2AmKFP1t5IoTiZg3/i5G7ieagmOSljQrGsSxs4D9
	hQ39P37+yPFEBjO+AQZRmwCXMTYKNCcqz3rU1nA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:F9qmX4+wv4ISMsvWQEsdZkLD6+2sWteR3ZH4Wdx+BAA=:fYNEIIoZRowGz7pWV+B8pTywvExa/rhUXUaVYgUd038=;
X-ME-Sender: <xms:54_xahV5rJt27S2vaYW5kP-idGnn_FwJ8zSa-_a52H40Dx_B7nLByw>
    <xme:54_xagpn_aAeQSEi8C80GqcyfNPe5y_mwLues13i4AeQqn4bDNlamJPdRiX50l7rw
    yRb2gYN2fmzUjsvDIhhlLpKf_q0C5uuRrxA7AYefUl6Lt01MbdHDw>
X-ME-Received: <xmr:54_xajmZPHMrdjwfeLDfK4AC9gqS6zYrPxsXG7QQwtQBX31nySjanhDYC43fbcihBOCEx9M>
X-ME-Proxy-Cause: dmFkZTFLDmST4h0/QkIVNTmtT/2+68jmkg/AqXqEhPGZWTMIyklTeaS9MJjagks4gxJUJO
    rNa9ZA7wFUJsvqo1TTxKww+YDT4pPH5120P/Tx0PkmfpxD6VKedYv5IlaMQDtHhllIfHjm
    KFfgv65+kDGs34QBJ+ynjep+uf5Qys6CFodRRZGBQC4/Rbqf7B+sBSIBoLmx4M6Go9Tjis
    xtW92jOsdYdsJ4ed25tVbaxJUvE0iy3/e1ZEEqUEO8FGDUVv7dG562Uo21mHCx1DdBQF+c
    Q2R1IkiZXvdYWFdiBNgWimvZxl6JmrdWkCvWU8J5SLvZI4phJGLSNFI4yrD90dWJGjrcRZ
    QNy8ht1C4NhPgYoaB25U6ovbKc10G5vX0TQy9lY0FP70bPMfgZZc7BbPhv8W+DiZWaWkdU
    g0wlSW2us8x0G5txARBTaghAQhPiilzKXcLAMAgniLiWwMw+ghHDEaHp2fr0wUqlbt7jzc
    hNl0fUkEzy+JdK+VVn28iGqSm9O010TdjRFDF0WvYbjVxXwo2Up6dhAwxXE9ifQnyKKRUa
    1NGAG6cBzpScWOlg61HLxwbptgHioYGN6KIHXcv55hw6o1sxB0USNo+vXPCIWU1NIhAeVi
    H77B+U7jznwjyGaq6NiHyjzxPomjBFEDoQLQTR92qq7GS9RlOVpWIamqBwdQ
X-ME-Proxy: <xmx:54_xag2R66XVfDwE7ZQD0uLC-JlHUIs1KxvaSwPGZROxFTEwwcS8Rg>
    <xmx:54_xagT_2G-JlW3ILQMQVzi9TRHYO0Dykc1CjNM79xd2O_NSKGNGZQ>
    <xmx:54_xapwq6gR4hoMhImDoRoNzPjtk5BkIH0czDuWfLinwIlw5iRbpoA>
    <xmx:54_xagCdj4xR4XJDBBxa8YbGmLJmqpODKuAVCo9fV37gyhvWrfxLiw>
    <xmx:54_xan3DDeK_ch9ODJcqsXv5Mu0wk39jMWl4BRSkXRtvZKHRfMfBW255>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 04:18:30 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ec4b25b8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 9 Nov 2026 09:18:28 +0000 (UTC)
Date: Mon, 9 Nov 2026 10:18:25 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	usmanakinyemi202@gmail.com, siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com, gitster@pobox.com,
	karthik.188@gmail.com
Subject: Re: [Outreachy PATCH 1/6] notes: store the repository in struct
 notes_tree
Message-ID: <avGP1YMrzFKIIsU1@pks.im>
References: <xmqq1p8zw49g.fsf@gitster.g>
 <20261105203344.48513-1-okhuomonajayi54@gmail.com>
 <20261105203344.48513-2-okhuomonajayi54@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105203344.48513-2-okhuomonajayi54@gmail.com>

On Thu, Nov 05, 2026 at 09:33:39PM +0100, Okhuomon Ajayi wrote:
> diff --git a/notes.c b/notes.c
> index ec9c2cb150..4ab3d45d7c 100644
> --- a/notes.c
> +++ b/notes.c
> @@ -1012,8 +1012,9 @@ char *default_notes_ref(struct repository *repo)
>  	return notes_ref;
>  }
>  
> -void init_notes(struct notes_tree *t, const char *notes_ref,
> -		combine_notes_fn combine_notes, int flags)
> +void init_notes(struct repository *r, struct notes_tree *t,
> +		const char *notes_ref, combine_notes_fn combine_notes,
> +		int flags)
>  {
>  	struct object_id oid, object_oid;
>  	unsigned short mode;

I think this function should continue to receive `struct notes_tree` as
first parameter, as this is the subsystem it belongs to. While at it,
and as we already have to adjust all callers anyway, we might rename the
function to `notes_tree_init()`.

> @@ -1057,7 +1059,8 @@ void init_notes(struct notes_tree *t, const char *notes_ref,
>  	free(to_free);
>  }
>  
> -struct notes_tree **load_notes_trees(struct string_list *refs, int flags)
> +struct notes_tree **load_notes_trees(struct repository *r,
> +				     struct string_list *refs, int flags)
>  {
>  	struct string_list_item *item;
>  	int counter = 0;

Okay, here the arguments make sense. We could likewise rename to
`notes_tree_load()` though.

> diff --git a/notes.h b/notes.h
> index 6dc6d7b265..0f50020816 100644
> --- a/notes.h
> +++ b/notes.h
> @@ -50,6 +50,7 @@ int combine_notes_cat_sort_uniq(struct object_id *cur_oid,
>   * simultaneously.
>   */
>  extern struct notes_tree {
> +	struct repository *repo;
>  	struct int_node *root;
>  	struct non_note *first_non_note, *prev_non_note;
>  	char *ref;

Oof, this interface is cursed, it really should be refactored to not
have implicit global state. Arguably, this default notes tree should be
either dropped, or it should be stored as part of a repository.

Anyway, as far as I can see we always initialize this default notes tree
via `init_notes()`. So it's cursed, but I think it should at least be
correct.

Patrick
