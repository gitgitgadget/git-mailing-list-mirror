Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795126835;
	b=h/dTPSQGWSOSScWGg1UGyq1y/TQhBWNmySfGM1DBO+irUn4O31Flmo8ZjOZilVPoCp7x
	 knmKmMDQLXBzOpn0DTk9Cvi2xQg8CpxWhd0lsvKtkbdig7i0dGAhpyrwiAqzvoHzHx7n4
	 AdmWfzLM7tnd2+btqT5SaHLual/I8dMNJTkHyk3d/pH69cVSY9RV9hSEm55ZhtJLmd2MM
	 N9WL45leH5H/WuYcO8EwLNfIwYcnX9UFJIEj1DwLb+ZQzu8dQyKul0z7DjO/KjRASoCJj
	 ho6WKMgR5Fk7vW7Asm3l8eBLEpiCbhdFzA0SxzhBdVF97Nx7cyZ6eL6q0YaD+N9UEhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795126835;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=FjQVl5adALWA2d6xV4j+KtfK4S1ZuyS+Rd0In9+Vipg=;
	b=Vp5hktKgdX9G3XSyhLCG4Ko5N2JPD8t6krEEzOHf3Zwab8CXc2OTSfA4fHHPNIBhKSNw
	 +1rBI3+ppbq0AQfOHdSsg3JfEMNRDH7yAeqlqP288HvGKc6DQQZANNkEF6emiWLynQKS4
	 me9zM+TShiLOQ/nPDMxbJ9XYK9CEgnyzT/Z660AIubSKRQrGPgpDwU+tombv7CxJwlle3
	 iy3QLRtMR1TNSwzlppMcEzDY+/u1MfzmvpVg5X5MaCbrjwXJDQnFQRz0pnyLn1ll6GyWO
	 YD4/sw+QF+IdCVOfTpuiUpnVg4SUm8rHzsrEs20pux/mXQcXt37u+HRAU/pQWcAEdgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=DjfUfwLS;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=xxGheOFn;
	arc=none smtp.remote-ip=202.12.124.148
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9387606A320
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 22:20:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9387606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=DjfUfwLS;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=xxGheOFn
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 212551D002D4
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 17:20:34 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 19 Nov 2026 17:20:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795126833; x=1795213233; bh=FjQVl5adAL
	WA2d6xV4j+KtfK4S1ZuyS+Rd0In9+Vipg=; b=DjfUfwLSQ7LSsP38saWISLprdi
	M+iC0SzI20IT3ZjC0ecNVo9U87Fn8FW9cvzrd7+M3Jq/aljeWV0nqOtqgoez9rLI
	jariZMxgFennSFVCS9+tJPaJVSu869QBl4QJ3i1QIeG/6yzOKLwZT/S5OMarsqsQ
	cLV8rO5I1Es9SxGXKMT4C9mJ+pYWi5o3V89x8Or0eMp1R5b21tNHHVjtWy1f3Net
	oVray8N09/190p9Z4/Ej0FYPsdwuxKe9/t2kncL1iJHHMc0TZlMUPJFOGi9uSE4J
	h6y5w7RJOEl2J2zgX7YZBvo2MLrPSVU1OTrwn2a/v/4sld8m6WVuKZRS2CJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795126833; x=1795213233; bh=FjQVl5adALWA2d6xV4j+KtfK4S1ZuyS+Rd0
	In9+Vipg=; b=xxGheOFn59r2VGSRPOcHegJwKImWEKLXCMcywU8rc0L74LTIDa3
	e3EyZjAOJvH9Dj3T8Un5idG+7ms0bsziMAg8oGyOzspjCNjsaXq/OMFkPfyDaZ7R
	NrEUKUP9r5b7RCLO1l98fNy6Fm0O6v3IWEBa2+Ev6975tUKSbLcmZzgI7nCTtLZw
	UELUt4J3qX9RL7seEYjdepNt82GLrLxuinG46wvfIuJN68FkQStj8Pt/92hD6Oxf
	MTX+Hwx1KE+KioCz45xrfF+m2nATDJuoFOn89JJ3Iy+JZmiTxrrBt/eeahvqAznv
	sxo6QmB8G7FKMDdJqOEWhkv2lISWz0xtvGw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795126833; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:M1I9qC7OJofil5o3KWJpWznlkPOqZDkzfZVYrANRj4Dc9S9
	gOZDLZQ2QcgGMj2yel+xpR6sfaE1HLEfN4V7LuOy4FwSlghsRYFNXw9Li6XWcLf3
	GNq++RWVtRuQ5YzWOSo1PYfVMjDF7hnSTrRxjAFmfSC0TMQepW1UzfpPlqg+JIZk
	s3DHxvLCBkKhh7mQGTqmhOb5QO5YQbuTy7A72MDXPar02SfIFdS6PTV6CftnsKCp
	tPdWGuUWL+BrOmogf/+satpMC0KnvQTy4Mr35mOD78A6sxJffT77da5JeZ2C5Suc
	aoFRw9InwfjiwHHtFJxuAplfcrfl0lqzqWgloAA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:BfayNSqJaN7S9hKYfseKWoi7AJpn2oYeinZ/1F+B8LE=:Pg5OjZKAE6/wa6KHzZ6wSNzNqe4sASrGUlx5QofX9cs=;
X-ME-Sender: <xms:MXb_anzV0uPZLoqsZHSkKlQMn9wGFRiQ2dm1PNQpSmlUaj_uv64G7w>
    <xme:MXb_amtFtHRjh3YSi7f6tCwt1uYYtQwh8VcVNKx55JJdks2PzGq1rnJjz1O8PJv0V
    EHdY6iBPLZ3TD4989trL6Sl5O0RGz8jt7p1FIHVX-mo0Z31jzqCEHk>
X-ME-Received: <xmr:MXb_auu4QaQd40gRa6T22-yjg2oFNMy5trhPhAXaHyL7EAe12TuUDnFDHYSTs38I5ffVGP-jYhaBlGiXlD9Nq8n0_P-d5fwGJprU>
X-ME-Proxy-Cause: dmFkZTEnk1bAD8l6QpNKGlC2Bf677e/D6JcX/WXpyFQiESfES6jyWDzkkEHj4M4dJmpSer
    oncHMpKRi8gWAplpxbLOeEOOWZOU8N3yHtenqg96J0qQ9CemKjg+Ksxwx8XRogFBHalbzD
    LvHJuWaJf4eNhOz9yMG5SaDZYMzrAdXw+WzYgtNs8ac7Sbnr3ksyZTS5566jdTvdYBrrt9
    OMVGzQg5MIPH2i8sqYvIsSHgKpAvfA83vPnE9IklfjnhpigfT3I+w37+yYEGK3gh7kmZzn
    mN+ihfZqCxt71Qsb7rHyU3vtvD9sde4Ehfzm34H1TLltgOmZpyinml64LGmvDMk0ty7Fm7
    NGWpTqWIjFzIIXcIqJBCY0wgX+g7tR+2aKCngXqW46W9d/NFp2SBZFyywa9qLKlJf5fyA7
    4u1MEJYJvPC/LhqCilTE1sRrYAMAvpXFCF8l+glozYpoVjZYc6JcuJhGvzaPcM9Q8ihqXf
    ZdCou+DfjiEW+MoaDuTMVneSPRd2jWI4UfEOVybQ7IrsouWyrwgvKz4m7jOhe/omGVW6ln
    d52cQoaqZ/2xdi8AKnSQfzDGiXSGC/WNklZqI9vIsjpvUg+CyCJxSGYXO9WnFOR/udyY4b
    1827p1Y3N0k91CrDoi1K10RzottELF6uSpeYB7zMRU2Fxv1zA/w2ilpe4j4w
X-ME-Proxy: <xmx:MXb_arNhjSdbqBAjT07vM8jxo17XbNEKpHQ2-5jm3vqgdK2_IcfzhQ>
    <xmx:MXb_as3mXpKfUqHCn9BX3subL4QwrbqaCgv6sse2usgTkBD7-Gd2IA>
    <xmx:MXb_anP0USv6_NCWJhOQdwWC0DlJDwuW0UOMakWfU6GNTqkWfYEaCQ>
    <xmx:MXb_as1wW5U7hnpXxZOfS2F0DXj72aaKkSC71GFZ4U7NpIIkkwuAJw>
    <xmx:MXb_amvDm_plWPD4tw_VwY_52ifBnxpEdtTKJ00UNqqfq6UjtDerZlFK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Nov 2026 17:20:33 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] doc: wrap emailed text near 70 columns
In-Reply-To: <20261119105300.95746-1-okhuomonajayi54@gmail.com> (Okhuomon
	Ajayi's message of "Thu, 19 Nov 2026 11:53:00 +0100")
References: <20261119105300.95746-1-okhuomonajayi54@gmail.com>
Date: Thu, 19 Nov 2026 14:20:32 -0800
Message-ID: <xmqqik1sv4y7.fsf@gitster.g>
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

Okhuomon Ajayi <okhuomonajayi54@gmail.com> writes:

> CodingGuidelines, SubmittingPatches, and ReviewingGuidelines do
> not say how long an emailed line should be. State the limit in
> each: keep the text near 70 columns so it still fits on an
> 80-column terminal after a few levels of quoting.

Thanks, but then why not also suggest to use these inter-paragraph
blank lines?

>
> Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
> ---
>  Documentation/CodingGuidelines         | 4 ++++
>  Documentation/ReviewingGuidelines.adoc | 3 +++
>  Documentation/SubmittingPatches        | 4 ++++
>  3 files changed, 11 insertions(+)
>
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> index 23a4d2186a..a0cc5a050d 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -33,6 +33,10 @@ Git in general, a few rough rules are:
>     achieve and why the changes were necessary (more on this in the
>     accompanying SubmittingPatches document).
>  
> + - E-mailed text, including a patch message and a review reply, is
> +   kept near 70 columns, so it still fits on an 80-column terminal
> +   after being quoted a few times.
> +
>   - A label "NEEDSWORK:" followed by a description of the things to
>     be done is a way to leave in-code comments to document design
>     decisions yet to be made. 80% of the work to resolve a NEEDSWORK
> diff --git a/Documentation/ReviewingGuidelines.adoc b/Documentation/ReviewingGuidelines.adoc
> index 6534643cff..8770f0597c 100644
> --- a/Documentation/ReviewingGuidelines.adoc
> +++ b/Documentation/ReviewingGuidelines.adoc
> @@ -116,6 +116,9 @@ guidance, and concrete tips for interacting with patches on the mailing list.
>    unrelated to your review from the email reply. Make sure to leave enough
>    context for readers to understand your comments!
>  
> +- Wrap a review reply so it still fits on an 80-column terminal after
> +  being quoted a few times. Around 70 columns is a comfortable limit.
> +
>  - If you cannot complete a full review of a series all at once, consider letting
>    the author know (on- or off-list) if/when you plan to review the rest of the
>    series.
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index c60855f706..2525cc7e20 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -700,6 +700,10 @@ WARNING: Be wary of your MUAs word-wrap
>  corrupting your patch.  Do not cut-n-paste your patch; you can
>  lose tabs that way if you are not careful.
>  
> +Wrap the prose you send so it still fits on an 80-column terminal
> +after being quoted a few times.  Around 70 columns is a comfortable
> +limit.
> +
>  It is a common convention to prefix your subject line with
>  [PATCH].  This lets people easily distinguish patches from other
>  e-mail discussions.  Use of markers in addition to PATCH within
>
> base-commit: 7fb6055e678f800320d8ab8cd8f201d9493d1ba0
