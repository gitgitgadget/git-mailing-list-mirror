Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968F221C165
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 22:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742423027; cv=none; b=GzrQvIle5F6xavqcqSRySZwk4llZfDeKsv0wUfK+3UcIp93H6tdAnJR4PT2YTJZCaXAGNd4cY9XMMpwyvWL/g6ulTYDr1F1wZTjRbVL/H5DkMQM4fCvteXqXIu/OoOPdYZAofpG6NRk+AW5SfSCEGK+cLp7zpC4bad6RF9jcpyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742423027; c=relaxed/simple;
	bh=k9cATOkCZiV/6nvvlgLvRcqLKxjOx5VhiwbrEA9Y44Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nTcRqX3USXKSYie8AMPn6oNlfApPGuFozXKWr0yaruhmJf+M8IbTC4SoIKPN1JaCf5kYwiptI+VvXd+O6SZX/etydbWrxJCD0aj6LbmINzl1pgEFNJymrxj5AGa+ao2OytF3QHzijSRu2OwnGZfcZ5wrrsxUZ0PFfvgf490ENtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=rfjNe33z; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="rfjNe33z"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c592764e54so22429685a.3
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 15:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742423024; x=1743027824; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DcOeaXxeKHiVndMYVLxOGtFIu55QLxoZbE2SGrBR9tU=;
        b=rfjNe33zOHY3NNj1oSTuR1g6UvInBcF2GjFkNbsXfgEzUYKuRUUe/sWHs+5IXjCXcb
         xw1BMR+S827Iq61h6NvshoP9pZvd/21QcCnQPKQYDthfnz4JVh0GgoLtIhKmynmDRVRs
         Jx3m/U8nLbZNwQqGrx4fd9LaqqK2ITfwbOulyDGS/mEdeTfRROvPRSnCe7nrnv33akM5
         AJyXHLHci8tcuKLg9jKrZIgtd32Ly57UWMO8rmg5YI0a0Tp+hTX29gkGlaBntb3FtVmd
         SDIjAhb6GxfSFhxAzCfsRe89dLD1zo/LMngudhvwDNoJYa/TPE2mqMDPNfD6+WUrmWV+
         CGFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742423024; x=1743027824;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DcOeaXxeKHiVndMYVLxOGtFIu55QLxoZbE2SGrBR9tU=;
        b=jIW4Ha5+GPSNKSiobcx/If/9aPTp0faU6Z/K4zaiO33Ba1KUTK8FqwxnzD+OEeFzBK
         xoOdGOgLBOlb+ULYPUBIywBhU1gF0AgMP+s8vz3T86OC7vJMfe8frASvqlCJK+5P05F4
         QoKb8Lh7Y7Ir/L8iyxbe9o+sw44ezg6OEOyFGnr6HDbI/wvq/D5zx2Zi3u8ryzbks5hN
         Czd5Set2CDtVxrOSR84F4J7v0blBSXdhaVf+ggytIXQpVMdJNW7db7+eba3t43SMpt1N
         xypGJ1ZJ6XSoyvvr5DZaPEWG2KqVJ4x97LUYR7bCiZBxfRxzVJkt2TVmvWBqEp3aa9Bs
         c+Ug==
X-Gm-Message-State: AOJu0Yy37kT1Y7/biil6x8N6xMkVyXg83r/gt3xfG+er01Pq6wcPzVLR
	FDo7O+5TBKfX1hAwLKP0RXpOuSRFkYQZxS0qSckacAGx2tgoQxXWSiAYx9GDik1B4fhbJnLSKO+
	mDnU=
X-Gm-Gg: ASbGncuyb/aJhXoCLK0ZsAh4ofS0hwXIh0sSRDXURGGLXXqhp5sax4eF7jH+b2rU/Yh
	UyWa01aazI8HmhKmU5kIvI6RL9KaTQqtl59z0sOW455HEvJNtx4EB8cDvkKISWUOc3edpnUb7Am
	aNpY1dJRyYalVXPigzmltESDy1MW2B0kYmg2MMgrz0wSzfts7o1dSDlWP5ZE4nXw7kWvHHd8h2W
	AkmEyCk284ERLJ2vYGmekAhtuGeiut36tVXXYg4zkfsoc750VpB6hpM51a+K6uB7TMzuGC3F5N/
	HS63OqRmCdg3r24gdmdleAfB8K4GpjmfYUc5GmSEPfwxwM/hJ9XLlpLOF+v9h/htDoueaUvkeEg
	5PFj1E4VfFH3YAxaQ
X-Google-Smtp-Source: AGHT+IEzdi3+tOpxMcnl4HSrsWGDzdtBlu75IBvobJpm2NK4hGuGC/foZwRqeSwpDKeaTcGgXtlujg==
X-Received: by 2002:a05:620a:3181:b0:7c5:55f9:4bcc with SMTP id af79cd13be357-7c5b0d0771fmr133225185a.44.1742423024332;
        Wed, 19 Mar 2025 15:23:44 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c573d8a062sm909473085a.94.2025.03.19.15.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 15:23:43 -0700 (PDT)
Date: Wed, 19 Mar 2025 18:23:42 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/4] http: support fine-tuning curl's keepalive behavior
Message-ID: <cover.1742423021.git.me@ttaylorr.com>
References: <cover.1742336481.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1742336481.git.me@ttaylorr.com>

Here's a reroll of my series to introduce new http.* knobs to control
curl's TCP keepalive behavior.

This reroll is mostly minor, with the notable differences being limited
to:

  - Added error handling in the new http.c::set_long_from_env().

  - Removed unnecessary casts from int -> long.

  - Only set CURLOPT_TCP_KEEPCNT when compiled with a version of curl
    that knows about that option to begin with (>8.9.0).

As usual, a range-diff is included below for convenience. Thanks again
for reviewing!

== Original cover letter

This short series introduces a few new http.* configuration options to
control curl's behavior around TCP keepalive packets. The details are
spelled out in the final patch, but the gist is:

  - http.keepAliveIdle specifies how long in seconds to wait on an idle
    connection before beginning to send keepalive packets.

  - http.keepAliveInterval does the same but controls the interval
    between successive keepalive packets.

  - http.keepAliveCount specifies how many keepalive packets to send
    before closing down the connection.

The first two commits of the series are general code clean-up of a
couple of small things I noticed while reading through the http.c code,
and the final patch implements these new options.

I couldn't think of a great way to test these new configuration
settings, and given the simplicity of the final patch I opted for no
tests there. But if someone has a good idea of how to test this
behavior, please let me know.

In either case, thanks in advance for your review!

Taylor Blau (4):
  http.c: remove unnecessary casts to long
  http.c: introduce `set_long_from_env()` for convenience
  http.c: inline `set_curl_keepalive()`
  http.c: allow custom TCP keepalive behavior via config

 Documentation/config/http.adoc | 18 ++++++++
 git-curl-compat.h              |  7 ++++
 http.c                         | 75 ++++++++++++++++++++++++++--------
 3 files changed, 84 insertions(+), 16 deletions(-)

Range-diff against v1:
-:  ---------- > 1:  204e5e18d2 http.c: remove unnecessary casts to long
1:  ba22a121fa ! 2:  2e39a78e87 http.c: introduce `set_long_from_env()` for convenience
    @@ Commit message
         Replace those two instances with a new cousin of 'set_from_env()' called
         'set_long_from_env()', which does what its name suggests. This allows us
         to remove the temporary variables and clean up some minor code
    -    duplication. More importantly, however, it prepares us for a future
    -    commit which will introduce more instances of assigning an environment
    -    variable to a long.
    +    duplication while also adding more robust error handling.
    +
    +    More importantly, however, it prepares us for a future commit which will
    +    introduce more instances of assigning an environment variable to a long.
     
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
    @@ http.c: static void set_from_env(char **var, const char *envname)
     +static void set_long_from_env(long *var, const char *envname)
     +{
     +	const char *val = getenv(envname);
    -+	if (val)
    -+		*var = strtol(val, NULL, 10);
    ++	if (val) {
    ++		long tmp;
    ++		char *endp;
    ++		int saved_errno = errno;
    ++
    ++		errno = 0;
    ++		tmp = strtol(val, &endp, 10);
    ++
    ++		if (errno)
    ++			warning_errno(_("failed to parse %s"), envname);
    ++		else if (*endp || endp == val)
    ++			warning(_("failed to parse %s"), envname);
    ++		else
    ++			*var = tmp;
    ++
    ++		errno = saved_errno;
    ++	}
     +}
     +
      void http_init(struct remote *remote, const char *url, int proactive_auth)
2:  a05269552f = 3:  cdfc9baa8d http.c: inline `set_curl_keepalive()`
3:  d840415808 ! 4:  3fe62181e5 http.c: allow custom TCP keepalive behavior via config
    @@ Commit message
         keepalive behavior, expose configuration and environment variables which
         allow setting curl's KEEPIDLE, KEEPINTVL, and KEEPCNT options.
     
    +    Note that while KEEPIDLE and KEEPINTVL were added in curl 7.25.0,
    +    KEEPCNT was added much more recently in curl 8.9.0. Per f7c094060c
    +    (git-curl-compat: remove check for curl 7.25.0, 2024-10-23), both
    +    KEEPIDLE and KEEPINTVL are set unconditionally. But since we may be
    +    compiled with a curl that isn't as new as 8.9.0, only set KEEPCNT when
    +    we have CURLOPT_TCP_KEEPCNT to begin with.
    +
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
      ## Documentation/config/http.adoc ##
    @@ Documentation/config/http.adoc: http.lowSpeedLimit, http.lowSpeedTime::
      	A boolean which disables using of EPSV ftp command by curl.
      	This can be helpful with some "poor" ftp servers which don't
     
    + ## git-curl-compat.h ##
    +@@
    + #define GIT_CURL_HAVE_CURLOPT_PROTOCOLS_STR 1
    + #endif
    + 
    ++/**
    ++ * CURLOPT_TCP_KEEPCNT was added in 8.9.0, released in July, 2024.
    ++ */
    ++#if LIBCURL_VERSION_NUM >= 0x080900
    ++#define GIT_CURL_HAVE_CURLOPT_TCP_KEEPCNT
    ++#endif
    ++
    + #endif
    +
      ## http.c ##
     @@ http.c: static struct {
      };
    @@ http.c: static int http_options(const char *var, const char *value,
      	}
      
     +	if (!strcmp("http.keepaliveidle", var)) {
    -+		curl_tcp_keepidle = (long)git_config_int(var, value, ctx->kvi);
    ++		curl_tcp_keepidle = git_config_int(var, value, ctx->kvi);
     +		return 0;
     +	}
     +	if (!strcmp("http.keepaliveinterval", var)) {
    -+		curl_tcp_keepintvl = (long)git_config_int(var, value, ctx->kvi);
    ++		curl_tcp_keepintvl = git_config_int(var, value, ctx->kvi);
     +		return 0;
     +	}
     +	if (!strcmp("http.keepalivecount", var)) {
    -+		curl_tcp_keepcnt = (long)git_config_int(var, value, ctx->kvi);
    ++		curl_tcp_keepcnt = git_config_int(var, value, ctx->kvi);
     +		return 0;
     +	}
     +
    @@ http.c: static CURL *get_curl_handle(void)
     +	if (curl_tcp_keepintvl > -1)
     +		curl_easy_setopt(result, CURLOPT_TCP_KEEPINTVL,
     +				 curl_tcp_keepintvl);
    ++#ifdef GIT_CURL_HAVE_CURLOPT_TCP_KEEPCNT
     +	if (curl_tcp_keepcnt > -1)
     +		curl_easy_setopt(result, CURLOPT_TCP_KEEPCNT, curl_tcp_keepcnt);
    ++#endif
     +
      	return result;
      }

base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
-- 
2.49.0.4.ge59cf92f8d
