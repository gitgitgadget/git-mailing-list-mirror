Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFB831BC8F
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 08:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765872523; cv=none; b=TDC+leLMqLeTNX/yQCFwo8RR0zeqc7l1rHRe1nTF279MhD52LeJ6KccQr8yyQngbP3hEXhWaHmM3dvIvDt8j8BxECEb7/xnKP6Q/+pG4T1vBWnzRrsA2eqqIAA41/ZX9DqKeS9fN/VVnrQrU9yuAllEtz0y0nxAaee5lvrb/8LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765872523; c=relaxed/simple;
	bh=xHqVaRe/6/Q2em3LG5imyK4g3FRpUmZ/hG0E8WkhWBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJDiiDzi23uWwGWcJNIbqvTzowkR6b/BUVbdN+LDfa6dtBpUXBKOrVEcPmLJgwjhp9I9sKGLPLy8x2a01rqHCKHw5JLwWG3cQRQqdpL/Vq9xcpQzbBR4qaqL5/TW/tbn5rS19TA/8V5zQDO6gmy7bWWSnmsfwUWmUs85PVXVCmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aB+JPYtJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ycBO4wtT; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aB+JPYtJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ycBO4wtT"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 7296E1D000FB;
	Tue, 16 Dec 2025 03:08:38 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Tue, 16 Dec 2025 03:08:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1765872518; x=1765958918; bh=syR8kByCoo
	u/Qdo65P3vixgUiKgYg+CTVAAIJ+O04Ag=; b=aB+JPYtJCSs56tE4uFq+Yc9Wvx
	tMTeJBGhXvIe656aQeGu53bWJV8ogE1plGR4adWXqLhZoipvYjuf5GMusYahvYZT
	MhZPEOMnEQ95VTaqPA8ZRmVVB/7WOtenvvMw1MtlXMlZaraT98D0MHMy1I+BKzu+
	A2M15sWsV9eUyJshYRWWZmRLwLbSOYO9dVBTJtJ9Fo8CELJikvfPg0iCIC3m7I+k
	n96ndjTRTVKCGr+0X+/zim2G87aL/tTj7NktIh84RXpgAPepdnf1lw/LiNh9BuWV
	5crDs6AV7/1YehqlTTRgzxYWKryD4UaNafwQNfm9or446GTJs8IY8R1aB+xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765872518; x=1765958918; bh=syR8kByCoou/Qdo65P3vixgUiKgYg+CTVAA
	IJ+O04Ag=; b=ycBO4wtThsmRddLnJ9CckhgcVH/0hTEDFa2m3aeDUc/G9WZZba/
	Y1p+ucR3GsYkhfsQsz0dOx5/9BJFgUgRJDMD9Q9EbxenqjtsuqNscUEawURiWWBF
	VdNVu+an5Rtt7JpRmqw3DTGRXism9/8GKPSkPwSjAJY0gVd2bUJtK9Tr4qjkPozx
	X5IpbSxHaEM8TVIw55Hnney8SjGYf/55Mm4uLmkbIY6ZB99UKzp7TqhTHX7utXwm
	2rstvRajDWdPn9PUZMVFxcyPWc1KrMUhsScTjW6mBERFrOTjbQAVVpHFGq3ISLvC
	lXVuOxacfOriSWHIQLBJ/Wbo4r6UYe144kg==
X-ME-Sender: <xms:hhNBaaGR6HLypFtK9GeLWMlc__BYYIpt_Zd1QTfyeVW4u2NVWYFSLA>
    <xme:hhNBaX6OFDZU2gFgXYE8CDWV_-WllL2hJQMaXebDIfKMrzffsZc317eE7RrNAL1cA
    dNkzmefy-kIedA0eMSCDXlnHFrRvt3m2kFpvZM6ZP0foP2EL--Yvw>
X-ME-Received: <xmr:hhNBaYkYlJLZWDAefOvnpSrtIvcbB_Tkkc6fJYtX9pNEzfcxpsbuHRWADC-QAv8UvY6SBCZNyTmhq26_zLslnWXO7mDC4lJHv2915ntoTA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefleduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopegsvghnrdhknh
    hosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopegrughrihgrnhdrrhgrthhiuhes
    tgholhhlrggsohhrrgdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghugh
    hssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesgh
    hmrghilhdrtghomhdprhgtphhtthhopegvmhhilhihshhhrghffhgvrhesghhoohhglhgv
    rdgtohhmpdhrtghpthhtoheprhgurghmrgiiihhosehgohhoghhlvgdrtghomhdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:hhNBaa6J2hPL93Qc__GW1MoUrecfx0qFdIy29VY8s5aMxHwIHPk0YA>
    <xmx:hhNBaRTLRPiny4aCUZsejc6oe3DykR_ERQnkNXKMzj-Ofo1BdHYb0A>
    <xmx:hhNBaQznMOu_Ovorn17ZsZBkHmxc08nWYaWEeKVQWVrqZOUCBAXIDA>
    <xmx:hhNBaRqRNw7Y1rMErCWSpxGRTP3gE86B31gVJiwG-8KcjCkX-Ikvrg>
    <xmx:hhNBaeJ57yPDgjcXjabD5FYPC1u-Ny8sfveP1xi6kjlnEgVKiojMMK_C>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Dec 2025 03:08:36 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id dead1b0f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 16 Dec 2025 08:08:36 +0000 (UTC)
Date: Tue, 16 Dec 2025 09:08:33 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v4 05/11] transport: convert pre-push to hook API
Message-ID: <aUETgWJ5DJaEpugO@pks.im>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20251204141535.1986263-1-adrian.ratiu@collabora.com>
 <20251204141535.1986263-6-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251204141535.1986263-6-adrian.ratiu@collabora.com>

On Thu, Dec 04, 2025 at 04:15:29PM +0200, Adrian Ratiu wrote:
> diff --git a/transport.c b/transport.c
> index c7f06a7382..047f2cefba 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -1316,65 +1316,71 @@ static void die_with_unpushed_submodules(struct string_list *needs_pushing)
[snip]
> -	if (start_command(&proc)) {
> -		finish_command(&proc);
> -		return -1;
> +	switch (r->status) {
> +	case REF_STATUS_REJECT_ALREADY_EXISTS:
> +	case REF_STATUS_REJECT_FETCH_FIRST:
> +	case REF_STATUS_REJECT_NEEDS_FORCE:
> +	case REF_STATUS_REJECT_NODELETE:
> +	case REF_STATUS_REJECT_NONFASTFORWARD:
> +	case REF_STATUS_REJECT_REMOTE_UPDATED:
> +	case REF_STATUS_REJECT_SHALLOW:
> +	case REF_STATUS_REJECT_STALE:
> +	case REF_STATUS_UPTODATE:
> +		return 0; /* skip refs which won't be pushed */
> +	default:
> +		break;
>  	}
>  
> -	sigchain_push(SIGPIPE, SIG_IGN);
> +	if (!r->peer_ref)
> +		return 0;
>  
> -	strbuf_init(&buf, 256);
> +	strbuf_reset(&data->buf);
> +	strbuf_addf(&data->buf, "%s %s %s %s\n",
> +		    r->peer_ref->name, oid_to_hex(&r->new_oid),
> +		    r->name, oid_to_hex(&r->old_oid));
>  
> -	for (r = remote_refs; r; r = r->next) {
> -		if (!r->peer_ref) continue;
> -		if (r->status == REF_STATUS_REJECT_NONFASTFORWARD) continue;
> -		if (r->status == REF_STATUS_REJECT_STALE) continue;
> -		if (r->status == REF_STATUS_REJECT_REMOTE_UPDATED) continue;
> -		if (r->status == REF_STATUS_UPTODATE) continue;

The new code looks a lot nicer in my opinion. But one thing I wonder
about is how these statements translate to the above switch statement.
We ignore a lot more `status` values now compared to previously, and
the reason for this is never explained.

Am I missing anything obvious?

Patrick
