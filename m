Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792706867;
	b=Lqs7nhMHXQhSyjW/zv3nff47f0gEF8n4WwwPOCNTi6bKcRlsZqcaDhjqfZd3LwvQNgff
	 GIPsK8EMKyTX7irb+wgLwG4qdB/pIPTPsePkIqpPzMeGM997m78tIrYIajmInhsBZjAUS
	 0s1qcnh85AJnenrrWRtVmzwXyZok+9VSu5NLzYNDqlWFP90xwcpUOabY3Wu+qes4iX+gH
	 cxkWuKLLMRq9g0HtcJ8cfsqOC16VVFdrowILNGWP/dk4jSEd/3wvyXpoqIIMCewjkmQEO
	 eBVPIyFtTOva8+5KTUsw27ShpGfW2/MdHOy7yXjj+5/DBDVeXh+fJOmheExamNl7HSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792706867;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=amg/Jhg5aez5tLKA0l4xr284iiB+YFHNW3fT/DgNLEA=;
	b=F1APSQ7o/gCHs4+SQsAcbcKT29KZNXl/KUFirv7+uiW7GXPlKiwFTtDIUrtEuq0CJoPT
	 ep8VTxQSjaB2MHN1bCiMxQJMlD1qkt/TrgrJBRrsUSv1C8Zdzd5hrjkLZhT8anV5fRtI+
	 snXsR2nhYylY0sZAVNvSvLTfrPdnRpIz8st1LYAiuMFNAUQzEkEFum5OMGx3yoMzArQq2
	 Id+bAyy5hPWGWsIf2vtAbfUdvRZwDKZgquURKa2w9AukVLa94PYyoiZwijkliPR4BuJY9
	 Dk9YNOFqOCSM6/ly8OV3rh0SHmvJIXyU99hBcJsSQXln8mz0v6DIeOp5EhcBD44uD4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b="K/tcvsf6";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=GJ1CmjGH;
	arc=none smtp.remote-ip=202.12.124.152
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A389606A31F
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 22:07:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A389606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=K/tcvsf6;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=GJ1CmjGH
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8ADF47A0182
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 18:07:46 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 22 Oct 2026 18:07:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792706866; x=1792793266; bh=amg/Jhg5ae
	z5tLKA0l4xr284iiB+YFHNW3fT/DgNLEA=; b=K/tcvsf6tI7tvV5Ax+82wCyLOj
	mQuu/s1jHunq/6/dii8Rg7z18BckiGx889Fpmcoc25QChcX1xO9F38+t1OIm+/Cf
	Sy9TqpEoFrD7q5TnIpoYnWzF0lmWcGKMQAVt3oARWhnh543OmsjHgZvn2dEpeCtR
	V50+E9r56cueeyBj69aJXAy3KuEJc/dF8giS/ZqOn3A+HjZCpEqiDADU/6sRSkJj
	is5eMk9ZkUVVzuJdKVg/97irVzQkLHbzgYJU+fpD4HX4487z24PXktGHEtYtZy2F
	6YA6hm0TDMAWxk/5FQVWaQxXuheoX0ETxNV423B2NO+G8C/cVu9nCMYZj3YQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792706866; x=1792793266; bh=amg/Jhg5aez5tLKA0l4xr284iiB+YFHNW3f
	T/DgNLEA=; b=GJ1CmjGHdLICvoUESOIEPbQ0OFGqA376PHg+KER47E2UmTWoZ/L
	Q1TC5VMkogOx7EhkAjXeJS8HedAcXu14fDCTXRo8JAmXGVpPOFm8MTw5iNF079WS
	fqEQilu4TGOhAKbqi0XvVVVassMU/nti/+aAbO9wsoHNbkNzN2gWA9SY70LUhcb9
	qICf7y+b2wGZo/J+YoorRDGtGCtCpHhAtGtlgbVok4M31iCNyARllnwkxj8fBw9G
	02Vn/as/egZpExF86nI1ACg7VAs69QMYr/E96hlbYKdgluSJ5GU1pUM/EM3qZKyy
	oCQixDUBQceq7Ao1rWGF50DUfl6EECcRWmw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792706866; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:hTfOGxmppumQFOR1Y1W37vt6xMsEIKqxpneTsYpc9wRKC4E
	9NiwwOMvZV9kWnd3HeFUkNID8iuOrtYVNbFqnhsLBJUcq+x2mlQAti+RdARxwflN
	KooiyAdm/AdK7thWvZbpGLxNtDevd3U6GU3KO3vKQ8i6NY6rHvs9P9dNa4uOKUog
	IIuETnrGixL1L2sSSnLaQ7bYt1oLmakqBKK/yZnlfb14ch62Z3zGdwCc4n502+9J
	fE9/BDXjk/LY0EDl9OCGjltwncKVmqzfnOuGG9RmltEpIMHxfkjYNFEJbQYrBl1p
	N/4ZZoNSyVmvlzgSllur61OqfqTNKjGwpEL6gQw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:mjOXmYj7HOUmm8FCXrxj2j02e3+zNmxqL7sQKFVcL2w=:kbhQ0a2cH75COnTAiIJnXAljXD6h8FVByJtEAJPdUmw=;
X-ME-Sender: <xms:Monaauiwp6uBvagqsw6VPc6lU3SizJ09c99G7vVwQdVe-XazuwkU7g>
    <xme:MonaaisEqPwAh1AM7rFwVZ9tevIUHM8PSmOkg8w0r7CkblU17kpesgbb7L-52gzJ5
    N1daEXqueCbMhsmyXee3br0Z4fm7DJvaf491vCSRIFnWbCZAYtz32AI>
X-ME-Received: <xmr:Monaav7Cr_FC_qGJMAu2qTxaIvcYVanT9TQIgbx-tFJFz2icMrxwM0x7dL8Rd8B7URgk89sOj0oORo2E_VEhV_23_hzpkNJV5Bq_>
X-ME-Proxy-Cause: dmFkZTGTDnz2qFtEHuSPc+px8EjGt5vuRnhy2DvF2pwHVi3Unv7czZBUfFEyrjoiIDrWfT
    nqDv1DiiLPK0EPT1OcgHJfyEdGWg3l4zvqgsp7T6RbmWSqudzi6B5OXUh3NthTEtFRMyeg
    5xI5++AoSDjoGDl8URKo3wGv/Ma8Gpei5ltQPSb5W+Tt84SvYXP1oUVqESLkyILa06tyhp
    20jUbRA1mQ8lwBBdkDyZP/pWUDgtWHy36UBNq4Ybu/ohu0NdtwRjvOx9Uol00gV6IzvDp2
    Xp5+TXtzBF7X6KB5eP1Z2ZbsGeLL4maOsU92ZpRLGyug7V1AZ0ynNg7NzxundV4QxK/9s9
    cecoqGVSgU4S1bCq9c+GWdNVjlkLh6jIbFEHPC9nGcejLcoRH/KYodMR4+KwADsLjhrpGg
    hwaQ12WGQM+cst+yBVi2B+AzDYtzbJtRxrBdtrVmRyzeUjyf2WQMkNuYYZcTAZ95+Ug6eq
    sKX7k+3XDfrLMb9OBqyVzfkXZmmzKywTwxgbGaZ09MjBBQTRKw3VPClicN4l6kx4iyhwk6
    jE1zwXOga/yJc2y9eYX2QXYVX8ilQkUuj3T672jbR1EmKeP2Ds9Rrhr4CO/17EnjjmC+7/
    zlI1N9ZY2fhsCaux6TZtf84WiM8+xhyFo/S9Olwb8iQwC2RZ/0pfrtd1wRuQ
X-ME-Proxy: <xmx:MonaauOpG7tAHuvV0pQ-QkL7txgPBcyEmhulwvLn2_R-u1n8l-UfTg>
    <xmx:MonaatsWI2Pfd_ifz5twBpE2e5SWjj7GLR1Lbjak1jn8eyInTk7ROg>
    <xmx:MonaahacjUfBVEJjBpMPNDsq1bUkIGVUZQQt6yKseaWBZSJUI3SMxQ>
    <xmx:Monaavyv17fSQrzpB8C9g6xC1dna2m245Q2Lef2tw5KUq5Vr3QQuqg>
    <xmx:MonaasG6YAROjlZnaDX6RxKKdrAkz0UxzY7rVW9jWpbvVO3PYVe9bXOc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Oct 2026 18:07:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Andy Koppe <andy.koppe@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Karthik Nayak
 <karthik.188@gmail.com>,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH 1/5] doc: glossary: add root ref and clarify pseudorefs
In-Reply-To: <20261022212903.177261-2-andy.koppe@gmail.com> (Andy Koppe's
	message of "Thu, 22 Oct 2026 22:28:49 +0100")
References: <20261022212903.177261-1-andy.koppe@gmail.com>
	<20261022212903.177261-2-andy.koppe@gmail.com>
Date: Thu, 22 Oct 2026 15:07:44 -0700
Message-ID: <xmqqv76tcrtb.fsf@gitster.g>
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

> The glossary describes refs in the root of the ref hierarchy, but does
> not actually name them "root refs", even though the term is used
> elsewhere, for example by "git for-each-ref --include-root-refs". It
> also defines pseudorefs as refs, yet is_root_ref() deliberately excludes
> them, as they are not stored or handled by the ref backends.
>
> Add a "root ref" entry, moving the naming rules and the list of
> irregular root refs there from the "ref" entry. State that pseudorefs
> are not root refs, and refer to gitrevisions(7) for descriptions of
> commonly used root refs and pseudorefs.
>
> Reword the "pseudoref" entry so that it no longer calls them refs, add
> git-for-each-ref(1) as another example of how they are not proper refs,
> and explain that using a pseudoref containing multiple object IDs yields
> the first one.
>
> Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
> ---
>  Documentation/glossary-content.adoc | 68 +++++++++++++++++------------
>  1 file changed, 41 insertions(+), 27 deletions(-)
>
> diff --git a/Documentation/glossary-content.adoc b/Documentation/glossary-content.adoc
> index 52301a56dd..b2c582254b 100644
> --- a/Documentation/glossary-content.adoc
> +++ b/Documentation/glossary-content.adoc
> @@ -500,9 +500,10 @@ exclude;;
>  	unusual refs.
>  
>  [[def_pseudoref]]pseudoref::
> -	A ref that has different semantics than normal refs. These refs can be
> -	read via normal Git commands, but cannot be written to by commands like
> -	linkgit:git-update-ref[1].
> +	A name that can be used like a <<def_ref,ref>> to refer to
> +	<<def_object,objects>>, but that is not stored in the same way as refs.
> +	For example, pseudorefs cannot be written by linkgit:git-update-ref[1]
> +	or listed by linkgit:git-for-each-ref[1].

I would love to get input from Patrick who wrote 993d57eded (refs:
pseudorefs are no refs, 2024-05-15), as I consider that the loss of
"different semantics" from this description is a rather serious one.
FETCH_HEAD and MERGE_HEAD cannot be written with update-ref simply
because it is normal for them to record multiple object names, so it
is not just "how" they are stored, but also "what" they can store,
that makes them "strange", "pseudo", "different", and "special".

>  The following pseudorefs are known to Git:
>  
> @@ -512,6 +513,9 @@ The following pseudorefs are known to Git:
>  
>   - `MERGE_HEAD` is written by linkgit:git-merge[1] when resolving merge
>     conflicts. It contains all commit IDs which are being merged.
> ++
> +When a pseudoref contains more than one object ID, using it to refer to an
> +object yields the first one.

This is an important addition.

> @@ -562,33 +566,12 @@ The following pseudorefs are known to Git:
>  +
>  The ref namespace is hierarchical.
>  Ref names must either start with `refs/` or be located in the root of
> +the hierarchy, in which case they must follow the naming rules for
> +<<def_root_ref,root refs>>.
>  +
>  Different subhierarchies are used for different purposes. For example,
>  the `refs/heads/` hierarchy is used to represent local branches whereas
> -the `refs/tags/` hierarchy is used to represent local tags..
> +the `refs/tags/` hierarchy is used to represent local tags.
>  +
>  See also "REFERENCES" in linkgit:gitdatamodel[7].
>  
> @@ -640,6 +623,37 @@ format. See linkgit:git-reflog[1] for details.
>  	To throw away part of the development, i.e. to assign the
>  	<<def_head,head>> to an earlier <<def_revision,revision>>.
>  
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
> ++
> +<<def_pseudoref,Pseudorefs>> are not considered root refs, even though
> +they follow the naming rules.
> ++
> +See linkgit:gitrevisions[7] for descriptions of commonly used root refs
> +and pseudorefs.

I think this is a great reorganization to split out the "these are
exceptions" into its own section.
