Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB7F15B10D
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 14:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738851584; cv=none; b=gy0LZwZofNM+AAJ+TvjxwWTBhsY25B4n31+zXANixGj9LFuXcZpxGvmRSGgjPlfr1PyWdrAUn3+28U6g3CKY2z2y7BZwjuemmBAql4xoPVpT+Zrs3m4YMNV0YGpMVvSIaGJHb9WlrI58zAHHaztYBbzjlnIMxUZz1wl+zjgWJfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738851584; c=relaxed/simple;
	bh=zBlYsOkuGD9k+k/Zyb82ISwCCxvDBNDyYT8IWvEqwEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AWatSfiGrx+nwaFtLzoUE3Nc8tJ5Ok/3tgIDo5JXOx1IFSYJi6F03HM3rQ3rSEEg8RUG1VSFg2y40gdC1LsbPOaYOluAW2KCTm/8/xqSALDANn1jiTMuilsmMFlHxEHMjOqWoXDvjyGoHV8Sxv7yHQrsTgB9SHxbNPkDlZdafdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tne+XKrF; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tne+XKrF"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21f16af1f71so15223125ad.3
        for <git@vger.kernel.org>; Thu, 06 Feb 2025 06:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738851582; x=1739456382; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+/r5tsWsH2vHMaqbQEhBuvCakbseugMWygdNcbaP74Y=;
        b=Tne+XKrFwNox7H8AFy1kM6WolJMvcGVk/VgxgDIufqmt7d1A+Kk4sgLzzPp5w7V3yQ
         d/xrVLm2nwdvWIbEc7c5heiQ8IjttFz6Uec0s2L7cLImuT7mRSX7r4Oo/YC6kAXA3gPK
         zppBW8S1h7NncoH+RGYeQ/aaJt5Xup7Qw/pwRj3mypp+CtreS/CbAhrry5dD7sbwK4Of
         GjJrJ2krXWcjHg36t6imhiLfg/YfPy5AcStbqyoSA5EZt9RPvqdQWKj0zEAAa5NuIPbF
         fmJmInXpQqjhDVBAV3+RXZEChsnFFXY1yvfqj+mBMS7J8Js/wy99HLSB7R9MKDhsdpvG
         ltXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738851582; x=1739456382;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/r5tsWsH2vHMaqbQEhBuvCakbseugMWygdNcbaP74Y=;
        b=acIC9A6QmjEcJKInhfoTmvzfBXZjucczsHilJG4HN1GL9GH6ksnlk5+YHmGI4r0Zwt
         0HhFEgrr8Z6NNkCcpcpC5EgsgewqIQP1xnLM5Qo+XkkbBiw1qinWAadCoyFz01FvW8IQ
         pI7q8KtfTTWXByZTKtgu0S/C6OjQvZaojMFSZxEnTH9bnF4e4QGrEk4/VZmyXAlGlSI7
         PaEuUbrqCKRB9SP9dThduMTRRGYWFXrbZ32IQrq8+zPu8gvxuvUpk3qB+exWFmMU3AHo
         iTcpNPm/ZWPIGHl9IRRF/jRc7+7POgujcvROc4lSEJhTK/8Q2EsZ82KR0012KwbcQs0z
         4iXQ==
X-Gm-Message-State: AOJu0Yy3filw2JiN+JQfo9DM8F7DZz8JkpxNLlw4G/kUrWG6pGpYTHjB
	uzbuTMgxGFJbL3cDy18idf6Yd8e22EEU7EdhAYLFZ6KQKeQcH440ZkyHsw==
X-Gm-Gg: ASbGncvquacOlV77UCZcMsvM0FiHecZh32TM0pZFPnavkElV0u2injeRrRlLISN4pGW
	x4LmRmDUb040sJnRrF0elbk0c0dkVksuMpXpxZfWn+GEFL6/eElqf1fsuRnHZ65YCRhCab6V9NR
	Z/s2UltfY3tPBFXkXs8dUz1THQ9yFD7IzGuFbAIPbchfFvcqgPFtsVz7O8ham54MngqSZLhyjhI
	h4DAcaWlvAgpJzLKMO/dg7275Kh0KzgxJ2mh4vwCicmqPIIeeEzThKO2HprxZY7lYd59A==
X-Google-Smtp-Source: AGHT+IEPgAAkbCl880bru7KgzcRDMsZSDbqzC802fL4tJBFm5PYkT2WhYR3vE3nFSJL3Fr2XvNiWOQ==
X-Received: by 2002:a17:902:ce86:b0:21f:123b:8f84 with SMTP id d9443c01a7336-21f17ed30f3mr127367725ad.46.1738851582281;
        Thu, 06 Feb 2025 06:19:42 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21f3683dab0sm13149325ad.139.2025.02.06.06.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 06:19:41 -0800 (PST)
Date: Thu, 6 Feb 2025 22:21:24 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/16] path: refactor `repo_common_path()` family of
 functions
Message-ID: <Z6TFZGNjs3Xfkh9x@ArchLinux>
References: <20250206-b4-pks-path-drop-the-repository-v1-0-4e77f0313206@pks.im>
 <20250206-b4-pks-path-drop-the-repository-v1-1-4e77f0313206@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206-b4-pks-path-drop-the-repository-v1-1-4e77f0313206@pks.im>

On Thu, Feb 06, 2025 at 08:57:57AM +0100, Patrick Steinhardt wrote:
> The functions provided by the "path" subsystem to derive repository
> paths for the commondir, gitdir, worktrees and submodules are quite
> inconsistent. Some functions have a `strbuf_` prefix, others have
> different return values, some don't provide a variant working on top of
> `strbuf`s.
> 
> We're thus about to refactor all of these family of functions so that
> they follow a common pattern:
> 
>   - `repo_*_path()` returns an allocated string.
> 
>   - `repo_*_path_append()` appends the path to the caller-provided
>     buffer while returning a constant pointer to the buffer. This
>     clarifies whether the buffer is being appended to or rewritten,
>     which otherwise wasn't immediately obvious.
> 
>   - `repo_*_path_replace()` replaces contents of the buffer with the
>     computed path, again returning a pointer to the buffer contents.
> 

I want to ask a design question about this. Why do we need to return the
raw pointer to the `struct strbuf` for the last two cases? I somehow
understand why you want to do this. You want to follow a common pattern
for those three functions. But I wonder should we let the caller to
decide whether they want to use the raw pointer?

And in this patch, the return value of the last two cases has never been
used. Until I read the next patch, I have seen the usage of the return
value thus I could understand your motivation.

> diff --git a/path.h b/path.h
> index 5f6c85e5f8..3c75495e1a 100644
> --- a/path.h
> +++ b/path.h
> @@ -25,22 +25,20 @@ char *mkpathdup(const char *fmt, ...)
>  	__attribute__((format (printf, 1, 2)));
>  
>  /*
> - * The `strbuf_git_common_path` family of functions will construct a path into a
> + * The `repo_common_path` family of functions will construct a path into a
>   * repository's common git directory, which is shared by all worktrees.
>   */
> -
> -/*
> - * Constructs a path into the common git directory of repository `repo` and
> - * append it in the provided buffer `sb`.
> - */
> -void strbuf_git_common_path(struct strbuf *sb,
> -			    const struct repository *repo,
> -			    const char *fmt, ...)
> +char *repo_common_path(const struct repository *repo,
> +		       const char *fmt, ...)
> +	__attribute__((format (printf, 2, 3)));
> +const char *repo_common_path_append(const struct repository *repo,
> +				    struct strbuf *sb,
> +				    const char *fmt, ...)
> +	__attribute__((format (printf, 3, 4)));
> +const char *repo_common_path_replace(const struct repository *repo,
> +				     struct strbuf *sb,
> +				     const char *fmt, ...)
>  	__attribute__((format (printf, 3, 4)));
> -void repo_common_pathv(const struct repository *repo,
> -		       struct strbuf *buf,
> -		       const char *fmt,
> -		       va_list args);
>  
>  /*
>   * The `repo_git_path` family of functions will construct a path into a repository's
> @@ -243,6 +241,12 @@ struct strbuf *get_pathname(void);
>  #  include "strbuf.h"
>  #  include "repository.h"
>  
> +/* Internal implementation detail that should not be used. */
> +void repo_common_pathv(const struct repository *repo,
> +		       struct strbuf *buf,
> +		       const char *fmt,
> +		       va_list args);
> +

If we decide to make this as internal implementation, why we don't just
delete this declaration in the header file? Do I miss out something
here?

Thanks,
Jialuo
