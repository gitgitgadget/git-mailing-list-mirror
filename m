Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6996A2F0C71
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 09:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771319134; cv=none; b=LkRxJmDPlGz6XjiKKo9AcfmCpSIfZW30XE2sKuqtNqMLu6snv6NR29byKxKe02ePACrl4aks6L3K0DSvoymV2xyZ90cV1/dx/lV2a2Hg7C/XdcWQpUGysiVUQ3JQ0eR8vjx2dBFEuIgqvzk9Z2up1yDQDe9csGsNTu/BY1k75TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771319134; c=relaxed/simple;
	bh=LLoWem0rs5n1U4nOdNNrsyZLNz5tC6vLDrrZGMnRqLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uHUmTyR6NwYnkiQ/IDHPxu8XwABwB+8JYVqRT498Zc+VW00Lhx2js7yxnhi6HYrtgtJ+7sWmgmn3sK+wog562Ht7jPgF6a66KhTUblYMd1H2yt5Nn6xwv3FE9HxILpftD+l8kVmLY6fRh6DyPDTJNj5qUBLXKKCzqoJr/st8arc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XzU5JLa8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nCriZ7/z; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XzU5JLa8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nCriZ7/z"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CAF387A053E;
	Tue, 17 Feb 2026 04:05:32 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 17 Feb 2026 04:05:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771319132; x=1771405532; bh=Il5UE6mUoF
	GxLZ5sfWNCYh/GCqiMKx0bjYH4u7mFL28=; b=XzU5JLa8AzrE8WnfLBA5w0QrhH
	I1J5d3Jd6MXJ4Amf0v3sKw9bc/BHO8o7SNDF1WW7kjv784WqDG7zlwpmEkRHbrlW
	S1re/TXNu113sqO418+MB2MhCb+hhTAtfqJhn6UNeFhWBOt47mXisn10obHLPL3M
	FXmz4ogrj0+nEZpNGq/2yDRLf21hdcv85Znenm4IRqTfvt1rc0gWhk9ehkKQ1Eay
	r9IlmLlY+2jkY0MtIdRPBUY0H2kh1MoRicFKxmRdCU3qGPPEMaUiua7yH/FhUPJf
	2RHUrriutsrw625M8h7C4bwCzduyBqExdzl+0m1+Y7Q3DQUN9A4X02OIqBOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771319132; x=1771405532; bh=Il5UE6mUoFGxLZ5sfWNCYh/GCqiMKx0bjYH
	4u7mFL28=; b=nCriZ7/znavwge9H+X3z3l/eena47wNPX3iQXLpswhy/39mmubT
	V5AuDZAx+vmUAE12JAawxwo6s6hzPYKyfrnlv4DreY1tYAuL28rz9X9DidM4A413
	g24MuZ/bTl4v5QEIXw1/02Lqq2J0ukFr/+EtywO4SVLA7f65uMUWblxsLSf8N8HJ
	3zm+UI9HpJC3g3gBkchCEKE1WFeUzPfigscuy4TkWb3eJ+k1uqCsIxNC5oSUm3qx
	7Vo4hNLngMLWSl6r6IVc432uaoBpwarDmbytkPOjZj+zMDAjZzuGtZQwsWkHz9tK
	q+vVitN6qNbJsT+TH0vQsXI9dIuqJhsIvPQ==
X-ME-Sender: <xms:XC-UaZMOPs6PV2gYBPSbIjlWBwfcqOA5EDU28q83FdRZeKfQ2-z2Og>
    <xme:XC-UabBBcQldbNl5vqX3C4CkPbVyXHVWVxWOVSretx8P7T_llW8tvbJBLpO7xw2y2
    qy8DlbdpclKaqRueli8lKl2ustDIVwrnh4OiA3EIBPDNiII7I0tz-U>
X-ME-Received: <xmr:XC-UaefVCYiYPj8JyCeqeoJNGumra-okUIw2PYirAdQ7FtSbu8Bg3OJKGBwEZ0nlQDhGqJ5g4c7uX24DTzzHpJmDoVa3MCwhh4fzwpqNqg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudelfeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehkrhhishhtohhffh
    gvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihht
    ghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehsthholhgvvgesgh
    hmrghilhdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhh
    phgrshhtvgdrnhgvthdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhh
    ihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:XC-UaSO7OrpJ_qpqjSBbeKgZieWyatTylMehdbmQzXkOL2f-inFZbA>
    <xmx:XC-UaWKupRVWOVCQAVEav0v2AjpFkb8YERbXzIyyFc6JW_2D-qccMw>
    <xmx:XC-UaaJJR7Ed1mcevJcJ0oWVU4EuWyO4KsXPK1zsNvN73sbhsM37mw>
    <xmx:XC-UaY42nWfis4ZstwH_q6JDAD7z56RS14qpMzTkKGDdVIHIaR3rJQ>
    <xmx:XC-UaQnthQW70WgtmtMvtRwm3LHk9u1plZxvKcFj1lAHb_Gf8HOTXzTg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 04:05:30 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9d3cc867 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 17 Feb 2026 09:05:30 +0000 (UTC)
Date: Tue, 17 Feb 2026 10:05:27 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 13/13] config: restructure format_config()
Message-ID: <aZQvVwWoDtZGLbQ5@pks.im>
References: <pull.2044.git.1770698579.gitgitgadget@gmail.com>
 <pull.2044.v2.git.1771026918.gitgitgadget@gmail.com>
 <48fc882785013b129fba9b8aada6c1f2e239a4cd.1771026918.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48fc882785013b129fba9b8aada6c1f2e239a4cd.1771026918.git.gitgitgadget@gmail.com>

On Fri, Feb 13, 2026 at 11:55:18PM +0000, Derrick Stolee via GitGitGadget wrote:
> diff --git a/builtin/config.c b/builtin/config.c
> index e8c02e5f21..1de3ce0eaa 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -393,25 +393,44 @@ static int format_config(const struct config_display_options *opts,
>  		show_config_origin(opts, kvi, buf);
>  	if (opts->show_keys)
>  		strbuf_addstr(buf, key_);
> -	if (!opts->omit_values) {
> -		if (opts->show_keys)
> -			strbuf_addch(buf, opts->key_delim);
> -
> -		if (opts->type == TYPE_INT)
> -			res = format_config_int64(buf, key_, value_, kvi, gently);
> -		else if (opts->type == TYPE_BOOL)
> -			res = format_config_bool(buf, key_, value_, gently);
> -		else if (opts->type == TYPE_BOOL_OR_INT)
> -			res = format_config_bool_or_int(buf, key_, value_, kvi, gently);
> -		else if (opts->type == TYPE_BOOL_OR_STR)
> -			res = format_config_bool_or_str(buf, value_);
> -		else if (opts->type == TYPE_PATH)
> -			res = format_config_path(buf, key_, value_, gently);
> -		else if (opts->type == TYPE_EXPIRY_DATE)
> -			res = format_config_expiry_date(buf, key_, value_, gently);
> -		else if (opts->type == TYPE_COLOR)
> -			res = format_config_color(buf, key_, value_, gently);
> -		else if (value_) {
> +
> +	if (opts->omit_values)
> +		goto terminator;
> +
> +	if (opts->show_keys)
> +		strbuf_addch(buf, opts->key_delim);
> +
> +	switch (opts->type) {

I very much prefer this layout. Switches are more verbose, but if you
ask me they are easier to parse.

> +	case TYPE_INT:
> +		res = format_config_int64(buf, key_, value_, kvi, gently);
> +		break;
> +

That being said, I'm not a huge fan of the empty newlines here. But feel
free to ignore.

> +	case TYPE_BOOL:
> +		res = format_config_bool(buf, key_, value_, gently);
> +		break;
> +
> +	case TYPE_BOOL_OR_INT:
> +		res = format_config_bool_or_int(buf, key_, value_, kvi, gently);
> +		break;
> +
> +	case TYPE_BOOL_OR_STR:
> +		res = format_config_bool_or_str(buf, value_);
> +		break;
> +
> +	case TYPE_PATH:
> +		res = format_config_path(buf, key_, value_, gently);
> +		break;
> +
> +	case TYPE_EXPIRY_DATE:
> +		res = format_config_expiry_date(buf, key_, value_, gently);
> +		break;
> +
> +	case TYPE_COLOR:
> +		res = format_config_color(buf, key_, value_, gently);
> +		break;
> +
> +	default:

Should we maybe handle all valid types explicitly and have the `default`
case `BUG()` instead?

Patrick
