Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794003222;
	b=vrUwQO9I2ooh6ltwrJDJ/UPYmzRR6MzgCu+/b2JyKi2y1tv1PfxvMJk/9FvJ0BDBv77z
	 Whd5owi0csliS19tbDPJdGFvHUtqGqX/nngRt2Zw81nWtJ10msn8xeBrTo2LahqCSCt3H
	 6e3l/ezZVWUYkd2W1oYsU1vxNNruNppRd+TCsWuhMO1LxvHULXVfyq+7bMOAmCNbrsbYk
	 8iwWUhduErH5aN1eLbcj8lPtj4r9CDFAYREE/o4feR0yBaQlY9eQ7Ab3WMMRRyE+76/Ci
	 gsKHzy+YBDfbYG5JLglvYN3QF3UQqhnY0ioP6qa5+9TmFBiXtIat625YKB3U+iNubUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794003222;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=0jBrw85QF1ktqzclm/eSHNUuc0bVjPh/jp/WxnTdtxI=;
	b=Ss+PHpiLWHSXokraQCaipRVXDR6er48Uqhz6Zi88eJtGjqb/W4ZAMcwWRUdkJ9KPnPik
	 VM+wMV6tsef4BjHMDnWgxByfOtyMZWS9ffqKU62fiNUMCL5AiZzzWNFbuE7fejoh+/bqf
	 0W3nji9HobUcfRkZM13IFaAxBcGLklBv2In7B920GVjE/aEjSsgnmzXuTz7lmG1vi193y
	 3iexLbaR8b+jqecUlJ0mILgXreB5ZhJKL6HUnZGzbMagIHG1qoUSRnwvsMwOGR5SFaoQ1
	 5dtD16vns0qZV5FKD8wFH6IZVCwD4rv3bVhzuo3VD1WaPLBwbKdUmW0xWuHMp/6bAog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=bgdV7bQ2;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=MVZGuk4o;
	arc=none smtp.remote-ip=103.168.172.144
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0060D606A32F
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 22:13:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0060D606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=bgdV7bQ2;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=MVZGuk4o
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 19A4EEC017D
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 17:13:36 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 06 Nov 2026 17:13:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794003216; x=1794089616; bh=0jBrw85QF1
	ktqzclm/eSHNUuc0bVjPh/jp/WxnTdtxI=; b=bgdV7bQ2pgFaDcvczEBcHYkcYk
	El9weX/HaGSQjnWlgoSsen8Xm84Vm6lTcRvd8FUYbH1/rh5+BNQYyj5g4hAsrVD9
	c4A8SUpLkE65JU0M9RJGUNlSsdvNvLZpGyBfAkJLFSVOHwo6xxiZzrEGu5TpiEiY
	hGvVDaxywSl2XmIyDO/+qYLKEWWxy8B6ityHB+JceX9xY2LITv0cxy2drWvwUI0O
	YQZEPqZ6qrwosoRbcJvfmAu3oNFpbRrkmRnqCaEhzBIZf+jJMet9eDZKmfDS5X4T
	weO9/EcUYs3FbczmMUwZOV77lNiQa9hWbpcZptyFoZTCql7o+yu4attjYRZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794003216; x=1794089616; bh=0jBrw85QF1ktqzclm/eSHNUuc0bVjPh/jp/
	WxnTdtxI=; b=MVZGuk4oqe0pyzc/NkP2JmAW2OmDMtClTqoUUWvZzrERz+8UwlW
	kYd+1eWvqQhizDL40wYDOCaomfLwRXpAAeCEAGaMfTVR+hULR81P+lRnwb3p06bB
	bl6wyQ2169i2FAUI5PMOjNwismqCCfmkNa5l9AO1rYriJ74bWwL6f+Gc1AxLij4q
	parMURrS3VIGimoGWGtyGIccbMdznffxxLcR4SpUhJFY1dRo0vkjBhYMOw+Vxekz
	971+1EDr4Sw+RjtWQ6J3/lLLlMA18WdBTym8k3spfECzBkXf7BCbDanX3VTYsvGl
	QGF8+jxox4zIwaik2JEvsj8fwuAC4pXJlyQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794003216; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:KsJkChDrhkjTTrtJxOTil8/89SRXilbZgTQ2f7AMDXYJ8eT
	sqsyw0X0XyRXhxl2lABbwN0MPWYpWVEWmsSxmzDGAq+clx95fmD1e4Ci17jLZShL
	tv18RVjSYRQhiCw5he+63flQdcoWapxdPB/WJWOUdSi8VDjYzKZ3yG7kuKzvACsZ
	tMneL4vpkjsUy4t07lnSuGj4pruBlVbq9j2pYJ4lJzmJRCKBiSmNI9uN7l+WBGRD
	oJHHPxRwsP5CVyg76mUGrPECETNioHa+AFB7lbuY25jlUiC9ddJtBeuRGS+5nweN
	sXH5iqMpDrp++Um1ulVRZQxWiWwPHuE8AeARatg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:ogbi55XILswB6kP+7i7/FJGKao6yupBFKGmnL6Z6Z6M=:tE/GX+B5udQpna4Xc+LAHjr1WYuL8GPX3dJ8yZQoxwE=;
X-ME-Sender: <xms:D1HuapqHb6T6Lnlo_Gj5R084R_ysODXFONh3OHwzeGbPhJwVEDI-AA>
    <xme:D1HuavVZurw1Hv4BGDX0M765sKb2n8z3qdED7kg9JKhIsFZgbOtYtkuCSRjg4acKv
    S8Yq80WPahZVFL81ngbsstqKIAvWyQNPQWCYvZoaDrNkJI3vmGMgyo>
X-ME-Received: <xmr:D1HuagDGyXRONN_hAjLv4FejVPUGw5yegT8FSQe3JPywVvbJA0qTzWed-B9gYfSi-X_nipAUizQeXSh6STNlTj6iLwRE7WL-cSMO>
X-ME-Proxy-Cause: dmFkZTGLG8eNgIDTOMYz+ZOtyGbUS8IoKE7mP7srJzy2KhLB/j785iOatUeGDxT90qSW74
    bwoVBz3qbeffVLTPFuX1mlLE9BNeSCByStHqwuWjPzFualMyLy7aiFKMx3cDaghSAyosoG
    f/olW0FqzHr/NJA0kKFUfikjRNpFl9yVA1y+m7rAvcqUNNjq4t03wqO3JEwwwY9xuDmOay
    4spTD0UAqGTumYa6FlYszxy2nTkMN4F7eaEfGmndHnG25tCpol4sIrieeAYteX68HDH1eg
    55o7HeAYWNeZ97/iCj05RM6RKOYdGtReWz3CEDJumSnjF7MSqzXvFzCOGpDmqAeJHllYKc
    L+YDErlfqg0Uv2ZdgvL89Qar/ThyJXTau1POSJf12BR55tnfLyCUn3PtdPAlVhpcqbeV2V
    I3Tox8E3fD0cbPbSWdj7FTbzEjwNgiv0Bvb5heX4z4P6wor/IV5BnaWGoltXRnoBdE28WE
    hVHq5x7lev3BfQl/PgfDa59wFhtmWssb3LqtCTGMs+hsh12sUKbeayrvG9Q7kyloQgdSUl
    HEw6IQTPgQ7AOrsqAMYRKO+JhlcotP6jdL10F/tvsrCje3A49sLzlnvPmiN8Ddj7kkUp9K
    adbZY2g3/efzS+q2k8/37ttclsjLO4SU+q3qhnzqJ+NgqWcaEEcK6WjQy3bQ
X-ME-Proxy: <xmx:D1Huar29um3tTNiprsF7Ktzu00P9jzS2YXTjjci-9zObPHZkA4AzUA>
    <xmx:D1Huaq1mrLV5lEbSd4ZjoybpqnVqff1TPlNd48rT4mvhrEEp9TTw5g>
    <xmx:D1HuaoBEU3uHL7SYi6SUhsZjeE-Ca1g2iAECL8Y-QDg5dmQZG0H7AA>
    <xmx:D1Huah6hB4aoa1UjPmc4MFuV5UIsi8uU9jOwLpiKOTCBG2UOhdVbcA>
    <xmx:EFHuahNFq8rDP0kDv4yDSXiyQdBAp7i2t3ILyMgOftvn6NeRFbKtS-9j>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 17:13:35 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Andy Koppe <andy.koppe@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Karthik Nayak
 <karthik.188@gmail.com>,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v3 1/5] doc: glossary: add root ref and clarify pseudorefs
In-Reply-To: <5630c671dbfc4a017e6698674c4b3f09d45cda54.1794000450.git.andy.koppe@gmail.com>
	(Andy Koppe's message of "Fri, 6 Nov 2026 21:31:04 +0000")
References: <20261022212903.177261-1-andy.koppe@gmail.com>
	<cover.1794000450.git.andy.koppe@gmail.com>
	<5630c671dbfc4a017e6698674c4b3f09d45cda54.1794000450.git.andy.koppe@gmail.com>
Date: Fri, 06 Nov 2026 14:13:34 -0800
Message-ID: <xmqqzevlehgx.fsf@gitster.g>
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

Andy Koppe <andy.koppe@gmail.com> writes:

> Reword the "pseudoref" entry so that it no longer calls them refs,

Very very good.  They are "pseudo" and are *not* "refs".

>  [[def_pseudoref]]pseudoref::
> -	A ref that has different semantics than normal refs. These refs can be
> -	read via normal Git commands, but cannot be written to by commands like
> -	linkgit:git-update-ref[1].
> +	A name that can be used like a <<def_ref,ref>> to refer to an
> +	<<def_object,object>>, but that has additional semantics: it can
> +	record more than one object ID and may carry extra metadata.

Good.

> +	... In
> +	contrast to <<def_root_ref,root refs>>, pseudorefs are therefore
> +	not stored or handled by the ref backend.

I am not sure if we need to contrast this with root refs, though.
Normal refs are also handled by the ref backend after all, but we do
not contrast pseudorefs with them, either.

Can we get rid of "In contrast to ..., " and start the sentence with
"Therefore, pseudorefs are not..."?

> +the hierarchy, in which case they must follow the naming rules for
> +<<def_root_ref,root refs>>.
>  +
>  Different subhierarchies are used for different purposes. For example,
>  the `refs/heads/` hierarchy is used to represent local branches whereas
> -the `refs/tags/` hierarchy is used to represent local tags..
> +the `refs/tags/` hierarchy is used to represent local tags.
>  +
>  See also "REFERENCES" in linkgit:gitdatamodel[7].

Do we want to mention remotes and notes hierarchies, I wonder.
If we do not mention remotes, calling things in refs/heads
specifically "local" branches is not very useful.

> +[[def_root_ref]]root ref::
> +	A <<def_ref,ref>> located in the root of the ref hierarchy, outside
> +	`refs/`. Root ref names must follow these rules:
> ++
> +--
> + - The name consists of only upper-case characters or underscores.
> +
> + - The name ends with "`_HEAD`" or is equal to "`HEAD`".
> +--
> ++
> +The following irregular root refs are exceptions to these rules. This
> +list is exhaustive and shall not be extended in future:
> ++
> +--
> + - `AUTO_MERGE`
> +
> + - `BISECT_EXPECTED_REV`
> +
> + - `NOTES_MERGE_PARTIAL`
> +
> + - `NOTES_MERGE_REF`
> +
> + - `MERGE_AUTOSTASH`
> +--

Good.

> +<<def_pseudoref,Pseudorefs>> are not considered root refs, even though
> +they follow the naming rules.

Again, I am not sure what the value of saying this is.  It somehow
feels like elephants are not rhinos even though they are both gray.
Why should a confused reader expect it to be considered root refs?
We already said that pseudorefs are not even refs upfront.

Other than these "do not contrast pseudorefs with refs or root refs"
suggestions on two places, the patch looks ready to me.

Thanks.


This is a tangent but is very deeply related to how "root refs" are
handled by the code, so I'll mention it.  Random things outside refs/
are usable as if they are refs in the same code path that handles
the root refs.  E.g.,

    $ git update-ref out/mister refs/heads/master
    $ git for-each-ref ;# not shown just like root refs
    29f5d436870d37a2e36388e96e9175e0a5bf53e9 commit	refs/heads/master
    $ ls -l .git/out/mister
    -rw------- 1 gitster gitster 41 Nov  6 14:01 .git/refo/heads/mister
    $ git show --oneline -s out/mister
    eddc71c initial

We probably should tighten the system to forbid them, not just from
creation side by tightening update-ref but from blind application of
the first element of rev_parse_rules[].

In other words, things "outside `refs/`" that are not at the root
level should not be treated by the code as if they were.

As solving this (or leaving it unsolved) has no impact on the status
of this patch we are discussing, I'll just leave #leftoverbits mark
here.

