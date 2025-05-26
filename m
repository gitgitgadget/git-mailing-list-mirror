Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54341A3BC0
	for <git@vger.kernel.org>; Mon, 26 May 2025 07:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748244249; cv=none; b=fHSLfJuuWwO98CKA6fYOPkl8OO5f+oHyr4pYprfFUwCkvbaeR1c2eKtrb9ylNsA6CsIaNNLuuQDfrLt8WAzOuQ/wNWbDVtfW+DCBJ1Bcytlxbt9sRe2Ma/9i+lDW7yyZrcM6G2IrZD+MSy3bPtJaWmIO8Wx3p5triJKctbjGySM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748244249; c=relaxed/simple;
	bh=gQDoDQS1+0SoWwiYcka6kyE/t+rupbw6PoTlOEN3rC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXJjsOf3LxAQzMHwPwUIZepJvR3zXUdzgFoEqNErsfgi+zxPrsdvzjVygtSiz/fimHAUopFPkOxPzWGmUHkWqOWmhyAfUj0zizeVBKA0etvYI8gK73QgoV9I/K8aV26lr/oLDdZqQTtxNsxPjdc05UxtQFcMN6+g2YXBiPzaXWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jtRWZ3sd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KVyRcYnZ; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jtRWZ3sd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KVyRcYnZ"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CE27C1140141;
	Mon, 26 May 2025 03:24:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 26 May 2025 03:24:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1748244246; x=1748330646; bh=9WGSV7vQU1
	TrguJqbxdQP5h7Vsoo3dkowjbsiQwQi7w=; b=jtRWZ3sd9F0DH+c4fWzZ8FOHZg
	GDWNXEhRFxG6zAlBxJ/PJY50RbB1c/F+Na8+FtgGoags8xyDYHV88Vi+EeRww0QJ
	scjjnLDNmmweO+TIHBdPdpyDk8aqEt4J+XEC35IaVY+RRAkd9vWX/Y7RrYqcOwmm
	Csg4HbQ1eREdESgLSAQ+88qkg+ZKUWrlXLIVZXOhpHuk0BriQv1TLPVoeCCXlYFb
	vobifJCqotQuq90g2Yfpzq1tbff45U87opDEkey0P5L+e3TdZJAhyrG92H1yxxBc
	BTwA0nBxqZR5svs97aBqk4cpxG+XNfMEVhHK/FTj0fTpQk6U/MawT7DvCOew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748244246; x=1748330646; bh=9WGSV7vQU1TrguJqbxdQP5h7Vsoo3dkowjb
	siQwQi7w=; b=KVyRcYnZZaja0sR0Pb+7dKxNQVTKxk4xPrnMi4b5ewVu/HYCIK5
	RR0tylmff4MkazXOYpBiiCPertXUQVElgPMLSnvzkZIdiONOzKXlJBTfTPitrgSr
	sEK510LvuZZxk7thM2tUFLW5qW9VUC6P6b3t+NPLXdOwMiC1u/dpZ8nndCZ/vKgx
	f9bmQKQFKR8bgkTSCMIHOft7Dksd5j7UZKDs29qiujpUmxRdD0XDGf2uaI9A3gqc
	2B/m5DktYEmOA2lGtoVzYkm00ONpTh8bInK9mNn3/+FlpzTlYAaw7EO0aMcgG4D2
	WOik2bQ/hTDWrwGo8i6VFsqnZH12GpdksTw==
X-ME-Sender: <xms:Fhc0aCd5pmSUDgIzAo6Xq5fPL_aK02XXH9BMAUHImouq-eiCvYZT5g>
    <xme:Fhc0aMO7pDUMozFtlvTZEVWjCJfYeD_UfkwjIam0-d3SgGbnOfY7EVoHR9XFq5j0G
    6wCwPz4Y2Cp_K2FpA>
X-ME-Received: <xmr:Fhc0aDh8-QAOIQgCjPlT_XAv7-nRwrE5EbADlqKXNpeNxNvipfmr3eeI_R81kzLBeq963iZKWpcjhUncYETm5EXO9OW2ZSFBqw0N8xxq6LlwbA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdduieelvdculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhep
    rfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrf
    grthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefh
    jedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:Fhc0aP-fV-gMlRYV57Jy5eIbjg1YUT8omQj0bzvNPbogC5zfwu0MFQ>
    <xmx:Fhc0aOv9ZYQK2Lu2oK3rNnOLqX5y1KduS7PuaNbN9ZcwYbl6bB0A6g>
    <xmx:Fhc0aGHbGGEYYb0u5L7ppyNO6Qx6sQ_mEWnKtWwsDwkIvgLGIf2dsQ>
    <xmx:Fhc0aNMfuHr-zxeHpZ-RUkx9Fbqyld9wQM7vAcIqR1hYdBq2I8gQmA>
    <xmx:Fhc0aPZSvXK0g5IAMwDO09J7jRIw13TTp9vaK5qpm-vwRloONLBU3o6J>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 May 2025 03:24:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0a4aa9af (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 26 May 2025 07:24:04 +0000 (UTC)
Date: Mon, 26 May 2025 09:24:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] midx: return a `packed_git` pointer from
 `prepare_midx_pack()`
Message-ID: <aDQXEz-RtrcUAwic@pks.im>
References: <aDC0bK+NOuuVvQtb@nand.local>
 <cover.1748198489.git.me@ttaylorr.com>
 <80699bb3ee35f8c4728e7efe8dc53d17134a5fe5.1748198489.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80699bb3ee35f8c4728e7efe8dc53d17134a5fe5.1748198489.git.me@ttaylorr.com>

On Sun, May 25, 2025 at 02:42:03PM -0400, Taylor Blau wrote:
> diff --git a/midx.c b/midx.c
> index fbce88bd46..f7f509cf46 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -449,50 +449,48 @@ static uint32_t midx_for_pack(struct multi_pack_index **_m,
>  	return pack_int_id - m->num_packs_in_base;
>  }
>  
> -int prepare_midx_pack(struct repository *r, struct multi_pack_index *m,
> -		      uint32_t pack_int_id)
> +struct packed_git *prepare_midx_pack(struct repository *r,
> +				     struct multi_pack_index *m,
> +				     uint32_t pack_int_id)
>  {
> -	struct strbuf pack_name = STRBUF_INIT;
> -	struct strbuf key = STRBUF_INIT;
> -	struct packed_git *p;
> +	uint32_t pack_pos = midx_for_pack(&m, pack_int_id);
>  
> -	pack_int_id = midx_for_pack(&m, pack_int_id);
> +	if (!m->packs[pack_pos]) {
> +		struct strbuf pack_name = STRBUF_INIT;
> +		struct strbuf key = STRBUF_INIT;
> +		struct packed_git *p;
>  
> -	if (m->packs[pack_int_id] == (void *)(intptr_t)-1)
> -		return 1;

Ah, so this series builds on top of my patch that introduces the
negative lookup cache? That wasn't quite clear to me and makes it a bit
hard to iterate on my patch now. Could I suggest that you maybe include
that patch as part of this series so that those can be iterated on in
tandem?

Overall I think that this change is quite sensible and hides away at
least some of the complexity. Thanks!

Patrick
