Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793971692;
	b=0WjAZo9u7okkJZ8gRnTjX6xDNmn0Lt6lZpkv8gcyO2ZO90pWoL2I6PErSUWg1Sbf4qE5
	 hGjEBAbuap1G2+ZvTod84Tj3/hBle0FMypY68uUy3h1MYXcsNBg8NybvS+63pM2768Fya
	 colznORKApci+xFkpujzV210srBrlHfcd89ibp9ny1kZP1YIBdYA9MprPI58SsY6Eqfaf
	 KGZiU4xUFS4caTQh3mJTo4+ywPmVQpwK3SZoN8agcHNnjXz2+WEG6gdvoRuyN2rdHApPM
	 GjKE6/ZJcrNzjQbQ4Nyzr6XE4iK2Ry9V/uBljZF0HbqGv53N0L3mQ7HSLgqegLcRE/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793971692;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=132UJlh+aJf2pqvyTSEg42h8KBnMLgjAJEwZ5WduNDU=;
	b=EqDgZwgZebCx+YNKp2sAxCd6nZmxQ7mKuE2lbmPly1ajOu+ok05zbbvXQvbe6oizcYn1
	 ZBx34+PGWdr8quwiVcspefa8CvGQVZZF3fGd3Dgos6fxeM+pwzlypuaMaE6V66mLv5Me1
	 IllCqSidJy3lIrSngkxXLa/bcdsbp9Ul+hMonLRSIavgwALQNuRIhH+OAuIiyDP+wBEg6
	 vtjXb4eMIE0J0clphiqbh+PDTVXQE/kXShqDxpqC7+7sVvrTbDlwdQNmMJpsNavSZgNiu
	 ZMi2P0ffNDaEktE++me1IiQAZEocfiVAnFUTedGbo/U+xAXrdbSXruAJuQf3Hy/zllw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=DIFemy1y;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=DncmJeJ8;
	arc=none smtp.remote-ip=202.12.124.148
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2AD606A326
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 13:28:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D2AD606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=DIFemy1y;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=DncmJeJ8
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id AD0C31D000BB
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 08:28:11 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 06 Nov 2026 08:28:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793971691; x=1794058091; bh=132UJlh+aJ
	f2pqvyTSEg42h8KBnMLgjAJEwZ5WduNDU=; b=DIFemy1yO1oEX0PDJdGBVL4F/N
	aDcWHvaaZ5vrlBS/PII38RfiCEnYpuk2EU0CEvvGdEUHkO05BAyBqP6a8fAzvG4e
	r2AVitkIRSZqjf68xtFWgTI5BRrqtzyyY1EnCThWwcS/K/9n+VSkvA6xaFaUiPaS
	QaE5ZyU58hc7SSWcdEc7pqfrckfaN8RMFqBZloJfcZwtiSCfrqMjn7xK+TeFtgpL
	yK34X7rND1oL3LDhpwm/8myPt4CyJ3dcFGS6LE43tsGowbiwv7Q3h3MCH7Yj7Mrv
	5kSpSTMYl6QZTTQ1t5pa11v/AKQZCj+ZTFpYA6kZdRWPO53wktLimImtshag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793971691; x=1794058091; bh=132UJlh+aJf2pqvyTSEg42h8KBnMLgjAJEw
	Z5WduNDU=; b=DncmJeJ8NMkK6P6/DZFo3P5CwXCM2jljhBx4ZHNKSbaMoJIcNKM
	sFjWtFXMF8JBJtmbRt62XGmgk8FpgQRoy9g0IDvWCQslQZkp10ixEXTxysqtsoEw
	+Wip6ygkhWmOUZVOk2WusmxdpKJl2qB1J/aoTUjqIODdi/STD3m845vHaZLZHSbz
	0zIxsRudlMRYCqmj/Zkm0AkoBigSO3i62PRRnyQfXn2nq4uvRCRLDX8QIbK7edBz
	tIyTY7ZKLQSDK2fffRNuufNQ4tYwygDfh7mkrcnNh5clgfvLorH2wtEUJAaSzOFD
	wOVTMcmVO+w5ddtyYx+bpncVLczcp1b6TZA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793971691; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:jIviO+S88eOWIpA4E6Cg6A6zXkyR1qQ636mV10fViLEcOfA
	g/SLU+DlbnJczkydCP0I55zDy7S4TKoYTOMvumtzxIPSgman+XzgVLt2kBQWvPNO
	UqtaUUBpVVib7u1RWACWTNfc9urAyOnPqNGCu/mBskZw8aU8loMBw6x0WDVs/yRF
	24lxb5SD33FA/1qA4liML0KeUvlqttanllskl/DABbwgVLjD5DNcYv2KaaRTnOx4
	KrxfbXGlp88CyY6DLkOSqOxocKYbdW3Pyfx5F4rjhEAd27SLoJ+PTGK9Fcr/LWv4
	UTsXUeDjvpIcW8d4GvmM3C5xUDMzvxtI/Kdu+wQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:5bkDennC0Ea09A6NsUrsd4bP9DhjRChmXIPAdMRG2MA=:57UqNv8OHz9ZI9EDRPnBMQ5Xfl2zr4d3RLozS1nfZgA=;
X-ME-Sender: <xms:69XtaquiyWp-OrIlqPeLI3fXotx3ZnTU_8AUUBjYTjMbOTGWOF2Z9w>
    <xme:69XtapjvjXjsD89v9OXyVaR1IbZ2gNY1qPq6CsF7ylFMV5nlwLlyd5KukghkvsKT5
    rVryC1OHecGEbHlftuwIDvjc9YasU704MYI61rBp63w__yYHxwv9w>
X-ME-Received: <xmr:69Xtaqvfe5euTf20IUvpP3NjADMEqDHu-j41bzTShT8rOSWEOvGLHZ6Fb4Cr9XKYEE9pL13DV5Nm8fbHYF7o5JZeNrxKcNtBL_Pz>
X-ME-Proxy-Cause: dmFkZTFLWk7BhnNG7ASsA8JMEyX4NdA4IqcfdnfD17ouYbZsxIF0Od5sKyLlxYacHt3M45
    7JRdI1JSe/WX+Fmky/krLTXVhFJRup6IHOg4NLwcRpw/P+RbKJUbkrCo2dluGUDIUw2+Fb
    GoMwSz1+Wj+E325qPKUwKbpQ9Qe4LncZvotFn7qJhSwePtAwGY3qxM71Sp65rNBo8mDRsq
    kW5tSwPQLtlYr2cbGvzKKZWt3KE5mkndA2ludgeeXbrBPRDb3PAjblyXt9+FJLEsXCUFj4
    Gm3tbuJRBrQGbBIKLplhMeBuXl2/jBCTAXUQ+y/mFRFYDexorpWyYOMbWP4dnzQNMu4Fob
    8mwK9g2oCM770RCcfCWUurSmNR+1PlB6zH2w/+SMpBcHtcpAD67EOTM7CtlLT6sUR2OkVB
    ABMZXRnzPPrnZ6hMMMIYQDJMp75xZnZ3Ribz9Bqbho7wYCjcxNJTqEA2ylPu1daPznBxSi
    8XnXKqPEH4/gS/Di5Rl5Wz7KnjOfm/AlGyRhzgua1gzOOtEdyZf576Ie/gsz0b+xHg/PFg
    /bTyNptAC6aay4nf1sEwe86zi+OcqN9XX+4COXJoNxTkjKo87UcrohT9pK9UImK9ml2/hc
    +PfYIUjQT1nNONl+DOsS2qJGbpt+VavkXEzPBn01nrqh+kYDrXRztqVWDbLQ
X-ME-Proxy: <xmx:69Xtas_AQ8AJibbRMNB0VPXWscUbzcijPc7826_kOx1NJvSEZZSxZA>
    <xmx:69XtaoYFrZpJPeyxLGZGfmHVkBM_KysPxkCjhK21WtFnhUs-Je6-rQ>
    <xmx:69XtaqoLoWHH7XjukMHG9jExKiPuFjFU-lGt3A3Xua0031G_xNisJQ>
    <xmx:69Xtat36RJ_UKubwgG6qW7XjvMeMRT_CNZQtetuaCFnjDpH_Kh7CZw>
    <xmx:69Xtao9SupkOQP2G-Q4_iH1btkNZ6osyutbH0RrVAsmjs2wv3HBK4YF3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 08:28:10 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Delilah Ashley Wu <delilahwu@linux.microsoft.com>
Cc: git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>,  Chris Torek
 <chris.torek@gmail.com>,  Patrick Steinhardt <ps@pks.im>,  Delilah Ashley
 Wu <delilahwu@microsoft.com>,  Ben Knoble <ben.knoble@gmail.com>,  Nils
 Fahldieck <nils@fahldieck.de>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Jade Lovelace <lists@jade.fyi>,  Glen Choo
 <glencbz@gmail.com>
Subject: Re: [PATCH v3 2/2] config: read global scope via config_sequence
In-Reply-To: <20261009-fix-config-list-global-home-and-xdg-v3-2-f936b9c8a0cc@microsoft.com>
	(Delilah Ashley Wu's message of "Fri, 09 Oct 2026 19:51:46 +1100")
References: <20261009-fix-config-list-global-home-and-xdg-v3-0-f936b9c8a0cc@microsoft.com>
	<20261009-fix-config-list-global-home-and-xdg-v3-2-f936b9c8a0cc@microsoft.com>
Date: Fri, 06 Nov 2026 05:28:09 -0800
Message-ID: <xmqqa4nmm6mu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Delilah Ashley Wu <delilahwu@linux.microsoft.com> writes:

> The implementation assumes that each configuration scope corresponds to
> a single file. So during `--global` read operations, Git selects one
> file path to pass to `git_config_from_file_with_options(file)`. Because
> the global scope can come from more than one file, we should use another
> method to read the global configuration.
>
> Since `git config list --show-scope --show-origin` reads both the home
> and XDG files, there must be existing code that respects both locations,
> namely `do_git_config_sequence()` which reads from all scopes. Introduce
> an `ignore_system` flag and modify `git_config_system()` to respect it.

We do not really need to listen to your story of discovery.  If you
wrote this via LLM, perhaps you can ask the same LLM to tone down
the verbosity a bit and shorten it by say a quarter or a half?

> diff --git a/builtin/config.c b/builtin/config.c
> index 2554322317..cdef5ebb00 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -957,6 +957,17 @@ static void location_options_init(struct config_location_options *opts,
>  	}
>  
>  	if (opts->use_global_config) {
> +		/*
> +		 * Since global config is sourced from more than one location,
> +		 * read it using `do_git_config_sequence()` with other scopes
> +		 * ignored. However, writing global config should point to a
> +		 * single destination, set in `opts->source.file`.
> +		 */
> +		opts->options.ignore_repo = 1;
> +		opts->options.ignore_cmdline = 1;
> +		opts->options.ignore_worktree = 1;
> +		opts->options.ignore_system = 1;
> ...
> @@ -1659,7 +1681,7 @@ int config_with_options(config_fn_t fn, void *data,
>  		ret = git_config_from_blob_ref(fn, repo, config_source->blob,
>  					       data, config_source->scope);
>  	} else {
> -		ret = do_git_config_sequence(opts, repo, fn, data);
> +		ret = do_git_config_sequence(opts, repo, fn, data, 0);
>  	}


THe idea to let the config sequence machinery to read only those two
per-user configuration files in turn does look sensible.

> -int git_config_system(void)
> +int git_config_system(const struct config_options *opts)
>  {
> -	return !git_env_bool("GIT_CONFIG_NOSYSTEM", 0);
> +	return !opts->ignore_system && !git_env_bool("GIT_CONFIG_NOSYSTEM", 0);
>  }

Existing callers of this function have all been changed to take a
non-NULL opts argument.  I am wondering if we want

	if (!opts)
		BUG(...);

to make sure callers don't pass NULL by mistake.



