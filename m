Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A73031A04D
	for <git@vger.kernel.org>; Sat, 18 Jul 2026 18:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784399713; cv=none; b=JOeAChlMuwOB4pKB0gPjAPsf4g0F8bY8s1gjNhnul1e6XJfDrzjPaZWPpdE5ISyEZu6S8tGrH55CbJahk+bm5r+CYsW1vU6Aiz5Of0sW3zIb/wkgRZ32ju0Yh0NDfpNa8PWZZPNNuTgODmLIsYAb7b2XkXmEioc2u26Fif18aaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784399713; c=relaxed/simple;
	bh=n4huIGdlTC1iZ325S9L2ISl/KXO9psTa3evfL5mQoMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tXQ5CtRFfqDFpeneLnFTZJGbxLgi5dPl3Ex0ncGlzUcnCmP73YxQo9ZLwXJ16E/fjEEK1ubsA4sZoD4ydEDZETn8AtDFg4NzNfEJRXrnu0eCKiQ+wYnyhIiTyJiSyj7ETu/WMElnwF9p/bf14eRCzFX91UKLvSvOnPzJGpc3m2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KPuvTD1d; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPuvTD1d"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49548aebcd8so11585135e9.3
        for <git@vger.kernel.org>; Sat, 18 Jul 2026 11:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784399709; x=1785004509; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=k+sJ/2hKg5H5vxB6x0wOUJMwNNbCo4/ZEWyYM1tU/Dc=;
        b=KPuvTD1dDAHPMJPVZHbO8Odx06GZT8EoLtRQUnTScssRtMhhgWfz1vVECI82k3fHod
         xo/fZldWfQh93EC4G4UIcP6viI7vM0a2CeJlsla2b8OmJYBRZj0jocd2qUB+Rtpx4cG2
         fHbP8fQuUQqUuPcR8CB+9t9AfvKDdPtaZegckUWaguiMj7zcdoU2s/sv89WjBXYZ13uB
         AfB2+lE1sDxFhjZh9L/eJ3B/mQxxZbLGPL2iVRyyupcZAprwbFO5FeXtQeraoVcFa9YW
         vjR4cuVCsvfVcNJbKc6do2t61nCda4lP7pA8nqZVMBMoVCkZNlUPaPIq/pWHWNnAhS3J
         jBwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784399709; x=1785004509;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=k+sJ/2hKg5H5vxB6x0wOUJMwNNbCo4/ZEWyYM1tU/Dc=;
        b=HT3HX1FHbASb/GfQyPbeD2Jsb5B1oGiOfwCMZ4TTzrafRT8ogImkAxfShHPajMapg7
         w9y1gv5Ct5OJEzIJ86Z7z8eLvr5N7E6b4H1LDiK+olRCuGJsYBYLQSwylEcUyS3YlKds
         KX3vPdt26B/L2pYR2Ipy5hGRGT9eimN41wvRzLdLhqOtuVU921EIO2zVHqmgeruFpd8p
         RrfyzzaJl/iufeqqL2hhWmVzfwBucBfL0YUEPr/wbypCpum11DvBG8U74rurYAIAINSn
         y+AQXlmaQC7ZMWgISa/k/BiGSFj6tBfdhGkFZJkOltVwESmUlw5SIUmJRGKoL23+cryF
         YQ+A==
X-Gm-Message-State: AOJu0Yx6Ec51gQmx8EPYVmHtOwaHG0OG4Usud1CFPINUlIPsgkx4AAcX
	NhBnm5/o7MsJIRMRiGisWHE/433OeECDzc7ryVep6NGg+vdQJO+38Y65
X-Gm-Gg: AfdE7cl9Xw/nP648KVgypPbf5MSljDlq78oXCcZ1p7+t2glMfTZ5ZHaSXSc3s5OegDh
	ll2Gox6GEUVaFymKOCjQtH9bFeN9Ab1Lnabp2ZmJK70bjJLyhcA7158HO5uYoJ8znvp6gPqc9ck
	6dXmYhgQ2lZuwO6EHnnh322Tsi/1TX6IxoCuoLI+0YHOZEOOXHUX8d8Y8Tk0Jxsf2mvLpyudmE7
	8b/djH9WlTLAoUm/qLAsY4ZHPkDyaVpim0JcD5Y4TWkLrIRuh5iXC9vlJLQN+XaX7/3OViIYbRG
	P9Idr0IBkjxTFMTs1BX7tVWKQ1hxy7FFxOF4ZCzD4Z3IEyIIhHda5meqHsJPspqAZKdslzN8vSj
	z3phyUmf6dZ7rahY7ZWIjHllwniPf+rNYX1zKcwVJbGik9in2fcn4y/gTX4abJeK7X4WzEuR/pa
	BzZPkEm7cXOJ0+ZcTAFZakopCNxGHj
X-Received: by 2002:a05:600c:1554:b0:493:a570:df7d with SMTP id 5b1f17b1804b1-4954a402f91mr88190275e9.20.1784399709129;
        Sat, 18 Jul 2026 11:35:09 -0700 (PDT)
Received: from localhost (94-21-29-149.pool.digikabel.hu. [94.21.29.149])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e49acesm13467831f8f.6.2026.07.18.11.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 11:35:08 -0700 (PDT)
Date: Sat, 18 Jul 2026 20:34:57 +0200
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org, chandrapratap3519@gmail.com,
	chriscool@tuxfamily.org, eric.peijian@gmail.com, gitster@pobox.com,
	jltobler@gmail.com, karthik.188@gmail.com, peff@peff.net,
	toon@iotcl.com
Subject: Re: [PATCH GSoC v19 05/13] fetch-pack: move
 write_fetch_command_and_capabilities() to connect.c
Message-ID: <alvHUX68McwlEau2@szeder.dev>
References: <20260715-ps-eric-work-rebase-v18-0-34d7adb051bb@gmail.com>
 <20260717-ps-eric-work-rebase-v19-0-d4faee35764b@gmail.com>
 <20260717-ps-eric-work-rebase-v19-5-d4faee35764b@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260717-ps-eric-work-rebase-v19-5-d4faee35764b@gmail.com>

On Fri, Jul 17, 2026 at 05:05:15PM +0200, Pablo Sabater wrote:
> In a subsequent commit write_fetch_command_and_capabilities() will be
> refactored to a more general-purpose function, making it more accessible
> to additional commands in the future.
> 
> Move write_fetch_command_and_capabilities() to 'connect.c', where
> there are similar purpose functions.
> 
> Because string_list is only used as a pointer, use a forward
> declaration [1].
> 
> [1]: https://lore.kernel.org/git/Z0RIqUAoEob8lGfM@pks.im/
> 
> Helped-by: Jonathan Tan <jonathantanmy@google.com>
> Helped-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Calvin Wan <calvinwan@google.com>
> Signed-off-by: Eric Ju <eric.peijian@gmail.com>
> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
> ---
>  connect.c    | 34 ++++++++++++++++++++++++++++++++++
>  connect.h    |  4 ++++
>  fetch-pack.c | 34 ----------------------------------
>  3 files changed, 38 insertions(+), 34 deletions(-)
> 
> diff --git a/connect.c b/connect.c
> index 47e39d2a73..31e5ab958b 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -700,6 +700,40 @@ int server_supports(const char *feature)
>  	return !!server_feature_value(feature, NULL);
>  }
>  
> +void write_fetch_command_and_capabilities(struct strbuf *req_buf,
> +					  const struct string_list *server_options)
> +{
> +	const char *hash_name;
> +	int advertise_sid = 0;
> +
> +	repo_config_get_bool(the_repository, "transfer.advertisesid", &advertise_sid);
> +
> +	ensure_server_supports_v2("fetch");
> +	packet_buf_write(req_buf, "command=fetch");
> +	if (server_supports_v2("agent"))
> +		packet_buf_write(req_buf, "agent=%s", git_user_agent_sanitized());
> +	if (advertise_sid && server_supports_v2("session-id"))
> +		packet_buf_write(req_buf, "session-id=%s", trace2_session_id());
> +	if (server_options && server_options->nr) {
> +		ensure_server_supports_v2("server-option");
> +		for (size_t i = 0; i < server_options->nr; i++)
> +			packet_buf_write(req_buf, "server-option=%s",
> +					 server_options->items[i].string);
> +	}
> +
> +	if (server_feature_v2("object-format", &hash_name)) {
> +		int hash_algo = hash_algo_by_name(hash_name);
> +		if (hash_algo_by_ptr(the_hash_algo) != hash_algo)

hash_algo_by_ptr() returns an unsigned integer, and comparing that to
a signed integer results in:

  connect.c: In function ‘write_fetch_command_and_capabilities’:
  connect.c:726:53: error: comparison of integer expressions of different signedness: ‘uint32_t’ {aka ‘unsigned int’} and ‘int’ [-Werror=sign-compare]
    726 |                 if (hash_algo_by_ptr(the_hash_algo) != hash_algo)
        |                                                     ^~
  cc1: all warnings being treated as errors
  make: *** [Makefile:2924: connect.o] Error 1

This was not an issue while the function lived in "fetch-pack.c",
because that file uses #define DISABLE_SIGN_COMPARE_WARNINGS, but
"connect.c" doesn't.

I think as a preparatory step the type of the 'hash_algo' variable
should be changed to unsigned int while the function is still in
"fetch-pack.c" to avoid this; you'll convert it in the next
patch anyway.

> +			die(_("mismatched algorithms: client %s; server %s"),
> +			    the_hash_algo->name, hash_name);
> +		packet_buf_write(req_buf, "object-format=%s", the_hash_algo->name);
> +	} else if (hash_algo_by_ptr(the_hash_algo) != GIT_HASH_SHA1_LEGACY) {
> +		die(_("the server does not support algorithm '%s'"),
> +		    the_hash_algo->name);
> +	}
> +	packet_buf_delim(req_buf);
> +}
> +
>  static const char *url_scheme_name(enum url_scheme scheme)
>  {
>  	switch (scheme) {
> diff --git a/connect.h b/connect.h
> index aa482a37fb..c4f6ea4b0a 100644
> --- a/connect.h
> +++ b/connect.h
> @@ -34,4 +34,8 @@ void check_stateless_delimiter(int stateless_rpc,
>  			       struct packet_reader *reader,
>  			       const char *error);
>  
> +struct string_list;
> +void write_fetch_command_and_capabilities(struct strbuf *req_buf,
> +					  const struct string_list *server_options);
> +
>  #endif
> diff --git a/fetch-pack.c b/fetch-pack.c
> index 65ebfec09f..f7789e8456 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -1375,40 +1375,6 @@ static int add_haves(struct fetch_negotiator *negotiator,
>  	return haves_added;
>  }
>  
> -static void write_fetch_command_and_capabilities(struct strbuf *req_buf,
> -						 const struct string_list *server_options)
> -{
> -	const char *hash_name;
> -	int advertise_sid = 0;
> -
> -	repo_config_get_bool(the_repository, "transfer.advertisesid", &advertise_sid);
> -
> -	ensure_server_supports_v2("fetch");
> -	packet_buf_write(req_buf, "command=fetch");
> -	if (server_supports_v2("agent"))
> -		packet_buf_write(req_buf, "agent=%s", git_user_agent_sanitized());
> -	if (advertise_sid && server_supports_v2("session-id"))
> -		packet_buf_write(req_buf, "session-id=%s", trace2_session_id());
> -	if (server_options && server_options->nr) {
> -		ensure_server_supports_v2("server-option");
> -		for (size_t i = 0; i < server_options->nr; i++)
> -			packet_buf_write(req_buf, "server-option=%s",
> -					 server_options->items[i].string);
> -	}
> -
> -	if (server_feature_v2("object-format", &hash_name)) {
> -		int hash_algo = hash_algo_by_name(hash_name);
> -		if (hash_algo_by_ptr(the_hash_algo) != hash_algo)
> -			die(_("mismatched algorithms: client %s; server %s"),
> -			    the_hash_algo->name, hash_name);
> -		packet_buf_write(req_buf, "object-format=%s", the_hash_algo->name);
> -	} else if (hash_algo_by_ptr(the_hash_algo) != GIT_HASH_SHA1_LEGACY) {
> -		die(_("the server does not support algorithm '%s'"),
> -		    the_hash_algo->name);
> -	}
> -	packet_buf_delim(req_buf);
> -}
> -
>  static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
>  			      struct fetch_pack_args *args,
>  			      const struct ref *wants, struct oidset *common,
> 
> -- 
> 2.54.0
