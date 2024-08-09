Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B37B16A925
	for <git@vger.kernel.org>; Fri,  9 Aug 2024 19:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723232690; cv=none; b=KmjcxM37u5VwCS7E4xP1HDc2WcgtA9atgcixroZHPqGzvZIy+LBc14xpHyCx/YSTxVXInEk1+PU6fLCLAkemB1jEXTOuBkGb3qIYPQkI36GZ+nXCO7srUX63xUvp8gg844b+Dbh5wvl2zKc9VGah/etXhIa/Ibs3LLjl0cj8sMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723232690; c=relaxed/simple;
	bh=pXdRxyzfmZ6wJ8TsQOd51O+l7J0B4BoC9/0dC8Klz1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GvLzTvmYDpm1TFwfXjUhZC+HNQbhrL8MNjPPtcDV28jQf61rBhT9HTf+GkRv5TpUILqsAnHggJOxq7LKf/SJYLEDK31pQOic5hVZW4IfRxNB3hFRZJTB0oouMazDtEvuHgR5DfR8B+wnjuL6ffUOKS+03a0KLvcL+ref9AhD3bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GztDtV5Q; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GztDtV5Q"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7093efbade6so1586569a34.2
        for <git@vger.kernel.org>; Fri, 09 Aug 2024 12:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723232687; x=1723837487; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xRb6F8sV4vbpG0pI96ixgI4Y7ropGBCTc1z0+OMrIu0=;
        b=GztDtV5QrFs/dxW31gX5HUXtXfjY2wsNdGVm6en5xyYjqD2oCNl2feozd8gUtrCE+N
         5ef6hY9IplJnhLeMuecKWbtFnXoGIhweWBYz9LTu+vnXYW5NuTyhKV4hIuRfrBVC+a82
         Uq9CzkK1wZCdjkmy3CzjfBPZ5ugh8/sK9KKAeZq+9N+/fkAUlb42hdMfCNDU8lTUqpqB
         5ZAfiJldInQBsO3tOt/flAMa/8QYjPcb76urYr3Lvvo5m4Xx85w3vJm6JV/hMoKYYabX
         ruBQjcSHIxr+W7lG/wUyZOfZjSa5tRn5EmrtzyVVAb4E6znp40TAlwCLbWFe0Zj9rUx8
         Gz5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723232687; x=1723837487;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xRb6F8sV4vbpG0pI96ixgI4Y7ropGBCTc1z0+OMrIu0=;
        b=IuAla1VWveL/3Zoe7KQ4mvQ14IjOSSO+ZxjaRM2Q6JuuMGJz94R3wi7JMMpL/iwiqp
         gTZnPZQlD7ODPyr5hL5OiYO18MVQboeqNU701D9kb+eWYiHpikx8gA1HtYjl/szAv4AD
         z4HZkueW6blaapp4h9EBT5Q+9fov6FqF7YzoMFwz5HvBNqV4cf8i9Pcrw7hojRFozReW
         F0VDDEB3qdsgo3W0UnA9APbo2y0cv4/bfmn7+xib/s5k+/LX+l/+eYChu+QuM7Rq+Ei/
         aiYVwX9EnD81Dna/QZNg4/IiiOFFF7r73Rs2LNqKiNwPI/xx694UDm/ziZqJjQvyB0L8
         /agw==
X-Gm-Message-State: AOJu0YwD14a+ZOwjIGqTuJgwJcD7NsvrCMwikgBDLs8C5Kk+E/voljqX
	Xe35gcTQs9wlwoxETsAD9X2ktQ5t69hgS2wl5xNoeD71NI8pf9kXoz/Izg==
X-Google-Smtp-Source: AGHT+IFHRlJ1YrVy426PW/yx4sC1EFGFqJ41zo6o2bBq9j3rh/MWme5AQlb9Y0egbAV8ttnBFLz9qw==
X-Received: by 2002:a05:6830:7199:b0:704:4563:b66a with SMTP id 46e09a7af769-70b6b2f5407mr2838475a34.4.1723232687300;
        Fri, 09 Aug 2024 12:44:47 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70c7b88f4desm103847a34.65.2024.08.09.12.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 12:44:46 -0700 (PDT)
Date: Fri, 9 Aug 2024 14:43:59 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 07/20] path: hide functions using `the_repository` by
 default
Message-ID: <mc4omj4mi23fhmqp4xeafcluzf2iidp4uaf3h3gaxcalm3igvk@a7abzjynshfw>
References: <cover.1723013714.git.ps@pks.im>
 <b4e973a2804ba09149224a2e18a359717228607e.1723013714.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4e973a2804ba09149224a2e18a359717228607e.1723013714.git.ps@pks.im>

On 24/08/07 08:57AM, Patrick Steinhardt wrote:
> The path subsytem provides a bunch of legacy functions that compute

s/subsytem/subsystem/

> paths relative to the "gitdir" and "commondir" directories of the global
> `the_repository` variable. Use of those functions is discouraged, and it
> is easy to miss the implicit dependency on `the_repository` that calls
> to those functions may cause.
> 
> With `USE_THE_REPOSITORY_VARIABLE`, we have recently introduced a tool
> that allows us to get rid of such functions over time. With this define,

s/define/defined/

> we can hide away functions that have such implicit dependency such that
> other subsystems that want to be free of `the_repository` will not use
> them by accident.
> 
> Move all path-related functions that use `the_repository` into a block
> that gets only conditionally compiled depending on whether or not the
> macro has been defined. This also removes all dependencies on that
> variable in "path.c", allowing us to remove the definition of said
> preprocessor macro.

Nice! So now the "path.c" is `the_repository` free. Implicit use of
`the_repository` is guarded behind `USE_THE_REPOSITORY_VARIABLE`. This
is quite neat. :)

> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  path.c |  52 +-------------------
>  path.h | 147 ++++++++++++++++++++++++++++++++++++++-------------------
>  2 files changed, 100 insertions(+), 99 deletions(-)
> 
> diff --git a/path.c b/path.c
> index 567eff5253..d073ae6449 100644
> --- a/path.c
> +++ b/path.c
> @@ -2,8 +2,6 @@
>   * Utilities for paths and pathnames
>   */
>  
> -#define USE_THE_REPOSITORY_VARIABLE
> -
>  #include "git-compat-util.h"
>  #include "abspath.h"
>  #include "environment.h"
> @@ -30,7 +28,7 @@ static int get_st_mode_bits(const char *path, int *mode)
>  	return 0;
>  }
>  
> -static struct strbuf *get_pathname(void)
> +struct strbuf *get_pathname(void)

Now that functions with implicit `the_repository` usage are static
inlined we are required to expose `get_pathname()` for the same reason
as some of the other functions in previous commits.

[snip]
> +# ifdef USE_THE_REPOSITORY_VARIABLE
> +#  include "strbuf.h"
> +#  include "repository.h"

Naive question, what is the purpose of providing the include statements
here? Wouldn't they always already be included?

> +
> +/*
> + * Return a statically allocated path into the main repository's
> + * (the_repository) common git directory.
> + */
> +__attribute__((format (printf, 1, 2)))
> +static inline const char *git_common_path(const char *fmt, ...)
> +{
> +	struct strbuf *pathname = get_pathname();
> +	va_list args;
> +	va_start(args, fmt);
> +	strbuf_git_common_pathv(pathname, the_repository, fmt, args);
> +	va_end(args);
> +	return pathname->buf;
> +}
> +
> +/*
> + * Construct a path into the main repository's (the_repository) git directory
> + * and place it in the provided buffer `buf`, the contents of the buffer will
> + * be overridden.
> + */
> +__attribute__((format (printf, 2, 3)))
> +static inline char *git_path_buf(struct strbuf *buf, const char *fmt, ...)
> +{
> +	va_list args;
> +	strbuf_reset(buf);
> +	va_start(args, fmt);
> +	repo_git_pathv(the_repository, NULL, buf, fmt, args);
> +	va_end(args);
> +	return buf->buf;
> +}
> +
> +/*
> + * Construct a path into the main repository's (the_repository) git directory
> + * and append it to the provided buffer `sb`.
> + */
> +__attribute__((format (printf, 2, 3)))
> +static inline void strbuf_git_path(struct strbuf *sb, const char *fmt, ...)
> +{
> +	va_list args;
> +	va_start(args, fmt);
> +	repo_git_pathv(the_repository, NULL, sb, fmt, args);
> +	va_end(args);
> +}
> +
> +/*
> + * Return a statically allocated path into the main repository's
> + * (the_repository) git directory.
> + */
> +__attribute__((format (printf, 1, 2)))
> +static inline const char *git_path(const char *fmt, ...)
> +{
> +	struct strbuf *pathname = get_pathname();
> +	va_list args;
> +	va_start(args, fmt);
> +	repo_git_pathv(the_repository, NULL, pathname, fmt, args);
> +	va_end(args);
> +	return pathname->buf;
> +}
> +
> +#define GIT_PATH_FUNC(func, filename) \
> +	const char *func(void) \
> +	{ \
> +		static char *ret; \
> +		if (!ret) \
> +			ret = git_pathdup(filename); \
> +		return ret; \
> +	}
> +
> +/*
> + * Return a path into the main repository's (the_repository) git directory.
> + */
> +__attribute__((format (printf, 1, 2)))
> +static inline char *git_pathdup(const char *fmt, ...)
> +{
> +	struct strbuf path = STRBUF_INIT;
> +	va_list args;
> +	va_start(args, fmt);
> +	repo_git_pathv(the_repository, NULL, &path, fmt, args);
> +	va_end(args);
> +	return strbuf_detach(&path, NULL);
> +}
> +
> +# endif /* USE_THE_REPOSITORY_VARIABLE */

I like how it's all consolidated into this one block. Very nice! :)
