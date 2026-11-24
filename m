Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795561446;
	b=L058q2YGb5Zny2DkuSo47Bphr+WUgTGK8GgiAmMlQl/x50qCrPoK++jtNSMCVXaOX33F
	 4IhGP2xysOaysC6iWfTlLw9vwqidBnmygqT/QdOoU30A4n6oX8DFpmXXQJ2xgRN9Li/5b
	 v/kBDZg04bPmzgrxUBJ12O4Jf/ohcZqM0SMDmgQxw70/at59yMC78wsPs4RsLaUdOORUZ
	 CdAtm/CSXrUP/Uqo0kqwomppZZHWchFi59uFSVIrws/6u7fM3aE1DfXY4G5ROPWIN8ohS
	 P+VyPzbDxSIEnrjtA1r44QQUCAseZwZQy4sTUfWbrz/a4ZxW06aHHUinlnDoRlL1YNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795561446;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=84X6HG4TVEi4/dkK4N75re3NCaSB0tFWLv5/DEWpL+U=;
	b=jeIFe2AxfflRmCTWSHfDwi8M4y53UYga+EXuvIlVNEo6y2IpCkgmdKAuUnLBzIp4Ct4o
	 DBCfUILnwZRpGWNtwi79RTBMG+LxD49ABSBfTAPnFMaiNJpOupsIsxm/PIwvXthi836LC
	 y1G2INlxz64LGK97dektyFjxgpl0X6kqzlTsCmKUF01dQGItkCKqzpeu7eGaIgKxhjsWa
	 Mj8dFDBavrqqYkOh0cy+026FHpy4gOqh5JKHG/2CjJMlzT/i2/KayHMQwqnOEIDBvB8/w
	 tMuCteMtdIGKIx90mpVF60N/GkWjK22Q0cQzJhZiYtWTeB4hOBreFBa82mZp2mcoyDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Qct54+k0;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=K1ZRdjiP;
	arc=none smtp.remote-ip=103.168.172.154
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8675D606A31E
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 23:04:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8675D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Qct54+k0;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=K1ZRdjiP
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9F3EA140030A
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 18:04:04 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 24 Nov 2026 18:04:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795561444; x=1795647844; bh=84X6HG4TVE
	i4/dkK4N75re3NCaSB0tFWLv5/DEWpL+U=; b=Qct54+k0IxEI8Sxnibz/uhhxzH
	ZocfBbfUjmHqNnA8L+EYfDXgfZCDKHdRU+XpS+5mRMgmsXGl+4I49edQEErZu/7Z
	lQbFVF1lEw2/923X5M31uLB3PvOL3VWvLBzdVb8dWpeunaEeF6d7braihEkvKAXJ
	tboasTnUaNh4tXA4p60lXYjxCkCx5D+F3EMR1lvkHjw3H8el9q5iaolbgXlSHRK6
	dONUmZeWWPuGgB1XEt2J6EkQRAuLvIr08tNDl8QTdWzhFd77bn0BrKEJ/Wt2mFdc
	Xgs6jPsBz4K6+rUBUAitG4q2My79dMt/OpWf8XI6ooJ6KMQoMCtHM0NSILKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795561444; x=1795647844; bh=84X6HG4TVEi4/dkK4N75re3NCaSB0tFWLv5
	/DEWpL+U=; b=K1ZRdjiPhMTxui9r/Uk0UeahM8lcknguF8PRqEFyn6YCW0FlZkf
	/BTZL1aYJnAdn2Zy1E0EBSQ4VdOe5/43dCTZrjGbUrQjuJQmGxbKwhBrOf6IQZEG
	G5bS17yL9Chn0rXE6U7bSMOahYLygvEEtCws1fAmVFZp5qLirVhgmS7Wg8eCtlQp
	z2mkLOCDRIqoV1PCCF5XFQz9UhwipXbCemwR0r9t+H0emd+Cs+kNVCscuHI3Kyeb
	eNuDCAvjVKNBf9st7Sd83oUMKXYgkXcl81MZHGtWVarUdBYXXE+OsDQsIXs4yti5
	9Va8uWl5FF9gPCG+L0lNA0ckxxCY32HybFA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795561444; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:X+bMl6dKVbxeSK5ue69qTrM7zj31SBGLFEZkjM0GEqmRDWK
	O205HIxqjbSCqkvhXdVYaoHaK86z+Pnnu6HpuDmHzda/4vT3nq1QW4I1F6S7TC64
	pWtW0O89402CIAA2z1VJFg9FBwzjXcfv9YPQgjGSyb2B3PJ/GyTd0Lm+9nJvZ5kQ
	jmoqt2/kMssCOkowG7JaJUYoVk4fF61V0GGE6vZUy/QNeQEQ3r/VmuMid2RWJDKM
	cs5snjvMN5fuLa2Li+/ga01SBtuR2nu1HL1nxUDoE/fVtRb2sUIz65yqixRrF/1v
	XlwnoO3vp6rwvhp0sZMIsDYVdwscv6jerRyBoMw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:utkQjDFrX96nvBaAH1yk6tOwuWUTp4Ahbk97Z3G42Ss=:DLb0Jk+Mf3i5+YnDulo9M4M34Ro/tITgbSzJx6taoW8=;
X-ME-Sender: <xms:5BcGa3n6pXA4x5UOHsK0f6iXK3ZDSHPycJmlXQxRU5Ah2jrkCEFsNw>
    <xme:5BcGa9FfDuoSqz2kHUdCPjR2zA-kWTFe1_utKECrJWbzpuP_jHlb24U_QEIEU0101
    8DZ4IXxX0Y19Nmuzf3ezgSmU5yTZ7c62HHLMtVQRnHvnIDrCmnNiFbt>
X-ME-Received: <xmr:5BcGa_5tJBCDaprGOchO6NtNLBNGudKT3f5YXhwcsUIZzmZpxD_EgsspwNPylesk057V4PbUFf400DUQc717EtRhMOrXLcdetnLpB4E>
X-ME-Proxy-Cause: dmFkZTF7LtQUHx38KPVW3o/3jiHdwPNrxET1SyqOo6Wapa6FtDysk7AOA1o1MskESMTROe
    OAwo1X4Fp5NMpkigcUfvJ+VM8oZtqhVuLv/NnDYFmVu2Jb9KdqCtK02PoGc+j6YfTIkDsr
    GQu9u2r5wipmfMwcsflQjxtEIdfzznjY9Omhhk4oCqlhwBHjJ32E5HSxvcvEaKpW289E4o
    tc7IHnWZmtwZHb7lED/X3LE4XW7kr1cPC+qNricIsstQFw2jiSJyhikuzu3s5fGj+P+d73
    BgalOBTamKeeHyCeCjppdH/6Oqc+nqxRMR2oKlkuGR22QvVj9zt0fpiMP6Pcdla2QpCphl
    gDbQcCxBXy3G49EsNNkzHUkSfJqgPyFSpUj8t8wc/1fycI8wjJDMR9kSzbLQrrvLjaXLy8
    Z0e+2fDiJu3gZTrhnogkguXgvsNaGaEQrhwjVJHUSDk56npSUvG8fx7m4/eRN7jxYW2/Mf
    kEaOtU740UwPuW9Pltx2DxTBvr5dVFL6L4SuuoCgT0+F/OhZT2ID7csbLL/bwLaSQd/4qs
    3OmTZrXPs3/EOnpJUf2hoLU+S8koutGDLNz/AzE8iIYz6a4wSkP+ixBS3Q7D8GZLABzF+D
    bHnozzmqXwIoo2quRmSHu0xsrb+nqZXVLIZ47UHgagI23QIS3RDfLiVAL/KQ
X-ME-Proxy: <xmx:5BcGa1l3LNNmweLuTR9onlJ6JAMM9oz5QsKq-Lwli6Xt0Q9xMqjocw>
    <xmx:5BcGa0qb6VjV65v5efmQOE56zdedG0NwKn5BskxBx3hhg0-RuYPPjQ>
    <xmx:5BcGa0v6gGPXuRfYw7rkav40iVm7rq2444FgkVZLcEfFGxF1IkLuUA>
    <xmx:5BcGa5FPyHmgFonRrb9WuqtoJJmzTHMOSkRxHvkh5Jsma4PY7MBqpQ>
    <xmx:5BcGawFR6QeqEXADDgy9zp11SATczzxfPM2dWKPf8mwrhIHIkw8aao2Q>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 18:04:03 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Ravi Mistry via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>,
  Patrick Steinhardt <ps@pks.im>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  Ravi Mistry <rmistry@google.com>
Subject: Re: [PATCH v4 4/5] remote-curl: retry transient HTTP errors in
 post_rpc()
In-Reply-To: <ca247f390c8ecd2df20f7054f3357bf8da86bee2.1795103883.git.gitgitgadget@gmail.com>
	(Ravi Mistry via GitGitGadget's message of "Thu, 19 Nov 2026 15:58:02
	+0000")
References: <pull.2287.git.1793462224.gitgitgadget@gmail.com>
	<pull.2287.v4.git.1795103883.gitgitgadget@gmail.com>
	<ca247f390c8ecd2df20f7054f3357bf8da86bee2.1795103883.git.gitgitgadget@gmail.com>
Date: Tue, 24 Nov 2026 15:04:02 -0800
Message-ID: <xmqq4id5kf19.fsf@gitster.g>
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

"Ravi Mistry via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/Documentation/config/http.adoc b/Documentation/config/http.adoc
> index 726669e85c..72e9bf011d 100644
> --- a/Documentation/config/http.adoc
> +++ b/Documentation/config/http.adoc
> @@ -350,7 +350,9 @@ http.maxRetries::
>  	Maximum number of times to retry after receiving a retryable HTTP
>  	status code. The set of retryable status codes is configured by
>  	`http.retryStatusCodes`, which includes only HTTP 429 (Too Many
> -	Requests) by default. Set to 0 (the default) to disable retries.
> +	Requests) by default. Retries apply to HTTP GET requests and
> +	read-only smart-HTTP POST requests (`git-upload-pack` and
> +	`git-upload-archive`). Set to 0 (the default) to disable retries.
>  	Can be overridden by the `GIT_HTTP_MAX_RETRIES` environment variable.
>  	See also `http.retryAfter`, `http.maxRetryTime`, and
>  	`http.retryStatusCodes`.
> diff --git a/http.c b/http.c
> index 4b92819abd..f7f4af7a31 100644
> --- a/http.c
> +++ b/http.c
> @@ -2479,6 +2479,34 @@ static long handle_rate_limit_retry(long slot_retry_after, size_t attempt)
>  	}
>  }
>  
> +int http_retry_wait(long http_code, long slot_retry_after, size_t attempt)
> +{
> +	long retry_delay;
> +
> +	if (http_max_retries <= 0)
> +		return -1;
> +	if (attempt > (size_t)http_max_retries) {
> +		trace2_data_string("http", the_repository,
> +				   "http/429-error", "retries-exhausted");
> +		return -1;
> +	}
> +	retry_delay = handle_rate_limit_retry(slot_retry_after, attempt);
> +	if (retry_delay < 0)
> +		return -1;
> +	if (retry_delay > 0) {
> +		if (http_code == 429)
> +			warning(_("rate limited, waiting %ld seconds before retry"),
> +				retry_delay);
> +		else
> +			warning(_("HTTP %ld, waiting %ld seconds before retry"),
> +				http_code, retry_delay);
> +		trace2_data_intmax("http", the_repository,
> +				   "http/retry-sleep-seconds", retry_delay);
> +		sleep(retry_delay);
> +	}
> +	return 0;
> +}
> +
>  static int http_request_recoverable(const char *url,
>  			       void *result, int target,
>  			       struct http_get_options *options)
> @@ -2486,7 +2514,7 @@ static int http_request_recoverable(const char *url,
>  	static struct http_get_options empty_opts;
>  	int i = 3;
>  	int ret;
> -	int rate_limit_retries = http_max_retries;
> +	size_t attempt = 0;
>  
>  	if (!options)
>  		options = &empty_opts;
> @@ -2508,9 +2536,8 @@ static int http_request_recoverable(const char *url,
>  	}
>  
>  	while ((ret == HTTP_REAUTH && --i) ||
> -	       (ret == HTTP_RATE_LIMITED && http_max_retries > 0 &&
> -		rate_limit_retries-- > 0)) {
> -		long retry_delay = -1;
> +	       (ret == HTTP_RATE_LIMITED &&
> +		!http_retry_wait(options->http_code, options->retry_after, ++attempt))) {
>  		/*
>  		 * The previous request may have put cruft into our output stream; we
>  		 * should clear it out before making our next request.
> @@ -2535,37 +2562,15 @@ static int http_request_recoverable(const char *url,
>  		default:
>  			BUG("Unknown http_request target");
>  		}
> -		if (ret == HTTP_RATE_LIMITED) {
> -			retry_delay = handle_rate_limit_retry(
> -				options->retry_after,
> -				(size_t)(http_max_retries - rate_limit_retries));
> -			if (retry_delay < 0)
> -				return HTTP_ERROR;
> -
> -			if (retry_delay > 0) {
> -				if (options->http_code == 429)
> -					warning(_("rate limited, waiting %ld seconds before retry"),
> -						retry_delay);
> -				else
> -					warning(_("HTTP %ld, waiting %ld seconds before retry"),
> -						options->http_code, retry_delay);
> -				trace2_data_intmax("http", the_repository,
> -						   "http/retry-sleep-seconds", retry_delay);
> -				sleep(retry_delay);
> -			}
> -		} else if (ret == HTTP_REAUTH) {
> +		if (ret == HTTP_REAUTH)
>  			http_reauth_prepare(1);
> -		}
>  
>  		ret = http_request(url, result, target, options);
>  	}
> -	if (ret == HTTP_RATE_LIMITED) {
> -		if (http_max_retries <= 0)
> -			return HTTP_ERROR;
> -		trace2_data_string("http", the_repository,
> -				   "http/429-error", "retries-exhausted");
> -		return options->http_code == 429 ? HTTP_RATE_LIMITED : HTTP_ERROR;
> -	}
> +	if (ret == HTTP_RATE_LIMITED &&
> +	    (http_max_retries <= 0 || attempt <= (size_t)http_max_retries ||
> +	     options->http_code != 429))
> +		return HTTP_ERROR;
>  	return ret;
>  }
>  
> diff --git a/http.h b/http.h
> index 5985a0f71f..ec96b6d2c7 100644
> --- a/http.h
> +++ b/http.h
> @@ -201,6 +201,12 @@ int http_get_strbuf(const char *url, struct strbuf *result, struct http_get_opti
>  int http_get_file(const char *url, const char *filename,
>  		  struct http_get_options *options);
>  
> +/*
> + * Wait before retrying a transient HTTP error (1-based attempt count).
> + * Returns 0 if the caller should retry, or -1 to stop retrying.
> + */
> +int http_retry_wait(long http_code, long slot_retry_after, size_t attempt);
> +
>  int http_fetch_ref(const char *base, struct ref *ref);
>  
>  struct curl_slist *http_append_auth_header(const struct credential *c,
> diff --git a/remote-curl.c b/remote-curl.c
> index 2c35dd5240..b92f33609d 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -845,35 +845,22 @@ static size_t rpc_in(char *ptr, size_t eltsize,
>  	return size;
>  }
>  
> -static int run_slot(struct active_request_slot *slot,
> -		    struct slot_results *results)
> +static void report_rpc_error(struct slot_results *results)
>  {
> -	int err;
> -	struct slot_results results_buf;
> -
> -	if (!results)
> -		results = &results_buf;
> -
> -	err = run_one_slot(slot, results);
> -
> -	if (err != HTTP_OK && err != HTTP_REAUTH) {
> -		struct strbuf msg = STRBUF_INIT;
> -		if (results->http_code && results->http_code != 200)
> -			strbuf_addf(&msg, "HTTP %ld", results->http_code);
> -		if (results->curl_result != CURLE_OK) {
> -			if (msg.len)
> -				strbuf_addch(&msg, ' ');
> -			strbuf_addf(&msg, "curl %d", results->curl_result);
> -			if (curl_errorstr[0]) {
> -				strbuf_addch(&msg, ' ');
> -				strbuf_addstr(&msg, curl_errorstr);
> -			}
> +	struct strbuf msg = STRBUF_INIT;
> +	if (results->http_code && results->http_code != 200)
> +		strbuf_addf(&msg, "HTTP %ld", results->http_code);
> +	if (results->curl_result != CURLE_OK) {
> +		if (msg.len)
> +			strbuf_addch(&msg, ' ');
> +		strbuf_addf(&msg, "curl %d", results->curl_result);
> +		if (curl_errorstr[0]) {
> +			strbuf_addch(&msg, ' ');
> +			strbuf_addstr(&msg, curl_errorstr);
>  		}
> -		error(_("RPC failed; %s"), msg.buf);
> -		strbuf_release(&msg);
>  	}
> -
> -	return err;
> +	error(_("RPC failed; %s"), msg.buf);
> +	strbuf_release(&msg);
>  }
>  
>  static int probe_rpc(struct rpc_state *rpc, struct slot_results *results)
> @@ -899,13 +886,19 @@ static int probe_rpc(struct rpc_state *rpc, struct slot_results *results)
>  	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
>  	curl_easy_setopt(slot->curl, CURLOPT_WRITEDATA, &buf);
>  
> -	err = run_slot(slot, results);
> +	err = run_one_slot(slot, results);
>  
>  	curl_slist_free_all(headers);
>  	strbuf_release(&buf);
>  	return err;
>  }
>  
> +static int can_retry_rpc(const struct rpc_state *rpc)
> +{
> +	return !strcmp(rpc->service_name, "git-upload-pack") ||
> +	       !strcmp(rpc->service_name, "git-upload-archive");
> +}
> +
>  /*
>   * If flush_received is true, do not attempt to read any more; just use what's
>   * in rpc->buf.
> @@ -913,12 +906,15 @@ static int probe_rpc(struct rpc_state *rpc, struct slot_results *results)
>  static int post_rpc(struct rpc_state *rpc, int stateless_connect, int flush_received)
>  {
>  	struct active_request_slot *slot;
> +	struct slot_results results = { 0 };
>  	struct curl_slist *headers = NULL;
>  	int use_gzip = rpc->gzip_request;
>  	char *gzip_body = NULL;
>  	size_t gzip_size = 0;
>  	int err, large_request = 0;
>  	int needs_100_continue = 0;
> +	int can_retry = can_retry_rpc(rpc);
> +	size_t attempt = 0;
>  	struct rpc_in_data rpc_in_data;
>  
>  	/* Try to load the entire request, if we can fit it into the
> @@ -941,15 +937,18 @@ static int post_rpc(struct rpc_state *rpc, int stateless_connect, int flush_rece
>  	}
>  
>  	if (large_request) {
> -		struct slot_results results;
> -
>  		do {
>  			err = probe_rpc(rpc, &results);
>  			if (err == HTTP_REAUTH)
>  				http_reauth_prepare(0);
> -		} while (err == HTTP_REAUTH);
> -		if (err != HTTP_OK)
> +		} while (err == HTTP_REAUTH ||
> +			 (can_retry && err == HTTP_RATE_LIMITED &&
> +			  !http_retry_wait(results.http_code,
> +					   results.retry_after, ++attempt)));
> +		if (err != HTTP_OK) {
> +			report_rpc_error(&results);
>  			return -1;
> +		}
>  
>  		if (results.auth_avail & CURLAUTH_GSSNEGOTIATE || http_auth.authtype)
>  			needs_100_continue = 1;
> @@ -998,10 +997,11 @@ retry:
>  
>  	} else if (gzip_body) {
>  		/*
> -		 * If we are looping to retry authentication, then the previous
> -		 * run will have set up the headers and gzip buffer already,
> -		 * and we just need to send it.
> +		 * If we are looping to retry, then the previous run will
> +		 * have set up the gzip buffer already, and we just need to
> +		 * send it.
>  		 */
> +		headers = curl_slist_append(headers, "Content-Encoding: gzip");
>  		curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDS, gzip_body);
>  		curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDSIZE_LARGE, cast_size_t_to_curl_off_t(gzip_size));

Nice catch here.  The code down below before it jumps back to retry:
label called curl_slist_free_all(headers) and we have added the default
one, but haven't added back Content-Encoding, so we need to add it here.

> @@ -1066,14 +1066,20 @@ retry:
>  
>  
>  	rpc->any_written = 0;
> -	err = run_slot(slot, NULL);
> -	if (err == HTTP_REAUTH && !large_request) {
> -		http_reauth_prepare(0);
> +	err = run_one_slot(slot, &results);
> +	if (!large_request && !rpc->any_written &&
> +	    (err == HTTP_REAUTH ||
> +	     (can_retry && err == HTTP_RATE_LIMITED &&
> +	      !http_retry_wait(results.http_code, results.retry_after, ++attempt)))) {
> +		if (err == HTTP_REAUTH)
> +			http_reauth_prepare(0);
>  		curl_slist_free_all(headers);
>  		goto retry;
>  	}
> -	if (err != HTTP_OK)
> +	if (err != HTTP_OK) {
> +		report_rpc_error(&results);
>  		err = -1;
> +	}

Deferring report_rpc_error() until after the retry loops and guarding
with !large_request and !rpc->any_written ensures we neither print
spurious "RPC failed" errors for recovered attempts nor retry after
partial response data has been forwarded to rpc->in.

The variable result is initialized at the beginning of the function just
once, but is not reset before we retry.  Would it cause issues if
run_one_slot() returns early due to start_active_slot() failing (which I
presume would not cause finish_active_slot() to be called on it to
update slot's results)?  Just wondering if we need to somehow clear to
give a fresh results object to run_one_slot() here.


