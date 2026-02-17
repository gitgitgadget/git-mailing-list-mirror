Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C57A2F0C71
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 09:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771319111; cv=none; b=FxU27L/cLISuW6QbJPAYSFv0Z1SAwV2RFANmuz0mBo+n+I7gLWjf1zlNyTETauVqZGQqSxcC0FD2Y7zIL8CjSygoJxeZcfd/VtX8GdnYPkULvxB0/UEnGsBU12qKvGdneNdNK/XPsiN5vK5GLA0hEDypnchARRvkktZZZcexlYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771319111; c=relaxed/simple;
	bh=7p6mr+yk3jWziBA6IaJ+qSPUvSLIuKBm9gZgJixz7ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+WUEUEqS1+bmFQogTOpH1Pjqu+/e4HREu6ZlLnSHMi2ugYn68Jp+U7/NtR/YU9flXvYCZq2ImbUSfGp4tV0z/HRE+e5wYsHlKhEy4zTAv4ADnOs7pOimZb9EBH4dAJvGo5aO4XDca7ikW5tu/VoGJd8t0vmfFhxmvnC1Zku1Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=s/NRFtnb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YCPR4DeA; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="s/NRFtnb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YCPR4DeA"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 574B37A053D;
	Tue, 17 Feb 2026 04:05:09 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 17 Feb 2026 04:05:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771319109; x=1771405509; bh=X89XuHT2sT
	2S0Wnv3DAya6Wn1p5ntgFNsJhoJ1ikfBI=; b=s/NRFtnbRbw0N0tjEP/M5v+aXL
	8pGC4L1PRtWwl5biUbdpX/rciFvhMyeFPsD/z8ItBqRhdvraH87VcP3OYAIbOtD3
	jPtCFrnvT9LXtlTDEulDhy3gkgaOZDIEQ4A8BJZrorUNCbLgDEVkIefEZ5GK6nnf
	byhx/F2DbvaHEsZC3wF5eWpiBo2Z/fQpEKBgTHXOsSFbwF86D8NY9pHMN/3Qer6e
	f3LSGsrkZh46vk/835iif24gi1zJZ/S99LQuc4/J30w2Tcedck1O05vZkWSpicYm
	Op50r0HnFPcukhuLVvz1/AolsRjx68plj/9lQbYB+xCAD1T0vqKMVbXapbcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771319109; x=1771405509; bh=X89XuHT2sT2S0Wnv3DAya6Wn1p5ntgFNsJh
	oJ1ikfBI=; b=YCPR4DeAEMGa0iLUGkIY2PvPdKratl4msHdqvJzTZH7OOXG4nIO
	GLMjklV1koRdSiXNUmolNSNXOzOcuaGMcf2HRM5/WW/NpGuTeRcJfROfYP5vnqjS
	FTk3gNiiBLTL2fPTgxF6znS526JfxFGKMjwBsyki+9rS9TMzweEl+W6K8Etw2DTH
	aQk90WBxbUA95CxxthPdwv0Ay/LCMmmV2OasZJM43IAIbkZ9ncfEIeCXhoTbccel
	hZcg2rnpL0Ws1PxhN1kUToe4G2y47E26xHMSW7i2+4iGEg564tAtABe23KT34z4t
	RuRc0Xdo+TSMLaqGrkCyGHR+6d3ClojeTOg==
X-ME-Sender: <xms:RS-UaS5jl8UrWOuwboyw-mI0ggLiAakDINf02k62ZdlCPGCK4Nx_XA>
    <xme:RS-Uaa-JYQWz--Tw_jOAdw7J_YSQKtE0bBK-xF9aVEEPGaKVx3l3xHw7arqGmdnr9
    ikwqePSl380ysgALB1uuKpYToG1W_dT7s8NcGBh3Fi2zdQPbyFERA>
X-ME-Received: <xmr:RS-UaXqXGy-t0kEZxnK6rrRoJhEn5yAPJCkJQtsE2kK5RgVmJAe6gbxL1Tfbdcg1p4zY6ryfkFej8RNwrDaKzzsFN6olusCcB4EvUu4BRA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudelfeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestg
    hruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkh
    hksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggv
    rdhfrhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:RS-Uabo4OL45RvgtlS8KltPBFifV2vgNhRBJr4j9Sh47e7LFHMHseA>
    <xmx:RS-Uaa3RnUCS9jbiaN2QX-L9y3e5S2WYM_sv7QmluLVLKI4XsdK_lw>
    <xmx:RS-UaZGyx3-hDFNtutm7xWy3J1duZ6E22ovh2T9kVZklKnjWU0TsfA>
    <xmx:RS-UaVGe5LCrq6viA3O5gzrwYMdOglLLAc9mp23AgedDIaV-Q-eiAA>
    <xmx:RS-UaYSm6CHgyctC80f0sfyN0deEcBt_qchkmHkLynbsorUDcu2v07gz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 04:05:07 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8bbb9880 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 17 Feb 2026 09:05:06 +0000 (UTC)
Date: Tue, 17 Feb 2026 10:05:03 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 04/13] config: format int64s gently
Message-ID: <aZQvP21anXXZWcMh@pks.im>
References: <pull.2044.git.1770698579.gitgitgadget@gmail.com>
 <pull.2044.v2.git.1771026918.gitgitgadget@gmail.com>
 <2bca4d231686e33ea9d4d85b10fcffd60a63ad46.1771026918.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bca4d231686e33ea9d4d85b10fcffd60a63ad46.1771026918.git.gitgitgadget@gmail.com>

On Fri, Feb 13, 2026 at 11:55:09PM +0000, Derrick Stolee via GitGitGadget wrote:
> diff --git a/builtin/config.c b/builtin/config.c
> index 4c4c791883..d259a91d53 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -237,6 +237,25 @@ struct strbuf_list {
>  	int alloc;
>  };
>  
> +static int format_config_int64(struct strbuf *buf,
> +			       const char *key_,
> +			       const char *value_,

Why do we have the trailing underscores here?

> @@ -249,8 +268,9 @@ struct strbuf_list {
>  static int format_config(const struct config_display_options *opts,
>  			 struct strbuf *buf, const char *key_,
>  			 const char *value_, const struct key_value_info *kvi,
> -			 int gently UNUSED)
> +			 int gently)
>  {
> +	int res = 0;
>  	if (opts->show_scope)
>  		show_config_scope(opts, kvi, buf);
>  	if (opts->show_origin)
> @@ -262,8 +282,7 @@ static int format_config(const struct config_display_options *opts,
>  			strbuf_addch(buf, opts->key_delim);
>  
>  		if (opts->type == TYPE_INT)
> -			strbuf_addf(buf, "%"PRId64,
> -				    git_config_int64(key_, value_ ? value_ : "", kvi));
> +			res = format_config_int64(buf, key_, value_, kvi, gently);
>  		else if (opts->type == TYPE_BOOL)
>  			strbuf_addstr(buf, git_config_bool(key_, value_) ?
>  				      "true" : "false");
> @@ -309,7 +328,7 @@ static int format_config(const struct config_display_options *opts,
>  		}
>  	}
>  	strbuf_addch(buf, opts->term);
> -	return 0;
> +	return res;
>  }

Okay. We bubble up the return value now, but we know that the return
value will only be different in case `gently != 0`. Otherwise, any error
would cause us to die.

Patrick
