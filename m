Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9679F39DBF2
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 22:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774997960; cv=none; b=TY8oPbHhVEDqzQruMlR6Tppcx0vCG2t3jWoaCnG6uTGGH3GF+fvU/wasrfoWlcJ2dsDV3Ys4jwXBaLNaar7nY8q5KxBj00chnYm8W4eHbIZZhV85JNfpJuiun1HFOugCoZs8TmYSD5c32tOhaC2jnF2LM5Y+hCp92wT6Y2iVR+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774997960; c=relaxed/simple;
	bh=0GB9HttyPQpZq5WE+Xkfi1v8aXGXfZ2rI+SyzLSYwVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hofaB+s8aLYQFmk7uxjQYnvhm4IOV1d/CsqKndxJytsVqHsKUCI1N8euIhzNm/KT+RqY+V59J5Pe1Q97YdX82HnF/6JnJFT53tWlg6PxDTlKKknjcBNlmuX89wPX/+qmUrYlnCqbcSSbLreg4nOyBP8oODqPL0VNpCd9tTLoMs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Sh9+Ohye; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hpjgjZFg; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Sh9+Ohye";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hpjgjZFg"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id A5C57EC0221;
	Tue, 31 Mar 2026 18:59:18 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 31 Mar 2026 18:59:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1774997958; x=1775084358; bh=BvXOnzM7mc
	8nzHJFHBYMwPuFItNU5tPmxfcs07uADYo=; b=Sh9+Ohye3oawyCOU1MOx2cKvH2
	xKoZDMV7BV3oi2dlozbYAn0O8BqyVDhEFFMGeAILNREsXTznjxQ7Mys7IS/3qnSS
	fw+6GzcSkLsAl3qi6ZLJxJ9QnwKSr4XLRxcS3uOi4noNrIe60HUzn0SnFCFsbptz
	A/JsMJDmNcOdSg7eW5zfi/YlPPqCCSnorOQkUQJXExASttYUl/knM1N/UlCTsThI
	KLPxHevN1uHrsjatDFE7SZHWRsNvpBtmOX1ChXB0rsujfPtSk/VCkB+YvIvC/C03
	7RYbMi0nze8hrfx+C1l4uL0tg+vFI0lvfFtwryhO+TzlCMcJklXj3LcyFPTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1774997958; x=1775084358; bh=BvXOnzM7mc8nzHJFHBYMwPuFItNU5tPmxfc
	s07uADYo=; b=hpjgjZFgIhYgVu6OkLJD7qGN1HzPP6pvvry/OQIVaqhlNeMdBiK
	FndQz9JajFbaE2vBI4fSixAoNkp3YykjgBbqlgAkch4E0JSvipcJ055BBpLZAigw
	2c4yyYJMhTV0gZ5SMNFeS1y+nDT337Jo58AtOfZM+qVIgM4UZKCcDcRI2NleAcxI
	3QsV36F96+y/0c5Vau7CYvwDVf+HMG2EsaryCFlqAwsMd/RvONBpPUmm9fOyZaXu
	7daRu3wChwVFDVdJ1yinrlVH9MPDqNKxuGIM+olns+7GWPRZGGWXwkTLIRYX72o9
	tjyBn+0Ox6OdIYJvGULUrZJaovC3HHolLkA==
X-ME-Sender: <xms:xlHMaUj5el2gr117ITLIHkoVktT3UVZ52-q5OhSKaOZ6NV3kzMngHA>
    <xme:xlHMaTBzRmB0BMlBeVD0Bo7DcicdXqQrdGj8lzSqW1dFh1fF5u-Sunc9n2w8br3Q2
    xLFFARZH7PetCYiHfntN1s23vJH_NvXUSVCS1Y5G_olETmXW_Jb7g>
X-ME-Received: <xmr:xlHMaZshBU7lAqCMeoT3YDQP5RLgJuiy9Zfun-2zjf-nXDEhpGRiMGkRbjFogvLlEWfbamJy6_eBzaAC95G4zLiKUo56lB3BkOwJGeVLVL0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepve
    ekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    jhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:xlHMaQbaHmFa6aOjbc8IT78KlYcJAZSuFE0mItnEYduafbfJvW_KsA>
    <xmx:xlHMaUW2Ui14dDpAmt62FrDkZZ5nWnlAdcKahXWlME7QxA0YNKzFhg>
    <xmx:xlHMac6ELRfENd5a6sQSdv5bb_DKXonN8Gh6PtNTVhlxZEOGd8jG8w>
    <xmx:xlHMaXhSL7Exa1W1hRiHHqTJvoS_XNKYG2vSMKvEYpsTbt6Y9dUvtg>
    <xmx:xlHMacRIMvRytEXgSvkYyOE25VWYB52gixHJdpGlckwoNUgJFohanACN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 18:59:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7bf43fb2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 31 Mar 2026 22:59:16 +0000 (UTC)
Date: Wed, 1 Apr 2026 00:59:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/6] object-file: generalize packfile writes to use
 odb_write_stream
Message-ID: <acxRwaUk4XNJiDx9@pks.im>
References: <20260331033835.2863514-1-jltobler@gmail.com>
 <20260331033835.2863514-6-jltobler@gmail.com>
 <act8YM8tMeUr3cJe@pks.im>
 <acvX8wdg39xTy-Am@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acvX8wdg39xTy-Am@denethor>

On Tue, Mar 31, 2026 at 09:31:25AM -0500, Justin Tobler wrote:
> On 26/03/31 09:48AM, Patrick Steinhardt wrote:
> > On Mon, Mar 30, 2026 at 10:38:34PM -0500, Justin Tobler wrote:
> > > @@ -1543,6 +1542,40 @@ static void flush_packfile_transaction(struct odb_transaction_files *transaction
> > >  	odb_reprepare(repo->objects);
> > >  }
> > >  
> > > +struct read_object_fd_data {
> > > +	int fd;
> > > +	size_t size;
> > > +	unsigned char buf[16384];
> > > +};
> > 
> > This interface feels generally useful to me, not just in this subsystem
> > here. Would it make sense to instead expose it in "odb/transaction.h"
> > as a new `odb_write_stream_from_fd()` function? No need to expose the
> > structure itself, I guess.
> 
> Hmmm, exposing an `odb_write_stream_from_fd()` function could probably
> be useful. Would it be better for it to be put in "odb/streaming.h"
> though? Maybe the its use case would always be related to transactions?

For now it's certainly always related to writing objects, but you're
right in that it is not necessarily related to a transaction. After all,
we also have `odb_write_object_stream()`.

Putting it into "odb.h" would feel off I think, so maybe
"odb/streaming.h" is a good alternative.

Patrick
