Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118001CF86
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 19:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="uGFzc5Ug"
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ECE594
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 12:29:49 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-7781bc3783fso260015085a.1
        for <git@vger.kernel.org>; Mon, 23 Oct 2023 12:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1698089388; x=1698694188; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dZxjw2xahgbZhO+zciJ2y+G7Win8kWAXF6pZo/kmF1Y=;
        b=uGFzc5UgD7lIEx9ea3XARjm6LgQ8KrjuNcGS0gO7ccVipN94q8h2R56bZzLdDbkJ0n
         S+GQ8rjUUxdBRSS465bm34A+jMFKenXpwcf0Fn3LeVJKe57q4zYi9oLCuCfS/CP3Kk3E
         y4RSD1iNkmz9HWEt/DBcFR4xNt2AWekikSkVjXFsqynVONw4VGGHt2U+ly95gEwEE+RF
         YCVQ5lGCNoDRQ1E30UOCVa93aFBsUPEPpyb+Bx37gfg/AJe7SM+HRlxrZNMWg+JzKXY3
         DxXuzcYCWa56PIJruZ+UgxahAwUrDyWvmR0TQ5Q0VuIoM0XSpyeDk6VXlouhTtImDUmu
         296Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698089388; x=1698694188;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dZxjw2xahgbZhO+zciJ2y+G7Win8kWAXF6pZo/kmF1Y=;
        b=a0BUuKkbq9ET6Q6HZ3T0Fj6W/zF04KZy6BL9LQrUqM8NQ5ooKsbwaWSFvg5u/OLy5A
         tw8slhxZkruJQcwsne++dkB/VKU96CgMLlqaZlor9c8afDGKay28zBXbSvVcU0RXI7he
         BeI+deBDbTu/WiYPObd+BoHLr4Ur2WZhRCtqsJsZYOpKA/RH9sVCc9qnR0KUFi0a7HYe
         /0fthIXLvRL9t72wVWVO1xFnDqnp5yj/ezikaGRSo9b+XOd2WbTm69nefT2CvU9gg+HG
         bKBWrNxe3U7SQjVft1dB61xHetMgbrVA6NLGdoQyxs57/CAEx1lahhZJH1xyNbze1mYB
         Up2Q==
X-Gm-Message-State: AOJu0YxMY07bLRsstFz9TNFAl7paG1kb6+MAkzDW2FWnzSzoZdkMD7We
	/XrS52mB8uU6pq+XwQiDpoUOBg==
X-Google-Smtp-Source: AGHT+IGbnQts64WMayBCZ6F90HiAojsS3vRWiSBpYM2EQNSRjyVyMVXs7zIaOG5AjeM+ZXHzkenJvQ==
X-Received: by 2002:a05:620a:244a:b0:779:e93f:b3c4 with SMTP id h10-20020a05620a244a00b00779e93fb3c4mr457079qkn.36.1698089388590;
        Mon, 23 Oct 2023 12:29:48 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o14-20020a05620a110e00b00775ab978009sm2938197qkk.36.2023.10.23.12.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 12:29:48 -0700 (PDT)
Date: Mon, 23 Oct 2023 15:29:47 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org, jonathantanmy@google.com, calvinwan@google.com,
	glencbz@gmail.com, gitster@pobox.com
Subject: Re: [PATCH v3 3/5] config: report config parse errors using cb
Message-ID: <ZTbJqzWDyqkhc6L9@nand.local>
References: <pull.1551.git.git.1689891436.gitgitgadget@gmail.com>
 <cover.1695330852.git.steadmon@google.com>
 <a888045c04d27864edf5751ea8641fdba596779c.1695330852.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a888045c04d27864edf5751ea8641fdba596779c.1695330852.git.steadmon@google.com>

On Thu, Sep 21, 2023 at 02:17:22PM -0700, Josh Steadmon wrote:
> diff --git a/bundle-uri.c b/bundle-uri.c
> index f93ca6a486..856bffdcad 100644
> --- a/bundle-uri.c
> +++ b/bundle-uri.c
> @@ -237,9 +237,7 @@ int bundle_uri_parse_config_format(const char *uri,
>  				   struct bundle_list *list)
>  {
>  	int result;
> -	struct config_parse_options opts = {
> -		.error_action = CONFIG_ERROR_ERROR,
> -	};
> +	struct config_parse_options opts = CP_OPTS_INIT(CONFIG_ERROR_ERROR);

I'm nit-picking, but I find this parameterized initializer macro to be a
little unusual w.r.t our usual conventions.

In terms of "usual conventions," I'm thinking about STRING_LIST_INIT_DUP
versus STRING_LIST_INIT_NODUP (as opposed to something like
STRING_LIST_INIT(DUP) or STRING_LIST_INIT(NODUP)).

Since there are only two possible values (the ones corresponding to
error() and die()) I wonder if something like CP_OPTS_INIT_ERROR and
CP_OPTS_INIT_DIE might be more appropriate. If you don't like either of
those, I'd suggest making the initializer a function instead of a
parameterized macro.

>  	if (!list->baseURI) {
>  		struct strbuf baseURI = STRBUF_INIT;
> diff --git a/config.c b/config.c
> index ff138500a2..0c4f1a2874 100644
> --- a/config.c
> +++ b/config.c
> @@ -55,7 +55,6 @@ struct config_source {
>  	enum config_origin_type origin_type;
>  	const char *name;
>  	const char *path;
> -	enum config_error_action default_error_action;
>  	int linenr;
>  	int eof;
>  	size_t total_len;
> @@ -185,13 +184,15 @@ static int handle_path_include(const struct key_value_info *kvi,
>  	}
>
>  	if (!access_or_die(path, R_OK, 0)) {
> +		struct config_parse_options config_opts = CP_OPTS_INIT(CONFIG_ERROR_DIE);
> +
>  		if (++inc->depth > MAX_INCLUDE_DEPTH)
>  			die(_(include_depth_advice), MAX_INCLUDE_DEPTH, path,
>  			    !kvi ? "<unknown>" :
>  			    kvi->filename ? kvi->filename :
>  			    "the command line");
>  		ret = git_config_from_file_with_options(git_config_include, path, inc,
> -							kvi->scope, NULL);
> +							kvi->scope, &config_opts);

...OK, so using the CONFIG_ERROR_DIE variant seems like the right choice
here because git_config_from_file_with_options() calls
do_config_from_file() which sets its default_error_action as
CONFIG_ERROR_DIE.

>  static uintmax_t get_unit_factor(const char *end)
> @@ -2023,7 +2052,6 @@ static int do_config_from_file(config_fn_t fn,
>  	top.origin_type = origin_type;
>  	top.name = name;
>  	top.path = path;
> -	top.default_error_action = CONFIG_ERROR_DIE;
>  	top.do_fgetc = config_file_fgetc;
>  	top.do_ungetc = config_file_ungetc;
>  	top.do_ftell = config_file_ftell;
> @@ -2037,8 +2065,10 @@ static int do_config_from_file(config_fn_t fn,
>  static int git_config_from_stdin(config_fn_t fn, void *data,
>  				 enum config_scope scope)
>  {
> +	struct config_parse_options config_opts = CP_OPTS_INIT(CONFIG_ERROR_DIE);
> +
>  	return do_config_from_file(fn, CONFIG_ORIGIN_STDIN, "", NULL, stdin,
> -				   data, scope, NULL);
> +				   data, scope, &config_opts);

Same here.

>  int git_config_from_file_with_options(config_fn_t fn, const char *filename,
> @@ -2061,8 +2091,10 @@ int git_config_from_file_with_options(config_fn_t fn, const char *filename,
>
>  int git_config_from_file(config_fn_t fn, const char *filename, void *data)
>  {
> +	struct config_parse_options config_opts = CP_OPTS_INIT(CONFIG_ERROR_DIE);
> +
>  	return git_config_from_file_with_options(fn, filename, data,
> -						 CONFIG_SCOPE_UNKNOWN, NULL);
> +						 CONFIG_SCOPE_UNKNOWN, &config_opts);
>  }

And here.

> @@ -2098,6 +2129,7 @@ int git_config_from_blob_oid(config_fn_t fn,
>  	char *buf;
>  	unsigned long size;
>  	int ret;
> +	struct config_parse_options config_opts = CP_OPTS_INIT(CONFIG_ERROR_ERROR);
>
>  	buf = repo_read_object_file(repo, oid, &type, &size);
>  	if (!buf)
> @@ -2108,7 +2140,7 @@ int git_config_from_blob_oid(config_fn_t fn,
>  	}
>
>  	ret = git_config_from_mem(fn, CONFIG_ORIGIN_BLOB, name, buf, size,
> -				  data, scope, NULL);
> +				  data, scope, &config_opts);
>  	free(buf);

This one uses git_config_from_mem(), which sets the default error action
to "CONFIG_ERROR_ERROR", so this transformation looks correct.

Thanks,
Taylor
