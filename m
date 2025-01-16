Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7718F1DAC88
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 10:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737021674; cv=none; b=kvgyYDX7XaSuB0fph78LniR0vcDo9tdWmMU0ToP1UP0hgXXmn4T3nGR814FX+m/M28I7SYXk6g1GGUQDIeZ56ZHkK5kxwo12xVbBj/GV4+QwpEqfsabfwmGP70gNoAiph3tvA4eQyFpHHHNnDL3NzATz+PTAHBMtqRr5ej1zZMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737021674; c=relaxed/simple;
	bh=/b29aQNZI8SUSRYpztjQBhBvxi5mTi/0gRuIcFCp1C4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aqszM1b73gRfd5vJvJ0FVsdo4M4NiiDzVoxa7Z8XII+ERFynypyOv6kW1Ddz9DuQuUHLXQRSyibpM1DjQrxrJXqpzQFqpTy74H4X8fnajOtDeW3eCcBWG3bVSe5/ngLEyt/paEvuWCL8IPNN4AkprFcR/1CqDMA4rCS7VAr9Tg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DDRF7dc6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=odB1rLmm; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DDRF7dc6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="odB1rLmm"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 46D2F114014F;
	Thu, 16 Jan 2025 05:01:11 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 16 Jan 2025 05:01:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737021671; x=1737108071; bh=nJI7/kMBwN
	Lx7kQ4+QLncmMbV/FqCC1zVN25R5Va09U=; b=DDRF7dc6xLLCZOgVJ5p68b8qCO
	KHfBtU/gT4j46qSuXrC4hDRJfcc1P24/4gz+/1Sj1sLZALrursKDx7MHo2Rd1b34
	LrlMnD5L3zq2zSdaTwAIVEkwgoiaBYJrZE1hu6Sq6x2tDzlvvfYX+VU1x/I7s0Fa
	INkprLQKWPZ/sXYbVeqPP3ebn+gdbctefT18o6X16CqqGkks2yqz38a5u08cC7zZ
	4Bomz98eko5oXVx0tRvqNZWV0HDPNI1RUJu+Bxnf8lQFsp58bZDYXGGRtaT1wYqh
	H6BiT44XbvmnhoD5FdTdMhhN0Du+H1H00/utYJypNhTnzbcKqTNuJ6WIBHKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737021671; x=1737108071; bh=nJI7/kMBwNLx7kQ4+QLncmMbV/FqCC1zVN2
	5R5Va09U=; b=odB1rLmmhPp8AcMMalnubciKMSF2I2t+SWyg7lZSGNBWs4ZUbfc
	yV+tW13K7aAeScef8J6Gx7GdDT3TF+Myv1ya6WKcHEpOgacirGtHe4NG+ZJIzk/G
	8p8E6q7QnjbiyxXSm2/Bh2AS/COQJTFvVwR71WCDk5XJjC5h9K6pQ07WOdn3hqxI
	WIj0nsJF3KzXk+yNfQwNAs66yOIBQHHUnjayp+DZAPDB/76ijzszRFuaJixokPEg
	tpAQxpKVMkW2Z9VUdTD+S0p4+DfSQnyF1MN+8rfOG77ZA4aYyNm7n5+T2yTq/FmA
	WqsFXdjNeUzqjX1y3a96WHQDQLSjoTG5gRQ==
X-ME-Sender: <xms:5tiIZ3Zan9HsvLxz9597GUjsvFuOJzhkWRYmCpF9CD0SqoA2iAw3tw>
    <xme:5tiIZ2ak3WxQ0QvQqV0cYNi2YVQ5iUi4KIG8XU8dQx0BwwClSyvazHXrtbDsxTJg9
    q78KeumA_tMxjAEgQ>
X-ME-Received: <xmr:5tiIZ5_7enXO-7P9PV_gKhPPrUIxxZNfrUEiAetR2Mo53dpMfRDqBspnaKp0MjH6G2qGn3WiQ0_UeGGV20fhnrGOKg_DH3_HClWa0O7cbY_FPsSH9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepudegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopeguvghrrhhitghkshhtohhlvggvsehgihhthhhusg
    drtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdp
    rhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdr
    tghomhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrd
    guvgdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:5tiIZ9po5aD0k29ffJGhL-gi4uJ3-s1fvWFa_w9vlhxi2UF9qMVlMw>
    <xmx:5tiIZypFHY_dKu27O3Kjrq9TRBV8w7dCovyjIH4Ao6sFf_z_s75mPQ>
    <xmx:5tiIZzTLOOvngQbsq3fphLn3_8ck3vbDUEBRYsnZICA7WsCP_mk7yg>
    <xmx:5tiIZ6rOTAz-8GXa5F4xw41zva448uL9-vciL3ycx71ZZeYO6YvazQ>
    <xmx:59iIZ9CAeIwrl-f0gylIFxX6MWIDBBYBT3_-hTo2o1l_FzPl2wU3CP-f>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jan 2025 05:01:08 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6a686c4d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 Jan 2025 10:01:07 +0000 (UTC)
Date: Thu, 16 Jan 2025 11:01:06 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
	peff@peff.net, me@ttaylorr.com, johncai86@gmail.com,
	newren@gmail.com, christian.couder@gmail.com,
	kristofferhaugsbakk@fastmail.com, jonathantanmy@google.com,
	karthik.188@gmail.com, Derrick Stolee <stolee@gmail.com>,
	Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 4/5] backfill: add --sparse option
Message-ID: <Z4jY4rELRYvS2gOk@pks.im>
References: <pull.1820.git.1733515638.gitgitgadget@gmail.com>
 <pull.1820.v2.git.1734712193.gitgitgadget@gmail.com>
 <2723143afb397507cbc794375525c37497046dc2.1734712193.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2723143afb397507cbc794375525c37497046dc2.1734712193.git.gitgitgadget@gmail.com>

On Fri, Dec 20, 2024 at 04:29:52PM +0000, Derrick Stolee via GitGitGadget wrote:
> diff --git a/path-walk.c b/path-walk.c
> index 136ec08fb0e..c7456a9c1c0 100644
> --- a/path-walk.c
> +++ b/path-walk.c
> @@ -12,6 +12,7 @@
>  #include "object.h"
>  #include "oid-array.h"
>  #include "prio-queue.h"
> +#include "repository.h"
>  #include "revision.h"
>  #include "string-list.h"
>  #include "strmap.h"
> @@ -173,6 +174,23 @@ static int add_tree_entries(struct path_walk_context *ctx,
>  		if (type == OBJ_TREE)
>  			strbuf_addch(&path, '/');
>  
> +		if (ctx->info->pl) {
> +			int dtype;
> +			enum pattern_match_result match;
> +			match = path_matches_pattern_list(path.buf, path.len,
> +							  path.buf + base_len, &dtype,
> +							  ctx->info->pl,
> +							  ctx->repo->index);
> +
> +			if (ctx->info->pl->use_cone_patterns &&
> +			    match == NOT_MATCHED)
> +				continue;
> +			else if (!ctx->info->pl->use_cone_patterns &&
> +				 type == OBJ_BLOB &&
> +				 match != MATCHED)

For my own understanding: is there as pecific reason why one of the
branches uses `== NOT_MATCHED` whereas the other one uses `!= MATCHED`?

> diff --git a/t/helper/test-path-walk.c b/t/helper/test-path-walk.c
> index 7f2d409c5bc..61e845e5ec2 100644
> --- a/t/helper/test-path-walk.c
> +++ b/t/helper/test-path-walk.c
> @@ -65,7 +67,7 @@ static int emit_block(const char *path, struct oid_array *oids,
>  
>  int cmd__path_walk(int argc, const char **argv)
>  {
> -	int res;
> +	int res, stdin_pl = 0;
>  	struct rev_info revs = REV_INFO_INIT;
>  	struct path_walk_info info = PATH_WALK_INFO_INIT;
>  	struct path_walk_test_data data = { 0 };
> @@ -80,6 +82,8 @@ int cmd__path_walk(int argc, const char **argv)
>  			 N_("toggle inclusion of tree objects")),
>  		OPT_BOOL(0, "prune", &info.prune_all_uninteresting,
>  			 N_("toggle pruning of uninteresting paths")),
> +		OPT_BOOL(0, "stdin-pl", &stdin_pl,
> +			 N_("read a pattern list over stdin")),
>  		OPT_END(),
>  	};
>  

I was about to suggest giving this a more descriptive name, as it might
be confusing for anybody not intimately familiar with the code. But then
I noticed that this is part of the test helper, only, so it doesn't
matter as much. So feel free to ignore.

Patrick
