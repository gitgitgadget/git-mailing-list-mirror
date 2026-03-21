Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01367BA34
	for <git@vger.kernel.org>; Sat, 21 Mar 2026 03:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774063841; cv=none; b=cZkKr6nws5UfoRQWo3NxdgQdJUAG1mES73HYdZ3hhRgjRyhMNmpNItezKQGMz4wy0cv0RS9mUQeS9ibJ9ORGPQH7cksfe5k1oTGMb62TedzcR8BeUJX63NtXMeTncsOhtYPISnWSe++dpJvMppHM83Je5z/eqQHO9pZRXtY6CrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774063841; c=relaxed/simple;
	bh=KWSf13VdxDXtiaqlA0TOOiaRYzOs6amA3wCKbdluvrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nDBsnbsa+eS6/2zGLvx5tPw/+wzVhsjdRYEbpNt5sHyz1uGDkHHAsMMn0AqmQfyd6UnURrcgZc1OzuUP9uMXGnniIi/sTfXHYBntgPFDE1JKAx5JTL5pMlFMFU1mctHdhOZQYzj489SX1FEUMACbFMmtQz7QHSHJuy2Jn9WFdKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=kLx1mkQB; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="kLx1mkQB"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-79a5fb98316so23492087b3.3
        for <git@vger.kernel.org>; Fri, 20 Mar 2026 20:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1774063839; x=1774668639; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CO2dhb6Hf4BIv9F39WMp4A+DDKljIADM4XcHIaKpzfw=;
        b=kLx1mkQB7FG2JIqNz6fpYIptNLBaaafL97B3sFaLusQPNbxyF49MvkDHyfB7V/cKAF
         7QMbTyV3Vo1lOXU4Y0tvPVE6HrqGInmiCIvshn7yJ2/nHMVQWtFLg6mJRcQ4QLDhnQa/
         WtAQSxnjx67zcSWm5irdHVdR+4TEI5CT0Ndy/5qzJeFOtSZlSWYhzWDIPghCAABCj5dz
         zkNea3lSNe7KduGoY7IuENFfWhn/FEGcfxNQJlLTKSulMUjOJXVxJQ/83Nmk2sV2S2D2
         SXHv9sXU64Wsxzt/TqyPXbYkwrU5kWYjvxt7JyKqb+y2WYlb2M0Misn455akCa3M2wmu
         //Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774063839; x=1774668639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CO2dhb6Hf4BIv9F39WMp4A+DDKljIADM4XcHIaKpzfw=;
        b=id9/B+scO2yQdZQZemJyCzbsmZxjDmw5T6piEkT3AIIbqk4BNV8panZszy9UfaHeVv
         ZgRqht2yIkUzlikIjVeYUKcXh/AH4vJlrJI8e8FVs58WjbQTUuwg+FlHifWzHaYO5bcE
         hXOHjVsohCWhgHjSOSmTzrragJYCulQGVE7qieTw2oVNOlcZPuB/IOsfRO8gGh4IewHz
         P1GsghHu0EZqNjbpJ4rJpuo87/PvUUjCw/wkP5mz6YEqglBo8GPTzmR+jgL3dbrNF5K6
         +RQOMl1htWKIttIeAgxcrxy7bJPECazbMmGHHt2A1/2njJOe5w0mUC1Dv81luFcccaLM
         iTdg==
X-Gm-Message-State: AOJu0YyHoygTjwKOddub9oyxwZfFO7b5sERgJ0zUxXycxSXCxxAIQbxA
	DJhGKy7P3x+kZhhfF6UZdfShCkCVTTnFYtLCpe4VU+1ZycP3AkmEHnhh83fDiuJ1jck=
X-Gm-Gg: ATEYQzx3QmPFqOZupYY1m1OFPgIGDfK42Ary5zQhlFV0i8DIq2wYkDzdFeVY+1f06yF
	CTEZRtbfFThkzgLB/hBQdVO0CHhNcDxh73iULeX0PqSHCsZos/frJkJdkbbFlyZtlprAp3pPeyq
	hCSApZCgUo+jA8NBGFIlQh8bMqkzyeUzoVN+Su2MhKXukFGNpRP7P9pzzJQQZfrrAi+usyaG8Q8
	qU8YHIk7WbofJpYLfd7B3XRisLA7mz6aXttaZ35Xewv360YdY1vPieNVQeDO//1gVO42QdyyVjQ
	HeSUcxUE0kO1ZrZaW6p0Z9Dvjwzv+6Sddsswum5gFVU7TIOL4JenVeiSv5F2aFljXOm09+wSMky
	JmyJ5I5Z0HWD+/Drni3Zirfb52SylakwCIZudmjYHCb+1YlP8wO0CEFF7SeOMlIVawBCXLYss2l
	dIwcaLbuzQ5GXYsU4dIO77j3lg+Z0iGEXmUZ4dpNjrrWfka6gi7l9IbsI/sxtuFB2DOeu6YygpV
	A0NX9W2pWNFioxFFj0Mzd12XOh5aCyXHsMTyaNY
X-Received: by 2002:a05:690c:c50f:b0:79a:62a2:b377 with SMTP id 00721157ae682-79a90b7ebc8mr57297157b3.31.1774063838932;
        Fri, 20 Mar 2026 20:30:38 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79a905c1484sm26215227b3.49.2026.03.20.20.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 20:30:38 -0700 (PDT)
Date: Fri, 20 Mar 2026 23:30:33 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Vaidas Pilkauskas via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>
Subject: Re: [PATCH v6 3/3] http: add support for HTTP 429 rate limit retries
Message-ID: <ab4Q2XMQIaOYDjPw@nand.local>
References: <pull.2008.v5.git.1771856405.gitgitgadget@gmail.com>
 <pull.2008.v6.git.1773752435.gitgitgadget@gmail.com>
 <3418f4553d246c797697c80f439c77fee293f7e0.1773752435.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3418f4553d246c797697c80f439c77fee293f7e0.1773752435.git.gitgitgadget@gmail.com>

On Tue, Mar 17, 2026 at 01:00:35PM +0000, Vaidas Pilkauskas via GitGitGadget wrote:
>  	return size && (*ptr == ' ' || *ptr == '\t');
>  }
>
> -static size_t fwrite_wwwauth(char *ptr, size_t eltsize, size_t nmemb, void *p UNUSED)
> +static size_t fwrite_wwwauth(char *ptr, size_t eltsize, size_t nmemb, void *p MAYBE_UNUSED)
>  {
>  	size_t size = eltsize * nmemb;
>  	struct strvec *values = &http_auth.wwwauth_headers;
> @@ -575,6 +582,21 @@ static int http_options(const char *var, const char *value,

Good, this version drops the special case where we do not define
GIT_CURL_HAVE_CURLINFO_RETRY_AFTER, which Peff suggested in his review
of the earlier round.

I agree with his suggestion that we can document that handling
Retry-After requires a libcurl newer than 7.66.0, and that is well
documented in the user-facing documentation and code comments where
appropriate.

> @@ -2119,10 +2150,10 @@ static void http_opt_request_remainder(CURL *curl, off_t pos)
>
>  static int http_request(const char *url,
>  			void *result, int target,
> -			const struct http_get_options *options)
> +			struct http_get_options *options)

The previous round had this as a const pointer, with a separate
out-parameter via 'long *retry_after_out'. Review on the previous round
suggested making the retry_after part of the existing out-parameter. Of
course, doing so requires that we make that parameter non-const, hence
the change here, which looks good to me.

>  {
>  	struct active_request_slot *slot;
> -	struct slot_results results;
> +	struct slot_results results = { .retry_after = -1 };

This also moved from run_one_slot(); this location makes more sense to
me.

> diff --git a/http.h b/http.h
> index f9d4593404..f9ee888c3e 100644
> --- a/http.h
> +++ b/http.h
> @@ -20,6 +20,7 @@ struct slot_results {
>  	long http_code;
>  	long auth_avail;
>  	long http_connectcode;
> +	long retry_after;
>  };
>
>  struct active_request_slot {
> @@ -157,6 +158,13 @@ struct http_get_options {
>  	 * request has completed.
>  	 */
>  	struct string_list *extra_headers;
> +
> +	/*
> +	 * After a request completes, contains the Retry-After delay in seconds
> +	 * if the server returned HTTP 429 with a Retry-After header (requires
> +	 * libcurl 7.66.0 or later), or -1 if no such header was present.
> +	 */
> +	long retry_after;

I think making this a pure long instead of a pointer as is the case with
other members of this struct makes sense for the reasons that Peff
pointed out in the review of the previous round.

Thanks,
Taylor
