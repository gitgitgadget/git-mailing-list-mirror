Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DD638DF9
	for <git@vger.kernel.org>; Thu,  8 Jan 2026 06:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767854822; cv=none; b=AOBzcnrRsbJlGMFrfS01JPdBBVo3uiEZAl765d3vQNSyCtgaq96efkW+cC+EcdRkVO+2/o9c4Qn9f6I6Gf/UdrPjFJ+QUMkH+clx8k4oF50JXwWBEvZvFpcitZT2Medv4fsCeGXMgSFPVyZaCrZ+b54A1/+7SHqy8UKNLk1f0oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767854822; c=relaxed/simple;
	bh=aGVlC/QwcKt2Xp3mDutfypiSDUb3l/2R4T6LhBnTAqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ge2pS4UuOkzDWRRSNcwwtTmNO1KPUBaC0xfy9oXw+B3vucTul7ciNHjRgXIWFG0d3P0jKCgso5bJzUzoFJaDI/ORsPE0IuodMut7ee5vg5TfC8gZ7GOBIDPO6J0CBl6n95FYQ0nQ7s5Mla/BnCjDMkOZFXPprAv7TNdPbvjsfjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GlNkyQDR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K4yTl27Y; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GlNkyQDR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K4yTl27Y"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1A97A7A00CF;
	Thu,  8 Jan 2026 01:47:00 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 08 Jan 2026 01:47:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1767854819; x=1767941219; bh=RFBb2WkS28
	6tiHRD3mPdIVbBrieOzFDapzcx85SR7pg=; b=GlNkyQDRQgzm/6mPvpZimY5yOZ
	8sb+mPsCQdbkwBKKwTOU02M00OIf02UL2x6G/SPwXgdjSqRoikejgBPDAewgAya5
	dgDnQx7450xv797A3tsqSE8pstuHHeBMp2Ln5gs9oQsw9SrLDGyY1eaCtqopw//r
	yC6rFIwlJmjkdbpIx++4FCuftt1CDk491O92nMZaHMSWHA4HJgWrsmpa8klN4IsG
	moY4suW08jsGWsk0xbYu5qkkEywcwSbKI9a1x4+jhEzQS1N61bWcfn3CmotHyMtt
	53coMjNSJHmoHQrB3lR1jqWc2gXIIeZXnskpjletfuVGi6FO8s1Wotlp+Q/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767854819; x=1767941219; bh=RFBb2WkS286tiHRD3mPdIVbBrieOzFDapzc
	x85SR7pg=; b=K4yTl27Ydh/VHyNmrmTQYDtYJS3X9CPPxaPRE+/P0TqADdYOg5c
	wgX2M2KUbkeb5Bknz8+4k9UOZjuNW2qRAkGCur8K2e1T6EF7UFogb+uJzbTp7mEo
	4yVZ5A4JnqKYbmiLCAU2g/hXW2H+T+dubrSxg4eNlQ7pov6/7Fm6GBozqY41JTCA
	aApF2dvWWRDhMydFDpmRT6OsRdtO63sBCFWEApUEwKEw1DMW43NK5U5QmSWXD35S
	sJ0zszAPAcGhqLknwlGrFHCWUl1J+5mFUx3SXP2ruihfeXsmY2mSm4aRuspHjlyG
	6jGiTUcTm7lQySaQ6DZtwIhhrs3e8iS9h2A==
X-ME-Sender: <xms:41JfaeLtlPEenvsp-4iiM67LHCMe-GYtMAx0q2Lywq8U-V12UN1EIA>
    <xme:41JfaeVl7LTJftSbM4JW9nayUoC3w4tyl_zk_gPFoemqgmjQhjJkCi0uPcfwDLRKa
    humv79W86Q3SDJbtl3E_4RcAkiriCSi7mdcNdllQCnUA4Qssf1q>
X-ME-Received: <xmr:41JfaaTiyXpwTmQO2gxCJZClMqWpgthiF5R-aHAB3f3jF2l9UAyKKI9CkcHE44TlkT0N_LyORGrS-9T2GoAN2dMFRJGFe6x91c3qeRYosg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdehvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegrughrihgrnhdrrhgrthhiuhestgholhhlrggsohhrrgdrtghomhdprhgtphhtth
    hopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    rhgurghmrgiiihhosehgohhoghhlvgdrtghomhdprhgtphhtthhopehsthgvrggumhhonh
    esghhoohhglhgvrdgtohhmpdhrtghpthhtohepjhhrnhhivgguvghrsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopegrrghrohhnsehstghhrhgrsgdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:41JfaeBdPTN48lNyxop-OshZaUF9-nX42g1su5Zj_crCpnZDr7PaoA>
    <xmx:41JfaRJ8RrUAfpVfOACAU_k8LAsqGsgby2LBALiPYnmTxQc_2wyBLQ>
    <xmx:41JfaZDS93WvB1RjOdxSsMnCgG005XmCWTyAtspVGKfM7nl33hZQ6w>
    <xmx:41JfaWsiPa7XA145jv6wVokAOpvv4yWPjDg6VwLrb8317zhwV9MURA>
    <xmx:41JfaSZVn4cJyXJODVncR4EVweHVXmasRyDQHqZIDkn6glTy82vglFHg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Jan 2026 01:46:57 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ebf49da9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Jan 2026 06:46:57 +0000 (UTC)
Date: Thu, 8 Jan 2026 07:46:54 +0100
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
Subject: Re: [PATCH v8 06/11] submodule--helper: add gitdir migration command
Message-ID: <aV9S3rV6wKZp9CP2@pks.im>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20260107230145.517562-1-adrian.ratiu@collabora.com>
 <20260107230145.517562-7-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107230145.517562-7-adrian.ratiu@collabora.com>

On Thu, Jan 08, 2026 at 01:01:40AM +0200, Adrian Ratiu wrote:
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index b3d6f9ff68..271d549bac 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -1266,6 +1266,66 @@ static int module_gitdir(int argc, const char **argv, const char *prefix UNUSED,
>  	return 0;
>  }
>  
> +static int module_migrate(int argc UNUSED, const char **argv UNUSED,
> +			  const char *prefix UNUSED, struct repository *repo)
> +{
> +	struct strbuf module_dir = STRBUF_INIT;
> +	DIR *dir;
> +	struct dirent *de;
> +	int repo_version = 0;
> +
> +	repo_git_path_append(repo, &module_dir, "modules/");
> +
> +	dir = opendir(module_dir.buf);
> +	if (!dir)
> +		die(_("could not open '%s'"), module_dir.buf);
> +
> +	while ((de = readdir(dir))) {
> +		struct strbuf gitdir_path = STRBUF_INIT;
> +		char *key;
> +		const char *value;
> +
> +		if (is_dot_or_dotdot(de->d_name))
> +			continue;
> +
> +		strbuf_addf(&gitdir_path, "%s/%s", module_dir.buf, de->d_name);
> +		if (!is_git_directory(gitdir_path.buf)) {
> +			strbuf_release(&gitdir_path);
> +			continue;
> +		}
> +		strbuf_release(&gitdir_path);
> +
> +		key = xstrfmt("submodule.%s.gitdir", de->d_name);
> +		if (!repo_config_get_string_tmp(repo, key, &value)) {
> +			/* Already has a gitdir config, nothing to do. */
> +			free(key);
> +			continue;
> +		}
> +		free(key);
> +
> +		create_default_gitdir_config(de->d_name);
> +	}
> +
> +	closedir(dir);
> +	strbuf_release(&module_dir);
> +
> +	repo_config_get_int(the_repository, "core.repositoryformatversion", &repo_version);
> +	if (repo_version == 0 &&
> +	    repo_config_set_gently(repo, "core.repositoryformatversion", "1"))
> +		die(_("could not set core.repositoryformatversion to 1. "
> +		      "Please set it for migration to work, for example: "
> +		      "git config core.repositoryformatversion 1"));
> +
> +	if (repo_config_set_gently(repo, "extensions.submodulePathConfig", "true"))
> +		die(_("could not enable submodulePathConfig extension. It is required "
> +		      "for migration to work. Please enable it in the root repo: "
> +		      "git config extensions.submodulePathConfig true"));

These error messages could probably use some newlines so that they're
wrapped to a more readable length.

Patrick
