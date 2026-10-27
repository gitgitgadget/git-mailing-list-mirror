Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793112932;
	b=eKQVBTQ8Ycuam8KzYbQXQrYnPcgRqKs7pyp/qGdv2JdZhwm9b0OHA3H9wegzr8pWSTQZ
	 NoHplb/h+30dCZa9DArUxGFGJsdpzeDT5leCE+HRaIJlcf1GIwOisM/321ZqaMHRUQNlc
	 a4LeaD2DDHsOsnZl+1sYlBsdt/JfNIq6Rp7Peo8qXFxCVPlepR4OArzT1LSTJqcKt5EMK
	 P33ixp+Pvz0hy3wmN0EJxYokQ0Vzg093QtuT5nboozpG8/yoJlr4KZjD7+82fE1raS4Ad
	 JG+8Kbh0PVtYb0X9YtUbynBszbjukE7MO1khurvom8yth7O8o21xle/b5MMKrRHbGaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793112932;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=+B6zg9J+4VXkxoKpdfG+bvG9XCvPvmFqIx22jM7boAQ=;
	b=BWwbV/1SJqPXLpDL+fkim9z77ELLy0KATJSZg+hbu+ERyx/FesR9oG22UucwgsFi421S
	 UXcTcghbi2NzJ8/M2OBtmdnte74f/sSKUNGuXNIX2iBBPR7ut9dozSmThhNKD2C55Ne6j
	 sq4zQAZ89JfAM5hK2Gx2dLZ8OI4qGzZsa7tAEpmRs+swnQ6Y8krgoM6p97L4dnvlUnDs4
	 /HzXhx6CvsZamOOYy+lFDTZy3Em9XteQjYfB5kNPs6glnHBswlJXUBPhqUXNd4/fo4B9F
	 bo5x+2W29AeTRXuYN6qEhN2OV+OXSELyym+PwmpJgEr0lTrF0XJ0YB2CeokFOcHrpVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=OuCsSsAt;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=UsBOzUVu;
	arc=none smtp.remote-ip=103.168.172.151
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF558606A321
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 14:55:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF558606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=OuCsSsAt;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=UsBOzUVu
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 8A23BEC01F0
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 10:55:30 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 27 Oct 2026 10:55:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793112930; x=1793199330; bh=+B6zg9J+4V
	XkxoKpdfG+bvG9XCvPvmFqIx22jM7boAQ=; b=OuCsSsAt7UOJHZz00zXeLH+Mtt
	XqTu9D7422JCF97Eriq2EbS30UOZHKDD0ImGYreK2R0lDIdJY22gxOWes3DuFBjo
	SND8gqWVXiKRaqTQQ/Z/mYo8BjOcacKyRLvRbctVkr/9reXNMECNjp0eNughiuiW
	vrzEe4ZqwkBjXIL3tlvw335LHrK7fgLnpohslFCViUoPAOvqYWdPBZh71ge0sd5d
	fPXUAtTqTFKmV+G2YpIhY7p2gmylXNaaa4mKzzlZJu492ryhRhk6ou/CgSbGFOn9
	Mkx0LESVvJkLjP+yyevnjPgOxz3+3oADBfjVzLVmC1vKWWcz0KwVd6uYIRPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793112930; x=1793199330; bh=+B6zg9J+4VXkxoKpdfG+bvG9XCvPvmFqIx2
	2jM7boAQ=; b=UsBOzUVuxGXUgO5WGojFyKgqJu9zLqwzMJKi0reMSDVvJ6NmC1k
	BBTLzj9xFzLm3+lS2oFXjVkt5dUpyggKGgpCAvNr+moD4k30mJr9qE5vr/vFIqyw
	iY3IBuIlHqibZBvjthh1s2YeXlujQUBFoNVhb4M2X+LTzQn1x+CkyLFVg2ZMJ394
	5om+8EnCxUVN5V5VUexUYQeakyrp69Cslo+WGZDhMbraV59A1ERYtIcec504RaYd
	hg9DOMBjp64RQxXIKrlo2jc/NDq7W0++/mRTT6HzVjK+gfy7YyE2NOwUdQCce/Vr
	mxZAveQxngG+mgyVwZD3UtF4VvY7I8b07aw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793112930; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:fAXlXOx0pYjrqEqPPlbqC9Af/lKAzLzvsgBzYGwunhILwxt
	FLrF5tKW7lXbfd+uYVO9jPknGUCv9mFVbnhboOsaO8+N79ngn0bcIu9t8eszo3qD
	U6+leuqlGuw5lCRltqWNxzzSCCXHS+9/UmztKIl7C7vBxST6dTGd5BhyqLVbIjAh
	7KXhez4XbNgeVQ89pOThDmnkayqqhJKlmW6++Yi1WmElaZzZNlyghwSc4e71kMGn
	wUJqcnJ41rMP2881tcbhAdkxkZpMZkctOoGsvSS2BQ+8rI3uz86FFqH+NO/O/jKt
	O4oKveGJbvZ8iyEG5FSUi+k/oYpfotfHpTX7jgw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:/PZ7QGUyQLH/0RVLv8e6cK2Ltjgxj0S1UeBnEopjh1A=:lxRu1dH88ZK6OuLd/ns/9GnQEgC2/0cfnSwh1z5UosM=;
X-ME-Sender: <xms:Yrvgah5oD1l0ZZpke2e-E8uCW9xWQFvR-69TKtvW84nW-6V1tTvs2Q>
    <xme:Yrvgak7oVZsyNlsW5_WPaLMzKEoitSa5ctEEgzKE2l84e8tjxcVSFx_ub1MRzbr-u
    qo8fupsp28do6rCg_yvuhatACdb_vxm5htHwkgDJE04C12gxtFZWxY>
X-ME-Received: <xmr:YrvgamHzelKNkmmfZDMSKqFP_hFuS5bvGzd8iUzzqdGy7UgVSO_g_Q>
X-ME-Proxy-Cause: dmFkZTGcBEuWflV8Vr6q9itRxBNndKR/s+D2eP6zD1tx5CYW3GJ+bYyiBEiJnaiIV9DggS
    rTIGOYdqgk/HunO9nIxHQt98zdIqbIhujw+jqKIYjuo+ynGNDA80lJLtLAGXOBmc/ynLp3
    U43HUIouFWfLUuji/aI7TrxqDtLwJMr34UScVe4M2MvK84n/o2ID123cVLZPgBdfOEw6c2
    D5L6QR0zK39zxM/FTrXTppKnUwS21YFXwYW1XkXklxiU0MZ9mqs/TdOgTKrJPlsY0nDN3q
    BigWWl6jlJEBVl+2eCxirLLe8DoxeKZ/wUKy/PuAXY9l/0grB/D0ys+i6UDi2owjCGPzoM
    E8J3YeyPzbMTqEK6FsmJPmlTkZ4qTSURx6dc7GMmfQN+UDHsK1QwC0dEnYpSYdJT1H7MMZ
    iKISVekEtSmKX7yZ1XstWw6stbaN8rw9lxvHLRNgs4P+Nx+4DYAVvS+P5eAcCwZ0j34Se1
    Qq+FvV5wS/whvkjxUQCU/m9/1bwrgGY2n/Ga+1JrbzM6NqwzBq3drCLb1k38wdK3C8BOhS
    YdwPeW8ld9YkGYfzJXGVQqHAw0Bw2vF2y5vLl9tI+mQMh4U+DhWTo/mu2nYBHTGLwhCV5h
    UrtMobb3t20fQak5/JfV504cUwyyG0TbTe/w2pStwNl+6VgeRnV2V/j98atQ
X-ME-Proxy: <xmx:YrvgalQPSTieq-OfTdDDFW2acVjRIv3i7mk2zeOcFIYusyQfrHPHwQ>
    <xmx:Yrvgant8F35_xcvo0rKT3EFzhBPdgLjOmZzjxIv9-tU-XvrDqIu3Cg>
    <xmx:Yrvgasxt0tIGPoEyr4KvlEvcY1WYh5yQfX1ZLLuOjsIFmEKB-odvKQ>
    <xmx:Yrvgap664s3EO8SE5tbckDpvJVAZFPhDMog0RHplHn280iuO8qHJ7Q>
    <xmx:YrvgalTdAMuV8JUZ6SVAWpF2VFWMGSRh0IcoI0SQ6awCUkkbGAIloxc1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 10:55:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9f86b751 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Oct 2026 14:55:28 +0000 (UTC)
Date: Tue, 27 Oct 2026 15:55:25 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 2/3] repo: make concern thresholds configurable
Message-ID: <auC7XTg6YXl6xAM3@pks.im>
References: <20261026-b4-repo-structure-concern-v2-0-e0df34228dc8@fastmail.com>
 <20261026-b4-repo-structure-concern-v2-2-e0df34228dc8@fastmail.com>
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
In-Reply-To: <20261026-b4-repo-structure-concern-v2-2-e0df34228dc8@fastmail.com>

On Mon, Oct 26, 2026 at 01:43:55PM -0400, Mark C. Chu-Carroll wrote:
> diff --git a/builtin/repo.c b/builtin/repo.c
> index a450497d4e..ed579e6685 100644
> --- a/builtin/repo.c
> +++ b/builtin/repo.c
> @@ -386,40 +389,43 @@ enum concern_stat {
>  	CONCERN_STAT_TREE_INFLATED_SIZE,
>  	CONCERN_STAT_BLOB_INFLATED_SIZE,
>  	CONCERN_STAT_TAG_INFLATED_SIZE,
> +	CONCERN_STAT_MAXIMUM
>  };
>  
> -struct concern_stat_threshold repo_structure_concern_thresholds[] = {
> -	{ .name = "commit_count", .threshold = 19 },
> -	{.name = "tree_count", .threshold = 21 },
> -	{ .name = "blob_count", .threshold = 22 },
> -	{ .name = "tag_count", .threshold = 15 },
> -	{ .name = "commit_size", .threshold = 28 },
> -	{ .name = "tree_size", .threshold = 27 },
> -	{ .name = "blob_size", .threshold = 36 },
> -	{ .name = "tags_size", .threshold = 18 },
> -	{ .name = "commit_largest", .threshold = 18  },
> -	{ .name = "tree_largest", .threshold = 18 },
> -	{ .name = "blob_largest", .threshold = 26 },
> -	{ .name = "tag_largest", .threshold =  15 },
> -	{ .name = "commit_inflated_size", .threshold = 28 },
> -	{ .name = "tree_inflated_size", .threshold = 32 },
> -	{ .name = "blob_inflated_size", .threshold = 34 },
> -	{ .name = "tag_inflated_size", .threshold = 25}
> +struct concern_stat_threshold concern_stat_thresholds[] = {
> +	{ .name = "commit-count", .threshold = 19 },
> +	{ .name = "tree-count", .threshold = 21 },
> +	{ .name = "blob-count", .threshold = 22 },
> +	{ .name = "tag-count", .threshold = 15 },
> +	{ .name = "commit-size", .threshold = 28 },
> +	{ .name = "tree-size", .threshold = 27 },
> +	{ .name = "blob-size", .threshold = 36 },
> +	{ .name = "tag-size", .threshold = 18 },
> +	{ .name = "commit-largest", .threshold = 18  },
> +	{ .name = "tree-largest", .threshold = 18 },
> +	{ .name = "blob-largest", .threshold = 26 },
> +	{ .name = "tag-largest", .threshold =  15 },
> +	{ .name = "commit-inflated-size", .threshold = 28 },
> +	{ .name = "tree-inflated-size", .threshold = 32 },
> +	{ .name = "blob-inflated-size", .threshold = 34 },
> +	{ .name = "tag-inflated-size", .threshold = 25},
> +	{ 0 }
>  };

This commit seems to fix up a couple of issues introduced in the
preceding commit. We generally require that every patch of a patch
series should compile and pass all tests so that we can bisect our
history.

Patrick
