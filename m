Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABB1339B3B
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 09:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765876208; cv=none; b=aO4XaVZx7Q/ESYos/AeTRAEm0SmUjUR5LmU+wte6d4wbPIK3ttbB3MvPBmKfYqAF8WqHn49ymqw4y9Y0X2M6NdiXIB3mxPFBjU75zJ7EDAUGXvv4kH0chu18IN8LzjvfK3A522dS6/TdjcKSx66pgYQ2rgVVcqDpC28Y7r9Kp04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765876208; c=relaxed/simple;
	bh=pCnunZBJSO17wKNEYmaqfmO8Y3XFQC9Xok5QAqeIzJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bu3pe2Y/I3BdWcBNbPdaXjsgybpwaQyV7AD5Rpu2GO4c2j1CoS5DeXulaB75Zre8Y4h+hRF+R4fM2pw15GnUaXMhiO9lo814FmsPxzkTk8wkvzTRDJONcEf7FqfJBX4q5pGWtKWIW8lwuWy9ZAM2HcgWR3FM28VO5p2kkPaYG9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SkcSGJx/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k4UXAaLF; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SkcSGJx/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k4UXAaLF"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 35B667A0184;
	Tue, 16 Dec 2025 04:10:05 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Tue, 16 Dec 2025 04:10:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1765876205; x=1765962605; bh=yGmjytISrr
	Iwvlc7W0vDVZgx+xJCCVOIWelsJ2eEV9Q=; b=SkcSGJx/XcIgcFrKFkg4ge6ia9
	5vSUoCJrrR3jTDipwAQ/zAjbwVlmvEkiBDQQmrzWaJOppv8hb8fiasSrawKHCb7I
	i7GlOyzMQ3rZm6TgK+OHiDlZO6iLcjrGHYW+Z9zZ0RZBNYPu+ItFNbH4EHN47mHU
	z0GI+W3V5HfD7G+z4CN8nEemCT9S/rUJXop6EURuLcmHrj1l926/yqyd9Jd2UCKv
	PzU/QtcpP3fRVfQnY/6WsiQqHe7LTSj6sUMGr6tEZCpAkL1ZMhxu8mx8rSvW994d
	31nLFWtEIroLzSt2FnTD4/dGQAu3aCmj+HlF2azN5tAPEEbWeAMYp/cyeMSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765876205; x=1765962605; bh=yGmjytISrrIwvlc7W0vDVZgx+xJCCVOIWel
	sJ2eEV9Q=; b=k4UXAaLFN9wCiFNDoMzpbKfGDFYt94yXGqlDr1vBG/8yZe0puUe
	9uqa/T+QFWv4cYHtqchb/MuXUwuh5B6hfxRcgqqyNbxK49Fwb/HqbePFida+76lt
	H2WKt0IZOzmNPN97Ao6ZOWlhOUDu9El35W66XzGLB//5Eg9wtTGtO6fZlbFB5F9b
	cfjwVs3uVCZizAt94plVnDfou5mV7ImUmxOloMrponFCMmeSFJuvbYzGtJKyAil6
	GEGcLiY8SfrFUJyPyBDCjMLdkVDwV7hafKyUBvEt/0/qbtQWo6CSEsHQujTsvoV9
	Shc8DB+nEo+Rnd6FFuFK4wq9gkoqpP96ElQ==
X-ME-Sender: <xms:7CFBaYWBykkVUkc1DSPhN5B02ibDJHtbosEonRt-C3nv3eotxpPa3Q>
    <xme:7CFBaUy0pNppfkiAgYJUZtjEUJUf0SyH9ovPMbRhRqZpNkO-D9u5sXggjG_rbDw7B
    9-NB0HGJB_DVMocxVeu0fdXYuSVAJRVYfN0uEUTCtpK6AP4R62f>
X-ME-Received: <xmr:7CFBaX_Op7mS11JMOGIg_EaUMLIZ2W7xAr9JhhwGtCW-Q_bNErrwdN5CM6YGcaYoDbcKSi42CxUrEi1fYGG8ImExl7ZvPj_pQONuonkCQg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefledvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrughrihgrnh
    drrhgrthhiuhestgholhhlrggsohhrrgdrtghomhdprhgtphhtthhopegsvghnrdhknhho
    sghlvgesghhmrghilhdrtghomhdprhgtphhtthhopegvmhhilhihshhhrghffhgvrhesgh
    hoohhglhgvrdgtohhmpdhrtghpthhtohepshhtvggrughmohhnsehgohhoghhlvgdrtgho
    mhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepphhhihhllh
    hiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhmpdhrtghpthhtohepjhhrnhhivgguvghrsehgmhgrihhlrdgtoh
    hm
X-ME-Proxy: <xmx:7CFBaR-MhbHs7l5IruhU3D_PlQl3jm9XyAPZpMiqV7l-Rk1rPLlO2Q>
    <xmx:7CFBaeXGopf03SVp9wl1JwU2MoNNLdeJlxnxscheOqberMLFYqzrFQ>
    <xmx:7CFBaWdAAbc7bIK0ogE3GlJoVYPU2hb4dZrHG02JPyoEkrUlX3UaIw>
    <xmx:7CFBafYQJIyrwpfPVss7tYLHz3bg-i8QngoEan9VpmkRe5cruRXTgg>
    <xmx:7SFBaa33GagJs2eOg_axVU3LK5faTxieVMrXigl1QLeJrtuRaytaGCg7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Dec 2025 04:10:01 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0f904b92 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 16 Dec 2025 09:10:00 +0000 (UTC)
Date: Tue, 16 Dec 2025 10:09:57 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Aaron Schrab <aaron@schrab.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v6 06/10] submodule--helper: add gitdir migration command
Message-ID: <aUEh5fclig8NYmEU@pks.im>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251213080817.347922-1-adrian.ratiu@collabora.com>
 <20251213080817.347922-7-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251213080817.347922-7-adrian.ratiu@collabora.com>

On Sat, Dec 13, 2025 at 10:08:12AM +0200, Adrian Ratiu wrote:
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 2b5b4f575b..458dc863df 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -1270,6 +1270,63 @@ static int module_gitdir(int argc, const char **argv, const char *prefix UNUSED,
>  	return 0;
>  }
>  
> +static int module_migrate(int argc UNUSED, const char **argv UNUSED,
> +			  const char *prefix UNUSED, struct repository *repo)
> +{
> +	struct strbuf module_dir = STRBUF_INIT;
> +	DIR *dir;
> +	struct dirent *de;
> +
> +	if (repo_config_set_gently(repo, "core.repositoryformatversion", "1"))
> +		die(_("could not set core.repositoryformatversion to 1. "
> +		      "Please enable it for migration to work, for example: "
> +		      "git config core.repositoryformatversion 1"));
> +
> +	if (repo_config_set_gently(repo, "extensions.submodulePathConfig", "true"))
> +		die(_("could not enable submodulePathConfig extension. It is required "
> +		      "for migration to work. Please enable it in the root repo: "
> +		      "git config extensions.submodulePathConfig true"));

I think we should reverse the ordering here and first create the
"gitdir" config entries before we enable the extension itself. This
ensures that a halfway-aborted migration will still leave us in a good
state, as the config entries will be ignored until the extension is
enabled.

Patrick
