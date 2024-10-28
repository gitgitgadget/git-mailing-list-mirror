Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E091DF254
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 16:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730133939; cv=none; b=K48BuUrQTsGG5IZwD+8WMtGyXxuyHEM4MKav89ryM5K1JjsNQDXppavfllUa3RLd1FGDQhsErp01t3Z0AEwEAijxSEmHjT8EQM2vfpvE7bDKPBuHXMm4isYQHL6GEGeFGsuZRdK2ixKe99JAsR/D0QYxZ+IEEmgso3RzPTnP8VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730133939; c=relaxed/simple;
	bh=ymzJxWR2Hl3Wq7nytTz4329ywKl3yBB0wgTyS0yPFBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=avNITYh1hV966ewPj0dNeSTHtOwB7GtBvT6rPt1Wlna9+rWKUF9Q/RF+xO2Ae4J3ZdDLA9PYd2lbWIhy4ArVWEcusQfj8UigEngjkoQcK2LTvQsEH0D68iVR3udWDZaw+1Ur5vRtXioPUMc/1JfJvq+i55bqWpHu7X/IiiExF0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=ryKoZnXb; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ryKoZnXb"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b148919e82so367609485a.0
        for <git@vger.kernel.org>; Mon, 28 Oct 2024 09:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730133935; x=1730738735; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MXScIGtgzm0+LKtyDd5dGAuasxaMBD3vlU47Hh8TbBY=;
        b=ryKoZnXbuF1q669flk3+zcfeeX7bhPbDMOnRH65xEYkeZFcprrQdlak+N614P0gcwb
         wEs8dDcUmFoBk+J3A/vkR1LwQXAm/EIT5k4xvCKjR20ttBF1tbpu1HiWwlnG/isjdlxW
         ZQYcXT+Eiz7c4b+5mrL5M9ddH+ta0oR+kN+QYHy0Sn0tZeGLcyggOUYCyCKUn53Ae09U
         ZIRS1Y22ZatDB0BgnIpKZOZ/LnS1qg2QeEZqw8pisf0zpjCUFeVXYX+KiPHUfe7SWgu2
         0uwixg+VbolVJ6KDcwDAsQWOd0OtKthJ7nMS0tX4xV/4lt3iffOQTT8XAtvXYpWRz8FO
         xDGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730133935; x=1730738735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MXScIGtgzm0+LKtyDd5dGAuasxaMBD3vlU47Hh8TbBY=;
        b=KKEPws3kQWKrYzwQzht7fDkr8XnF7ynvxgt5MG0xtDWSqez7K7Y/pGSGOf5T6xmRLo
         b9W5huAjicMOjlHbO8xPqWGPh71VhZ0P0tQu/XVHisTXwR+gAZN/z3PzvkZ6DBxsi9lw
         bMg0Shk5vhjw0v5wsK8ZiO7Z0dzlOeIH0d9+yFQjZzEY2j0fjwKencb1bEynLI9NQtiv
         3q9b2ZiAV2oMJu/EjJxcOfEjrgTjiks873MR8H9u/Hr1WsiZ2P7Xj3Uy0HSofc/0jqFz
         rzP47sZ5OqCGijDqBlAQTHCCVCv6mgP1W+Hgq5ZPnpC70fAK8Yjz46nmkHFpakAPklaa
         QL4g==
X-Gm-Message-State: AOJu0YzS7yzCjff2TI/bizyGc8SL3k3JlPtJUbVdyrNtRd/QMyZodHe2
	Busz64WzuC/oNvL48Bq66/2hEDOv9HwNRYkudxqy1DQw1egLO5ixJJu07GF8zY03EWOkZpqdS0j
	X1o8=
X-Google-Smtp-Source: AGHT+IF/Zh9yn8wZ0GWAv9WKOn6Hlcul3zhVToQ4ddqsLOgVg6QTPzlvtRnfKTBkWmVlcUy6WRZ/Lg==
X-Received: by 2002:ac8:5dcc:0:b0:461:13a:b0e9 with SMTP id d75a77b69052e-461646cee6cmr1098301cf.50.1730133935655;
        Mon, 28 Oct 2024 09:45:35 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-461323a6862sm35857001cf.92.2024.10.28.09.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 09:45:35 -0700 (PDT)
Date: Mon, 28 Oct 2024 12:45:32 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 8/8] config: make `packed_git_(limit|window_size)`
 non-global variables
Message-ID: <Zx+/rEB8RklP359p@nand.local>
References: <cover.1730122499.git.karthik.188@gmail.com>
 <e99b1dad549bb1e87011d8722b8582172390aa04.1730122499.git.karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e99b1dad549bb1e87011d8722b8582172390aa04.1730122499.git.karthik.188@gmail.com>

On Mon, Oct 28, 2024 at 02:43:46PM +0100, Karthik Nayak wrote:
> The variables `packed_git_window_size` and `packed_git_limit` are global
> config variables used in the `packfile.c` file. Since it is only used in
> this file, let's change it from being a global config variable to a
> local variable for the subsystem.
>
> We do this by introducing a new local `packfile_config` struct in
> `packfile.c` and also adding the required function to parse the said
> config. We then use this within `packfile.c` to obtain the variables.
>
> With this, we rid `packfile.c` from all global variable usage and this
> means we can also remove the `USE_THE_REPOSITORY_VARIABLE` guard from
> the file.

Ahh. Now the motivation of the previous patch is clearer. Have you
considered hinting at the motivation here in the previous commit message
(e.g., "this gets us part of the way towards ...")?

> diff --git a/environment.c b/environment.c
> index 8e5022c282..8389a27270 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -49,8 +49,6 @@ int fsync_object_files = -1;
>  int use_fsync = -1;
>  enum fsync_method fsync_method = FSYNC_METHOD_DEFAULT;
>  enum fsync_component fsync_components = FSYNC_COMPONENTS_DEFAULT;
> -size_t packed_git_window_size = DEFAULT_PACKED_GIT_WINDOW_SIZE;
> -size_t packed_git_limit = DEFAULT_PACKED_GIT_LIMIT;

Very satisfying :-).

> +struct packfile_config {
> +	unsigned long packed_git_window_size;
> +	unsigned long packed_git_limit;
> +};
> +
> +#define PACKFILE_CONFIG_INIT \
> +{ \
> +	.packed_git_window_size = DEFAULT_PACKED_GIT_WINDOW_SIZE, \
> +	.packed_git_limit = DEFAULT_PACKED_GIT_LIMIT,  \

s/,  /, /

> +static int packfile_config(const char *var, const char *value,
> +			   const struct config_context *ctx, void *cb)
>  {
> +	struct packfile_config *config = cb;
> +
> +	if (!strcmp(var, "core.packedgitwindowsize")) {
> +		int pgsz_x2 = getpagesize() * 2;
> +		config->packed_git_window_size = git_config_ulong(var, value, ctx->kvi);
> +
> +		/* This value must be multiple of (pagesize * 2) */
> +		config->packed_git_window_size /= pgsz_x2;
> +		if (config->packed_git_window_size < 1)
> +			config->packed_git_window_size = 1;
> +		config->packed_git_window_size *= pgsz_x2;
> +		return 0;
> +	}
> +
> +	if (!strcmp(var, "core.packedgitlimit")) {
> +		config->packed_git_limit = git_config_ulong(var, value, ctx->kvi);
> +		return 0;
> +	}
> +
> +	return git_default_config(var, value, ctx, cb);
> +}

I get that this was copy/pasted from elsewhere, but it would be nice to
replace the "every if statement ends in 'return 0' to keep them mutually
exclusive" with else if statements instead:

--- 8< ---
diff --git a/packfile.c b/packfile.c
index cfbfcdc2b8..c8af29bf0a 100644
--- a/packfile.c
+++ b/packfile.c
@@ -72,15 +72,11 @@ static int packfile_config(const char *var, const char *value,
 		if (config->packed_git_window_size < 1)
 			config->packed_git_window_size = 1;
 		config->packed_git_window_size *= pgsz_x2;
-		return 0;
-	}
-
-	if (!strcmp(var, "core.packedgitlimit")) {
+	} else if (!strcmp(var, "core.packedgitlimit")) {
 		config->packed_git_limit = git_config_ulong(var, value, ctx->kvi);
-		return 0;
+	} else {
+		return git_default_config(var, value, ctx, cb);
 	}
-
-	return git_default_config(var, value, ctx, cb);
 }
--- >8 ---

> +
> +

Extra newline here (after the definition of packfile_config())?

The rest all looks good.

Thanks,
Taylor
