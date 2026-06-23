Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728953090C2
	for <git@vger.kernel.org>; Tue, 23 Jun 2026 15:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782230234; cv=none; b=RQ0FEc2RUyYNJQkiW8GrecXv6Il9vuPh+f1P4U6LTee0v4gTgZTgfrhlosiCKJC/1Onvp0jpvvm4iYU0jMWqrYbXRGfgFfhJEjY1q66LvFvnK/L6SH+gyi3bdwA94JRwm0aRDjUPLgjgNCJwKSvO+iJJqts/ie+KxXwlZ9UDcL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782230234; c=relaxed/simple;
	bh=/iXRsqAICroiUJ3rBpfGH5U9KP/Zgh5SEJnhF7o9pgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=blCCYeQVUpFDJ9W8JosjgIVIi+fIe65br8arcaO/a4LOZtREjnO9FIW02CpCkA/5ZZenFMsZpOwzSZhAduaIcxeTnajhLqwWRcALENS754kqYzQbm1COob2l3FWa/78CBqFlUHA7aUvdInSOfOAN4q6247n1sE2MwdEW8YYnnHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oNJwDnnG; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oNJwDnnG"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so536945e9.0
        for <git@vger.kernel.org>; Tue, 23 Jun 2026 08:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782230231; x=1782835031; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=X7EssYEJC+e0V8IEvykplgTo76G9Tx/yxTJAYcaazdg=;
        b=oNJwDnnG3/AdRFd8vhOzeW2iYvjmdJ0QOS2AnezeLxbV5YvRTL3A68SpzGE7Brq5kW
         rGdiEboIZ81mGQB7pJ0QE91s/lF+QqkuJy0gZNO5zpesxVDu7m3ianPtUjDXGgiXV0Ju
         OxaHS5c4hCiqBsxpYaN7El1ys2IfOAKCbfJLRq0+346T1IAAfrJ4Al/BsPn/PqH4wgYM
         aUpgKkrMtBYkxUMi+GxM7jdgrnJ1yHD9Ymrq/4uztYTy++SUhwNvdRFAONFHNmXI/s3X
         Bb3DOITb3xve9cuppqgrxim8gp6TNuLN3TKod6+5mfe02qILNmsGPJIeiyRglj4gnlDf
         Z6dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782230231; x=1782835031;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X7EssYEJC+e0V8IEvykplgTo76G9Tx/yxTJAYcaazdg=;
        b=cS51IBtQyKhk4jtsehZNUOEMbEnqyHftCtlXe/XHIfHzp9y5e1VlnwV9Y0GvYJPBY7
         FBgdBvRpormP5Hw9Bl3TS71tz/y7ikRZW3TSfF8E/Q3jWB0WP6HHUfrvo36/36bh1hPv
         39FOSbIcMgaU0MTZzzGRd4hergzLYgQYk+FdHnb17lwUhpnHndWNXvhbdPULly5Fl3/w
         Uev+E+ZfWurrgMOZ8w+1gzGSemIcTxLzwz8rRgL1KX9aqfu7DIxQQd/cd92+Zypxn68g
         3TzRuNde4FHoeWirtHk0zrq7MW5yifM/x4uc+wdw/rYZZx7NNUSir7LOjNrpTOghM6Ou
         y/Lg==
X-Forwarded-Encrypted: i=1; AFNElJ+HTFyVpVzZmuaftpbVSxZybcephc6n3dmLJBVcTaZnWQrBtmnQyvbbpU1qey1YCjggz98=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSQSwE89FdXm3iU0pO4yL6UZNxiwNOxtEX9S9X+a7CJq1O1sQD
	czZJwp/TeQgvO6R/lo5sqpddj4Iac/g/GF3GFE7i5e8Xy3JR4cLZJlFG
X-Gm-Gg: AfdE7ckKeoFh4blCMfVS4UNWSb1w6gl3WEToDRkt2wgQaotxzn+0RTJKqvFfgHcsUbm
	ZnxRAt8n9u6qs5EnuAS86Gjpu3EEv/sEiWw2lU8AnpMcwCNIf39ZpMmA6AL6HwdHbI2OJfopmcu
	caPZSjShEzqc1E0msscknqgnRKK0e0ZTaNp7lvvdMUhczTazcMFP/3xraDiFWbN9WvtSzvXhLWI
	JulXngA3OMuzpBr3wphFxAM1AWozCU6xrksXk1qJVILiVv58a71riXQi4urkpj+SqeiZ8uOBNer
	Ni6q2goVFFQiXZUlZkPUYwmH4PIvHGMXSjc0m07dBUu5Pa48fhodzEcRRbTfK51oxctjsy0w69m
	8M02fwzramLEQd/Odgo4vX1PnlWivCBZUvXJ5n0nWOLjJIFUvub3EKh4oyVSYycNJa0ueAH03HN
	GOjK/1FzDDMDV7bcbwHlhny+CG6tmyxBAeahjJ4PZb7ndz9uTn2krIvzEnnL5c3ZPK28k=
X-Received: by 2002:a05:600c:8b71:b0:492:59a0:4a65 with SMTP id 5b1f17b1804b1-4925b3802a0mr54247835e9.27.1782230230794;
        Tue, 23 Jun 2026 08:57:10 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:201a:26ab:8d41:fb43? ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46667221de7sm35809544f8f.33.2026.06.23.08.57.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 08:57:10 -0700 (PDT)
Message-ID: <084ad4d0-d872-4c7f-94a8-ec2383c7a8ca@gmail.com>
Date: Tue, 23 Jun 2026 16:57:09 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSoC Patch v7 1/3] path: extract append_formatted_path() and use
 in rev-parse
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: a3205153416@gmail.com, git@vger.kernel.org, gitster@pobox.com,
 jltobler@gmail.com, kumarayushjha123@gmail.com, lucasseikioshiro@gmail.com,
 phillip.wood@dunelm.org.uk, sandals@crustytoothpaste.net
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
 <20260621055534.46798-1-jayatheerthkulkarni2005@gmail.com>
 <20260621055534.46798-2-jayatheerthkulkarni2005@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20260621055534.46798-2-jayatheerthkulkarni2005@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/06/2026 06:55, K Jayatheerth wrote:
> Path formatting logic in builtin/rev-parse.c writes directly to
> stdout. Other builtins cannot reuse it.
> 
> Extract this logic into append_formatted_path() in path.c and expose
> a path_format enum in path.h.
> 
> Convert rev-parse to use the new helper in the same step to validate
> the API against existing tests and avoid introducing dead code.

The new API looks good now, and so does the conversion of the existing 
code. I'm very happy with this version and don't have anything to add to 
Junio's comments

Thanks

Phillip

> Mentored-by: Justin Tobler <jltobler@gmail.com>
> Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
> Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
> ---
>   builtin/rev-parse.c | 73 ++++++++++++++++++---------------------------
>   path.c              | 69 ++++++++++++++++++++++++++++++++++++++++++
>   path.h              | 30 +++++++++++++++++++
>   3 files changed, 128 insertions(+), 44 deletions(-)
> 
> diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
> index bb882678fe..6de01466db 100644
> --- a/builtin/rev-parse.c
> +++ b/builtin/rev-parse.c
> @@ -653,53 +653,38 @@ enum default_type {
>   	DEFAULT_UNMODIFIED,
>   };
>   
> -static void print_path(const char *path, const char *prefix, enum format_type format, enum default_type def)
> +static void print_path(const char *path, const char *prefix,
> +		       enum format_type format, enum default_type def)
>   {
> -	char *cwd = NULL;
> -	/*
> -	 * We don't ever produce a relative path if prefix is NULL, so set the
> -	 * prefix to the current directory so that we can produce a relative
> -	 * path whenever possible.  If we're using RELATIVE_IF_SHARED mode, then
> -	 * we want an absolute path unless the two share a common prefix, so don't
> -	 * set it in that case, since doing so causes a relative path to always
> -	 * be produced if possible.
> -	 */
> -	if (!prefix && (format != FORMAT_DEFAULT || def != DEFAULT_RELATIVE_IF_SHARED))
> -		prefix = cwd = xgetcwd();
> -	if (format == FORMAT_DEFAULT && def == DEFAULT_UNMODIFIED) {
> -		puts(path);
> -	} else if (format == FORMAT_RELATIVE ||
> -		  (format == FORMAT_DEFAULT && def == DEFAULT_RELATIVE)) {
> -		/*
> -		 * In order for relative_path to work as expected, we need to
> -		 * make sure that both paths are absolute paths.  If we don't,
> -		 * we can end up with an unexpected absolute path that the user
> -		 * didn't want.
> -		 */
> -		struct strbuf buf = STRBUF_INIT, realbuf = STRBUF_INIT, prefixbuf = STRBUF_INIT;
> -		if (!is_absolute_path(path)) {
> -			strbuf_realpath_forgiving(&realbuf, path,  1);
> -			path = realbuf.buf;
> -		}
> -		if (!is_absolute_path(prefix)) {
> -			strbuf_realpath_forgiving(&prefixbuf, prefix, 1);
> -			prefix = prefixbuf.buf;
> +	struct strbuf sb = STRBUF_INIT;
> +	enum path_format fmt;
> +
> +	if (format == FORMAT_RELATIVE) {
> +		fmt = PATH_FORMAT_RELATIVE;
> +	} else if (format == FORMAT_CANONICAL) {
> +		fmt = PATH_FORMAT_CANONICAL;
> +	} else /* FORMAT_DEFAULT */ {
> +		switch (def) {
> +		case DEFAULT_RELATIVE:
> +			fmt = PATH_FORMAT_RELATIVE;
> +			break;
> +		case DEFAULT_RELATIVE_IF_SHARED:
> +			fmt = PATH_FORMAT_RELATIVE_IF_SHARED;
> +			break;
> +		case DEFAULT_CANONICAL:
> +			fmt = PATH_FORMAT_CANONICAL;
> +			break;
> +		case DEFAULT_UNMODIFIED:
> +		default:
> +			fmt = PATH_FORMAT_UNMODIFIED;
> +			break;
>   		}
> -		puts(relative_path(path, prefix, &buf));
> -		strbuf_release(&buf);
> -		strbuf_release(&realbuf);
> -		strbuf_release(&prefixbuf);
> -	} else if (format == FORMAT_DEFAULT && def == DEFAULT_RELATIVE_IF_SHARED) {
> -		struct strbuf buf = STRBUF_INIT;
> -		puts(relative_path(path, prefix, &buf));
> -		strbuf_release(&buf);
> -	} else {
> -		struct strbuf buf = STRBUF_INIT;
> -		strbuf_realpath_forgiving(&buf, path, 1);
> -		puts(buf.buf);
> -		strbuf_release(&buf);
>   	}
> -	free(cwd);
> +
> +	append_formatted_path(&sb, path, prefix, fmt);
> +	puts(sb.buf);
> +
> +	strbuf_release(&sb);
>   }
>   
>   int cmd_rev_parse(int argc,
> diff --git a/path.c b/path.c
> index d7e17bf174..6d8e892ada 100644
> --- a/path.c
> +++ b/path.c
> @@ -1579,6 +1579,75 @@ char *xdg_cache_home(const char *filename)
>   	return NULL;
>   }
>   
> +void append_formatted_path(struct strbuf *dest, const char *path,
> +			   const char *prefix, enum path_format format)
> +{
> +	switch (format) {
> +	case PATH_FORMAT_UNMODIFIED:
> +		strbuf_addstr(dest, path);
> +		break;
> +
> +	case PATH_FORMAT_RELATIVE: {
> +		struct strbuf relative_buf = STRBUF_INIT;
> +		struct strbuf real_path = STRBUF_INIT;
> +		struct strbuf real_prefix = STRBUF_INIT;
> +		char *cwd = NULL;
> +
> +		/*
> +		 * We don't ever produce a relative path if prefix is NULL,
> +		 * so set the prefix to the current directory so that we can
> +		 * produce a relative path whenever possible.
> +		 */
> +		if (!prefix)
> +			prefix = cwd = xgetcwd();
> +
> +		if (!is_absolute_path(path)) {
> +			strbuf_realpath_forgiving(&real_path, path, 1);
> +			path = real_path.buf;
> +		}
> +		if (!is_absolute_path(prefix)) {
> +			strbuf_realpath_forgiving(&real_prefix, prefix, 1);
> +			prefix = real_prefix.buf;
> +		}
> +
> +		strbuf_addstr(dest, relative_path(path, prefix, &relative_buf));
> +
> +		strbuf_release(&relative_buf);
> +		strbuf_release(&real_path);
> +		strbuf_release(&real_prefix);
> +		free(cwd);
> +		break;
> +	}
> +
> +	case PATH_FORMAT_RELATIVE_IF_SHARED: {
> +		struct strbuf relative_buf = STRBUF_INIT;
> +
> +		/*
> +		 * If we're using RELATIVE_IF_SHARED mode, then we want an
> +		 * absolute path unless the two share a common prefix, so don't
> +		 * default the prefix to the current working directory. Doing so
> +		 * would cause a relative path to always be produced if possible.
> +		 */
> +		strbuf_addstr(dest, relative_path(path, prefix, &relative_buf));
> +		strbuf_release(&relative_buf);
> +		break;
> +	}
> +
> +	case PATH_FORMAT_CANONICAL: {
> +		struct strbuf canonical_buf = STRBUF_INIT;
> +
> +		strbuf_realpath_forgiving(&canonical_buf, path, 1);
> +		strbuf_addbuf(dest, &canonical_buf);
> +
> +		strbuf_release(&canonical_buf);
> +		break;
> +	}
> +
> +	default:
> +		BUG("unknown path_format value %d", format);
> +	}
> +}
> +
>   REPO_GIT_PATH_FUNC(squash_msg, "SQUASH_MSG")
>   REPO_GIT_PATH_FUNC(merge_msg, "MERGE_MSG")
>   REPO_GIT_PATH_FUNC(merge_rr, "MERGE_RR")
> diff --git a/path.h b/path.h
> index 4c2958a903..4d982a2c8e 100644
> --- a/path.h
> +++ b/path.h
> @@ -262,6 +262,36 @@ enum scld_error safe_create_leading_directories_no_share(char *path);
>   int safe_create_file_with_leading_directories(struct repository *repo,
>   					      const char *path);
>   
> +/**
> + * The formatting strategy to apply when writing a path into a buffer.
> + */
> +enum path_format {
> +	/* Output the path exactly as-is without any modifications. */
> +	PATH_FORMAT_UNMODIFIED,
> +
> +	/* Output a path relative to the provided directory prefix. */
> +	PATH_FORMAT_RELATIVE,
> +
> +	/* Output a relative path only if the path shares a root with the prefix. */
> +	PATH_FORMAT_RELATIVE_IF_SHARED,
> +
> +	/* Output a fully resolved, absolute canonical path. */
> +	PATH_FORMAT_CANONICAL
> +};
> +
> +/**
> + * Format a path according to the specified formatting strategy and append
> + * the result to the given strbuf.
> + *
> + * `dest`   : The string buffer to append the formatted path to.
> + * `path`   : The path string that needs to be formatted.
> + * `prefix` : The directory prefix to calculate relative offsets against.
> + * Pass NULL to default to the current working directory where applicable.
> + * `format` : The formatting behavior rule to execute.
> + */
> +void append_formatted_path(struct strbuf *dest, const char *path,
> +			   const char *prefix, enum path_format format);
> +
>   # ifdef USE_THE_REPOSITORY_VARIABLE
>   #  include "strbuf.h"
>   #  include "repository.h"

