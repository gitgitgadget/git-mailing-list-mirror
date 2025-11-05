Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116811A9F82
	for <git@vger.kernel.org>; Wed,  5 Nov 2025 17:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762365367; cv=none; b=NZEej5ENiYhDTOBQkFG2vZVk9DrvHBN/2ifD+B6R+mmqUOuVFckcKhskbGqLItrmcllloA74bwYOGEEgBfXYFtbXbCyXGLvXR/qas4HqviXPkqf6gLtHoEA7WCWnSTDxFbFWsJzH8mK5BfxMqscqZ5voqtnJdUcfSe5udKX7+Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762365367; c=relaxed/simple;
	bh=85aEyOQIVRi4mzntU1TdbgjBthAl2bHaxsI+tc202qs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tQG/8HDOe0I/B6IWNZ/VPQ78tf2vfEBQ1q6sHl+fvuur44n2VdnTrSNuL6zQfn8rlZ6bZCZ9SR9BKS2IX7E1a6hAK8ptvnxc93HjmnhN3gTC9MSSBJWZoD/ILslWkPiURNzMRBSlQ6W8/gNqPSPOLdW3ybsG3DHyiYjOxwGH/tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=K2vqz4l6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RWhgWXu8; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="K2vqz4l6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RWhgWXu8"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 2DE351D00225;
	Wed,  5 Nov 2025 12:56:03 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 05 Nov 2025 12:56:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762365363; x=1762451763; bh=gp6RRG7Wf4
	hf+0ZnPB0OlcMeVKsIhixX24ie9swgscg=; b=K2vqz4l6xjpw6YO22Uh39ECn3R
	yJLncyKZo4+EW3e2YSrvUYSfWZepfLjoRu5dDkeD5fFrDYBa1xIW9rA7ODKHK/cY
	1IhE+NC0yvS76wR7Y7gs2bleN9cqfOBDpES1saXJa//+WPRl3XuAavprDWhWHop6
	W7NhGsXjvfTQAFPHfqliWe8zTRkEGohtbVHsdSSLcrz2VlYoU1qNfaUZc1LHmP+i
	41hOG8lCxes8svGl/qOXBJcVfCfkiGQ1xHdYFMXI1jJlRUQHlilKarrzEGcEIVHv
	v/G8JJbrzgbiA+vg0IGwm/1yqst9z+OTQmsizdr789lIELDUlV5tpY6iv+ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762365363; x=1762451763; bh=gp6RRG7Wf4hf+0ZnPB0OlcMeVKsIhixX24i
	e9swgscg=; b=RWhgWXu8x8qP9XMdypTU7fmsFIMs1cXcqYuFcHNispILZ+UjLN9
	aQRAVRZafQANcvkYMyCLu408zAz3BH67rYF8tH4miqoAE+au1rrFIZSVcftB5zle
	QCJdiWcy0OBKFdR3ZWHPTVctPVYDcDmKcDVk7PLREBxG8+vmOZI/TZGDkf+/7Fsn
	C347N8/pASzf7gFlYf8R6Q/6mjrYaV+5g+JzFMtlNfue/X7xV7ADaovAUO+1Qqao
	kiNzKrkC6EQHyF5z10Y+zEOCNAK1C5UcWhCMHkLYPKIPVaGAWzRTaDDU6Pgof3VS
	OvYtq0wCq1T2+YUAAD3vDVUTYPSM50+DeAg==
X-ME-Sender: <xms:so8LaWPTrme1WTKyl1Wt0e04dyDfmtT2n_UUVq5NRxUWq4_RpszGhg>
    <xme:so8LaWcdQHbAJBT1uVIPa4DjbGeIC7FFh0h2IgUVUh93fNQrixA7AN_8ydYGvhPH1
    0o9nJORR8TzqOt_GLKET8er60VyaBffZvaOJ4kTv-76WPA2BW9ivA>
X-ME-Received: <xmr:so8LadXLwJXJgqK7Vax5Clr1K-ncF90fpmPR0I3XZiShdGAin_wR6jklsAEdBq6jFmxKDMlVBTgrGnKf295Nuq68QRIq4kiUSSzE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeegheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehlihhnuhigrdgsvggruhhthidprhgtphhtth
    hopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhrihhsthhofh
    hfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:so8LaWiBkJxydEPttsj9GraOI-oBQ1ubZTCKVKQfuWJStsHScydXMQ>
    <xmx:so8LaU_R409mASAkGGR4FpUoVZ2krGmYad9kwAO-Gs5mMFo928cMQg>
    <xmx:so8LaQZaUiDVPyWLWRabGNWHY_XRX11Ag5LPNvJpUAyTTkElri5rgQ>
    <xmx:so8LaT0TPTr6CYgG39fd08KqxiKRsrnVxa3OZp1nmkKGn9AaVwjQeQ>
    <xmx:s48LaS2sNVOZisGool4xTjnBkeQ7oFsbbvGEuVq3GEMAAgFxELpXNtE7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Nov 2025 12:56:01 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Li Chen <me@linux.beauty>
Cc: "phillipwood" <phillip.wood@dunelm.org.uk>,  "git"
 <git@vger.kernel.org>,  "Kristoffer Haugsbakk"
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v6 3/4] trailer: append trailers in-process and drop the
 fork to `interpret-trailers`
In-Reply-To: <20251105142944.73061-4-me@linux.beauty> (Li Chen's message of
	"Wed, 5 Nov 2025 22:29:43 +0800")
References: <20251105142944.73061-1-me@linux.beauty>
	<20251105142944.73061-4-me@linux.beauty>
Date: Wed, 05 Nov 2025 09:56:00 -0800
Message-ID: <xmqqqzucl5xr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Li Chen <me@linux.beauty> writes:

> From: Li Chen <chenl311@chinatelecom.cn>
>
> Route all trailer insertion through trailer_process() and make
> builtin/interpret-trailers just do file I/O before calling into it.
> amend_file_with_trailers() now shares the same code path.
>
> This removes the fork/exec and tempfile juggling, cutting overhead and
> simplifying error handling. No functional change. It also
> centralizes logic to prepare for follow-up rebase --trailer patch.
>
> Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
> ---
>  builtin/commit.c             |  2 +-
>  builtin/interpret-trailers.c | 46 +++---------------------
>  builtin/tag.c                |  3 +-
>  trailer.c                    | 68 +++++++++++++++++++++++++++++++-----
>  trailer.h                    |  5 ++-
>  wrapper.c                    | 16 +++++++++
>  wrapper.h                    |  6 ++++
>  7 files changed, 90 insertions(+), 56 deletions(-)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 0243f17d53..67070d6a54 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1719,7 +1719,7 @@ int cmd_commit(int argc,
>  		OPT_STRING(0, "fixup", &fixup_message, N_("[(amend|reword):]commit"), N_("use autosquash formatted message to fixup or amend/reword specified commit")),
>  		OPT_STRING(0, "squash", &squash_message, N_("commit"), N_("use autosquash formatted message to squash specified commit")),
>  		OPT_BOOL(0, "reset-author", &renew_authorship, N_("the commit is authored by me now (used with -C/-c/--amend)")),
> -		OPT_PASSTHRU_ARGV(0, "trailer", &trailer_args, N_("trailer"), N_("add custom trailer(s)"), PARSE_OPT_NONEG),
> +		OPT_CALLBACK_F(0, "trailer", &trailer_args, N_("trailer"), N_("add custom trailer(s)"), PARSE_OPT_NONEG, parse_opt_strvec),

What is this change for?

As the external interface of the amend_file_with_trailers() helper
did not change in this patch, this cannot be a change that is
required to "remove fork/exec and tempfile juggling".  

Or did amend_file_with_trailers() changed behaviour without changing
its function signature?  If so, this patch does too many things in a
single step, I am afraid.

Perhaps split this step further into multiple patches.

 - update the internal implementation of amend_file_with_trailers()
   to avoid having to fork/exec an external process, but *without*
   changing its external interface at all.  This step should not have
   to touch builtin/commit.c and builtin/tag.c at all.

 - if the strvec styled after passthru-argv is cumbersome to handle,
   perform the interface change, such as change from passthru-argv
   to bare strvec, as a separate step.

There might need another preparatory step to clean up the
interpret-trailers.c itself before the above two (or there may not
be---I haven't thought it through).

> diff --git a/wrapper.c b/wrapper.c
> index 3d507d4204..1f12dbb2fa 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -688,6 +688,22 @@ void write_file_buf(const char *path, const char *buf, size_t len)
> ...
> +int write_file_buf_gently(const char *path, const char *buf, size_t len)

I do not think this new helper is warranted.  You only call it from
one place anyway.
