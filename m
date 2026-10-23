Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792741311;
	b=jMoTavbD8PtjzF1dvTvqHyXvOKOmV6Wpax9NFJa90vf9W7/N9mb0blxifLjCOUFa6vvv
	 WNatucAPGJFEL8NN8oNgnr7Xk1V4wo8o16Z+UCSkk4KS9NdEwKfgxJPRvEhFFbCdBlH7A
	 1sgd8Y1NM1GETg5bGKYnlJ5yYDiFMPMomwHMwEb9bytsgOOlRASp4xD2FRHvqFadKr2sc
	 RjJLOCqpLRV9UFcqtEdFK34BfwtUtcecvFvG/UjdP1O4etfE+ddqzTQKlIp3bt7sRbl09
	 6Qzy1rIHHSqN/zBaZsjEALBzRzvfBBfrY1wKMxff0s2N/SNp3myf56aJTdg/O1xUVhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792741311;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=nFQIw2HnCXUmU2lGF+0xJyjNLvZi3NeROA5MhoNr5nQ=;
	b=Jri249xwj29fBahMM4b5/bVs115RvnUBs+K1/LUJ3dmXLQoarTIPljWc2FIThqtV7PFc
	 sK+MbzQyC+ZRBVeeV39R73sM0+EUsFwLirp157zrxAeNleCK3x712r6Fwy3NUoLjH2+xt
	 9gMDTR3R5/UnA7410I5TTUni6cNridGAySFFEJ46zYcGPntog7OWTZgPi90sW7k/5skBh
	 5I9dMF1pNyfTwrQpMRzYYYAzsdr5Z4aYdUVWXB8ehv2mh/dPLPzJ8FWRFTthngXAzj6sx
	 KIOt+tR/G1EUf/2Hz4xx9G9s8oAkHzEndPgk3Tl5vI4OzOxPNrtzvk8IR9MCwedGJSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=sxk2Ywsa;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=WUpaIIWn;
	arc=none smtp.remote-ip=103.168.172.151
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B49606A31A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 07:41:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6B49606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=sxk2Ywsa;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=WUpaIIWn
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 05A2EEC01FA
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 03:41:50 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 23 Oct 2026 03:41:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792741309; x=1792827709; bh=nFQIw2HnCX
	UmU2lGF+0xJyjNLvZi3NeROA5MhoNr5nQ=; b=sxk2Ywsa2sBbaKENjmsmBMLSJy
	LwMshrca41F4B8W067X46MrBYQNyLnwV9W5Aj1/NEeD1OgZMXOGMR2jv5eTfcgZF
	PYAoaE1oVR9gZtfPWzMB39CfEa9KkCekTn5LzrMoPPDlZW/noEnAlSYg/2rXyc/J
	ArIDTkTM13Lkt7XaDdlM6HSB4imPgrKfMLMC8gkBhD77BrSAXGTS3HXlel944F7q
	b0JKuygtnWifVt5z/KPYmeJ+kS8fgraFaEdkC6Z0LQ82EGRuq9UuNR5FB6hqIxIT
	7k2SMs7pXaTnuEGbuEeVbHBtHxiYrYeOtMzZ2Gi5m6lttLact3J50GkTbu8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792741309; x=1792827709; bh=nFQIw2HnCXUmU2lGF+0xJyjNLvZi3NeROA5
	MhoNr5nQ=; b=WUpaIIWn9GKQwt/VhcapAtGQ6Qiv24Nv9uZj2bn20RAu02Dx0cE
	ArrTw10cKr6r9Mojtm+hKcHWEh2KaHFTkBoNo+3NDaOAYCWdXsWsBThDT28tW0kg
	5v/FKmvt86v7nEQ990+QaTSAFVQTUTsjwfUQkrFQ6svseSU9/WNJFOpM+XwzeYl9
	Cfv6QHxQwBgDmqflTDdmszjiDyGb1O3/ngEw5+ZzuLK8h/RJO/HrrbHN8HB5QikZ
	K4DBXnce0I6ndbzxpJFQNY7liYoEwRGmm2l80sqd78Vbv0YRAS+zbV4TirO5ves/
	YiT5muJTVV7b1aCA+TzCRQmML8nPMVM4KTg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792741309; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:EBINcPB+pnUJjyDLnCdL74yuAuNAKtVGnX46+iS3pQirQl6
	/nk17CZxpKoGfuabhhEQAfFFg9F3BPbfr1EpQRblqoIjLvdLfC1cGC89BpylnCIr
	TkjOw0yz9f8tjV6r/lRyXQAq6s6O67B2vS9ev6Hjaiy53yEPzzoIujPa5m2a2qVI
	C5SDG+W1JB4iZRKzztX3FHVvOZwKA6qUVI7CO/RmV2KZrXRsWGmK8p6scbho4m5p
	yNzb6rcKgSU5pSnqRJcWgWGoXKD9Lz4kLvPPSuHj0f5/YkeOJcJd+L5vw7QBBPmp
	FEtR2iIPrfYUgisEUDt6ucOQUqLRVrwsaXlOqUg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Iaak8rjYYD5rzn13gpIkeAzjT83HJIxwLo9K6NTcyh8=:EqvnhDsgWOfWGvzcT4jDKTCDlqZLzbBjSpneqfdE7tc=;
X-ME-Sender: <xms:vQ_batz_TuH3jhgE9oR5lkBL0-ZVdhAcPos6-Uy4uw2e-Jt0ril79Q>
    <xme:vQ_bakRZgfJu6JaTDYSs_QxekrPFX_7HM71uz3DFFD170ZXWNhWXzvARa10cTw51I
    rl2sYC31PhacysFsWAuZ12xc3m7zAksRzfih1k2zypJECmlOzl6t3U>
X-ME-Received: <xmr:vQ_basUn4CdBmtPkf-aQCrTPO1sI1gQjekBzeZWcm2p8n5KmjbBJKybd6MXVDLJdf6CUJw>
X-ME-Proxy-Cause: dmFkZTFGRgASGGSMCuP1qhSLnRREWeMs3Yjpj2ZQBJa8kbDVqF3OnQYagfXSQeATUsL+ME
    mB8EQccRDceGEZE+49/Ru4CG3gOl8GGpO0EGidIrKLJXlQYN0uwLNaiBFtzDgVNvx02qga
    DAfGNhZoS5KG4sFQ6SI0R65g8yVnmjiaCZG7LUF0QB3zYlIIt1eX93mggc+odDcNH2R4E2
    NdH69ItwYD+Jku4DnnMqMyVSEzvI1ReHij87gbU2mx+6jenxGBd7RZVCThxnNnyHZxeppS
    qIf5KHqObb+L8io7MM9AKROZE3LYckLtTZ1FraXqyrlU5FKCVzo15IKOEewNM0c13XS/TM
    Huk6YI2KOichbocmk8I4CQZVqMgvUP24z/fXhI1gaN0mnOdSYl/FEx8q310XnZ2Wbgzvtf
    KLtGqinysutlrJH4I+QfgQoxMCGTVsXALu1LKG+ijyWl73ioeYSS2IrXh/jVxBX2Py71uT
    wDvjzuwtMb69sJE+1QO9+UrLVfQWJgBj1q0kHvocvqsZkYvwyp7FgiGUMAiDF0X+jEoh/A
    +rX4bW9rNPD9DD/z4qYIHD0WsfNrgDJS2sVInvmJ1I0p4/qJLdq4PLD2ah6afjW/bXHj2L
    W3EFuwlVI8/EdUONcMQ6ZvGRoPb1R1ng3H+HjP8bZJgwQfFoL4egrWq8E33Q
X-ME-Proxy: <xmx:vQ_baub657aNHWx4OwoPEPnWnC-H8FbYuXppalQnzTTENdz5JGEo3w>
    <xmx:vQ_baq2tebnGUwnAv7a0WM29oaVV_RZptxNDpYNA29l8fdBekB381w>
    <xmx:vQ_baoiu6rqQmVInMrs99Nbxl-CQJvs-gEgvVAm5SECJD1aeOBT5xw>
    <xmx:vQ_bamaTBcxQ5CZbmngJFY5kNQHwKtRMMwAXakACTzlsWZ4T57zTrA>
    <xmx:vQ_baj3Wc6D2aHgFUtym9jbj4p-UOnxF8esyLjQc_L47HzUAVhai5n3M>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 03:41:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id daa1ece1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 23 Oct 2026 07:41:46 +0000 (UTC)
Date: Fri, 23 Oct 2026 09:41:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Andy Koppe <andy.koppe@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH 1/5] doc: glossary: add root ref and clarify pseudorefs
Message-ID: <atsPsFnb5mrneAMb@pks.im>
References: <20261022212903.177261-1-andy.koppe@gmail.com>
 <20261022212903.177261-2-andy.koppe@gmail.com>
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
In-Reply-To: <20261022212903.177261-2-andy.koppe@gmail.com>

On Thu, Oct 22, 2026 at 10:28:49PM +0100, Andy Koppe wrote:
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

As Junio already mentioned, I think we should retain the information
about different semantics.

I also think that the previous guidance around how pseudorefs can be
used is weakened, because now you only list examples of how they cannot
be used. Previously though we explicitly specified that the only
supported operation is reading the refs directly. So instead of giving
examples of how they cannot be used, I think we should continue to list
the few operations that _are_ possible.

> @@ -512,6 +513,9 @@ The following pseudorefs are known to Git:
>  
>   - `MERGE_HEAD` is written by linkgit:git-merge[1] when resolving merge
>     conflicts. It contains all commit IDs which are being merged.
> ++
> +When a pseudoref contains more than one object ID, using it to refer to an
> +object yields the first one.

This is indeed a good addition.

> @@ -640,6 +623,37 @@ format. See linkgit:git-reflog[1] for details.
>  	To throw away part of the development, i.e. to assign the
>  	<<def_head,head>> to an earlier <<def_revision,revision>>.
>  
> +[[def_root_ref]]root ref::

And splitting this out makes sense, as well.

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

Okay, this paragraph has been shortened a bit, which I think is a good
change.

Thanks!

Patrick
