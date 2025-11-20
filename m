Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9317F2EB86D
	for <git@vger.kernel.org>; Thu, 20 Nov 2025 19:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763667523; cv=none; b=U0Zqbd9bT1ObYbFpEv2qJGcdQUDWEsdHuMPe6H7tAYhG2b/5d+4S6cSXlQO7ud9EilUJ+tY7NRD3SBiXqMDHE5Ms8u4LxYG9eGoIxQnLZZjuMw9qsluL/EXQU2DponbNinl9l8QmDKmL7E1h10l7WKj9L3akHjXRqGHi85+YHe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763667523; c=relaxed/simple;
	bh=B5rH/DPhU/s7A4o6zlWcqulEYLMgyN7+ywXkUUqu4ZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GVTheRMxf0Mej0t1MRYmi/PDYLehTeU/icFXe90lqE7lCRJeeESZW+spUdn48L/aaQDU5uiicbFKrkI6QtIwYMWayZl3dsPs1HW5hYnNc3IGc2qXfXCmOiBbFJbwLAcmmusp3KqGV6R+FZyB+zsIDB8JoPjfwduCeX51Mwoab5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SKBEuyDu; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKBEuyDu"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6575e760f06so259190eaf.0
        for <git@vger.kernel.org>; Thu, 20 Nov 2025 11:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763667520; x=1764272320; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HsfroG2DXA0LE/Pwm349Ob4Rnc6YsnrrvlS0i30JwD0=;
        b=SKBEuyDuHsm8hIMpmZMc61Tn9G7qrKWPyQESLYuBvpBv2N+Y5SdRNtd4WeunuREYqL
         61QgTR+vnSnDfBRgG4sCh9bD/mPdKpYpOs3MpgcJLawrDPkFUAkrRcSBiDzweakGHFNQ
         +D08ZZapxQTqXvC7he5WA3LytL5Lecpi/B1G93sZLdXl11thQRKdK83Q4i12HK6LnPT5
         mck9gFZJJ2TVWJDOpB4C880btDvQfpvodWJPI/zYh+eBaNkkTkTRl1iHhImKxOcKzjRn
         sHMqh68d7QVLfpNgy2HCiI6laog7zQSjPxX8hI+tQBfs39mAPGKesRNTycnFQXNeMR31
         D7hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763667520; x=1764272320;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HsfroG2DXA0LE/Pwm349Ob4Rnc6YsnrrvlS0i30JwD0=;
        b=CXd8lsnol9DcFLaGaPDn6UrXyxQhQsoqSIa/zyB1IZTsj3qfBy5R+3HcdBId5WxiQL
         F2i2t/r/KC5KxCWD8H61qZE73amPBbZon5MAadKB0PpgBej8Su39JtHUJQWXXNAal5li
         m4mJKEe1oGxVuVRP2hefp6kcAIIk9vlzxUDrIyXdq8CmWy3lEDnw0I4uLvXavsi17b4L
         Q3IYYbY3qZYD/zeHvAS8YZuhUfcUeA7QEWRR8u2szR0rfwGY4/BK/+lA+vUkY1aRE64X
         5ibFuZZGJAlXmoMunCud4cNPhaK4L0Ms4ymMxWGuIXTwaxevSeMsnTg+iUkKTGPIPJxF
         OkqA==
X-Gm-Message-State: AOJu0Yzpx7BUffcxk6eMKbD/WMv8UdIQfBsye/Kdq5Pit5A3PblMOxhq
	G4hnFir6uzGP1raPZhQpc/xc/xJbBf3S1V9Tl4AD/nMVoZTo1KMJdHSh
X-Gm-Gg: ASbGnct58uxVLPbvzZbIpkDFyqCR6NBbdB5ZgQFAPL4Tqy2LGbuvaqwNajAutA6T3Wc
	2FC3A4ZD/4mSPICfEJMhL04VfgRerQqHnsF0DbtkoVQ7D6jkJJ7SDubG7FIQmaUzj2pUJpcRMid
	pj3ttoSvF8UOw1164Z/ozWMoZLb1g9vzI0cQIVfFMLB6MYafS0DBiQzCvlxYlbxhH4lNNC4qaKv
	DkN6M9f7wA4J512tTx8IDGq8T6d71eqyLH2hPqDAflDZ6aCy3FxtkG53uMhETPUMB+qZpOKTMfJ
	Yho+rEUJl6YWyjL7MTQMJrZQyNyhkKiyg6Hxo/i5jz7SHjXSkpRY2TGxpAtbuzKfFKESJXJtkF/
	FqEv0ZjNyfq4kGX0M3JFhvY9e1iSSf7h6iYC1K9WFxMVuP00/XWrhffhTXeBez9JNLqcmoBRQuU
	oLv8Du
X-Google-Smtp-Source: AGHT+IGVG+X97Atpq+dT6bI6iOPX1uVzRHfu7VjDp86t9GV9Ygxj5foZ73ki2b6cOROQ7c2d0eLA9A==
X-Received: by 2002:a05:6820:168b:b0:656:b1c0:7f4c with SMTP id 006d021491bc7-65782a88f19mr1889142eaf.4.1763667520506;
        Thu, 20 Nov 2025 11:38:40 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65782a6de78sm990517eaf.8.2025.11.20.11.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 11:38:40 -0800 (PST)
Date: Thu, 20 Nov 2025 13:38:37 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] refs: add GIT_REF_URI to specify reference backend
 and directory
Message-ID: <3kdv5xzzoci5hmxau2qwhwtkx5rw7752vdb4a2mricrgt5vdqj@oxm7jvcr6ysy>
References: <20251119-kn-alternate-ref-dir-v1-0-4cf4a94c8bed@gmail.com>
 <20251119-kn-alternate-ref-dir-v1-2-4cf4a94c8bed@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119-kn-alternate-ref-dir-v1-2-4cf4a94c8bed@gmail.com>

On 25/11/19 10:48PM, Karthik Nayak wrote:
> Git allows setting a different object directory via
> 'GIT_OBJECT_DIRECTORY', but provides no equivalent for references.
> This asymmetry makes it difficult to test different reference backends
> or use alternative reference storage locations without modifying the
> repository structure.
> 
> Add a new environment variable 'GIT_REF_URI' that specifies both the
> reference backend and directory path using a URI format:
> 
>     <ref_backend>://<path>

Ok, we include the reference format as part of the URI here since it is
possible that the alternative reference store could be using a different
backend that what the repository is currently configured to use. Makes
sense.

> When set, this variable is used to obtain the main reference store for
> all Git commands. The variable is checked in `get_main_ref_store()`
> when lazily assigning `repo->refs_private`. We cannot initialize this
> earlier in `repo_set_gitdir()` because the repository's hash algorithm
> isn't known at that point, and the reftable backend requires this
> information during initialization.
>
> When used with worktrees, the specified directory is treated as the
> reference directory for all worktree operations.
> 
> Add a new test file 't1423-ref-backend.sh' to test this environment
> variable.
> 
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  Documentation/git.adoc |   8 ++++
>  environment.h          |   1 +
>  refs.c                 |  53 +++++++++++++++++++++++-
>  t/meson.build          |   1 +
>  t/t1423-ref-backend.sh | 109 +++++++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 171 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/git.adoc b/Documentation/git.adoc
> index ce099e78b8..a1d1078f42 100644
> --- a/Documentation/git.adoc
> +++ b/Documentation/git.adoc
> @@ -584,6 +584,14 @@ double-quotes and respecting backslash escapes. E.g., the value
>  	repositories will be set to this value. The default is "files".
>  	See `--ref-format` in linkgit:git-init[1].
>  
> +`GIT_REF_URI`::
> +    Specify which reference backend and path to be used, if not specified the
> +    backend is inferred from the configuration and $GIT_DIR is used as the
> +    path.
> ++
> +Expects the format '<ref_backend>://<path>', where the 'backend' specifies the
> +reference backend and the 'path' specifies the directory used by the backend.

I think some users may assume that the path to the reference backend
would be something like ".git/refs" similar to how
`GIT_OBJECT_DIRECTORY` is usually ".git/objects". It might be worth
clarifying this in the docs here.

> +
>  Git Commits
>  ~~~~~~~~~~~
>  `GIT_AUTHOR_NAME`::
> diff --git a/environment.h b/environment.h
> index 51898c99cd..9bc380bba4 100644
> --- a/environment.h
> +++ b/environment.h
> @@ -42,6 +42,7 @@
>  #define GIT_OPTIONAL_LOCKS_ENVIRONMENT "GIT_OPTIONAL_LOCKS"
>  #define GIT_TEXT_DOMAIN_DIR_ENVIRONMENT "GIT_TEXTDOMAINDIR"
>  #define GIT_ATTR_SOURCE_ENVIRONMENT "GIT_ATTR_SOURCE"
> +#define GIT_REF_URI_ENVIRONMENT "GIT_REF_URI"
>  
>  /*
>   * Environment variable used to propagate the --no-advice global option to the
> diff --git a/refs.c b/refs.c
> index 23f46867f2..0922f08c9f 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2186,15 +2186,66 @@ static struct ref_store *get_ref_store_for_dir(struct repository *r,
>  	return maybe_debug_wrap_ref_store(dir, ref_store);
>  }
>  
> +static struct ref_store *get_ref_store_from_uri(struct repository *repo,
> +						const char *uri)
> +{
> +	struct string_list ref_backend_info = STRING_LIST_INIT_DUP;
> +	enum ref_storage_format format;
> +	struct ref_store *store = NULL;
> +	char *format_string;
> +	char *dir;
> +
> +	if (!uri || !uri[0]) {
> +		error("reference backend uri is empty");
> +		goto cleanup;
> +	}
> +
> +	if (string_list_split(&ref_backend_info, uri, ":", 2) != 2) {
> +		error("invalid reference backend uri format '%s'", uri);
> +		goto cleanup;
> +	}
> +
> +	format_string = ref_backend_info.items[0].string;
> +	dir = ref_backend_info.items[1].string + 2;
> +
> +	if (!dir || !dir[0]) {
> +		error("invalid path in uri '%s'", uri);
> +		goto cleanup;
> +	}
> +
> +	format = ref_storage_format_by_name(format_string);
> +	if (format == REF_STORAGE_FORMAT_UNKNOWN) {
> +		error("unknown reference backend '%s'", format_string);
> +		goto cleanup;
> +	}
> +
> +	store = get_ref_store_for_dir(repo, dir, format);

Since we don't update the reference format stored in repo, if we were to
run:

  $ GIT_REF_URI="reftable://<path> git repo info references.format

it would still report what ever the repository was originally configured
with. Since only a single reference backend can be used at time, I
wonder if we should go a bit further and update `r->ref_storage_format`
to be inline with how the repository reference backend is configured via
`GIT_REF_URI`.

-Justin
