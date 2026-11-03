Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793703654;
	b=UiWjalt6RL/UctgN9JYBsaXF92LWLMzISTJis1JjTB8xsqHO8rBbN0VT1x+KYL8TkJ7m
	 5qHkwPHDulVlVagJwwrZ6s1O/nuyGi9qZe44a0iLuysy3xkbq4/KqQlgDydGv/EBNhmqg
	 SDsryEFtI1xjeNvt9SWEUH6N7hqqSLviSLnfDsq8WFi3m4JQCP/E5elkzkuNKaEfggdd8
	 7nJxMT+nPBTfJMuIwLcMZ0lg7Gonq74MP2R4XMMDTnvKOmdkP1R5hC6vgo2QsDwgorCCd
	 VpO+DjsLxdk1+U7dSxahdnY7DeyAukijJCU58qT1dbgt6QR2wLGI7n/3wqdqJOTgrgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793703654;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=UYG2V/XG0HChn6BDQ08EIbXaueebG70GjotpiWcbpic=;
	b=KWMS3DxeBm3T3e1k7qsW5V0dCaT8NWnrnl7r2InveZERVbz997K4ROIpMH+ouPK2QWTq
	 fUH/gs1BRk6foqkVJWA/QupwmCy9Vd9M+udiFooXfvXiuS9+YJPwa9+VVGODFuXHkRA+g
	 9hNX8r4nZIwmjbfCl3CsBIzHg0SM6b6LGDWkLAp1g4tjZ7B8zZ41GcQ9mQ6e9Jry2oKKt
	 zw9vvbNTM8sBR/tMfZcRZnn/g5IpdwxbUozGNagX/S6e3VOhcmRrekUNEe9cSuqbfDjJ7
	 RK7nSXpfJFBiaJ0Zm7MgOqs+dbIOsdcP9KMZ6rETrfAzowO5kj+HAAvnkdrR/w/21BA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=n3JMdjKc;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=TGAk0aSI;
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EC0606A32C
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 11:00:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1EC0606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=n3JMdjKc;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=TGAk0aSI
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 23CBD7A0161
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 06:00:53 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 03 Nov 2026 06:00:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1793703652; x=1793790052; bh=UYG2V/XG0H
	Chn6BDQ08EIbXaueebG70GjotpiWcbpic=; b=n3JMdjKct/gFU7xx4Lse4Iuojn
	yzjemKIPjDidvWNHvGoQC9f/MT4BDuO91lUUKdXN8VIvwGzKnmKu3L0XjOrM+6hW
	JWkT0OQfjkOSA0dSBY4pds+4WcInz6wqkJTmtuC+U/aNdHBRTFP7KjELII5/mKlL
	261aY10b68SsPKWKfNTyN0XHiT9RKQ0WLu2WI/yN96LPupkRHZI5LQLskRxfGy44
	vV1NFfin1XkEDjCiEU6jyxbFSQnerWKAEW+6L3EQHlotf3mtZAve1K+/Zut/RL6v
	60J4eEJwP+1EMqYPZe5jQPept1WF5bWZpi1ZlTKgpwz3bh7hEHswCrCw98Pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793703652; x=1793790052; bh=UYG2V/XG0HChn6BDQ08EIbXaueebG70Gjot
	piWcbpic=; b=TGAk0aSI5dfAv+qFWKV7biz0oHRKThiW0jISS6aTQxcAkLKv2Ru
	cS3ydJoE/yyoffsKA6RkhDPO+FnrN90LEqqFsWBZJj8VYUzuY9rzRzKGM2nUyYoN
	TlXAtNku7me17lUgE7A9urvLyxcJNpF3FlLtHZIrPwzEYsjSiXJYvLq6zirPkmIE
	LC3tTo7OgfkYs2OOdfuOQUv3yTYzNeACXhlc7VLvW5C8UMKkDRT83Dliu8H1UCL0
	Yf3iPN5FKiZd48PCOqjeQm+d5wzo603vOOHbl4AO4808+bXoxMQsPdhBoIp/Y7a2
	0FHUSURBW9Du079BxHg+JZrzuY7gT0viM3g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793703652; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:P5jB2MPSqDRF1dIsbWuDBmM4QJYWMMtL/KaUfqHqSUc2aKM
	ckTjYENWXXI5Uy+Ba+yTcTlPYOmQoVvajiisFiohwMEA+vdAm1lL/LsaGLumQ9kX
	5jrKKM9gPKhBvhFL8k1D6Al9Ifyo36eTi/1opz+BGMTdrnwAPgh22d8uUuXGUmKZ
	SGhMo5AtoFbQArdErILrgFcDM+p+QBCBexaIeNh5RHXabzdwOfPZ5u7cQdQ3KIbE
	aZTvq33NvtXcwVQ2TlQCq3x600gNBp6A032RQ92IsKjpANbaf8tOldzyVMIB6SRX
	t28rvjI4mneE4OBxCcnzFMMvXXEdbWLV1OJFH+Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:wPelpzoQwTQDmN3gQe2Af1cizJpU8Grf+lsuAyWjpIg=:7SNKxL4oZ8fYmbDpCVg2Tfr9lpkYvxy1XcTbCa9UB0w=;
X-ME-Sender: <xms:5L7pat47RuYwAiPHKjJI8aT5uMa-TELCvdjOlic6v9jlqMu8RjyvgQ>
    <xme:5L7pahzYhfWlo26OFwsX2oQOpbta5vgh-FZEsCOicqtUkEPcHQ9zjMXLYd2bCPtXA
    VaqjEmMXztrRoIzrj2fS9LQ124N6MqJS6xhofpS137pU-yinlyeHpQ>
X-ME-Received: <xmr:5L7pasy-CO_Q2litBp6UIqUeOP6zezAhunYelWRwooiwbkbFuTygAA>
X-ME-Proxy-Cause: dmFkZTFAMQtCt/AMHd8MCjNQWEtXTxCSuaW6VMZXMnh8oGtSIkM8Jx37ZB89PcB00KsHw9
    v9INO+//DI0mN0mntGNODhVoBlS2gQkIPsQpkrbC9Y3ZF3zlmUI7wVkJrNyBkwL2g3COoL
    /yTo+pFUszaHFr4nBHqYKj8gyhhYyGYpWjGchWoH77+93kt2/Zxv4w5H2cxetzYpTNx7qU
    9huwZJywQo5T0SyXLdrJBrfrpFOoooEf5A8OviNvvaVm98PEgcM3GJGUH7qQ36rKetfxZC
    5/tI1Onx7LROFvTl0nwkjuvRTwlCq1qD466pdsN+s+i6lxeIbnbDFz0EPOJXeOpHFVl2tk
    OJfofQ9pTrkv16ocF8TYi0aQCDuAsZFw77lkyoFO/MxKZ9I7ZRAoI65Uulkk3qzl+UXFC7
    VktbvWIZQUkWFJUIh8vWzOGnOqrp09BNQbzBlGvqzVnenBgNWq4yv0/T+RJLE7GyQc8aom
    MUJYS/DNpsDGYGki3Ixwe8Waj6r8Tq6K2lvWwimTTRbMyrY19ONHDdiM5Vf9ONYBSFn2ZL
    7poLRGR/iFRez9wAilKivCBzvUtnI46aejZuW19qAKQ0QCpLZoEKAX1IiLJPBSCyi2PJSf
    rlNvCsiX+psmBJ2Pxctp6v1xxvQpvdwXEKGt3rOvSSzew1KPfXBFODLlzoMQ
X-ME-Proxy: <xmx:5L7pahyv1fN8j3temuhWkLxTSAlz8AIVQD5plIYmYz_2BdvugksaHg>
    <xmx:5L7pauZzNLhad2l4qD4mYbjDheQPjt0DTvblSUjrlAFbYrqx-HFMJg>
    <xmx:5L7paqVWet6bR91mUFDR-7BMSaKg9EoKTRHkiQmPpScOuUK2S0oh4Q>
    <xmx:5L7pakhqRPCCo4XLY6v1RdhC4CupEF0hH4yX7rDWkjoT_I136E7Jow>
    <xmx:5L7pauT8_rfqhdmFOGiNcjuSW9jWudm6W478-zELv42zTjs1ZK7kOA9n>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Nov 2026 06:00:51 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ed93e025 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Nov 2026 11:00:50 +0000 (UTC)
Date: Tue, 3 Nov 2026 12:00:47 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Justin Tobler <jltobler@gmail.com>,
	Kristofer Karlsson <krka@spotify.com>
Subject: Re: [PATCH v2] odb: do not list our own refs as alternate refs in
 the quarantine
Message-ID: <aum-34I8KZvTfDRT@pks.im>
References: <pull.2285.git.1793200705017.gitgitgadget@gmail.com>
 <pull.2285.v2.git.1793619933300.gitgitgadget@gmail.com>
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
In-Reply-To: <pull.2285.v2.git.1793619933300.gitgitgadget@gmail.com>

On Mon, Nov 02, 2026 at 11:45:33AM +0000, Kristofer Karlsson via GitGitGadget wrote:
> diff --git a/odb/source-files.c b/odb/source-files.c
> index 5b4277fbfd..223af45dd9 100644
> --- a/odb/source-files.c
> +++ b/odb/source-files.c
> @@ -348,6 +351,45 @@ static int read_alternates(const char *object_dir, struct strvec *out)
>  	return 0;
>  }
>  
> +/*
> + * Our own object directory is <commondir>/objects, or the parent of
> + * GIT_QUARANTINE_PATH, as an object quarantine is created directly

Or it may be derived from `files://<payload>` with the object storage
format extension.

> + * inside it (see tmp_objdir_create()). Anything else, including a path
> + * that cannot be resolved, is borrowed.
> + */
> +static bool is_borrowed_object_dir(struct odb_source_files *files,
> +				   const char *path)
> +{
> +	struct strbuf real = STRBUF_INIT;
> +	struct strbuf objdir = STRBUF_INIT;
> +	struct strbuf self = STRBUF_INIT;
> +	bool ret = true;
> +
> +	if (!strbuf_realpath(&real, path, 0))
> +		goto out;
> +
> +	strbuf_addf(&objdir, "%s/objects", files->base.odb->repo->commondir);
> +	if (strbuf_realpath(&self, objdir.buf, 0) &&
> +	    !fspathcmp(real.buf, self.buf)) {
> +		ret = false;
> +		goto out;
> +	}

So this here isn't fully correct as it does not account for all cases.
We'd have to read the object storage format extension to figure out
where the primary object directory lives.

> @@ -1256,15 +1299,19 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
>  	struct odb_source_files *files;
>  	char *object_dir = NULL;
>  	char *alternates = NULL;
> +	char *quarantine_path = NULL;
>  
>  	if (flags & ODB_NEW_HONOR_ENV) {
>  		object_dir = xstrdup_or_null(getenv(DB_ENVIRONMENT));
>  		alternates = xstrdup_or_null(getenv(ALTERNATE_DB_ENVIRONMENT));
> +		quarantine_path =
> +			xstrdup_or_null(getenv(GIT_QUARANTINE_ENVIRONMENT));
>  	}
>  	if (!object_dir)
>  		object_dir = xstrfmt("%s/objects", odb->repo->commondir);
>  
>  	CALLOC_ARRAY(files, 1);
> +	files->quarantine_path = quarantine_path;
>  	odb_source_init(&files->base, odb, ODB_SOURCE_FILES, object_dir);
>  
>  	hashmap_init(&files->dirs_by_path, odb_files_dir_by_path_cmp, files, 0);

This makes me wonder whether the better fix would be to stop modifying
the primary object directory and instead we simply append the quarantine
directory to alternates. The presence of `GIT_QUARANTINE_ENVIRONMENT`
could then serve as an indicator that the child process is not allowed
to write objects.

That's a much bigger change in semantics though, and the risk of causing
a regression would be quite a bit higher. But the upside is that we
wouldn't have to juggle alternates anymore, and your case with alternate
refs would "just work".

Patrick
