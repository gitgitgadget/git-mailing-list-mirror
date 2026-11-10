Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794326879;
	b=Pr+JX90xfZxq8nX4BAPeCwNXIIk9ZnjPheMVtZLffuXkY7ull7F3duKZ70AOsz+Kqamy
	 H3jpAA96nGEi36b5e8D/lGxbbAyuL5BY6LCDJWVGWXXe57hbZjB7HA4WCsbUpbpHBYvbi
	 sIBQIxfyycEPZdu/fCjVJMEI7RUggM+Tg/f8N+7WtTs7xLi8AlsiIoI9MnbVinU7x+1dX
	 LG1pgtKEjwpOX+hxtuJOfMdJcHzQ9wQGtL54mzGCyPvs/TgvaeC05gT6fJXJWbHNd5pid
	 hVUIPOwNnmznJ+g7w7G0qZC9hVupN1O95uOuONuEr/AX1QAc2z8rjYI6E2hkUXshRRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794326879;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=EXlawxwQ6I3vPpJWL22hGUig4q5hezIJSpVDYepwrBs=;
	b=zDsF+XHGDSYK1FdEy6jDFlv4hGuKJEUO3zvHAO59itJnxQqk3hqZPSnCeWsu+u7xNZaB
	 cpn25Nonyjc2P9+bhLNrFzX4zoIYqD9aWUfupa4/pidUTb2G0WIY5M/ywBGzKZ0Ht6G6R
	 +fq7/rh3N4eGuv/BMp057PZfqPjTEZdKWfHTZcScbufiAB/qiX3A74fKAcjPbxq9boYAt
	 5B27teYKHcDaE5d3aAyUgFIMgePcJ1mLFEdUBC4APwhKTfmQEFBVr8ywUChIvzFo/D9Ra
	 EOQwEG1sa6lp0y/kIw5D7pS4amZCs3Obt2202WvjUtxUZtApZiIJh2xjSHcvRKJTHvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Dmce74K2;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Hib87NFE;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FD7606A326
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 16:07:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38FD7606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Dmce74K2;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Hib87NFE
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 7479C1D00253
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 11:07:58 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 10 Nov 2026 11:07:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794326878; x=1794413278; bh=EXlawxwQ6I
	3vPpJWL22hGUig4q5hezIJSpVDYepwrBs=; b=Dmce74K2ceHkpzZk+uWXYRKK/g
	ukKH5CLPjt03uZHBus8QcGXSBbsk+nW+xBCflC//gNTxI712GR8yCanHcpKoJrhC
	H3jZTGOEqK2hAX2pixpErr1TSv+ob5AY/qkNlBmU0Y8z8PcQdSZmEys+cyUQre4h
	wTkWg6V67um2Y+o0peYqpzcdDwkyzoqVsxnZua5S1da/lmCYNEvwnfSjc5nXsUUs
	Uoo6ZjCpWo0B5D5UmbDwTy7JMtyr+mZVK+AjzO2aKf3GbL9+FxfbvEHQex+09BkF
	knaGnxG7XHp/YsO2kom3AkynFzU5LFwTP0DwpGi8JTmXO1Nge4KOI3Kt5zDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794326878; x=1794413278; bh=EXlawxwQ6I3vPpJWL22hGUig4q5hezIJSpV
	DYepwrBs=; b=Hib87NFERvjjP8jiZu8HN1RtbYumJQuKL+Sp+EWwcsPPFspLK5r
	2as9Pc5Tw4LvxtCsPptZZwH2+NcQkqO9JlggfRr+yupn2hN52QfuEZBIPD9eC3VY
	rQQtI30ONCAkUPTTk1zp+yGdnVfmuxsSc7mdmZ8GyIFaXUMMh683PbRjPPP7OHNH
	B0EmOC9vho0aLX+Wu/8o0q7dAl37xLd0KCon8kCcOvTFTWIW7i2DQvIT+5xmQipJ
	BZuaHgRabR9+hFxok8uaqJADpBT/gCTwZAAHrTo05VsBJu4qDF2cFPKex4B53q9v
	7Hmh8s9a7Jk3YpCfV9MXRJHbuwiZDiHp7aA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794326878; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:eIf8eQpd+LIX9p96RIeDRZG6ACd4Ht1558SDhLKov+dJBEj
	gwleNZb6q3eFjLkI/C2wY8Ct2q2nPZA/oEVcwiUkr74gdBWDMUal6WK32HJWIBOD
	npv/52Ef39lzL7VHtmdCX6sQRMgbITAQuzVOeFFogEYf9MevgdNeQoMkmXxhKy5j
	pjfRVL5PY1zPvbkwmXY0R7pzkXX2YCY1DLXcvcVqMXL6nGQr1Oa3GDQnBdYCKnLD
	YQSkWQgoSQZIlmaTOM5qOAxWyEvlmpkRBTtrxa2vTzbiXQlN/JwfGo9rP2OkSE8a
	Iqzih3VxHSLC8ZlSoSLhyi5j9ZPbfROELiWErAA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:H5Q2jjMvWo1VcQg1l3PAJa2TxFiGMyabRFRzYeac9n0=:T4wMb6oC6qO31vdySPuB4Fh2Ha55nAtSQoHDD9be5Jw=;
X-ME-Sender: <xms:XkHzalutfUw6s_rxNH3WLaOvP9YGp4q8A9PoUFH2R8j0CayPYqqeJA>
    <xme:XkHzaldSVZivgwffxvAKJ78hKonxyeySNxMgFta9NjQM0EbekZI-IxPUJ8YlMNa3a
    I5ujEbJvX1mxo0zoUyIW1fxaNXgwr62YWbU-BmzG0gA_tRVaFH0_JM>
X-ME-Received: <xmr:XkHzatxGbEwDp64MKdGu340qoFi1h00HVeOV6GkAnx2YVvT2ADvEgN0bpAWbXJyknudqUux7lA1CNVclM66W5seEYOsDE4vEHgFs>
X-ME-Proxy-Cause: dmFkZTEtUgwsnI+Cg6429ubxC1FUQR9h96+nyyY1beWVDQMJkZTpr9L2NKMGV9TQ6E2rWO
    t+rBP8Lg2OcNPul1RF5MT3phNDVeIlh+FtEPvKZXm7lWvRSPhdniIkrhzgC1vugrbb4aID
    93Sk4N55HQHJB4tykg6rRCaztIN9mDGk0IvoX/OA91q11g/ET862zOrOcCFVYy1O2ni/Mg
    mwwQwbZYNaeD+HoEunKQ/XlkU9oowXjAObbbeaSCDqNZVXctVJBroesFJMM1agl8ISGQ3V
    nD8EhD0Lmh489UrE7xOUpe/zs6kgtsQHMzPKW7uG2SJeS3DGWfi1RrMUIDco7EDqBP9DJk
    dxjIw3K9CxzH3xzsBuUVrhonvJ4t6IX0dAKNxp2vFtSWWUQi++5pGx8Cr5/Jc8/fZdcbda
    w0vp22RCXuaYrqU/AeC00KP7Jgbl+xhsLLqXq4kon3GawEhAE2znw90l/OCgYxheHaFS/Y
    mDWcX81oj98u1+uTdWyK1TVeHs8htgwYybjEg4cNlLAn14EcOHzeW+JyPDLJHxY7Mfo52c
    2/hJLMkV4gCcr93lqAop/8W8UElEA0ZLn2FI4QJwhX+18+se8LJB3CfyHgcm2kSc9e2jW6
    WVvTJR4OUTzgAnU1AJMVFrZUW+hTGVr902wRc9eFwVFmUDJz/9d4KKLWVVWQ
X-ME-Proxy: <xmx:XkHzarHhs8WdP2zz17H09socbf8l5O7HHq9xdIykuGmtD0a8SK8PqQ>
    <xmx:XkHzahxUyQQDAanzkeBCnjZ3UWvIlc0n1ZNyt2Gv2_yaxYR8P0TRYA>
    <xmx:XkHzastFsAtWXDCQKJf-BBomy7bBHou9tygaOF1RkNUdUJnm3QfYcA>
    <xmx:XkHzau0s0UGQNiVRQjaXvhFYEzJMeGvrtU1nj0sVO9C_6VC8S9YhzA>
    <xmx:XkHzahQYPgbTVL5HQEVrWT6WSjLosrgDaOgzpxRywxNDissb1ee0p2az>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Nov 2026 11:07:57 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Srujith A Poojary <poojarysrujith@gmail.com>
Subject: Re: [PATCH v2 2/2] archive: remove USE_THE_REPOSITORY_VARIABLE from
 archival modules
In-Reply-To: <3d8d9a9261a1f4fcb883ab9afd236f254a494430.1794290598.git.gitgitgadget@gmail.com>
	(Srujith A. Poojary via GitGitGadget's message of "Tue, 10 Nov 2026
	06:03:18 +0000")
References: <pull.2305.git.1794251100.gitgitgadget@gmail.com>
	<pull.2305.v2.git.1794290598.gitgitgadget@gmail.com>
	<3d8d9a9261a1f4fcb883ab9afd236f254a494430.1794290598.git.gitgitgadget@gmail.com>
Date: Tue, 10 Nov 2026 08:07:56 -0800
Message-ID: <xmqq1p8svfdv.fsf@gitster.g>
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

"Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Srujith A Poojary <poojarysrujith@gmail.com>
>
> Refactor archival modules (archive-tar.c, archive-zip.c, archive.c,
> builtin/archive.c, builtin/upload-archive.c, and diagnose.c) to accept
> and pass explicit struct repository * pointers instead of relying on
> global repository state.
>
> Signed-off-by: Srujith A Poojary <poojarysrujith@gmail.com>
> ---
>  archive-tar.c     | 5 ++---
>  builtin/archive.c | 1 +
>  2 files changed, 3 insertions(+), 3 deletions(-)

Is the description above really for the change in this message?  It
does not seem to match at all to me.

>
> diff --git a/archive-tar.c b/archive-tar.c
> index a1c66024d4..642a3ddfc3 100644
> --- a/archive-tar.c
> +++ b/archive-tar.c
> @@ -3,7 +3,6 @@
>   */
>  
>  #define USE_THE_REPOSITORY_VARIABLE
> -
>  #include "git-compat-util.h"
>  #include "config.h"
>  #include "gettext.h"
> @@ -337,7 +336,7 @@ static void write_global_extended_header(struct archiver_args *args)
>  	if (oid)
>  		strbuf_append_ext_header(&ext_header, "comment",
>  					 oid_to_hex(oid),
> -					 the_hash_algo->hexsz);
> +					 args->repo->hash_algo->hexsz);
>  	if (args->time > USTAR_MAX_MTIME) {
>  		strbuf_append_ext_header_uint(&ext_header, "mtime",
>  					      args->time);
> @@ -529,13 +528,13 @@ static struct archiver tar_archiver = {
>  void init_tar_archiver(void)
>  {
>  	int i;
> +	repo_config(the_repository, git_tar_config, NULL);
>  	register_archiver(&tar_archiver);
>  
>  	tar_filter_config("tar.tgz.command", internal_gzip_command, NULL);
>  	tar_filter_config("tar.tgz.remote", "true", NULL);
>  	tar_filter_config("tar.tar.gz.command", internal_gzip_command, NULL);
>  	tar_filter_config("tar.tar.gz.remote", "true", NULL);
> -	repo_config(the_repository, git_tar_config, NULL);
>  	for (i = 0; i < nr_tar_filters; i++) {
>  		/* omit any filters that never had a command configured */
>  		if (tar_filters[i]->filter_command)
> diff --git a/builtin/archive.c b/builtin/archive.c
> index 3c1288a123..8b7d56f8cb 100644
> --- a/builtin/archive.c
> +++ b/builtin/archive.c
> @@ -2,6 +2,7 @@
>   * Copyright (c) 2006 Franck Bui-Huu
>   * Copyright (c) 2006 Rene Scharfe
>   */
> +#define USE_THE_REPOSITORY_VARIABLE
>  #include "builtin.h"
>  #include "archive.h"
>  #include "gettext.h"
