Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795553037;
	b=IfwRBBq9KXgJtRqQowvne/vajGQZSEiKlYEtc0pLM+Maod475jpmcHEnVeBbNnd6VJt1
	 pG9hstKtaGhlZOYuXUeuIpKHjPJGPGuV0dQohxdz6tsJwOgVn1ajura2/u4Nj/LufbTtv
	 3cZCUEGsUVa28/RkSVI9wfjFIMDqBYfdB0tOcVfym+Vu+zTKNq8lcGOu13ZkRR8Eaeneb
	 0C3FTb5m1ycQxBED19EBbybSMPTF1JN+aLoWqO6JXpMrnpHpWqAuytRzotptTFXrSDz+5
	 TaXmD+hQJNdHl54jB4GCnlJ7Jp8Tlva7EkX08j9KThwhWep50XCTFZqPa4jz/+Cmz6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795553037;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=WZ2SgRXXr0qahS0sUD0eUU6SlAKKuPnmaNNPvKBdHqY=;
	b=tIfvwVgJU84AXXekyo5RUx98u+bOQ9IcWBeOXcjivONo/OacAeoYyGJuczy/7dS1SyIP
	 fvTKc+NMPnxWHQhkFCmjVEZW4DL+vrL0jMmTXN+trz7qP6pTS9cGuIUfXXdXNlNBv271O
	 fcpxQhWWhfJUyOF0vYX+tRjvSIwdTCp0WjsZ0AiOCDq6OVn4oCLV0EpjXM22EkU2ZHdWD
	 Up5K9YzS619Z9ktm+jWFxhy5Eq4RH56QThImrhTKxUmI0q/yLO4Yqp4zVaPX+eOK7CmI6
	 a3qChtCxkfc+XVJxtSA2XLGqw10OtPZ5gFTzVK5FnjcnheOpdtmroIsVuT0JdnL30fA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=QKpqhJnl;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=gS2rfKXH;
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14028606A321
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 20:43:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14028606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=QKpqhJnl;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=gS2rfKXH
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 412C0140030E
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 15:43:56 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Tue, 24 Nov 2026 15:43:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795553036; x=1795639436; bh=WZ2SgRXXr0
	qahS0sUD0eUU6SlAKKuPnmaNNPvKBdHqY=; b=QKpqhJnlbZA74nqkTk9HUIYJdA
	kVcpi9i0FXhhqCsQnu/sH/vWRMbdlwjtXd7kjEn86bg9P+j/RfVsEFocDGNVSPbF
	B+JbTHRF8JqeMws2UU4j1TSmVIkqOMBX8rhhylcUGqk6yYziA4Vx5ynuWz5DXYd2
	JIE2sqPz+gEE13ULV171You7B4T/uf/ngSUGhcyujmsn5wsafo9cC0vtWYX5olMH
	54S/Dc/bZvdtbohQsy35CZFH7/GzLY53OcFIpzVDs6MwW3KnJzNY+YdX0Mgshqz+
	IJo1b+qCgjmBckYfsIU5xSPZUuOsKwhtG5sl+mud/qi5p5PZf5yYvT/akUFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795553036; x=1795639436; bh=WZ2SgRXXr0qahS0sUD0eUU6SlAKKuPnmaNN
	PvKBdHqY=; b=gS2rfKXHyh38Pd0cQ5tOLCVeR/kJ3cFrnEEhC+BEh3feTCsU/kL
	K+iUATE4RtY9iFfurffs89CkqivdM2RcMopF7vYthvnN9nr7mP6IFCFMExyTGRTh
	sLYySc9f2g2s/vyCkmNkTJT00wI/cGvhz/CYk48J+kP7+4VwEj/+octzeGX5JNhT
	k1r/wS/vkcbzRLBUTak7Fg3OXh+jfl9+0bIvKOqc41UR89Fz+0bPqQh06fDJ0jWT
	I4yNXo01BS0B3xsgAU2kFewWWKqeK0+kmviHR2snwlT1/FlBo+R47UmdFA4vg0tT
	Z3jvFQODDHaqyqh8CYUmEcCWtY+lo+2ZaPw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795553036; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:T9r8BMxgcM6Vdj6v64mva4lpqKLs343zEjH3RGO01OSp6nR
	Q9GcN+1ZFi7dde7OqkCRi5sGMt2HyChhV8BdRAyTBr6e96c2jD5wnjyXilwzpDn3
	3oKmGc4wkKf6rFYFDWyFWCo267M1UgOtOOqQWrOGvkxCakxfkLUMXfrucUVVrq4F
	hxt3LVW+/gUwPBAKlOuBxcTxig5GJssPUAR238ssay83fhqX9D1Bbss1tqZlgmWu
	bGrhi+6wg655XU6cJ4rQG0mmQoM3p4FznjisZWk3XgX6AZX/fr3MS7GciiveFPGI
	O0TqK8+IwEKLKmV5tu41UpuvFeeTnI3SvjJEppg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:T45pO95d3ZlglmhPNROSJTmXBKKXKh9Yfp9Lt6lMqTU=:3y6k6LX+LjlvnQ06e6gQgYkWt2Pt81myAky39fmOlc0=;
X-ME-Sender: <xms:DPcFa7tBIAEYPinxwdKDR7HoJiJ3VB23oNV36hV8-RQVLpN4xplAmQ>
    <xme:DPcFaz72_-lFJjPwTX6gSpcOUBE9oXWfHmzd1s8gr4zFUwDgnauVGATtfecEpXESp
    BFGXnq6R_87DschsQiAe50-nFtU_GJnN_R5glFNTC8yRkyxCJkRYhI>
X-ME-Received: <xmr:DPcFa8KU3ZJu0ziU76GGaJ5GbEuorpNNJ0njEDqr7CWhAMtKqtygtTlVx-4xy46_Q51Xw-g8Y7gOZQX5qgKhuZ4DMUfqea_t41MJHQ0>
X-ME-Proxy-Cause: dmFkZTGI8pEnokAYkPxZAV6jAm4FRBANdGj8q6CyPC93Yp7kgXbkp9cWQ3RYWwZ26ynv7U
    Ofcl0WgZalmR5bF0NQe8hZGFmXYKSEw9rVi/SynG8lada2JZRT9FKZXuUjb1Bd0CU6GBfv
    OU+gQfmY/A3P19OQ48J33RlxkObt/8Fzz+fW1u+5nnVfJhxli5gTBSACHxUnvl7eysPJLh
    lnj7mG4eD23O+gwtj4k2Z7RX5GYdv9RCVY3bJg53QJpsgEEAxp5IpJtpDEDuwovObsyWhi
    1SnoVjIhj6a6fbVzQzfGfRm/hE0aAAFx700O4VZIyuU3kmVvayflGBPxhI4V8eIy8yxGuB
    0oPGnjohqRH0qwtUOUxmHhq54GX8BcK4O6sL1+74qRqSWCMLvaHdlBkIfv2Mu0SDh6TNmq
    BPOhiHnKHN4ljYegt6L5V2ctiZZhaR+bqji+seuBkLcQVx50XprInwwqYtsiI7RscmU2+u
    hQ3Ew0JE8PcYPzEgzbPJXNvOympqxLfhnSIrFn5LK1dthcM7eC8nslb9eI5fSa454onSJ/
    9MBnQ87yc0S4QBzpF8ESEGkz+G4NEIaBhk3KXQTUokmToLh/NW+4pbqZ1j8gYN20Lkj51l
    oR3jDd9jqNa7fyQSGZ+QLKv9yW5D/MCmZ8xialjFN/M2VAIJxLuvrUjaMC4g
X-ME-Proxy: <xmx:DPcFaz4moeOCMH052YMrXREO40Muil4V8yJy7HfuuFXq6zxHOEtjEA>
    <xmx:DPcFa_x3giOdK6YDpDCMlK3HjSUim2wkTC5zNtvHESl1FfG3j31Mig>
    <xmx:DPcFa3b_OoW3wSCs-GKxkZBTO1f1wY4Q7D1nMcZzOODUtL6k2PjpJA>
    <xmx:DPcFaxTTPf6bUpaLAUfeB-uHPlDTNGaKQrPG51fghr-V8JP6xElBoQ>
    <xmx:DPcFa0Bb2XCSUzwqpu_NnRm8LZyGLUEMz171vDdAQV-JARr8QmMxCl8w>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 15:43:55 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/6] builtin/fast-import: stop reporting packfile
 statistics
In-Reply-To: <20261120-pks-packfile-global-statistics-v1-1-19beb83b145f@pks.im>
	(Patrick Steinhardt's message of "Fri, 20 Nov 2026 13:02:28 +0100")
References: <20261120-pks-packfile-global-statistics-v1-0-19beb83b145f@pks.im>
	<20261120-pks-packfile-global-statistics-v1-1-19beb83b145f@pks.im>
Date: Tue, 24 Nov 2026 12:43:54 -0800
Message-ID: <xmqqse0qnenp.fsf@gitster.g>
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

Patrick Steinhardt <ps@pks.im> writes:

> By default, git-fast-import(1) prints a bunch of statistics about all
> kinds of internal details of Git. This includes for example how many
> objects have been allocated, the number of refs processed, or the amount
> of memory that was allocated.
>
> Reporting this kind information is highly questionable, doubly so as it
> is done by default, as a user really shoudln't have to worry about such

"kind of information".
"shouldn't".

> internal implementation details. For some of the above metrics it could
> be argued though that it's indeed interesting to learn about the number
> of objects processed to get a rough sense of what git-fast-import(1) has
> done. But for other kind of information that's not the case, as it is
> without a doubt purely internal implementation details.

"other kinds of"?


> One of these reported implementation details is our packfile statistics.
> These include information on the system's page size, the number of packs
> that were opened, the number of calls to mmap(3) and how many pack
> windows were created. Reporting that kind of information, and that even
> by default, is just completely uncalled for. This information may be
> useful to a developer, but a user really shouldn't have to care about
> any of this.

Looking at pack_report() below, it does not actually report the number
of packs opened.  It prints getpagesize(), core.packedGitWindowSize,
core.packedGitLimit, pack_used_ctr (the window-switch counter bumped in
use_pack()), pack_mmap_calls, current and peak pack_open_windows, and
current and peak pack_mapped.

Nevertheless, I would agree with you that these are targetted more
towards Git developers and not end-users.

> diff --git a/Documentation/git-fast-import.adoc b/Documentation/git-fast-import.adoc
> index 5201e493345..6afe14b650c 100644
> --- a/Documentation/git-fast-import.adoc
> +++ b/Documentation/git-fast-import.adoc
> @@ -48,9 +48,8 @@ OPTIONS
>  
>  --stats::
>  	Display some basic statistics about the objects fast-import has
> -	created, the packfiles they were stored into, and the
> -	memory used by fast-import during this run.  Showing this output
> -	is currently the default, but can be disabled with --quiet.
> +	created, and the memory used by fast-import during this run.  Showing
> +	this output is currently the default, but can be disabled with --quiet.

In our new design "--stats" no longer talks about packfiles.

> diff --git a/builtin/fast-import.c b/builtin/fast-import.c
> index ab5d2a23448..14e75149415 100644
> --- a/builtin/fast-import.c
> +++ b/builtin/fast-import.c
> @@ -4153,7 +4153,7 @@ static int option_parse_early_allow_unsafe(const struct option *option,
>  int cmd_fast_import(int argc,
>  		    const char **argv,
>  		    const char *prefix,
> -		    struct repository *repo)
> +		    struct repository *repo UNUSED)
>  {
>  	struct fast_import_state state;
>  
> @@ -4346,8 +4346,6 @@ int cmd_fast_import(int argc,
>  		fprintf(stderr, "       pools:    %10lu KiB\n", (unsigned long)((tree_entry_allocd + fi_mem_pool.pool_alloc) /1024));
>  		fprintf(stderr, "     objects:    %10" PRIuMAX " KiB\n", (alloc_count*sizeof(struct object_entry))/1024);
>  		fprintf(stderr, "---------------------------------------------------------------------\n");
> -		pack_report(repo);
> -		fprintf(stderr, "---------------------------------------------------------------------\n");
>  		fprintf(stderr, "\n");
>  	}

And we no longer call pack_report(), which was the only user of "repo"
in the function, so "repo" goes back to UNUSED as well.  Sounds good.

However, cmd_fast_import() has in its fast_import_option[] array

    OPT_BOOL_F(0, "stats", &show_stats,
        N_("display some basic statistics (objects, packfiles and memory)"),

which still talks about packfiles.

Dropping pack_report() and the four counters that existed solely for it
(pack_mmap_calls, pack_open_windows, peak_pack_open_windows, and
peak_pack_mapped) looks clean.
