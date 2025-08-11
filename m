Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5983823BCE3
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 14:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754923374; cv=none; b=aYaYHSx/HOHB6IgP6sZ0fw7Gu2/bwZfGYxvPuwTgsrWy8L7WlpcJ02S/WhtMMOdhJ4im6d+52t3lWn5SkrCtOW+T6U/CTXkI2TmGheQuqkUK1KE8DeELokR2VGvIwrCg1sKOjBcX/9UpfP3Nh/1oWnQMfIWjG+RLRvfEikoVuQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754923374; c=relaxed/simple;
	bh=UuvraPn3S2B4h92iV/TXpRxV1GcBGqtNC7y1dIAFlhc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=RIma7ejk5bac8xZLxfewnXEPXVURnPoivnoznldRnNaZMYHTHiDpwkhDTI8J2vFeztep857kVAGMyFhY7JkjEkfp3HrqaTFW5pnVpjmW9a93BLuqWD2vBNnOvg2cR56+g/Q80jWyHjyw+cd2zTKIO5K+c3XSl2Ond7Xy1XdurQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U2LUrX71; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2LUrX71"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-459e20ec1d9so44330525e9.3
        for <git@vger.kernel.org>; Mon, 11 Aug 2025 07:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754923370; x=1755528170; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uTwsh+4UFT1mfke3+yfrVapnml65/MoKDm3eFtvqlRA=;
        b=U2LUrX71cgOlrQsSYylzWLlPHvlcxuEeHgEhGYhrsJtKOiWjSQwcdRM2ur+iPZu6KY
         boOgqxDASwvhUw2dsrQUT6rlzM7mzW5mdQB6FkCBQiRPA3OTh6QB/wM3wqRLgbjgBGgC
         SmArBl/jui98CCVKx8QcTH+J6kSg3A9YZR8fmCpDz4DJVk5TvxjqwBWmrRCU3CWtCAAX
         bLD/ACq1A9d3fAkBxMgHCCqp5DI13gii/p1TjKNKs8MEJorEXbPTlwLxP0UCoK5MXqR2
         rc3Eh5w+21OZzfEVtG79cirYvEpVr/HdExdv7JxwDXXubOwZot2gurhtCKM/H43MwIfE
         THag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754923370; x=1755528170;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uTwsh+4UFT1mfke3+yfrVapnml65/MoKDm3eFtvqlRA=;
        b=HqF4PJu2t3NAIVpMVeTEJ9yD28Vv2I2VaiuPSAwzGXU9kkxJFsFwrxZudhUuxtkqa3
         27dHZXIRJ+7102ny6ngQntl75dIreQ1LOfnumI7tdkjP7EXUkKHVE3Cur//n6naNlq6M
         jS8XRzOA1aOBN38oYczkt2cwLWkZr11GXJwETE/U18DXedIz2o7vencvFIE3c+GDwNTl
         fxxm2rRqI4Lk3xXrM12K99qrR0HfTyXUUm4S+ETbIjXUbN4pmuuqMnMlrXQc/CPzjdbM
         A91ahdKxJz7x+VINgko33CDghG3DRfEv1Tcp07IRbkWSCO+3/oYMCdJHYcAiUtCmv/OP
         c1Ag==
X-Forwarded-Encrypted: i=1; AJvYcCWh+i8ka4lGu0/YISsc8mHXbZk8+wl1RQ8MJ1KtUJk8GbHX2xykdPQDPSyzQciHCVSLQHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLh43XkHbJvJcFkICCemJAYpglAreOItYv2RZu5eYhy/TKUgM/
	8oPpXxbWF0+gxiOntifse5Kex0DlwO+SzLTx+2VLPHVymH7oglJqzxoV
X-Gm-Gg: ASbGncv2h48m+eGUP7Xrcqd1t3Iy1zzQPSthH/CCDNscq+K5epA4zG+qwIju0PpYlZd
	PqIdAgkiK8478aEq7deIvWOneZmu5/ldxxOpClSFFJZX3nOZUbT47F+DCyfGIjPF0bJ6QQan93y
	gcpTmft86240er0RA8pkN2Yz+brLo9hSCBp851FYNTl6kmV0w0+KRkjM3jG39OMkgSMQNQqjrEi
	BRtEMcS12gh4+p1zC7sHDxNwtIZQy8IOj+FF4LtrU+AqkNfjkyNMHz5c+A+R7frk35ElX95Y7p7
	cVH9fxwKgn7JYVN2I09rDiFdA0xrGGUoY+uIaddLEWf/yIUkVXecxQwpNLTgfHSEKgq4f7FJyYd
	Zp9ubekvtQqIhqkWAwGmUP4/M3r+HklGeLAVIrOW4ewm4dGvVjd7JykAHKM3UvZXsq+QBIRY+BV
	og
X-Google-Smtp-Source: AGHT+IEA/z71DeCCHtOw30iBRe0+F/NQWGa7dO4R6M96CC2LSD5hlxS6Q6BpgWo2Bxz9WG9/6MSshQ==
X-Received: by 2002:a05:600c:35cb:b0:456:1d4e:c127 with SMTP id 5b1f17b1804b1-459f4f5124cmr112156935e9.8.1754923370212;
        Mon, 11 Aug 2025 07:42:50 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e3d37439sm161555315e9.2.2025.08.11.07.42.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 07:42:49 -0700 (PDT)
Message-ID: <076c19ae-58fc-4823-9679-1d5fe6e46211@gmail.com>
Date: Mon, 11 Aug 2025 15:42:48 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSOC PATCH v2 1/2] environment: remove the global variable
 'merge_log_config'
To: Ayush Chandekar <ayu.chandekar@gmail.com>
Cc: christian.couder@gmail.com, git@vger.kernel.org,
 shyamthakkar001@gmail.com, gitster@pobox.com
References: <cover.1754868681.git.ayu.chandekar@gmail.com>
 <3aa014ed46d14e31ea0c2f6b7631e7e4cbbd3943.1754868681.git.ayu.chandekar@gmail.com>
Content-Language: en-US
In-Reply-To: <3aa014ed46d14e31ea0c2f6b7631e7e4cbbd3943.1754868681.git.ayu.chandekar@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ayush

On 11/08/2025 00:45, Ayush Chandekar wrote:
> The global variable 'merge_log_config', set via the "merge.log" or
> "merge.summary" settings, is only used in 'cmd_fmt_merge_msg()' and
> 'cmd_merge()' to adjust the 'shortlog_len' variable.
> 
> Remove 'merge_log_config' globally and localize it in
> 'cmd_fmt_merge_msg()' and 'cmd_merge()'. Set its value by passing it in
> 'fmt_merge_msg_config()' by passing its pointer to the function via the
> callback parameter.

This looks like a good solution

Thanks

Phillip

> This change is part of an ongoing effort to eliminate global variables,
> improve modularity and help libify the codebase.
> 
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
> Signed-off-by: Ayush Chandekar <ayu.chandekar@gmail.com>
> ---
>   builtin/fmt-merge-msg.c |  3 ++-
>   builtin/merge.c         |  3 ++-
>   environment.c           |  1 -
>   fmt-merge-msg.c         | 10 ++++++----
>   fmt-merge-msg.h         |  1 -
>   5 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
> index 3b6aac2cf7..4b24de32fb 100644
> --- a/builtin/fmt-merge-msg.c
> +++ b/builtin/fmt-merge-msg.c
> @@ -19,6 +19,7 @@ int cmd_fmt_merge_msg(int argc,
>   	const char *message = NULL;
>   	char *into_name = NULL;
>   	int shortlog_len = -1;
> +	int merge_log_config = -1;
>   	struct option options[] = {
>   		{
>   			.type = OPTION_INTEGER,
> @@ -53,7 +54,7 @@ int cmd_fmt_merge_msg(int argc,
>   	int ret;
>   	struct fmt_merge_msg_opts opts;
>   
> -	git_config(fmt_merge_msg_config, NULL);
> +	git_config(fmt_merge_msg_config, &merge_log_config);
>   	argc = parse_options(argc, argv, prefix, options, fmt_merge_msg_usage,
>   			     0);
>   	if (argc > 0)
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 18b22c0a26..c2089b5e6f 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -1374,6 +1374,7 @@ int cmd_merge(int argc,
>   	struct commit_list *remoteheads = NULL, *p;
>   	void *branch_to_free;
>   	int orig_argc = argc;
> +	int merge_log_config = -1;
>   
>   	show_usage_with_options_if_asked(argc, argv,
>   					 builtin_merge_usage, builtin_merge_options);
> @@ -1392,7 +1393,7 @@ int cmd_merge(int argc,
>   		skip_prefix(branch, "refs/heads/", &branch);
>   
>   	init_diff_ui_defaults();
> -	git_config(git_merge_config, NULL);
> +	git_config(git_merge_config, &merge_log_config);
>   
>   	if (!branch || is_null_oid(&head_oid))
>   		head_commit = NULL;
> diff --git a/environment.c b/environment.c
> index 7c2480b22e..6751aa5683 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -66,7 +66,6 @@ int grafts_keep_true_parents;
>   int core_apply_sparse_checkout;
>   int core_sparse_checkout_cone;
>   int sparse_expect_files_outside_of_patterns;
> -int merge_log_config = -1;
>   int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
>   unsigned long pack_size_limit_cfg;
>   int max_allowed_tree_depth =
> diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
> index 40174efa3d..c9085edc40 100644
> --- a/fmt-merge-msg.c
> +++ b/fmt-merge-msg.c
> @@ -26,13 +26,15 @@ static struct string_list suppress_dest_patterns = STRING_LIST_INIT_DUP;
>   int fmt_merge_msg_config(const char *key, const char *value,
>   			 const struct config_context *ctx, void *cb)
>   {
> +	int *merge_log_config = cb;
> +
>   	if (!strcmp(key, "merge.log") || !strcmp(key, "merge.summary")) {
>   		int is_bool;
> -		merge_log_config = git_config_bool_or_int(key, value, ctx->kvi, &is_bool);
> -		if (!is_bool && merge_log_config < 0)
> +		*merge_log_config = git_config_bool_or_int(key, value, ctx->kvi, &is_bool);
> +		if (!is_bool && *merge_log_config < 0)
>   			return error("%s: negative length %s", key, value);
> -		if (is_bool && merge_log_config)
> -			merge_log_config = DEFAULT_MERGE_LOG_LEN;
> +		if (is_bool && *merge_log_config)
> +			*merge_log_config = DEFAULT_MERGE_LOG_LEN;
>   	} else if (!strcmp(key, "merge.branchdesc")) {
>   		use_branch_desc = git_config_bool(key, value);
>   	} else if (!strcmp(key, "merge.suppressdest")) {
> diff --git a/fmt-merge-msg.h b/fmt-merge-msg.h
> index 73ca3e4465..c066d83761 100644
> --- a/fmt-merge-msg.h
> +++ b/fmt-merge-msg.h
> @@ -12,7 +12,6 @@ struct fmt_merge_msg_opts {
>   	const char *into_name;
>   };
>   
> -extern int merge_log_config;
>   int fmt_merge_msg_config(const char *key, const char *value,
>   			 const struct config_context *ctx, void *cb);
>   int fmt_merge_msg(struct strbuf *in, struct strbuf *out,

