Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E90D24C079
	for <git@vger.kernel.org>; Mon,  7 Apr 2025 12:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744029072; cv=none; b=JgrW6I0RsZM97E5T2LWPfEAjEpYbotS1aQDg+KMYnuWBBd794PFBT3cPsNt5qfBfdLa79YUT8PRyIaKvTCsLHd0WkvPQhqRVRInksLIPw7CwPhTFcuK0tSuENYHtZXo8pUczQ4P8O/sosXKzRKMsOUsLfXuqgohbtgnVdHQCe3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744029072; c=relaxed/simple;
	bh=lBzcEIavAS9teodHRDXC1jIRMwJK29ExEb6nDb8QVw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gxUGsSJFdnBtqNkNBk7p1rbhYKc7JwsMnp1vEYRFcCoaUHq1iggPlgsV14j1GWbNLmPU+WfxLaPgJABjyhE+RR5cRhYp8A64y244V+dN3s9Wz9IGt2HdQO+DRJNhGi3Rct+I0bK6PVJG8Lk6pFmI9LC1DxkPJNntycqlbsdEMlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CM6HSRGs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z5/FgWxK; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CM6HSRGs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z5/FgWxK"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 68CDA138022F;
	Mon,  7 Apr 2025 08:31:09 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 07 Apr 2025 08:31:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1744029069; x=1744115469; bh=J4w2a4E/T2
	NK8iBSQcDbPQUbbGk3gBppgbd7F0tMKPs=; b=CM6HSRGs62WkU6cDUN7EAlQMeW
	cbTLqJbORA98qNbvAN5cZSg8uhCKKrzzPomVGMduBFjloCtkHMviQeVziL+gI4kL
	VvWJBW9I1V1PFu/EHTUf3eKWy5pOhx9+EzgqViNvDP+eK2nfjdZeQGjVj6pyF36R
	d2vESN3ZiZRbJsH8OJa5Os0HWNW3xIMm2u4IFtgJ/o5/SzEGCyL+dv0CNvW9yr2w
	0wgTZOBpyd1ZF2uhdG/FEp1nxmL2u1ou5IEG/fotO4FX1D5yZGjm5H5vuG4JuqSk
	e+pS4OiKniFw+BIo8ym/ZdGjBUs9XBNHMaNcLAF3H1nueZx8j1jaB1ClmepA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744029069; x=1744115469; bh=J4w2a4E/T2NK8iBSQcDbPQUbbGk3gBppgbd
	7F0tMKPs=; b=Z5/FgWxKn5oPR/D/Ub0BBweHwmpMUR0+nj64Vqy/O0k9pfDFdJv
	vhZENXoWTOAaPm10APZ6CM4SKUeWpappgQhvoNftIBMCpPBTq0h7xNtwLYJb88d0
	ClFKC2/CY6IYa1LQjB2gN7ij+X4Bx+25p+MeLF6WxNRQbd5HGexy0t9LS7lwtjzw
	+oP/RP+7jcfFdjsjszJ3gnvC0RckQLUloATIZ8xVkLT2iGX6dDLLZoqcP1LwJW0u
	Zbw5gASUu2kU8Z1TUh2ZiTG34V3bqZpVtv1QnubQdlmhw37KpRgoZbLvMke00Dej
	A3WvT6Rl18ayk7suKc1RV2TXYIADqxJTe9A==
X-ME-Sender: <xms:jcXzZ-5ZS891kh6c5ps0kSS1GysP3d4flcpqbhSvz-y-sxtJyLBhcg>
    <xme:jcXzZ346P4m-BcSI2sO7pYdgcP3dvvv8mGg5Srh0OarBdMAMDweR6aAIomELt76EP
    Vyet6h-Y_lni3UUJA>
X-ME-Received: <xmr:jcXzZ9dzAWbSgXrPz_S2FeElU3uvfz-Ev28zO4-mHzMpkwcqqKvDjVwaUEgp4vUwlLLbASlP3CCwMvCSn1MV2PUqwdNrCaVIXNB003WI7Eaiwg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddtvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:jcXzZ7LoyD2ovBOm0A3W_-ksR5ZZO6u0k_PJ-cpVf2v4XiSisDDoGw>
    <xmx:jcXzZyLE9ut_rBFT1xfCsvYvEQ-FEej7Sa0-XFJ-9T5wXE6PceTqZA>
    <xmx:jcXzZ8yqhvipky7ePxmMGPyc4q-PaKYjMy1SRU5KJYj1fnqlwREToQ>
    <xmx:jcXzZ2KSd53W3PNAYf1cWD6RTE3j_BYJGMlkbW7Sie0aUZIjbmSDYg>
    <xmx:jcXzZ5mefLDG59gw6ukkUBYoDDSPx2btFQYdeRr5vTXvh7DpITwqOTI5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Apr 2025 08:31:08 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bae2bd81 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Apr 2025 12:31:08 +0000 (UTC)
Date: Mon, 7 Apr 2025 14:31:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 04/16] reftable/block: simplify how we track restart
 points
Message-ID: <Z_PFi4-B3ACD5hmq@pks.im>
References: <20250331-pks-reftable-polishing-v1-0-ebed5247434c@pks.im>
 <20250331-pks-reftable-polishing-v1-4-ebed5247434c@pks.im>
 <CAOLa=ZRwRkV56HAxtfX3EM1Lr3D938bY7d-zv+xUF4G40f-O2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZRwRkV56HAxtfX3EM1Lr3D938bY7d-zv+xUF4G40f-O2A@mail.gmail.com>

On Thu, Apr 03, 2025 at 08:17:50AM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Restart points record the location of reftable records that do not use
> > prefix compression and are used to perform a binary search inside of a
> > block. These restart points are encoded at the end of a block, between
> > the record data and the footer of a table.
> >
> > The block structure contains three different variables related to these
> > restart points:
> >
> >   - The block length contains the length of the reftable block up to the
> >     restart points.
> >
> >   - The restart count contains the number of restart points contained in
> >     the block.
> >
> >   - The restart bytes variable tracks where the restart point data
> >     begins.
> >
> > Tracking all three of these variables is unnecessary though as the data
> > can be derived from one another: the block length without restart points
> > is the exact same as the offset of the restart count data, which we
> > already track via the `restart_bytes` data.
> >
> 
> Nit: This para makes it seem as if we'd eliminate 'block length' in
> support of having/keeping `restart_bytes`, but we remove both.

We don't, we only remove the block length. The restart bytes are
retained, but they are renamed to `restart_off` to better reflect what
it actually contains. The next paragraph tries to explain this:

> > Refactor the code so that we track the location of restart bytes not as
> > a pointer, but instead as an offset. This allows us to trivially get rid
> > of the `block_len` variable as described above. This avoids having the
> > confusing `block_len` variable and allows us to do less bookkeeping
> > overall.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  reftable/block.c | 25 ++++++++++++-------------
> >  reftable/block.h |  8 +++++---
> >  reftable/table.c |  2 +-
> >  3 files changed, 18 insertions(+), 17 deletions(-)
> >
> > diff --git a/reftable/block.c b/reftable/block.c
> > index 97740187259..f2567a8f0fd 100644
> > --- a/reftable/block.c
> > +++ b/reftable/block.c
> > @@ -216,10 +216,9 @@ int block_reader_init(struct block_reader *br, struct reftable_block *block,
> >  	uint32_t full_block_size = table_block_size;
> >  	uint8_t typ = block->data[header_off];
> >  	uint32_t sz = reftable_get_be24(block->data + header_off + 1);
> > -	int err = 0;
> > -	uint16_t restart_count = 0;
> > -	uint32_t restart_start = 0;
> > -	uint8_t *restart_bytes = NULL;
> > +	uint16_t restart_count;
> > +	uint32_t restart_off;
> 
> Nit: I guess this is to be consistent with `header_off`, but I would
> think spelling it out as `header_offset` is much easier to understand.

Yeah, I'm not much of a fan of such abbreviations, either. But I'd like
to retain this abbreviation for the sake of consistency.

Patrick
