Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717861F585C
	for <git@vger.kernel.org>; Thu, 17 Apr 2025 22:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744927446; cv=none; b=mRwHIHSq+OV9rGnZWdhE3xBvKlXh4V87YgYV7NGeSX+YKgWOD00+wmOrcTa9D9UHhqfFDhvQYMWlakELxUIgQ3/FeJ0kAS7RqorFO4lS5vOQ32luzQ8JWAwKNfkE9ZJu9elskmSMdKdEOGI1AS3LSXrkn09L0Q1gFjlkbOk9S+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744927446; c=relaxed/simple;
	bh=wVVz2pZoxPGCwQw9v4Py4h/cMMZNIe6aEAduT1XXCEs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EAhnmSPYBsTVCxcFLKdB0+b/z4uyAHA9NxoTvAdO5EBFfhefsUA+VcDY2FW0GwOJPlyLAwVqQr5u2j/IvxuXKw7d/ivori/gZ7sKYfFXMuO8dHmUgnrv3tRYZOqF+a2Sj1Pn7JSWfdpJLk1clkpUcVbq4xjvyZdRhnh9gYbIKzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LDh44ONw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Afqysjy3; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LDh44ONw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Afqysjy3"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6A4D525400D3;
	Thu, 17 Apr 2025 18:04:02 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Thu, 17 Apr 2025 18:04:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744927442; x=1745013842; bh=g6sQCt/CE3
	gfl+uHl9fMQm0ViH5t0dnO07vGkxqiaW0=; b=LDh44ONws9FQoiAK4ohGblNEk9
	clW1/t72jiF9JJ74iHHhKyNR919KkbSwOLcumd8za6OwTlYZnT4ug6/Psnq382Xb
	MB3tMXHfpaMsLQTZrZdtQE7dsYF0aNrsEwVRW8RgwK6v89C3e4mix1EciR/wUqh2
	+HVJC9UCJwXWIydMYyPju4+1JlKfT9wY4f20IpodO1lS9xBn0cEtDDoszk3qho1Z
	JurZhe36wKsm5vxtsZOVzoZsCQ4fz/HUQxlymnPRFVwPcvWO55DG7fyhV6+YujPw
	mG4Og0CnkllFD++fVZGiPpV3tvL5V1rH3TO6USpoaAagsT45EdIxK/eVLaCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744927442; x=1745013842; bh=g6sQCt/CE3gfl+uHl9fMQm0ViH5t0dnO07v
	GkxqiaW0=; b=Afqysjy3In+BKB0/aIN5W27/t0aOosddU/7lvOD443upEIMZmkk
	di5r7Ac2wQkJSVCXFRhOtWwib6X7RDY1ZL1Wf5a3+vWzKzSfyJfSbwz3mg31eT4X
	o1Yt6IFYOqFJF7dXTTynua/wExi0K9grKTOpSZ2vQFgirSnPe+9k1f58vAWavwiX
	v8ZaASsm4g3ee8ew5w2iWAXfhc6D2VYNR7hk6yt7R5lyjhXKVsdCexhPVrHcYOhZ
	yy1rRw+vMjeSyhH4VrQMP5tj4ls9Jww3kxRWep/oOy4MLxrspmVgy+8GA7maehfI
	aksAE3n/LBcQBfMn4iBE7RQuENtYWqwWn+Q==
X-ME-Sender: <xms:0noBaNUgwlL4_ZmjhMIM8fYl7gDYimdR5j-8NHn_KiRPwiTeODRLSw>
    <xme:0noBaNl0eegwXV13aFFE2b5T_dfnKcI9q3ZAnRedgXXZ5GAGKiW7HmPk4ASbg-jXv
    _M26kaxz-6l0VJ-FA>
X-ME-Received: <xmr:0noBaJYOHvgc8pIPfiAvc4i6GfykTEpB8H-8tMnP60e7oKwwz5-eZLrZmeeh47JAb99OhI1Sue7lDLfDprbsV7-9WKqMAQiUyg7K>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfedtgeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhi
    hlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfh
    hfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:0noBaAVmEnG8m7EsKLUmI2R_XUybHuGbza3og-Yil6MhtaqGKyWSQA>
    <xmx:0noBaHmyXUuq25C3E1iqibf9AIVPPyvRNbLXm-yx98SL39Tl5k-1AA>
    <xmx:0noBaNdPsDvFBgqHC7zO-h2fxVAxkg1Qzs9bl02WwB2QKt6S8o3rJg>
    <xmx:0noBaBG6nlBR8Vcz65VuqdO25leC9spVptThDC6in_yDHQq5vCQAMw>
    <xmx:0noBaGoR6YPqmEx-ap5NLTLaRo8bWfIr_iKLa1pcxgRBjGMCrTXxLLMi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Apr 2025 18:04:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH 1/4] pack-bitmap: write lookup table extension by default
In-Reply-To: <b7cfb1267fdd7f50f414c9f79377cb338a0c1ab0.1744924321.git.me@ttaylorr.com>
	(Taylor Blau's message of "Thu, 17 Apr 2025 17:12:14 -0400")
References: <cover.1744924321.git.me@ttaylorr.com>
	<b7cfb1267fdd7f50f414c9f79377cb338a0c1ab0.1744924321.git.me@ttaylorr.com>
Date: Thu, 17 Apr 2025 15:04:00 -0700
Message-ID: <xmqqmscee97z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
> index 2a938466f5..6ad6f814e3 100644
> --- a/builtin/multi-pack-index.c
> +++ b/builtin/multi-pack-index.c
> @@ -142,6 +142,7 @@ static int cmd_multi_pack_index_write(int argc, const char **argv,
>  	int ret;
>  
>  	opts.flags |= MIDX_WRITE_BITMAP_HASH_CACHE;
> +	opts.flags |= MIDX_WRITE_BITMAP_LOOKUP_TABLE;
>  
>  	git_config(git_multi_pack_index_write_config, NULL);
>  
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 3973267e9e..384fefbb1d 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -239,7 +239,7 @@ static enum {
>  	WRITE_BITMAP_QUIET,
>  	WRITE_BITMAP_TRUE,
>  } write_bitmap_index;
> -static uint16_t write_bitmap_options = BITMAP_OPT_HASH_CACHE;
> +static uint16_t write_bitmap_options = BITMAP_OPT_HASH_CACHE | BITMAP_OPT_LOOKUP_TABLE;

Are these two hunks required to be kept in sync?

If so, I am wondering what is the right approach to make sure they
are.  The definition of MIDX_WRITE_BITMAP_* flag bits in midx.h and
BITMAP_OPT_* flag bits in write_bitmap_index enum are distinct two
sets, and we need a way to somehow convert between them back and
forth if we really wanted to ensure that these "default" values are
kept in sync automatically.

The reason I ask is mostly because I do not know offhand, and I
would imagine that it would be hard for third-parties to verify, if
these are only two places that need to be updated in order for
lookup table extensions to be written by default, when somebody
new wants to further update the default.

