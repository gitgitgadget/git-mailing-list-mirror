Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794878915;
	b=V1YOq6uELdN0wWfo799XUUrikh9RIm/IsfKsevh3/DLcux/2NJjAc8JhGHkfvsDrJM9a
	 ZT84tueQWdrzxpYC+M7kATOzFiDzJ6UdigVubyXWtOID+fWuJ9yWrDpjsJm6FIvOyhnph
	 SdGj8C1n/Lgq+5f3MuY3AR87DSmt6VtRPASRnDFDuU3QCUI+tmtmx4YrPyzlYIq7fYnkB
	 vWGuc+1xy2Ma9qQFYYZP7R8+E6EXo+SogUEQ8KhSCIJm/5nQtTHC1mvat0tSw8FVDzkNT
	 WhponWoA5rcmNrugNCSdEMBCaGfuUw3fo0/HEJV9V4iFa+P4fVhPihPq9N05hzghGmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794878915;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=iaJf8k/qN1nIaiWfd0uDUw7rEtPezrCGyn/inf/QLhA=;
	b=wYHXjIQOuGx4CTQRcBC3ER4ADYZUWprGvpF5aU6qjVBU2landsr7F03MsoxjflyxntLk
	 RDBnHbdKuDWqkXH5JVzPhw/ewqQLDv9T+1zKicHoLY+IyqSMoC+PryB96AH30xjpDkGEd
	 T2dZPv8tAQPIHobi3RzdLTu1eGduf7+H5T3GDw6bx4vJqmy8z4ewDGPSvgM74ygdW7DDm
	 L8+aMQ+ZGWiRAO5ViVMJxz57uqiiNNpeRzdHoBTpX5n9nRsL3GXavbY2i3aweiD1yzgiz
	 9DbYRSC3bsSJW27yMR/z4L2WIpC67y8A7qN5KxwXp/Re9p1cuPzzwLPROhey2ECLoCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=I3REJXPo;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=bndVyjjX;
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD9D606A31C
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 01:28:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAD9D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=I3REJXPo;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=bndVyjjX
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F3F1A7A00F2
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 20:28:33 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 16 Nov 2026 20:28:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794878913; x=1794965313; bh=iaJf8k/qN1
	nIaiWfd0uDUw7rEtPezrCGyn/inf/QLhA=; b=I3REJXPoKFbI2waG3s96n3jXVS
	jNnGLtjYRuoqmBs5ceeRJH1iMKMUHxkjUFJdPbN0mjS/sydKaeoeGNPc+ugGPmAQ
	l6i3HzxL3+TlVfs4uc7Kr0bUjBk2Ct2liLX4MAAXlLmJiwtRd3t9DiSKiIclwePa
	JFv9/tMO78RiOa8e5IloetEvo/xjwRioHfKQKQWYDURdoA3gFTc8g9h3+eeLZcWl
	1S3gAQLyjRim710HeAQ1kQdg/ocvBH7Bo8WvFaZXeVDw7w11lv5YGqq9jmRgnFLG
	yEfAXkXdFiteu89/uCXdV+t7GyCvUfEzfbJd7bUpUSZkiWTfyzDYmIn/CNkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794878913; x=1794965313; bh=iaJf8k/qN1nIaiWfd0uDUw7rEtPezrCGyn/
	inf/QLhA=; b=bndVyjjXpDgoA+jCEPIk9A3FXRSgIrM5TjlMV6pcAyx944Ml3Ke
	z1aAEubVSXioOGpprfKTWmTd/md739wwrIil+O62h1tCS+E0hK9tyuh9sNKSMk2T
	686Tw9ZvfVPfrUmva0kJFwf21xWwbshbDIxaFAb65tb7YZ2kgBSB4FW6NBWVGXF8
	vWpD5WrEjWIR5vQNAoKgCjOwOAJQVYeHEkpk4djbMfOHLzd9DcWX+ZUTSUPakFCd
	SKFwwIRSqRVUsw7ZRQhipsw5k4GXhEvj6wnSP49+BJs0gCPr/upgmlSBsl0KqEjt
	PLA3An25J3kYONAaonn6EhaIkhAqERtPlCQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794878913; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:WR08VjsXJeW4+/ZFwGhtmVG+tWeeEvE8aBwQSW4E2C9BCG3
	7dTjzcAz2buVhteVgbQAvEVqCIbozmcj7AXpAxe4EJGm1GjgcZsJbNMdURQjtZ1z
	iTJGwdYYbekydChmW3El24p1alID35WtFHWTvgZjfttYpLLO4h5HgxHRngIGFgL+
	qWkIjF9CqemuNeL+8t2SI7o/78Ulm+KoeYGBYn4Txt4tirbd10MHZ6K4B0+qnNiZ
	W+17wnyIZhOPJ1M3cT4AfGJde1XL0jPfRNi3FJ+gRwiYl//VP6Q8B7R5C4Y62dRk
	zFPVbAgPp/XsEACd6TZXIrCt3DUPYhbnqEe5Thg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:QoQN5Bsdvaqs0pdRzvIuv7uvq392URac3nZ0Xhygyks=:WPoTyDeEg7TAB48jp4vSwd8mdIxFqNClJqmZYtyrf4s=;
X-ME-Sender: <xms:wa37ajryiKpZOzEasL9ZSD2L-LVMhXzsK_8gHWgEjtcRJjxo46A7fg>
    <xme:wa37akgllFr5k0XGC_uKee5ffdZlhGm6krtLtnBDOinIot7EUSSukm5QS2GL7YquD
    4kXj4unJFvGf5YENtArDbIVHX-i-wsGBxmcUTuIWYc5Cq1E6RMEfw>
X-ME-Received: <xmr:wa37aogiBRxBowYnWpITYBfb2kI6z5u3ChlmaIrwBlRQ_jQArqBSqsc606bbb_ohlPdPC1utA7KVv8oVdKHHHviSJpi_nJaffaNn>
X-ME-Proxy-Cause: dmFkZTGqlWGOc51zhw9QlQxbNPGXcoahznJVhCzlz047DeNncUmsIyHai407u7+Qqdiutd
    K6z1rm/4Jy3rjgP2qWwd4JjQhln3V3GD8MYlKl3P3hLVKcz0VekIOjJ7luRJTjjvpbzfyI
    kvgnL/zYjWQ2+rMxyZJ4jbjW2/VEv6WO0t8a/MgANbCvzUYn4OFoQ0DTJsEW8g2mwKmdyt
    B6gMIU/+hinp6m02Dsg5KFW6p9zjUK2s+Bv+zCwYXcyj7kzDsMLQGCTrAJFIVZosiJz+Ss
    aLoXdOMaS1RwV5TJI95WbiP2B+tjXhlMnhvYmi1096Zp0fwwf0VSjsySu/xHk8TJr3A6LS
    1Pjk1Q9x4QiqOW2WVgusbFcoLac/rXVyD2DGcjYgmp9pjZaOkdtU/hfD7s9gYrL6IcxLye
    8mZUb24MyAsHc3P0HywZBTSn3lpMGbjggXZFXJzb6NMxZnC7JvnIX71/PNT6X22/q2HkK9
    cz5UXmtev8CoWZvvJusIZC48u4tj2jR0lZK7qpP1vrC6OBC8SXpShSColDch9TfCXrVn9P
    +RLhqaLpCidc1HZjV4Yel+HzGbVZpb6GHmbUmmI/WLj+/tNMdYQQk/vqfequUdCws9Onz0
    9Ks2dBGdKuWnUVBGVNxBpJdhACm8pkju6G3KIpqDSXFPxyoDF3pE9wmIg90Q
X-ME-Proxy: <xmx:wa37aigON9YEceuK0sdrRMfqyUAh6vxCPZcSmBpPGrvMQB8HyqrVGQ>
    <xmx:wa37agK0Hp4ZQNEc2cpDiznjFpCaSqOONFI6nVDx9GCgI1RvWCo6GA>
    <xmx:wa37apHKoJqE5N9p5S73hCkeYpUJXhEgG--yQIH7VGrbnmPxWqIiUg>
    <xmx:wa37asTNWR6c01o-nwcUotwiGbWAr0T686NuSiyUscth0j2khHahYg>
    <xmx:wa37alyyPaCnb050rX6jbeYZvXZEjgRevkK6ph7hsEJmGm5kTtZ2yZUO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Nov 2026 20:28:33 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  "Mark C. Chu-Carroll"
 <markchucarroll@fastmail.com>,  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 11/12] builtin/rerere: use `OPT_SUBCOMMAND()`
In-Reply-To: <20261111-pks-rerere-subcommands-v4-11-df0c8bf79e16@pks.im>
	(Patrick Steinhardt's message of "Wed, 11 Nov 2026 13:18:47 +0100")
References: <20261111-pks-rerere-subcommands-v4-0-df0c8bf79e16@pks.im>
	<20261111-pks-rerere-subcommands-v4-11-df0c8bf79e16@pks.im>
Date: Mon, 16 Nov 2026 17:28:32 -0800
Message-ID: <xmqqwlqcgsan.fsf@gitster.g>
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

> In git-rerere(1) we have our own custom logic to parse subcommands. In
> preceding commits we have refactored all of those subcommands so that
> they are ready to be used as `OPT_SUBCOMMAND()`s. Switch over to use
> these so that we get rid of our custom subcommand parsing.
>
> Unfortunately this means that we have a backwards-incompatible change
> because we no longer accept the "--[no-]rerere-autoupdate" flag for all
> subcommands. But this was arguably broken and misleading as we ignore
> this flag for any other subcommand aynway. So we cheat a bit and simply
> call it a bug that those flags were accepted in the first place.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/rerere.c | 84 +++++++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 56 insertions(+), 28 deletions(-)

I already mentioned

$ rungit master rerere unknown
usage: git rerere [clear | forget <pathspec>... | diff | status | remaining | gc]

    --[no-]rerere-autoupdate
                          register clean resolutions in index

vs

$ rungit seen rerere unknown
usage: too many arguments

and it is this step that may be responsible for some of it.

> @@ -211,41 +237,43 @@ int cmd_rerere(int argc,
>  	       const char *prefix,
>  	       struct repository *repo)
>  {
> +	parse_opt_subcommand_fn *fn = NULL;
> +		OPT_SUBCOMMAND("clear", &fn, cmd_rerere_clear),
> +		OPT_SUBCOMMAND("diff", &fn, cmd_rerere_diff),
> +		OPT_SUBCOMMAND("forget", &fn, cmd_rerere_forget),
> +		OPT_SUBCOMMAND("gc", &fn, cmd_rerere_gc),
> +		OPT_SUBCOMMAND("remaining", &fn, cmd_rerere_remaining),
> +		OPT_SUBCOMMAND("status", &fn, cmd_rerere_status),
>  		OPT_END(),
>  	};
>  
>  	argc = parse_options(argc, argv, prefix, options, rerere_usage,
> +			     PARSE_OPT_KEEP_UNKNOWN_OPT | PARSE_OPT_SUBCOMMAND_OPTIONAL);
>  	repo_config(repo, git_xmerge_config, NULL);
>  
> +	if (!fn) {
> +		struct strvec args = STRVEC_INIT;
> +		const char **args_copy;
> +		int ret;
>  
> +		strvec_push(&args, "perform");
> +		strvec_pushv(&args, argv);
>  
> +		/*
> +		 * We need to copy the array as it will be modified by
> +		 * `parse_options()`, and if so we leak the strings
> +		 * referenced by `args`.
> +		 */
> +		CALLOC_ARRAY(args_copy, args.nr);
> +		COPY_ARRAY(args_copy, args.v, args.nr);

Does args.nr count the terminating NULL pointer?  We mimic the
familiar (ac, av) convention of the C language; av[ac] being NULL is
also part of the convention, so if CALLOC_ARRAY() is not allocating
an entry for the terminating NULL and COPY_ARRAY() is not copying
args together with the NULL, this may want to be corrected.

> +		ret = cmd_rerere_perform(args.nr, args_copy, prefix, repo);
> +
> +		strvec_clear(&args);
> +		free(args_copy);
> +		return ret;
> +	}
> +
> +	return fn(argc, argv, prefix, repo);
>  }
